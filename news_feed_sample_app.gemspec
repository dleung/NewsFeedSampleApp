$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "news_feed_sample_app/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "news_feed_sample_app"
  s.version     = NewsFeedSampleApp::VERSION
  s.authors     = ["David Leung"]
  s.email       = ["dleung@quosap.com"]
  s.homepage    = ""
  s.summary     = "A stand alone sample application utilizing gem 'newsfeed'."
  s.description = "This app allows users to create newsfeed events associated to objects."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'obscenity'
  s.add_development_dependency "sqlite3"
end
