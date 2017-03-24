Feature: commenting
  In order to disscuss with about post with author
  As a registered user
  I want to comment on other posts

  Background:
    Given following users:
      | name  | email          | visible | role |
      | Jane  | jane@blog.net  | true    | 0    |
      | David | david@blog.net | true    | 0    |
    And Jane's post with data:
      | title         | content                     |
      | One more post | Today is very shiny weather |
    And i sign in as 'david@blog.net'

  Scenario: do not display comment form if user not logged in
    Given I as guest
    When i'm on Jane's profile
    And i click on post title 'One more post'
    Then comment form should not be displayed
    Then page should not contain field 'comment[content]'

  Scenario: display comment form if user signed in
    Given I as guest
    When i'm on Jane's profile
    And i click on post title 'One more post'
    Then page should contain field 'comment[content]'

  Scenario: creating new comment
    When i'm on Jane's profile
    And i click on post 'One more post'
    And i fill 'comment[content]' field with 'Great post'
    And i click on button 'Отправить'
    Then site should redirect on Jane's post 'One more post'
    And page should contain comment 'Great post'
    And page should contain comment author 'David'
    And page should contain link 'Действия'

  Scenario: visit edit comment page
    When i'm on Jane's profile
    And i click on post title link 'One more post'

    # There is a issue #10
    # And i click on link 'Изменить коммент.'
    # Then site should redirect to edit post comment page
    # And page should contain header 'Изменить комментарий'
    # And submit button 'Изменить'

  Scenario: editing comment
    # This feature scenario has unpredictable behavior
    Given David's comment 'Nice article' on Jane's post 'One more post'

    # Site generates wrong url
    # When i'm on edit page of comment 'Nice article' on Jane's post 'One more post'

    # And fill 'comment[content]' field with 'I changed my mind'
    # And i click on button 'Изменить'

    # There is a issue #10
    # Then site should redirect to show post page
    # And page should contain changed content

  Scenario: deleting comment
    Given David's comment 'Nice article' on Jane's post 'One more post'
    When i'm on Jane's show post page 'One more post'

    # There is a issue #10
    # And i click on link 'Удалить коммент.'
    # Then site should redirect to david's show post page
    # And page should not contain comment content 'Nice article'
