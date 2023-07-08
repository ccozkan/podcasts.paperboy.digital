class BrowseSearchController < SearchFeedsController
  CATEGORY_MAP = {
    arts: "Arts",
    business: "Business",
    comedy: "Comedy",
    education: "Education",
    fiction: "Fiction",
    government: "Government",
    history: "History",
    health_and_fitness: "Health &amp; Fitness",
    kids_and_family: "Kids &amp; Family",
    leisure: "Leisure",
    music: "Music",
    news: "News",
    religion_and_spirituality: "Religion &amp; Spirituality",
    science: "Science",
    society_and_culture: "Society &amp; Culture",
    sports: "Sports",
    technology: "Technology",
    true_crime: "True Crime",
  }.freeze
  ALLOWED_CATEGORIES = CATEGORY_MAP.keys

  before_action :ensure_category_allowed, only: :show

  def show
    @categories = CATEGORY_MAP

    search_results = retrieve_search_results(params[:category])
    if search_results.empty?
      @no_results_found = true
    else
      @already_subscribed = current_user.feeds.pluck(:external_id) if current_user
      @pagy, @items = pagy_array(search_results)
    end
    render "search_feeds/index"
  end

  def ensure_category_allowed
    category = params[:category]

    redirect_to search_path unless ALLOWED_CATEGORIES.include?(category.to_sym)
  end
end
