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
                  healthy: !episodes.error.present?)

      unless episodes.success?
        Honeybadger.notify("not process stopping error: #{episodes.error}")
        return
      end

      episodes.payload.each do |episode_remote|
        episode = Episode.find_by(external_id: episode_remote[:external_id])
        return if episode

        params = episode_remote.merge(feed_id: feed.id)

        if episode
          episode.update!(params)
        else
          Episode.create!(params)
        end
      end
    end

    def count
      # Optionally, define the number of rows that will be iterated over
      # This is used to track the task's progress
    end
  end
end
