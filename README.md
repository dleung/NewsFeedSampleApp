Welcome to the NewsFeedSampleApp wiki!

This is a sample application I created as a demonstration of the newsfeed gem, as well as a sample of my code styles.  

[NewsFeed Sample Application Demo Site](http://capykoa.com/news_feed)

Notes
* I wrote all the [CSS ](https://github.com/dleung/NewsFeedSampleApp/blob/master/app/assets/stylesheets/news_feed_sample_app/news_feed.css.scss), [controllers](https://github.com/dleung/NewsFeedSampleApp/blob/master/app/controllers/news_feed_sample_app/news_feed_events_controller.rb), and [slim](https://github.com/dleung/NewsFeedSampleApp/blob/master/app/views/news_feed_sample_app/news_feed_events/_index.html.slim).  This does not include some of the plugins I used like DataTables or Chosen.
* Before I start implementation, I always like to do a mockup of the page.
* I believe in writing tests, not only for test driven development, but also for solidification of the feature and bug fixing.  [Controller RSpec Example](https://github.com/dleung/NewsFeedSampleApp/blob/master/spec/controllers/news_feed_events_controller_spec.rb)
and [Cucumber Example](https://github.com/dleung/NewsFeedSampleApp/blob/master/features/news_feed_events/manage_news_feed.feature)
* The [News Feed Gem](https://github.com/dleung/NewsFeed) that I wrote is included in this app.
* This sample app is deployed as a [mountable engine](http://edgeguides.rubyonrails.org/engines.html) on my website, also built using Ruby on Rails.  
* This is a scaled down version of the news feed I developed for [Quosap](www.quosap.com), which includes significant more customizations and email handling.