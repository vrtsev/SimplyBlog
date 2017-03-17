Feature: Display profiles of other users
  In order to know that correct layout rendered
  As a logged user
  I want to visit other profiles

  Scenario: Display content of other profile
    Given I as user Admin wih posts and categories
    And user David wih posts and categories
    When i visit David profile
    Then i should see David name
    And i should see David posts
    And i should see David categories

  Scenario: Display correct view for other profiles
    Given I as user Admin wih posts and categories
    And user David wih posts and categories
    When i visit David profile
    Then page should not have link for new category

  Scenario: Display correct view for posts of other users
    Given I as user Admin wih posts and categories
    And user David wih posts and categories
    When i visit post page of David profile
    Then i should not have ability to manage David post

  Scenario: Display correct view for post comments of other users
    Given I as user Admin wih posts and categories
    And user David wih posts and categories
    And few comments on David post
    When i visit post page of David profile
    Then i should not have ability to manage comments on David page
    And have ability to manage my comments

  Scenario: Display correct view for category of other users
    Given I as user Admin wih posts and categories
    And user David wih posts and categories
    When i visit category page on David profile
    Then i should not have ability to manage David category
