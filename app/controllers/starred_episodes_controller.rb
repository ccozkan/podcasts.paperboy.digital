class StarredEpisodesController < ApplicationController
  def index
    starred_episodes = current_user.episodes.where(dismissed: false, starred: true)
    episodes = Episode.where(feed_id: @feed.id).where.not(id: current_user.interactions.where(dismissed: true))
  end
end
