Feature: Perform CRUD actions on posts
  As a logged user
  I want to manage my posts

  Scenario: Create post
    Given Post creation form
    And Filled data in form fields
    When I click button for post creation
    Then Site should redirect to created post
    And Page should contain filled content

  Scenario: Show post
    Given List of user posts
    When I click on choosen post title
    Then Site should redirect to choosen post
    And Page should contain content

  Scenario: Edit post
    Given Post edit form
    And Filled content of this post
    When I change filled content
    And Press button for save edited post
    Then Site should redirect to edited post
    And Page should contain changed content

  Scenario: Delete post
    Given Page with post
    When I click delete link
    Then Site should redirect to profile page
    And Page should not contain delete post content