# frozen_string_literal: true

module Maintenance
  class UpdateRssUrlAndPicUrlOfFirstUnhealthyFeedTask < MaintenanceTasks::Task
    def collection
      unhealthy_first_feed_id = Feed.where(healthy: false).sample.id
      Feed.where(id: unhealthy_first_feed_id)
    end

    def process(element)
      feed = element
      search_result = FeedSearcherService.new(feed.name).call.payload.first

      if search_result[:external_id] == feed.external_id
        new_rss = search_result[:rss_url]
        dummy_service = EpisodesReceiverService.new(new_rss).call

        raise dummy_service.error.to_s + "STOPPED! dummy service failed for #{feed.id} id, #{feed.name} error: #{dummy_service.error}" unless dummy_service.success?

        feed.pic_url = search_result[:pic_url]
        feed.rss_url = search_result[:rss_url]
        feed.healthy = true
        feed.save!
      else
        raise "STOPPED! external id match did not for #{feed.id} id, #{feed.name}"
      end
    end

    def count; end
  end
end
