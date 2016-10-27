Feature: Chat
  Users want to chat to their pals by adding messages to a list
  Every user can see the board update as they and others add to it

  Scenario:
    Given an empty list
    When I add a message to the list
    Then I see my message at the bottom of the list

  Scenario:
    Given an empty list
    When Geoff adds a message to the list
    Then I see Geoff's message at the bottom of the list

  Scenario:
    Given an empty list
    When Geoff adds a message to the list
    And I add a message in reply
    Then I see Geoff's message first
    And I see my message second
