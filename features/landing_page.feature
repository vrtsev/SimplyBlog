Feature: Display site landing page
  In order to know which options to register exists
  As an guest
  I want to see a list of available registration buttons

  Background:
    Given I as guest

  Scenario: Display all important components
    When i visit home page
    Then page should contain text 'Simplyblog'
    Then page should contain text 'Задача SimplyBlog'
    Then page should contain link 'Войти'
    Then page should contain link 'Регистрация'

  Scenario: Display the list of all available buttons for registration
    When i visit home page
    Then page should contain link 'Бесплатная регистрация'
    And page should contain link 'Войти с помощью VK'
    And page should contain link 'Войти с помощью Google'
