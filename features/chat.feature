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
  Scenario: Other users can add messages and we see them # also tests usernames and should be broken out
    Given an empty list
    When Geoff sets his username
    And Geoff adds a message to the list
    Then I see Geoff's message in the list

  @javascript
  Scenario: Messages are displayed oldest to newest
    Given an empty list
    When Geoff sets his username
    And Geoff adds a message to the list
    And I add a message to the list
    Then I see Geoff's message first, then mine
