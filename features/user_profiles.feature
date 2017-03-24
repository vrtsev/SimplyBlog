Feature: user profiles
  In order to store all my posts and other data
  As registered user
  I want to manage my profile page

  Background:
    Given following users:
      | name | email         | visible | role |
      | John | john@blog.net | true    | 0    |
    And i sign in as 'john@blog.net'

  Scenario: display warning page if profile is private
    Given following users:
      | name | email         | visible | role |
      | Kate | kate@blog.net | false   | 0    |
    When i'm going to visit Kate's profile
    Then site should redirect to /422
    And page should contain header 'Это действие недоступно'
    And page should contain text 'предпочел скрыть свою страницу'
    And page should contain footer 'Ошибка 422. Доступ запрещен'

  Scenario: display user profile settings
    When i visit profile edit page
    Then page should contain header 'Редактирование профиля'
    And page should contain field 'user[visible]'
    And page should contain checkbox 'Сделать мою страницу публичной'
    And page should include user profile fields
    And page should contain button 'Сохранить'

  Scenario: visiting profile of other user
    Given following users:
      | name | email         | visible | role |
      | Dave | dave@blog.net | true    | 0    |
    And Dave's post with data:
      | title         | content                     |
      | One more post | Today is very shiny weather |
      | Good moments  | I love this beautiful blog  |
    When i'm on Dave's profile
    Then page should not contain link 'Новая категория'
    And page should contain Daves post 'One more post'
    And page should contain Daves post 'Good moments'
