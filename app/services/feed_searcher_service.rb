# frozen_string_literal: true

class FeedSearcherService
  def initialize(query)
    @query = ActiveSupport::Inflector.transliterate(query)
  end

  def call
    response = RequestMakerService.new(url).call
    return response unless response.success?

    result = format_payload(response.payload)
  rescue StandardError => e
    ServiceResponse.new(error: e)
  else
    ServiceResponse.new(payload: result)
  end

  private

  def url
    "https://itunes.apple.com/search?term=#{@query}&media=podcast"
  end

  def format_payload(payload)
    data = JSON.parse(payload)

    results = []
    data["results"].each do |feed|
      next if feed["feedUrl"].nil?

      result = { 'rss_url': feed["feedUrl"],
                 'pic_url': feed["artworkUrl600"],
                 'provider': feed["artistName"],
                 'name': feed["trackName"],
                 'external_id': feed["collectionId"].to_s,
                 'genres': feed["genres"].delete("Podcasts") && feed["genres"].join(" ~ "),
                 'release_date': feed["releaseDate"].split("T").first }
      results << result
    end
    results
  end
end
