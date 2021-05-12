class NewEpisodesReceiverWorker
  include Sidekiq::Worker

  def perform(*args)
    Feed.all.each do |feed|
      episodes = EpisodesReceiverService.new(feed.rss_url).call
      episodes.each do |e|
        next if e[:published_at] < Episode.last_week_time_period[:starting_at] || Episode.find_by(external_id: e[:external_id])

        params = e.merge(feed_id: feed.id)
        new_episode = Episode.create!(params)
      end
    end
  end
end
