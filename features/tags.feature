Feature: tagging
  In order to quickly find needed post
  As an guest and registered user
  I want to assign tags for each post

  Background:
    Given following users:
      | name  | email          | visible | role |
      | Jane  | jane@blog.net  | true    | 0    |
      | David | david@blog.net | true    | 0    |
    And David's post with data:
      | title         | content                    | tags        |
      | My first trip | Egypt is wonderful country | egypt       |
      | Filadelphia   | It was unusual trip ever   | filadelphia |
    And i sign in as 'david@blog.net'

  Scenario: display tags under posts
    When i visit my profile page
    Then page should contain tag link 'egypt'
    And page should contain tag link 'filadelphia'

  Scenario: find all posts with specified tag
    When i visit my profile page
    And i click on tag link 'egypt'
    Then site should redirect to /posts?tag=egypt
    And page should not contain post title link 'Filadelphia'
    And page should contain post title link 'My first trip'

  Scenario: find all posts by tag on other user's profile
    Given Jane's post with data:
      | title       | content             | tags    |
      | Siamese cat | Very beautiful cats | siamese |
      | Sphynx cat  | Very strange breed  | sphynx  |
    And i sign in as 'david@blog.net'
    When i'm on Jane's profile
    And i click on tag link 'siamese'
    Then url should be for Jane's 'siamese' tag
    And page should not contain post title link 'Sphynx cat'
    And page should contain post title link 'Siamese cat'
