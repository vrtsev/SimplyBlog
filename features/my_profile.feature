Feature: Display profile of current user
  In order to know that correct layout has been rendered
  As current user
  I want to see own posts, categories and login status

  Scenario: Display correct login status
    Given User 'Админ'
    And User posts
    And User categories
    When User visit his own page
    Then He can see login status 'Вы вошли как Админ'
    And He can see his posts
    And He can see his categories
