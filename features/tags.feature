Feature: Tag system on site
  In order to know that tags system works correctly
  As an guest
  I want to use tags for serching posts

  Scenario: Display tags under post
    Given current user Admin
    And post of Admin with tags
    When I visit my profile
    Then I see tags under post

  Scenario: Search all post with tag
    Given current user Admin
    And 2 posts with same tag
    And 1 post with another tag
    When I click another tag
    Then I should see post with another tag