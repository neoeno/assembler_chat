Feature: Assembler Chat
  Users want to be able to execute assembler in their chat messages (really)
  They want to type in assembler commands and see the machine state update
  They want to see other users do this too

  @javascript
  Scenario: We can post an assembler command to the list and see the state change
    Given an empty list
    When I post "mov ax, 1d" to the list
    Then I see register "AX" is 1

  @javascript
  Scenario: We can see state updates from other users
    Given an empty list
    When Geoff posts "mov ax, 1d" to the list
    Then I see register "AX" is 1

  @javascript
  Scenario: Our commands operate on the previous state without clobbering it
    Given an empty list
    When I post "mov ax, 1d" to the list
    When I post "mov bx, 2d" to the list
    When I post "mov cx, 3d" to the list
    When I post "mov dx, 4d" to the list
    Then I see register "AX" is 1
    Then I see register "BX" is 2
    Then I see register "CX" is 3
    Then I see register "DX" is 4
