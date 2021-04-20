FactoryBot.define do
  factory :feed do
    rss_url { "https://url_of_feed_rss.rss" }
    pic_url { "https://url_of_feed_pic.png" }
    external_id { "xyz123" }
    name { "Awesome Feed" }
  end
end
