class EpisodesReceiverWorker
  include Sidekiq::Worker

  def perform(feed_id = nil)
    feeds = if feed_id.nil?
              Feed.all
            else
              [Feed.find_by(id: feed_id)]
            end

    feeds.each do |feed|
      episodes = EpisodesReceiverService.new(feed.rss_url).call

      feed.update(last_check_error: episodes.error,
                  healthy: !episodes.error.present?)

      unless episodes.success?
        Honeybadger.notify(episodes.error)
        next
      end

      episodes.payload.each do |e|
        next if Episode.find_by(external_id: e[:external_id])

        params = e.merge(feed_id: feed.id)
        new_episode = Episode.create!(params)
      end
    end
  end
end
