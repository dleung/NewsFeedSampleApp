$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "news_feed_sample_app/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "news_feed_sample_app"
  s.version     = NewsFeedSampleApp::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of NewsFeed."
  s.description = "TODO: Description of NewsFeed."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.7"
  s.add_dependency 'obscenity'

  s.add_development_dependency "sqlite3"
end
