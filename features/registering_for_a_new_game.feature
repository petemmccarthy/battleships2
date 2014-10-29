
Feature: Registering for a game
  In order to register for a new game
  As a player
  I want to enter my name and be recognised

  Scenario: Registering
    Given I am on the homepage
    When I enter my name
    And click "Register"
    Then I should see "Hello Peter"

