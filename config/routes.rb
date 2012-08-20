NewsFeedSampleApp::Engine.routes.draw do
  root :to => redirect("/news_feed_events")
  
  resources :news_feed_events do
    get :search, on: :collection
  end
end
