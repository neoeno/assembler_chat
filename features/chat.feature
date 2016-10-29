Feature: Chat
  Users want to chat to their pals by adding messages to a list
  Every user can see the board update as they and others add to it
  Users start with a default username
  Users can edit their username for future messages

  @javascript
  Scenario: We can post a message to the list
    Given an empty list
    When I add a message to the list
    Then I see my message in the list
    And my message field is reset

  @javascript
  Scenario: Our username is shown alongside our message
    Given an empty list
    When I add a message to the list
    Then I see my username by my message in the list

  @javascript
  Scenario: We can change our username
    Given an empty list
    When I set my username to Kay
    And I add a message to the list
    Then I see my username by my message in the list

  @javascript
  Scenario: Other users can add messages
    Given an empty list
    When Geoff adds a message to the list
    Then I see Geoff's message in the list

  @javascript
  Scenario: Messages are displayed oldest to newest
    Given an empty list
    When Geoff adds a message to the list
    And I add a message to the list
    Then I see Geoff's message first, then mine

  @javascript
  Scenario: We can see messages sent before we visited the site
    Given an empty list
    When Geoff adds a message to the list
    And I open the chat page
    Then I see Geoff's message in the list
