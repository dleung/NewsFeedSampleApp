require 'spec_helper'

Given /^several news feed exists$/ do
  user = User.create(name: "Buster")
  user.insertNewsFeed(:Create, user, user)
  user.insertNewsFeed(:Update, user, user)
  user.insertNewsFeed(:Delete, user, user)
  @news_feed = NewsFeedEvent.first
end

And /^I am on the news feed page$/ do
  visit('/')
end

And /^I try to delete a news feed$/ do
  find("#delete_#{@news_feed.id}").click
end

And /^the news feed gets deleted$/ do
  NewsFeedEvent.where(id: @news_feed.id).should be_blank
end

When /^I select to create an object$/ do
  select('Create', :from => 'action_type')
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => eval('"' + value + '"'))
end

When /^I click "([^"]*)"$/ do |field| 
  click_button(field)
end

When /^a new news feed should exist with name "My New Name"$/ do 
  NewsFeedEvent.where(text: "You have created a User: My New Name").should_not be_blank
end

Then /^I should see 1 results$/ do
  page.should have_css("li.by_news_feed", :count => 1)
end