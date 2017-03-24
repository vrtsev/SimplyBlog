Feature: Authorization
  In order to use all features on site
  As guest
  I want to authorize on site

  Background:
    Given I as guest
    And i visit home page

  Scenario: registration on site
    When i click on link 'Регистрация'
    And I fill registration fields with data:
      | name          | email          | password |
      | Administrator | admin@blog.net | password |
    And i click on button 'Продолжить'
    Then site should redirect to my profile page
    And page should contain text 'Вы вошли как Administrator'
    And page should contain text 'Был в сети'
    And page should contain text 'Новая категория'
    And page should contain text 'Нет записей'

  Scenario: visit login page
    When i click on link 'Войти'
    Then site should redirect to login page
    And page should contain header 'Вход в учетную запись'
    And page should contain field 'user[email]'
    And page should contain field 'user[password]'
    And page should contain button 'Войти на сайт'

  Scenario: login on site
    Given following users:
      | name | email         | visible | role |
      | John | john@blog.net | true    | 0    |
    When i click on link 'Войти'
    And i fill 'user[email]' field with 'John'
    And i fill 'user[password]' field with 'password'
    And i click on button 'Войти на сайт'
    # Authentification error
    # Then site should redirect to my profile page

    # RSpec.configure do |config|
    #   config.use_transactional_fixtures = false
    # end

  Scenario: Logout
    Given following users:
      | name | email         | visible | role |
      | John | john@blog.net | true    | 0    |
    And i sign in as 'john@blog.net'
    When i visit my profile page
    And i click on link 'Выйти'
    Then site should redirect to home page
