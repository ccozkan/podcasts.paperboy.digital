class BookmarkEpisodesController < ApplicationController
  before_action :authenticate_user!

  def update
    return unless permitted_params[:second]

    interaction = Interaction.bookmark!(permitted_params[:episode_id],
                                        current_user.id,
                                        permitted_params[:second].to_i)

    redirect_to request.referer, notice: "Bookmarked🔖 at second #{interaction.bookmarked_at_second}"
  end

  private

  def permitted_params
    params.permit(:episode_id, :second)
  end
end
