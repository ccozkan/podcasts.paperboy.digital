# frozen_string_literal: true

class FeedSearcherService
  def initialize(query)
    @query = query
  end

  def call
    url = "https://itunes.apple.com/search?term=#{@query}&entity=podcast"
    response = RequestMakerService.new(url).call
    format_response(response.payload) if response.success?
  end

  private

  def format_response(response)
    results = []
    response = JSON.parse(response)
    response['results'].each do |r|
      result = { 'rss_url': r['feedUrl'],
                 'pic_url': r['artworkUrl600'],
                 'provider': r['artistName'],
                 'name': r['trackName'],
                 'external_id': r['collectionId'].to_s
                 'last_published_at': r['release_date']
                 }
      results << result
    end
    results
  end
end
