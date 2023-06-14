# frozen_string_literal: true

module Maintenance
  class ReceiveAndBackfillEpisodesTask < MaintenanceTasks::Task
    def collection
      Feed.all
    end

    def process(element)
      feed = element
      episodes = EpisodesReceiverService.new(feed.rss_url).call

      feed.update(last_check_error: episodes.error,
                  healthy: episodes.error.blank?)

      return unless episodes.success?

      episodes.payload.each do |episode_remote|
        episode = Episode.find_by(external_id: episode_remote[:external_id])

        params = episode_remote.merge(feed_id: feed.id)

        if episode
          episode.update!(params)
        else
          Episode.create!(params)
        end
      end
    end

    def count
    end
  end
end
