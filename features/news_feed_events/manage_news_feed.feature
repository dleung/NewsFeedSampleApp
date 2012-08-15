Feature:  Manage news feed should work
  In order to manage my news eed
  As a regular user
  I want to create and delete a new news feed events

  Background:
    Given several news feed exists
    And I am on the news feed page

  Scenario:  I delete a news feed
    And I try to delete a news feed
    Then the news feed gets deleted
    
  Scenario:  I create a news feed
    And I select to create an object
    And I fill in "news_feed_object_name" with "My New Name"
    And I click "Create News Feed"
    Then a new news feed should exist with name "My New Name"

  Scenario:  I search for a news feed
    And I select to create an object
    And I fill in "q" with "Create"
    And I click "search_icon"
    Then I should see 1 results    
