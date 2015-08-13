@plugin @plagiarism_moorsp
Feature: Show student disclosure to student
  In order to be notified about plagiarism checking
  As a student
  I need to see the plagiarism check student disclosure

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 1 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
      | student1 | C1 | student |
    And I log in as "admin"
    And I navigate to "Advanced features" node in "Site administration"
    And I set the field "Enable plagiarism plugins" to "1"
    And I press "Save changes"
    And I navigate to "Moorsp" node in "Site administration>Plugins>Plagiarism"
    And I set the field "Enable Moorsp" to "1"
    And I set the field "Enable Moorsp for assign" to "1"
    And I set the field "Enable Moorsp for workshop" to "1"
    And I set the field "Student Disclosure" to "Test student disclosure"
    And I press "Save changes"
    And I log out
    And I log in as "teacher1"
    And I follow "Course 1"
    And I turn editing mode on


  @javascript
  Scenario: View plagiarism disclosure statement when submitting to assignment
    Given I add a "Assignment" to section "1" and I fill the form with:
      | Assignment name | Test assignment |
      | Description | Test assignment for Moorsp |
      | Require students click submit button | Yes |
      | Enable Moorsp | Yes |
      | Show plagiarism info to student | Always |
    And I log out
    And I log in as "student1"
    And I follow "Course 1"
    And I follow "Test assignment"
    When I press "Add submission"
    Then I should see "Test student disclosure"

  @javascript
  Scenario: View plagiarism disclosure statement when submitting to workshop
    Given I add a "Workshop" to section "1" and I fill the form with:
      | Workshop name | Test workshop |
      | Description | Test workshop for Moorsp |
      | Instructions for submission | Submit a file to be evaluated |
      | Enable Moorsp | Yes |
    And I change phase in workshop "Test workshop" to "Submission phase"
    And I log out
    And I log in as "student1"
    And I follow "Course 1"
    And I follow "Test workshop"
    When I press "Start preparing your submission"
    Then I should see "Test student disclosure"