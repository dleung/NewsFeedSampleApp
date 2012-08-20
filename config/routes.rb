NewsFeedSampleApp::Engine.routes.draw do
  root :to => "news_feed_events#index"
  
  resources :news_feed_events do
    get :search, on: :collection
  end
end
