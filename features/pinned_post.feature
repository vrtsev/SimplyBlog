Feature: Pin user post
  In order to see important posts in top of page
  As current user
  I want to see pinned post in top

  Scenario: Pin post on profile page
    Given current user Admin
    And pinned post
    When I visit my profile page
    Then page should contains pinned post
    And the same post in timeline