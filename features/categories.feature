Feature: categories
  In order to structure all my post
  As a registered user
  I want to use categories

  Background:
    Given following users:
      | name  | email          | visible | role |
      | Jane  | jane@blog.net  | true    | 0    |
      | David | david@blog.net | true    | 0    |
    And i sign in as 'david@blog.net'

  Scenario: display button for category creation if i'm om my profile
    When i visit my profile page
    Then page should contain link 'Новая категория'

  Scenario: visiting new category creation page
    When i visit my profile page
    And i click on link 'Новая категория'
    Then site should redirect to new category page
    And page should contain header 'Создание новой категории'
    And page should contain field 'category[name]'
    And page should contain field 'category[description]'
    And page should contain button 'Сохранить'

  Scenario: creating new category
    When i visit new category page
    And i fill 'category[name]' field with 'Trips'
    And i click on button 'Сохранить'
    Then site should redirect to show category page
    And page should contain header 'Категория "Trips"'
    And page should contain text 'Нет записей'

  Scenario: visiting category page with included posts
    Given David's category with name 'Trips'
    And David's post with data:
      | title         | content                    | category |
      | My first trip | Egypt is wonderful country | Trips    |
      | Filadelphia   | It was unusual trip ever   | Trips    |
    When i visit show category page
    Then page should contain post title link 'My first trip'
    And page should contain post content 'Egypt is wonderful country'
    And page should contain post title link 'Filadelphia'
    And page should contain post content 'It was unusual trip ever'

  Scenario: visiting category page of other users
    Given Jane's category with name 'Cats'
    And Jane's post with data:
      | title       | content             | category |
      | My cat      | My lovely pet       | Cats     |
      | Siamese cat | Very beautiful cats | Cats     |
    And i sign in as 'david@blog.net'
    When i'm on Jane's profile
    And i click on link 'Cats'
    Then url should be for Jane's 'Cats' category
    And page should contain post title link 'My cat'
    And page should contain post content 'My lovely pet'
    And page should contain post title link 'Siamese cat'
    And page should contain post content 'Very beautiful cats'

  Scenario: visit edit category page
    Given David's category with name 'Trips'
    When i visit my profile page
    And i click on link 'Trips'
    And i click on link 'Настройка'
    Then page should contain header 'Настройка категории'
    And page should contain field 'category[name]'
    And page should contain field 'category[description]'
    And page should contain button 'Сохранить'

  Scenario: editing existed category
    Given David's category with name 'Trips'
    When i visit edit category page
    And i fill 'category[name]' field with 'World trips'
    And i fill 'category[description]' field with 'Some interesting stories'
    And i click on button 'Сохранить'

    # Should redirect to edited category page
    Then site should redirect to my profile page
    And page should not contain link 'Trips'
    And page should contain link 'World trips'

  Scenario: deleting category
    Given David's category with name 'Trips'
    When i visit edit category page
    And i click on link 'Удалить'

    # Should redirect to edited category page
    Then site should redirect to my profile page
    And page should not contain link 'Trips'
