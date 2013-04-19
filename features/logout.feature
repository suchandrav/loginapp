Feature: LOGOUT

  Scenario Outline: Group Logout
    Given I'm logged in with a group account to '<service>' for the opco '<opco>', with credentials '<username>' '<password>'
    When I click logout
    Then I see login cookie not present

  Examples:
    | opco | service       | username       | password       |
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
    #    | at   | mobileprotect | usual_msisdn_2 | usual_password |
    | hr   | contacts      | usual_msisdn_2 | usual_password |
    | hr   | contentbackup | usual_msisdn_2 | usual_password |
    | hr   | mobileprotect | usual_msisdn_2 | usual_password |
    | bg   | contacts      | usual_msisdn_2 | usual_password |
    | bg   | contentbackup | usual_msisdn_2 | usual_password |
    | bg   | mobileprotect | usual_msisdn_2 | usual_password |
    | za   | mobileprotect | usual_msisdn_2 | usual_password |
    | za   | contacts      | usual_msisdn_2 | usual_password |
    | za   | contentbackup | usual_msisdn_2 | usual_password |


  Scenario Outline: PT Logout
    Given I open '<service>' site for the opco 'pt' in a logged out state
    And I go to login page
    And I login to PT with '<username_input>' as user name and '<password>' as password
    And I see login cookie present
    When I click logout
    Then I see login cookie not present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | PT_number_1    | PT_password_1 |
    | music         | PT_number_1    | PT_password_1 |

  Scenario Outline: ES Logout
    Given I generate the next correlative ES msisdn
    And I open '<service>' site for the opco 'es' in a logged out state
    And I go to login page
    And I login to ES with '<username_input>' as user name and '<password>' as password
    And I see login cookie present
    When I click logout
    Then I see login cookie not present

  Examples:
    | service       | username_input    | password      |
    | mobileprotect | current_ES_msisdn | ES_password_1 |

  Scenario Outline: NL Logout
    Given I open '<service>' site for the opco 'nl' in a logged out state
    And I go to login page
    And I login to NL with '<username_input>' as user name and '<password>' as password
    And I see login cookie present
    When I click logout
    Then I see login cookie not present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | NL_msisdn_1    | NL_password_1 |

  Scenario Outline: DE Logout
    And I open '<service>' site for the opco 'de' in a logged out state
    And I go to login page
    And I login to DE with '<username_input>' as user name and '<password>' as password
    And I see login cookie present
    When I click logout
    Then I see login cookie not present

  Examples:
    | service       | username_input | password      |
    | mobileprotect | DE_username_1  | DE_password_1 |

