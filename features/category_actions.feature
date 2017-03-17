Feature: Perform CRUD actions on categories
  As a logged user
  I want to manage my categories

  Scenario: Create category
    Given Category creation form
    When I fill up fields
    And Press create category button
    Then Site should redirect to category page
    And Page should contain category name

  Scenario: Show categories
    Given List of categories
    When I visit profile page
    Then page should contain categories

  Scenario: Edit category
    Given Category page
    When I click category settings button
    And Fill up fields for category
    And Press save button
    Then Site should redirect to profile page
    And page should contain edited category

  Scenario: Delete category
    Given Category page for delete
    When I click category settings button
    And Press delete button
    Then Site should redirect to profile page
    And page should not contain deleted category
