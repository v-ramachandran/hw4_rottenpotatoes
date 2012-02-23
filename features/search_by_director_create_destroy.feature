Feature: Check Create and Deletion with search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and serach on director information in movies I enter

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: add movie to database
  When I go to the Create New Movie page
  And I fill in "Title" with "Endhiran"
  And I fill in "Director" with "Shankar"
  And I press "Save Changes"
  And I check the following ratings: G, PG, PG-13, NC-17, R
  And I press "Refresh"
  And I go to the details page for "Endhiran"
  Then the director of "Endhiran" should be "Shankar"

