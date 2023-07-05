class BookmarkEpisodesController < ApplicationController
  before_action :authenticate_user!

  def update
    return unless permitted_params[:second]

    interaction = Interaction.bookmark!(permitted_params[:episode_id],
                                        current_user.id,
                                        permitted_params[:second].to_i)

    if permitted_params[:second] == "0"
      redirect_to request.referer, notice: "Bookmark🔖 removed"
    else
      redirect_to request.referer, notice: "Bookmarked🔖 at #{format_bookmarked_at_second(interaction.bookmarked_at_second)}"
    end
  end

  private

  def format_bookmarked_at_second(second)
    Time.at(second).utc.strftime("%H:%M:%S")
  end

  def permitted_params
    params.permit(:episode_id, :second)
  end
end
