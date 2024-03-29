class EpisodesReceiverWorker
  include Sidekiq::Worker

  def perform(feed_id = nil, backfill = false)
    Rails.logger.info('~~ EpisodesReceiverService has started ~~')
    start_time = Time.now.to_i

    feeds = if feed_id.nil?
              Feed.where(id: Subscription.all.pluck(:feed_id).uniq)
            else
              [Feed.find_by(id: feed_id)]
            end

    Rails.logger.info("~~ running for #{feeds.count} feeds")

    feeds.each do |feed|
      Rails.logger.info("~~ feed_id is #{feed_id} backfill is #{backfill} ~~")
      Rails.logger.info("~~ running for #{feed&.id} id feed")

      if feed.subscriptions&.empty? && !feed.healthy.nil?
        Rails.logger.info("~~ skipping #{feed.id} id feed since has no subscriptions")
        next
      end

      if feed.healthy == false && !!feed.last_check_error&.starts_with?('FailedToFix:')
        next
      end

      episodes = EpisodesReceiverService.new(feed.rss_url).call

      feed.update(last_check_error: episodes.error,
                  healthy: !episodes.error.present?)

      next unless episodes.success?

      episodes.payload.each do |episode_remote|
        episode = Episode.find_by(external_id: episode_remote[:external_id])
        next if episode && !backfill

        params = episode_remote.merge(feed_id: feed.id)

        if episode && backfill
          episode.update!(params)
        else
          Episode.create!(params)
        end
      end
    end

    end_time = Time.now.to_i
    elapsed_time = end_time - start_time
    Rails.logger.info("~~ EpisodesReceiverService has ended. Took #{elapsed_time} seconds ~~")
  end
end
