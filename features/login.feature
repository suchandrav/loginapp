Feature: LOGIN

  @dont_delete_cookies_before
  Scenario: Check Version
    Given I open the version page
    And I take a screenshot

  @dont_delete_cookies_before
  Scenario: Login : Empty fields error message
    Given I open 'nwab' site for the opco 'ie' in a logged out state
    And I go to login page
    When I login with '' as user name and '' as password
    Then I see Login empty fields failure message

  @dont_delete_cookies_before
  Scenario Outline: Group Login
    Given I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to login page
    When I login with '<username>' as user name and '<password>' as password
    Then I see login cookie present

  Examples:
    | opco | service       | username       | password       |
    # | gb   | contacts      | 778545659960    | usual_password |
    #    | gb   | contacts      | 0778545659960   | usual_password |
    #    | gb   | contacts      | usual_msisdn_2 | usual_password |
    #    | gb   | contacts      | usual_msisdn_2 | usual_password |
    #    | gb   | nwab          | usual_msisdn_2 | usual_password |
    #    | gb   | contentbackup | usual_msisdn_2 | usual_password |
    #    | gb   | mobileprotect | usual_msisdn_2 | usual_password |
    | gb   | music         | usual_msisdn_2 | usual_password |
    | ie   | contacts      | usual_msisdn_2 | usual_password |
    | ie   | nwab          | usual_msisdn_2 | usual_password |
    | ie   | contentbackup | usual_msisdn_2 | usual_password |
    | ie   | music         | usual_msisdn_2 | usual_password |
    | it   | music         | usual_msisdn_2 | usual_password |
    | it   | contacts      | usual_msisdn_2 | usual_password |
    | it   | nwab          | usual_msisdn_2 | usual_password |
    | it   | contentbackup | usual_msisdn_2 | usual_password |
    | it   | mobileprotect | usual_msisdn_2 | usual_password |
    | gr   | music         | usual_msisdn_2 | usual_password |
    | gr   | contacts      | usual_msisdn_2 | usual_password |
    | gr   | cloud         | usual_msisdn_2 | usual_password |
    | gr   | contentbackup | usual_msisdn_2 | usual_password |
    | nl   | music         | usual_msisdn_2 | usual_password |
    | nl   | contentbackup | usual_msisdn_2 | usual_password |
    | es   | music         | usual_msisdn_2 | usual_password |
    | de   | contentbackup | usual_msisdn_2 | usual_password |
    #    | at   | contacts      | usual_msisdn_2 | usual_password |
    #    | at   | cloud         | usual_msisdn_2 | usual_password |
    #   | at   | mobileprotect | usual_msisdn_2 | usual_password |
    | hr   | contacts      | usual_msisdn_2 | usual_password |
    | hr   | contentbackup | usual_msisdn_2 | usual_password |
    | hr   | mobileprotect | usual_msisdn_2 | usual_password |
    | bg   | contacts      | usual_msisdn_2 | usual_password |
    | bg   | contentbackup | usual_msisdn_2 | usual_password |
    | bg   | mobileprotect | usual_msisdn_2 | usual_password |
    | za   | mobileprotect | usual_msisdn_2 | usual_password |
    | za   | contacts      | usual_msisdn_2 | usual_password |
    | za   | contentbackup | usual_msisdn_2 | usual_password |

  @dont_delete_cookies_before
  Scenario Outline: Group Logout
    Given I open '<service>' site for the opco '<opco>' in a logged out state
    And I go to login page
    When I login with '<username>' as user name and '<password>' as password
    Then I see login cookie present
    And I click on Logout
    Then I see login cookie not present

  Examples:
    | opco | service       | username       | password       |
    # | gb   | contacts      | 778545659960    | usual_password |
    #    | gb   | contacts      | 0778545659960   | usual_password |
    #    | gb   | contacts      | usual_msisdn_2 | usual_password |
    #    | gb   | contacts      | usual_msisdn_2 | usual_password |
    #    | gb   | nwab          | usual_msisdn_2 | usual_password |
    #    | gb   | contentbackup | usual_msisdn_2 | usual_password |
    #    | gb   | mobileprotect | usual_msisdn_2 | usual_password |
    | gb   | music         | usual_msisdn_2 | usual_password |
    | ie   | contacts      | usual_msisdn_2 | usual_password |
    | ie   | nwab          | usual_msisdn_2 | usual_password |
    | ie   | contentbackup | usual_msisdn_2 | usual_password |
    | ie   | music         | usual_msisdn_2 | usual_password |
    | it   | music         | usual_msisdn_2 | usual_password |
    | it   | contacts      | usual_msisdn_2 | usual_password |
    | it   | nwab          | usual_msisdn_2 | usual_password |
    | it   | contentbackup | usual_msisdn_2 | usual_password |
    | it   | mobileprotect | usual_msisdn_2 | usual_password |
    | gr   | music         | usual_msisdn_2 | usual_password |
    | gr   | contacts      | usual_msisdn_2 | usual_password |
    | gr   | cloud         | usual_msisdn_2 | usual_password |
    | gr   | contentbackup | usual_msisdn_2 | usual_password |
    | nl   | music         | usual_msisdn_2 | usual_password |
    | nl   | contentbackup | usual_msisdn_2 | usual_password |
    | es   | music         | usual_msisdn_2 | usual_password |
    | de   | contentbackup | usual_msisdn_2 | usual_password |
    #    | at   | contacts      | usual_msisdn_2 | usual_password |
    #    | at   | cloud         | usual_msisdn_2 | usual_password |
    #   | at   | mobileprotect | usual_msisdn_2 | usual_password |
    | hr   | contacts      | usual_msisdn_2 | usual_password |
    | hr   | contentbackup | usual_msisdn_2 | usual_password |
    | hr   | mobileprotect | usual_msisdn_2 | usual_password |
    | bg   | contacts      | usual_msisdn_2 | usual_password |
    | bg   | contentbackup | usual_msisdn_2 | usual_password |
    | bg   | mobileprotect | usual_msisdn_2 | usual_password |
    | za   | mobileprotect | usual_msisdn_2 | usual_password |
    | za   | contacts      | usual_msisdn_2 | usual_password |
    | za   | contentbackup | usual_msisdn_2 | usual_password |

  @dont_delete_cookies_before
  Scenario Outline: PT Login Wrong Credentials
    Given I open '<service>' site for the opco 'pt' in a logged out state
    And I go to login page
    When I login to PT with '<username_input>' as user name and '<password>' as password
    Then I see PT login failure message

  Examples:
    | service       | username_input | password |
    | mobileprotect | PT_number_1    | 123456   |
    | music         | PT_number_1    | 123456   |
    | contacts      | PT_number_1    | 123456   |
    | contentbackup | PT_number_1    | 123456   |

  @dont_delete_cookies_before
  Scenario Outline: PT Login
    Given I open '<service>' site for the opco 'pt' in a logged out state
    And I go to login page
    When I login to PT with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | PT_number_1    | PT_password_1 |
    | music         | PT_number_1    | PT_password_1 |
    | contacts      | PT_number_1    | PT_password_1 |

  @dont_delete_cookies_before
  Scenario Outline: PT Logout
    And I open '<service>' site for the opco 'pt' in a logged out state
    And I go to login page
    When I login to PT with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present
    And I click on Logout
    Then I see login cookie not present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | PT_number_1    | PT_password_1 |
    | music         | PT_number_1    | PT_password_1 |
    | contacts      | PT_number_1    | PT_password_1 |

  Scenario Outline: PT Login adding email
    Given I generate the next correlative email address
    And I purge delete accounts with MSISDN '<msisdn>' verified
    And I open '<service>' site for the opco 'pt' in a logged out state
    And I go to login page
    When I login to PT with '<username_input>' as user name and '<password>' as password
    And I check I am in the add email page
    And I wait '2' seconds
    And I add my email '<email>' because the account lacks an email address
    Then I see login cookie present

  Examples:
    | service       | msisdn      | username_input | password      | email         |
    | nwab          | PT_msisdn_1 | PT_number_1    | PT_password_1 | current_email |
    | contentbackup | PT_msisdn_1 | PT_number_1    | PT_password_1 | current_email |

