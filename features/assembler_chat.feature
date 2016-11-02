Feature: Assembler Chat
  Users want to be able to execute assembler in their chat messages (really)
  They want to type in assembler commands and see the machine state update
  They want to see other users do this too

  @javascript
  Scenario: We can post an assembler command to the list and see the state change
    Given an empty list
    When I post "mov ax, 1d" to the list
    Then I see register "AX" is 0000000000000001

  @javascript
  Scenario: We can see state updates from other users
    Given an empty list
    When Geoff posts "mov ax, 1d" to the list
    Then I see register "AX" is 0000000000000001

  @javascript
  Scenario: Our commands operate on the previous state without clobbering it
    Given an empty list
    When I post "mov ax, 1d" to the list
    And I post "mov bx, 2d" to the list
    And I post "mov cx, 3d" to the list
    And I post "mov dx, 4d" to the list
    Then I see register "AX" is 0000000000000001
    And I see register "BX" is 0000000000000010
    And I see register "CX" is 0000000000000011
    And I see register "DX" is 0000000000000100

  @javascript
  Scenario: We can run a simple program
    Given an empty list
    When I post "mov bx, 1d" to the list
    And I post "add bx, 2d" to the list
    And I post "inc ax" to the list
    And I post "sub bx, ax" to the list
    Then I see register "AX" is 0000000000000001
    And I see register "BX" is 0000000000000010
    And I see register "CX" is 0000000000000000
    And I see register "DX" is 0000000000000000

  @javascript
  Scenario: Our commands can use all sorts of numbers
    Given an empty list
    When I post "mov ax, 255" to the list
    Then I see register "AX" is 0000000011111111
    When I post "mov ax, 254d" to the list
    Then I see register "AX" is 0000000011111110
    When I post "mov ax, FDh" to the list
    Then I see register "AX" is 0000000011111101
    When I post "mov ax, 11111100b" to the list
    Then I see register "AX" is 0000000011111100
    When I post "mov ax, 373o" to the list
    Then I see register "AX" is 0000000011111011
