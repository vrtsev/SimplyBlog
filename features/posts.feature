Feature: Posting on site
  In order to share my news with other people
  As a registered user
  I want to post on site

  Background:
    Given following users:
      | name  | email          | visible | role |
      | David | david@blog.net | true    | 0    |
    And i sign in as 'david@blog.net'

  Scenario: Redirect to login page if user not logged in
    Given I as guest
    When i visit new post page
    Then site should redirect to login page

  Scenario: Hide new post button when not logged in
    Given I as guest
    When i visit home page
    Then page should not contain link 'Создать запись'

  Scenario: Show new post button when logged in
    When i visit my profile page
    Then page should contain link 'Создать запись'

  Scenario: visit page to create new post
    When i visit my profile page
    And i press button 'Создать запись'
    Then site should redirect to new post page
    And page should contain header 'Сообщение'
    And page should contain post fields
    And page should contain button 'Сохранить'

  Scenario: creating new post
    When i visit new post page
    And i fill 'post[title]' field with 'Hello world'
    And i fill 'post[content]' field with 'Some content in my post'
    And i press confirmation button
    Then site should redirect to show post page
    And page should contain title 'Hello world'
    And page should contain content 'Some content in my post'
    And page should contain post author 'David'

  Scenario: displaying created post on profile page
    Given David's post with data:
      | title         | content                     |
      | One more post | Today is very shiny weather |
    When i visit my profile page
    Then page should contain title 'One more post'
    And page should contain content 'Today is very shiny weather'

  Scenario: visit page of created post
    Given David's post with data:
      | title        | content              |
      | About my dog | My dogs name is Bark |
    When i visit my profile page
    And i click on title 'About my dog'
    Then site should redirect to show post page
    And page should contain title 'About my dog'
    And page should contain content 'My dogs name is Bark'

  Scenario: visiting page to edit existed post
    Given David's post with data:
      | title        | content              |
      | About my dog | My dogs name is Bark |
    When i visit show post page
    And i click on link 'Изменить'
    Then site should redirect to edit post page
    And page should have field 'post[title]' filled with 'About my dog'
    And page should have field 'post[content]' filled with 'My dogs name is Bark'
    And page should contain button 'Сохранить'

  Scenario: editing existed post
    Given David's post with data:
      | title        | content              |
      | About my dog | My dogs name is Bark |
    When i visit edit post page
    And i fill 'post[title]' field with 'Edited post'
    And i fill 'post[content]' field with 'There is new post content'
    And i click on button 'Сохранить'
    Then site should redirect to show post page
    And page should contain title 'Edited post'
    And page should contain content 'There is new post content'
    And page should contain post author 'David'

    When i visit my profile page
    Then page should not contain title 'About my dog'
    And page should not contain content 'My dogs name is Bark'

  Scenario: listing all posts
    Given David's post with data:
      | title      | content              |
      | First day  | I visited cafe       |
      | Second day | I met my best friend |
    When i visit my profile page
    Then page should contain title 'First day'
    And page should contain title 'Second day'

  Scenario: destroing post
    Given David's post with data:
      | title    | content             |
      | Bad post | This is bad content |
    When i visit show post page
    And i click on link 'Удалить пост'
    Then site should redirect to my profile page
    And page should not contain title 'Bad post'
    And page should not contain content 'This is bad content'

  Scenario: pin post
    Given David's post with data:
      | title       | content           | pin  |
      | Pinned post | Important content | true |
    When i visit my profile page
    Then page should contain title 'Pinned post'
    And page should contain content 'Important content'
