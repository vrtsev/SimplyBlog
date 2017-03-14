Feature: Display site landing page
  In order to know which options to register exists
  As an guest
  I want to see a list of available registration buttons

  Scenario: Display the list of all available buttons for registration
    Given I am a guest
    When I visit the landing page
    Then I see all available registrations buttons