Feature: Assembler Chat
  Users want to be able to execute assembler in their chat messages (really)
  They want to type in assembler commands and see the machine state update
  They want to see other users do this too

  @javascript
  Scenario: We can post an assembler command to the list and see the state change
    Given an empty list
    When I post "mov ax, 1d" to the list
    Then I see register AX change to 1
