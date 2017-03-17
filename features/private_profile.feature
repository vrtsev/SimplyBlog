Feature: Ability to make profile private
  In order to hide profile page
  As current user
  I want to see warning page if I'm trying to visit private profile

  Scenario: Render warning page if profile is private
    Given current user Admin
    And user David with private profile
    When I visit David page
    Then Site should render warning page