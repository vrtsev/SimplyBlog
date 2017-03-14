Feature: Login and registration on site
  In order to use all features on site
  As guest
  I want to register and login to site

  Scenario: Registration on site
    Given I am a random guest
    When I visit registration page
    And I fill registration fields
    And Press register button
    Then Site should redirect me to my new profile page

  Scenario: New profile page
    Given I as registered user for new profile
    When I first time visit my profile page
    Then Page should not contain any posts or categories

  Scenario: Logout
    Given I as registered user for logout
    When I click logout link
    Then Site should redirect me to landing page

  Scenario: Login
    Given I am a guest for login
    When I visit login page
    And Login to site
    Then Site should redirect me to my profile page
