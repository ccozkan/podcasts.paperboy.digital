class EpisodesReceiverService
  def initialize(rss_url)
    @rss_url = rss_url
  end

  def call
    response = RequestMakerService.new(@rss_url).call

    if response.success?
      begin
        xml = response.payload.body
        episodes = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
                   .entries.sort_by(&:published).reverse
        data = format_response(episodes)
      rescue StandardError => e
        OpenStruct.new({ success?: false, error: e })
      else
        OpenStruct.new({ success?: true, payload: data })
      end
    else
      response
    end
  end

  private

  def format_response(response)
    raise StandardError.new('Response is blank, might be wrong or outdated url') if response.blank?

    results = []
    response.each do |e|
      result = { 'audio_url': e.enclosure_url,
                 'external_id': e.entry_id,
                 'published_at': e.published,
                 'title': e.title,
               }
      results << result
    end
    results
  end
end
