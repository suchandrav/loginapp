Feature: MY ACCOUNT

  Scenario Outline: Change email address
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    And I login with a brand new group account to '<service>' for the opco '<opco>', with MSISDN='<msisdn>', password='<password>' and email='<email>'
    When I click on My account
    Then I see a page with a headline that says 'My account'
    And I click the update email button
    And I see the text 'Enter your new email address' anywhere in the page
    And I generate the next correlative email address
    And I enter a new email '<new_email>'
    And I click submit new email
    And I see a page with a headline that says 'My account'
    And I see the text 'Verify my email address now' anywhere in the page

  Examples:
    | opco | service       | msisdn         | password       | email         | new_email     |
    | gb   | music         | current_msisdn | usual_password | current_email | current_email |
    | de   | contacts      | current_msisdn | usual_password | current_email | current_email |
    | de   | contentbackup | current_msisdn | usual_password | current_email | current_email |
    | it   | contacts      | current_msisdn | usual_password | current_email | current_email |
    | it   | nwab          | current_msisdn | usual_password | current_email | current_email |
    | it   | contentbackup | current_msisdn | usual_password | current_email | current_email |

  Scenario Outline: Change email address invalid address
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    Given I login with a brand new group account to '<service>' for the opco '<opco>', with MSISDN='<msisdn>', password='<password>' and email='<email>'
    When I click on My account
    Then I see a page with a headline that says 'My account'
    And I click the update email button
    And I enter a new email '<new_email>'
    And I click submit new email
    And I wait '3' seconds
    And I see the text 'is not a valid email address' anywhere in the page

  Examples:
    | service | opco | msisdn         | password       | email         | new_email                |
    | music   | gb   | current_msisdn | usual_password | current_email | test_new_email_1_invalid |
    | music   | it   | current_msisdn | usual_password | current_email | test_new_email_2_invalid |
    | music   | cz   | +420776959555  | usual_password | current_email | test_new_email_2_invalid |
    
  Scenario: Change Email Address with one already used
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    Given I login with a brand new group account to 'music' for the opco 'gb', with MSISDN='current_msisdn', password='usual_password' and email='current_email'
    When I click on My account
    Then I see a page with a headline that says 'My account'
    When I click the update email button
    And I enter a new email 'current_email'
    Then I click new email
    And I take a screenshot
    Then I see the text 'There's already an account registered with the email address you've entered' in the popup

  Scenario Outline: : word
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    And I login with a brand new group account to '<service>' for the opco '<opco>', with MSISDN='<msisdn>', password='<password>' and email='<email>'
    When I click on My account
    And I see a page with a headline that says 'My account'
    And I click the change password link
    And I see the text 'Please enter and confirm your new password' anywhere in the page
    And I enter my current password with '<password>'
    And I enter a new password with '<new_password>'
    And I confirm my new password with '<new_password>'
    And I wait '4' seconds
    And I click submit new password
    And I wait '4' seconds
    And I see the text 'Password changed' anywhere in the page
    And I wait '4' seconds
    And I click the OK button in the Password changed dialog
    And I see a page with a headline that says 'My account'
    And I click the back button on the my account page
    And I see login cookie present
    And I click logout
    And I see login cookie not present
    And I go to login page
    Then I login with '<msisdn>' as user name and '<password>' as password
    And I see login failure message
    And I login with '<msisdn>' as user name and '<new_password>' as password
    And I see login cookie present

  Examples:
    | opco | service       | msisdn         | password       | new_password | email         |
    | gb   | music         | current_msisdn | usual_password | Victor1234   | current_email |
    | it   | contacts      | current_msisdn | usual_password | Password1    | current_email |
    | it   | nwab          | current_msisdn | usual_password | Password1    | current_email |
    | it   | contentbackup | current_msisdn | usual_password | Password1    | current_email |
    | de   | contacts      | current_msisdn | usual_password | Password1    | current_email |
    | de   | contentbackup | current_msisdn | usual_password | Password1    | current_email |


  Scenario: Verify Email Address
    Given I generate the next correlative email address
    Given I login with a brand new group account to 'music' for the opco 'gb', with MSISDN='usual_msisdn_5', password='usual_password' and email='current_email'
    When I click on verify Email with 'current_email'
    Then I see Email verification success message 'Email Sent Successfully'

  Scenario: Verify already verified Email Address
    Given I open 'music' site for the opco 'gb'
    And I click logout if necessary
    And I see login cookie not present
    And I go to login page
    When I login with 'victorrodr.iguezg.i.l@gmail.com' as user name and 'usual_password' as password
    Then I see login cookie present
    When I click on verify Email with 'victorrodr.iguezg.i.l@gmail.com'
    Then I see Email verification success message 'Email Verified'

  Scenario: Verify MSISDN
    Given I open 'music' site for the opco 'gb'
    And I click logout if necessary
    And I see login cookie not present
    And I go to login page
    When I login with '+447785456599001' as user name and 'usual_password' as password
    Then I see login cookie present
    When I click on verify MSISDN with '447785456599001'
    Then I see MSISDN verification success message 'Number Verified'
