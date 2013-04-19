Feature: SIGN UP
  @subhash
  Scenario Outline: Group Signup
#    Given I generate the next correlative email address
#    And I generate the next correlative msisdn
    Given I open '<service>' preprod site for the opco '<opco>' in a logged out state
    And I go to preprod signup page
    When I signup with '<msisdn_input>' as number
    And I enter sms code with 'magic'
    And I enter email address with '<email>'
    And I enter password with '<password>'
    And I confirm password with '<password>'
    And I accept the terms and condition
    And I submit
    Then I see login cookie present

  Examples:
    | opco | service       | msisdn_input   | password  | email         |
    | de   | contentbackup | +491624119131 | Vodafone123 | s60gugle@googlemail.com |
    | mt   | mobileprotect | +35699952012  | Vodafone123 | vscmt@mailinator.com |
    | hu   | mobileprotect | +36703193529  | Vodafone123 | vschu@mailinator.com |
    | it   | contacts      | +393479100449 | Vodafone123 | vscit@mailinator.com |
    | ie   | contacts      | +353871791214 | Vodafone123 | vscie@mailinator.com |



Scenario Outline: ES Signup
 #   Given I generate the next correlative email address
 #   And I generate the next correlative ES msisdn
    And I open '<service>' preprod site for the opco 'es' in a logged out state
    And I go to signup page
    When I signup to ES with '<msisdn_input>' as number and <email> as email
    And I see a message page that says 'We have created your account, now you can login.'
    And I click the 'Log in' button in the message page
    And I login to ES with '<msisdn_input>' as user name and 'ES_password_1' as password
    And I add my email '<email>' because the account lacks an email address
    Then I see login cookie present

  Examples:
    | service  | msisdn_input      | email         |
    | contacts | +34610331770 | vsces@mailinator.com |
#    | contacts |34600000010   | current_email |
#    | contacts | +34600000011  | current_email |
#    | contacts | 0034600000012 | current_email |


  Scenario Outline: Signup error existing email
#    Given I generate the next correlative email address
#    And I generate the next correlative msisdn
#    And I login with a brand new group account to '<service>' for the opco '<opco>', with MSISDN='<msisdn>', password='<password>' and email='<email>'
#    And I click logout
#   And I go to signup page
#    And I generate the next correlative msisdn
#    When I signup with '<new_msisdn>' as number
    And I see Please check your phone now
    And I enter sms code with 'magic'
    And I enter email address with '<email>'
    And I enter password with '<password>'
    And I confirm password with '<password>'
    And I accept the terms and condition
    And I submit
    And I see Please check your phone now
#    And I take a screenshot
    Then I see the text 'already an account registered with the email address you' anywhere in the page

  Examples:
    | service | opco | msisdn         | new_msisdn     | password       | email         |
    | contentbackup   | de   | +491624119131 | +491624119131 | Vodafone123 | s60gugle@googlemail.com |

  Scenario Outline: Signup pages render
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    And I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to signup page
    And I see a page with a headline that says 'Sign up'
    Then I see the text 'Vodafone mobile number' anywhere in the page
    When I signup with '<msisdn_input>' as number
    And I see Please check your phone now
    And I see the text 'Required information' anywhere in the page
    And I see the text 'Code from SMS' anywhere in the page
    And I see the text 'Not received the code yet?' anywhere in the page
    And I see the text 'Click here' anywhere in the page
    And I see the text 'Email address' anywhere in the page
    And I see the text 'Password' anywhere in the page
    And I see the text 'Confirm password' anywhere in the page
    And I see the text 'The password must be at least 8 characters long' anywhere in the page
    And I see the text 'Show password' anywhere in the page
    And I see the text 'I have read and agree to the Privacy Policy' anywhere in the page
    Then I cancel sign up
    And I see a page with a headline that says 'Log in'

  Examples:
    | opco | service | msisdn_input   | email         |
    | gb   | music   | current_msisdn | current_email |

  Scenario Outline: Signup show password
    Given I generate the next correlative msisdn
    And I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to signup page
    And I see a page with a headline that says 'Sign up'
    When I signup with '<msisdn_input>' as number
    And I see the text 'Confirm password' anywhere in the page
    And I see the text 'Show password' anywhere in the page
    Then I click show password
    And I wait '3' seconds
    And I do not see the text 'Confirm password' anywhere in the page
    Then I cancel sign up
    And I see a page with a headline that says 'Log in'

  Examples:
    | opco | service | msisdn_input   |
    | gb   | music   | current_msisdn |

  Scenario: Signup page one : Empty fields error message
    Given I open 'music' site for the opco 'gb'
    And I click logout if necessary
    And I see login cookie not present
    And I go to signup page
    When I signup with '' as number
#     And I take a screenshot
    Then I see the text 'Please enter your phone number' anywhere in the page

  Scenario Outline: Signup page two : Empty fields error message
    Given I generate the next correlative msisdn
    And I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to signup page
    When I signup with '<msisdn>' as number
    And I enter sms code with ''
    And I enter email address with ''
    And I enter password with ''
    And I confirm password with ''
    And I accept the terms and condition
    And I submit
    Then I see Signup empty fields failure message

  Examples:
    | opco | service | msisdn         |
    | gb   | music   | current_msisdn |

  Scenario Outline: Signup page : Email validation
    Given I generate the next correlative msisdn
    And I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to signup page
    When I signup with '<msisdn>' as number
    And I enter sms code with 'magic'
    And I enter email address with '<bad_email>'
    And I enter password with '<password>'
    And I confirm password with '<password>'
    And I accept the terms and condition
    And I submit
    Then I see the text 'is not a valid email address' anywhere in the page

  Examples:
    | opco | service       | msisdn         | password  | bad_email                   |
    | gb   | music         | current_msisdn | Password1 | bad_emailunused.example.com |
    | ie   | contentbackup | current_msisdn | Password1 | bad_emailunused.example.com |

  Scenario Outline: Signup page : password validation different passwords
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    And I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to signup page
    When I signup with '<msisdn_input>' as number
    And I enter sms code with 'magic'
    And I enter email address with '<email>'
    And I enter password with '<password>'
    And I confirm password with '<bad_password>'
    And I accept the terms and condition
    And I submit
    Then I see the text 'Your passwords don't match' anywhere in the page

  Examples:
    | opco | service | msisdn_input   | password  | bad_password | email         |
    | gb   | music   | current_msisdn | Password1 | password1    | current_email |

  Scenario Outline: Signup page : password validation invalid passwords
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    And I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to signup page
    When I signup with '<msisdn_input>' as number
    And I enter sms code with 'magic'
    And I enter email address with '<email>'
    And I enter password with '<invalid_password>'
    And I confirm password with '<invalid_password>'
    And I accept the terms and condition
    And I submit
    Then I see the text 'Your password doesn't meet the security rules' anywhere in the page

  Examples:
    | opco | service | msisdn_input   | invalid_password | email         |
    | gb   | music   | current_msisdn | bbbb             | current_email |

  Scenario Outline: Signup page : MSISDN validation invalid code
    Given I generate the next correlative email address
    And I generate the next correlative msisdn
    And I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to signup page
    When I signup with '<msisdn_input>' as number
    And I enter sms code with '_fail_'
    And I enter email address with '<email>'
    And I enter password with '<password>'
    And I confirm password with '<password>'
    And I accept the terms and condition
    And I submit
    Then I see the text 'Your verification code could not be recognised' anywhere in the page

  Examples:
    | opco | service | msisdn_input   | password  | email         |
    | gb   | music   | current_msisdn | Password1 | current_email |

