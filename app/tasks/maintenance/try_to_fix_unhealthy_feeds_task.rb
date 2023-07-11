# frozen_string_literal: true

module Maintenance
  class TryToFixUnhealthyFeedsTask < MaintenanceTasks::Task
    def collection
      Feed.where(healthy: false)
    end

    def process(element)
      feed = element
      search_result = FeedSearcherService.new(feed.name).call.payload.first
      if search_result[:external_id] == feed.external_id
        new_rss = search_result[:rss_url]
        dummy_service = EpisodesReceiverService.new(new_rss).call

        unless dummy_service.success?
          feed.last_check_error = "STOPPED! dummy service failed for #{feed.id} id, #{feed.name} error: #{dummy_service.error}"
          feed.save!
        end

        feed.pic_url = search_result[:pic_url]
        feed.rss_url = search_result[:rss_url]
        feed.healthy = true
        feed.save!
      else

        feed.last_check_error = "STOPPED! dummy service failed for #{feed.id} id, #{feed.name} error: #{dummy_service.error}"
        feed.save!
      end
    end

    def count; end
  end
end
