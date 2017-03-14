Feature: Perform CRUD actions on comments
  As a logged user
  I want to manage my comments

  Scenario: Create comment
    Given Post page
    And Comment creation form
    When I fill up comment form
    And Press create button
    Then Site should redirect to profile path
    And Post should contain comment with filled content

  Scenario: Show comments
    Given Posts page for comments
    And user posts
    And post comments
    When i click post title
    Then page should contain comments

  Scenario: Edit comment
    Given Post page
    And Post comment
    When I click comment edit button
    Then I should see comment editing form

    When I fill up comment edit form
    And press edit button
    Then site should redirect to post page
    And page should contains modified comment

  Scenario: Delete comment
    Given Post page(delete)
    And Post comment(delete)
    When I click comment delete link
    Then Site should redirect to post page
