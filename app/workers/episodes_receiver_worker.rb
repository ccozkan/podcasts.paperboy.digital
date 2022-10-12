class EpisodesReceiverWorker
  include Sidekiq::Worker

  def perform(feed_id = nil)
    Rails.logger.info('~~ EpisodesReceiverService has started ~~')
    start_time = Time.now.to_i

    feeds = if feed_id.nil?
              Feed.all
            else
              [Feed.find_by(id: feed_id)]
            end

    Rails.logger.info("~~ running for #{feeds.count} feeds")

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


    end_time = Time.now.to_i
    elapsed_time = end_time - start_time
    Rails.logger.info("~~ EpisodesReceiverService has ended. Took #{elapsed_time} seconds ~~")
  end
end