# Commenting out this test as the
# SSOGW for ES is stubbed in DIT so you can log in with whatever you want.
#  Scenario Outline: ES Login Wrong Credentials
#    Given I purge delete accounts with MSISDN '<msisdn>' verified
#    And I open '<service>' site for the opco 'es' in a logged out state
#    And I go to login page
#    When I login to ES with '<username_input>' as user name and '<password>' as password
#    Then I see ES login failure message
#
#  Examples:
#    | service       | msisdn        | username_input | password |
#    | mobileprotect | +34600000005  | 34600000005    | 123456   |
#    | contacts      | +34600000005  | 34600000005    | 123456   |
#    | contentbackup | +34600000005  | 34600000005    | 123456   |

  @dont_delete_cookies_before
  Scenario Outline: ES Login
    Given I generate the next correlative ES msisdn
    And I open '<service>' site for the opco 'es' in a logged out state
    And I go to login page
    When I login to ES with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present

  Examples:
    | service       | username_input    | password      |
    | mobileprotect | current_ES_msisdn | ES_password_1 |
    | kids          | current_ES_msisdn | ES_password_1 |

  @dont_delete_cookies_before
  Scenario Outline: ES Logout
    Given I generate the next correlative ES msisdn
    And I open '<service>' site for the opco 'es' in a logged out state
    And I go to login page
    When I login to ES with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present
    And I click on Logout
    Then I see login cookie not present

  Examples:
    | service       | username_input    | password      |
    | mobileprotect | current_ES_msisdn | ES_password_1 |
    | kids          | current_ES_msisdn | ES_password_1 |

  Scenario Outline: ES Login adding email
    Given I generate the next correlative email address
    And I generate the next correlative ES msisdn
    And I open '<service>' site for the opco 'es' in a logged out state
    And I go to login page
    When I login to ES with '<username_input>' as user name and '<password>' as password
    And I check I am in the add email page
    And I wait '2' seconds
    And I add my email '<email>' because the account lacks an email address
    Then I see login cookie present

  Examples:
    | service       | username_input    | password      | email         |
    | contacts      | current_ES_msisdn | ES_password_1 | current_email |
    | nwab          | current_ES_msisdn | ES_password_1 | current_email |
    | contentbackup | current_ES_msisdn | ES_password_1 | current_email |

  Scenario Outline: NL first Login
    And I open '<service>' site for the opco 'nl' in a logged out state
    And I go to login page
    When I login to NL with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | NL_msisdn_1    | NL_password_1 |

  Scenario Outline: NL click through Login
    And I open '<service>' site for the opco 'nl' in a logged out state
    And I go to login page
    And I login to NL with '<username_input>' as user name and '<password>' as password
    And I see login cookie present
    And I click logout
    And I see login cookie not present
    And I go to login page
    Then I see login cookie present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | NL_msisdn_1    | NL_password_1 |


  Scenario Outline: NL second Login
    And I open '<service>' site for the opco 'nl' in a logged out state
    And I go to login page
    And I login to NL with '<username_input>' as user name and '<password>' as password
    And I see login cookie present
    When I click logout
    And I see login cookie not present
    And I delete all the cookies in all domains
    And I open '<service>' site for the opco 'nl'
    And I see login cookie not present
    And I go to login page
    And I login to NL with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | NL_msisdn_1    | NL_password_1 |


  Scenario Outline: DE first Login
    And I open '<service>' site for the opco 'de' in a logged out state
    And I go to login page
    When I login to DE with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present
    And I purge delete accounts with MSISDN '<msisdn>' verified

  Examples:
    | service       | msisdn      | username_input | password      |
    | mobileprotect | DE_msisdn_1 | DE_username_1  | DE_password_1 |

  Scenario Outline: DE second Login
    And I open '<service>' site for the opco 'de' in a logged out state
    And I go to login page
    And I login to DE with '<username_input>' as user name and '<password>' as password
    And I see login cookie present
    And I click logout
    And I see login cookie not present
    And I go to login page
    When I login to DE with '<username_input>' as user name and '<password>' as password
    Then I see login cookie present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | DE_username_1  | DE_password_1 |
    | music         | DE_username_1  | DE_password_1 |

  Scenario: Login function fails due to invalid credentials
    Given I open 'music' site for the opco 'gb'
    And I click logout if necessary
    And I see login cookie not present
    And I go to login page
    When I login with '+44792028580611111' as user name and 'Password11111' as password
    Then I see login failure message
    And I should not see login cookie present


  Scenario: Show password checkbox
    Given I open 'nwab' site for the opco 'ie' in a logged out state
    And I go to login page
    When I enter 'Something' in the password field
#    And I don't see 'Something' in clear text in the password field
#    And click the show password checkbox
#    Then I see 'Something' in clear text in the password field



