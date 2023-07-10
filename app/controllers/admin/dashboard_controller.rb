class Admin::DashboardController < Admin::BaseController
  def index
    @user_count = User.count
    @feed_count = Feed.count
    @episode_count = Episode.count

    @last_user = User.last
    @last_feed = Feed.last
    @last_episode = Episode.last

    @unhealthy_feeds = Feed.where(healthy: false)
  end
end
