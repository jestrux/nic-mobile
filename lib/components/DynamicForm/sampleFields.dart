List<Map<String, dynamic>> sampleFields = [
  {
    "id": "127",
    "name": "image",
    "label": "Image",
    "type": "file",
  },
  {
    "id": "128",
    "name": "file",
    "label": "File",
    "type": "file",
    "tags": "Allow File Picker",
  },
  {
    "id": "129",
    "name": "video",
    "label": "Video",
    "type": "video",
  },
  {
    "id": 100,
    "trigger": null,
    "name":
        "Has_the_vehicle_been_insured_with_other_companies_IMIS_CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER_FIELD_100",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Has the vehicle been insured with other companies?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "9",
      "checklist": "11",
      "name": "CLAIM EXPERIENCE AND DECLINATURE OF COVER:",
      "type": "CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "100_IMIS_100"},
      {"name": "Yes", "value": "99_IMIS_100"}
    ],
    "childs": [
      {
        "id": 102,
        "trigger": 99,
        "name": "99__TRIGGER__Policy_number_IMIS__FIELD_102",
        "tag": "PolicyNumber",
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Policy number",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "99__TRIGGER__Policy_number_IMIS__FIELD_102",
          "99__TRIGGER__Policy_number_IMIS__FIELD_102"
        ],
        "group": {
          "id": "None",
          "checklist": "11",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "Policy number",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 101,
        "trigger": 99,
        "name": "99__TRIGGER__Name_of_the_company_IMIS__FIELD_101",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Name of the company",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "99__TRIGGER__Name_of_the_company_IMIS__FIELD_101",
          "99__TRIGGER__Name_of_the_company_IMIS__FIELD_101"
        ],
        "group": {
          "id": "None",
          "checklist": "11",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "Name of the company",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 103,
        "trigger": 100,
        "name": "99__TRIGGER__Type_of_cover_IMIS__FIELD_103",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Type of cover",
        "description": "",
        "declaration": false,
        "type": "select",
        "possible_names": [
          "99__TRIGGER__Type_of_cover_IMIS__FIELD_103",
          "99__TRIGGER__Type_of_cover_IMIS__FIELD_103"
        ],
        "group": {
          "id": "None",
          "checklist": "11",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "Type of cover",
        "max_length": 500,
        "required": true,
        "choices": [
          {"name": "No", "value": "100_IMIS_100"},
          {"name": "Yes", "value": "99_IMIS_100"}
        ],
        "childs": [
          {
            "trigger": 100,
            "name": "Inset",
            "label": "Inset",
            "type": "radio",
            "choices": [
              {"name": "No", "value": "100_IMIS_100"},
              {"name": "Yes", "value": "99_IMIS_100"}
            ],
            "childs": [
              {
                "trigger": 99,
                "name": "Double Inset",
                "label": "Double Inset",
                "type": "text",
              }
            ]
          }
        ]
      }
    ]
  },
  {
    "id": 6686,
    "trigger": null,
    "name":
        "Attach_one1_left_front_corner_photograph_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6686",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": " (Less Than 1 Mb) - Attach one(1) left front corner photograph",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) left front corner photograph",
    "max_length": 500,
    "required": false,
    "childs": []
  },
  {
    "id": 6687,
    "trigger": null,
    "name":
        "Attach_one1_right_front_corner_photograph_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6687",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": " (Less Than 1 Mb) - Attach one(1) right front corner photograph",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) right front corner photograph",
    "max_length": 500,
    "required": false,
    "childs": []
  },
];

List<Map<String, dynamic>> sampleFields1 = [
  {
    "id": 9253,
    "trigger": null,
    "name": "Registration_number_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_9253",
    "tag": "Tira,RegNo,PropertyName,InsuredInfo,TiraRegistrationNumber",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Registration number",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "834",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Registration number",
    "max_length": 500,
    "required": true
  },
  {
    "id": 20139,
    "trigger": null,
    "name": "Provide_nidavoterlicensepassport_number_IMIS__FIELD_20139",
    "tag": "NIDA, IndividualClientQuestion",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Provide nida/voter/license/passport number",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "832",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Provide nida/voter/license/passport number",
    "max_length": 500,
    "required": true
  },
  {
    "id": 9255,
    "trigger": null,
    "name": "Policy_commencement_date_IMIS_PERIOD_OF_INSURANCE_FIELD_9255",
    "tag": "PolicyStartDate,CorporateRequired",
    "min_value": null,
    "max_value": null,
    "commence": true,
    "answered_question": null,
    "tira": false,
    "label": "Policy commencement date",
    "description": "",
    "declaration": false,
    "type": "future_date",
    "possible_names": [],
    "group": {
      "id": "8",
      "checklist": "834",
      "name": "PERIOD OF INSURANCE",
      "type": "PERIOD_OF_INSURANCE",
      "multiple": false
    },
    "help_text": "Policy commencement date",
    "max_length": 500,
    "required": true
  },
  {
    "id": 59,
    "trigger": null,
    "name": "Do_you_wish_driving_limited_to_IMIS__FIELD_59",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Do you wish driving limited to:",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "10",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "Open driving", "value": "46_IMIS_59"},
      {"name": "Yourself and named driver(s)", "value": "45_IMIS_59"},
      {"name": "Yourself and spouse only", "value": "44_IMIS_59"},
      {"name": "Yourself", "value": "43_IMIS_59"}
    ],
    "childs": [
      {
        "id": 60,
        "trigger": 44,
        "name":
            "44__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Name of the driver",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "44__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
          "44__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
          "44__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
          "44__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "Name of the driver",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 60,
        "trigger": 45,
        "name":
            "45__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Name of the driver",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "45__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
          "45__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
          "45__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60",
          "45__TRIGGER__Name_of_the_driver_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_60"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "Name of the driver",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 61,
        "trigger": 44,
        "name":
            "44__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Driving experience",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "44__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
          "44__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
          "44__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
          "44__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "Driving experience",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 61,
        "trigger": 45,
        "name":
            "45__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Driving experience",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "45__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
          "45__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
          "45__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61",
          "45__TRIGGER__Driving_experience_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_61"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "Driving experience",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 62,
        "trigger": 44,
        "name": "44__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Sex",
        "description": "",
        "declaration": false,
        "type": "radio",
        "possible_names": [
          "44__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
          "44__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
          "44__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
          "44__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "max_length": 500,
        "required": true,
        "choices": [
          {"name": "Female", "value": "48_IMIS_62"},
          {"name": "Male", "value": "47_IMIS_62"}
        ],
        "childs": []
      },
      {
        "id": 62,
        "trigger": 45,
        "name": "45__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Sex",
        "description": "",
        "declaration": false,
        "type": "radio",
        "possible_names": [
          "45__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
          "45__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
          "45__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62",
          "45__TRIGGER__Sex_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_62"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "max_length": 500,
        "required": true,
        "choices": [
          {"name": "Female", "value": "48_IMIS_62"},
          {"name": "Male", "value": "47_IMIS_62"}
        ],
        "childs": []
      },
      {
        "id": 63,
        "trigger": 44,
        "name": "44__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Age",
        "description": "",
        "declaration": false,
        "type": "integer",
        "possible_names": [
          "44__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
          "44__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
          "44__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
          "44__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "Age",
        "max_length": 500,
        "required": false,
        "childs": []
      },
      {
        "id": 63,
        "trigger": 45,
        "name": "45__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Age",
        "description": "",
        "declaration": false,
        "type": "integer",
        "possible_names": [
          "45__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
          "45__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
          "45__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63",
          "45__TRIGGER__Age_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_63"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "Age",
        "max_length": 500,
        "required": false,
        "childs": []
      },
      {
        "id": 15521,
        "trigger": 43,
        "name":
            "43__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Do you hold a valid or provision licence?",
        "description": "",
        "declaration": false,
        "type": "radio",
        "possible_names": [
          "43__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "43__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "43__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "43__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "max_length": 500,
        "required": true,
        "choices": [
          {"name": "Provisional", "value": "56_IMIS_15521"},
          {"name": "Valid", "value": "55_IMIS_15521"}
        ],
        "childs": []
      },
      {
        "id": 15521,
        "trigger": 44,
        "name":
            "44__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Do you hold a valid or provision licence?",
        "description": "",
        "declaration": false,
        "type": "radio",
        "possible_names": [
          "44__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "44__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "44__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "44__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "max_length": 500,
        "required": true,
        "choices": [
          {"name": "Provisional", "value": "56_IMIS_15521"},
          {"name": "Valid", "value": "55_IMIS_15521"}
        ],
        "childs": []
      },
      {
        "id": 15521,
        "trigger": 45,
        "name":
            "45__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Do you hold a valid or provision licence?",
        "description": "",
        "declaration": false,
        "type": "radio",
        "possible_names": [
          "45__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "45__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "45__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521",
          "45__TRIGGER__Do_you_hold_a_valid_or_provision_licence_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15521"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "max_length": 500,
        "required": true,
        "choices": [
          {"name": "Provisional", "value": "56_IMIS_15521"},
          {"name": "Valid", "value": "55_IMIS_15521"}
        ],
        "childs": []
      },
      {
        "id": 15520,
        "trigger": 43,
        "name":
            "43__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "How long have you been driving under such license(years)",
        "description": "",
        "declaration": false,
        "type": "integer",
        "possible_names": [
          "43__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "43__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "43__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "43__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "How long have you been driving under such license(years)",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 15520,
        "trigger": 44,
        "name":
            "44__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "How long have you been driving under such license(years)",
        "description": "",
        "declaration": false,
        "type": "integer",
        "possible_names": [
          "44__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "44__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "44__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "44__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "How long have you been driving under such license(years)",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 15520,
        "trigger": 45,
        "name":
            "45__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "How long have you been driving under such license(years)",
        "description": "",
        "declaration": false,
        "type": "integer",
        "possible_names": [
          "45__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "45__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "45__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520",
          "45__TRIGGER__How_long_have_you_been_driving_under_such_licenseyears_IMIS_GIVE_THE_FOLLOWING_DETAILS_FIELD_15520"
        ],
        "group": {
          "id": "4",
          "checklist": "10",
          "name": "GIVE THE FOLLOWING DETAILS:",
          "type": "GIVE_THE_FOLLOWING_DETAILS",
          "multiple": true
        },
        "help_text": "How long have you been driving under such license(years)",
        "max_length": 500,
        "required": true,
        "childs": []
      }
    ]
  },
  {
    "id": 64,
    "trigger": null,
    "name":
        "Been_involved_in_any_vehicle_accident_or_loss_in_the_last_five_5_years_IMIS_HAVE_YOU_OR_ANY_PERSON_WHO_WILL_DRIVE_FIELD_64",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label":
        "Been involved in any vehicle accident or loss in the last five (5) years?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "5",
      "checklist": "10",
      "name": "HAVE YOU OR ANY PERSON WHO WILL DRIVE:",
      "type": "HAVE_YOU_OR_ANY_PERSON_WHO_WILL_DRIVE",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "50_IMIS_64"},
      {"name": "Yes", "value": "49_IMIS_64"}
    ],
    "childs": []
  },
  {
    "id": 65,
    "trigger": null,
    "name":
        "Been_convicted_of_any_motoring_offence_or_is_any_prosecution_pending_IMIS_HAVE_YOU_OR_ANY_PERSON_WHO_WILL_DRIVE_FIELD_65",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label":
        "Been convicted of any motoring offence or is any prosecution pending?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "5",
      "checklist": "10",
      "name": "HAVE YOU OR ANY PERSON WHO WILL DRIVE:",
      "type": "HAVE_YOU_OR_ANY_PERSON_WHO_WILL_DRIVE",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "52_IMIS_65"},
      {"name": "Yes", "value": "51_IMIS_65"}
    ],
    "childs": []
  },
  {
    "id": 66,
    "trigger": null,
    "name":
        "Suffer_from_defective_vision_or_hearing_or_from_any_physical_infirmity_IMIS_HAVE_YOU_OR_ANY_PERSON_WHO_WILL_DRIVE_FIELD_66",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label":
        "Suffer from defective vision or hearing or from any physical infirmity?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "5",
      "checklist": "10",
      "name": "HAVE YOU OR ANY PERSON WHO WILL DRIVE:",
      "type": "HAVE_YOU_OR_ANY_PERSON_WHO_WILL_DRIVE",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "54_IMIS_66"},
      {"name": "Yes", "value": "53_IMIS_66"}
    ],
    "childs": [
      {
        "id": 67,
        "trigger": 53,
        "name": "53__TRIGGER__State_name_and_type_of_defective_IMIS__FIELD_67",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "State name and type of defective",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "53__TRIGGER__State_name_and_type_of_defective_IMIS__FIELD_67",
          "53__TRIGGER__State_name_and_type_of_defective_IMIS__FIELD_67"
        ],
        "group": {
          "id": "None",
          "checklist": "10",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "State name and type of defective",
        "max_length": 500,
        "required": true,
        "childs": []
      }
    ]
  },
  {
    "id": 81,
    "trigger": null,
    "name": "Chassis_number_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_81",
    "tag": "InsuredInfo,TiraChassisNumber",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Chassis number",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Chassis number",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 82,
    "trigger": null,
    "name": "Engine_number_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_82",
    "tag": "InsuredInfo,TiraEngineNumber",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Engine number",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Engine number",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 85,
    "trigger": null,
    "name": "Make_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_85",
    "tag": "Make, InsuredInfo,TiraMake",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Make",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Make",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 86,
    "trigger": null,
    "name": "Model_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_86",
    "tag": "Model,InsuredInfo,Tira_Model",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Model",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Model",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 87,
    "trigger": null,
    "name": "Colour_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_87",
    "tag": "Color,Tira,InsuredInfo,TiraColor",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Colour",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Colour",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 88,
    "trigger": null,
    "name": "Body_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_88",
    "tag": "InsuredInfo,TiraBodyType",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Body",
    "description": "",
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Body",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 89,
    "trigger": null,
    "name": "Year_of_make_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_89",
    "tag": "InsuredInfo,TiraYearOfManufacture",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Year of make",
    "description": "",
    "declaration": false,
    "type": "integer",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Year of make",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 92,
    "trigger": null,
    "name": "Seating_capacity_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_92",
    "tag": "InsuredInfo,TiraSittingCapacity",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Seating capacity",
    "description": "",
    "declaration": false,
    "type": "integer",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Seating capacity",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 83,
    "trigger": null,
    "name": "Vehicle_value_IMIS_PARTICULARS_OF_THE_VEHICLE_FIELD_83",
    "tag": "Tira,InsuredInfo, Tira, TiraVehicleValue",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Vehicle value",
    "description": "",
    "declaration": false,
    "type": "decimal",
    "possible_names": [],
    "group": {
      "id": "11",
      "checklist": "11",
      "name": "PARTICULARS OF THE VEHICLE",
      "type": "PARTICULARS_OF_THE_VEHICLE",
      "multiple": false
    },
    "help_text": "Vehicle value",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 6686,
    "trigger": null,
    "name":
        "Attach_one1_left_front_corner_photograph_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6686",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": " (Less Than 1 Mb) - Attach one(1) left front corner photograph",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) left front corner photograph",
    "max_length": 500,
    "required": false,
    "childs": []
  },
  {
    "id": 6687,
    "trigger": null,
    "name":
        "Attach_one1_right_front_corner_photograph_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6687",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": " (Less Than 1 Mb) - Attach one(1) right front corner photograph",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) right front corner photograph",
    "max_length": 500,
    "required": false,
    "childs": []
  },
  {
    "id": 6688,
    "trigger": null,
    "name":
        "Attach_one1_left_back_corner_photograph_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6688",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": " (Less Than 1 Mb) - Attach one(1) left back corner photograph",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) left back corner photograph",
    "max_length": 500,
    "required": false,
    "childs": []
  },
  {
    "id": 6689,
    "trigger": null,
    "name":
        "Attach_one1_right_back_corner_photograph_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6689",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": " (Less Than 1 Mb) - Attach one(1) right back corner photograph",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) right back corner photograph",
    "max_length": 500,
    "required": false,
    "childs": []
  },
  {
    "id": 6690,
    "trigger": null,
    "name":
        "Attach_one1_clear_photograph_showing_the_engine_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6690",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label":
        " (Less Than 1 Mb) - Attach one(1) clear photograph showing the engine",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) clear photograph showing the engine",
    "max_length": 500,
    "required": false,
    "childs": []
  },
  {
    "id": 6691,
    "trigger": null,
    "name":
        "Attach_one1_clear_photograph_showing_chassis_number_IMIS_PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE_FIELD_6691",
    "tag": "MOTOR",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label":
        " (Less Than 1 Mb) - Attach one(1) clear photograph showing chassis number",
    "description": "",
    "declaration": false,
    "type": "file",
    "possible_names": [],
    "group": {
      "id": "244",
      "checklist": "11",
      "name": "PHOTOGRAPHS OF THE MOTOR VEHICLE",
      "type": "PHOTOGRAPHS_OF_THE_MOTOR_VEHICLE",
      "multiple": false
    },
    "help_text": "Attach one(1) clear photograph showing chassis number",
    "max_length": 500,
    "required": false,
    "childs": []
  },
  {
    "id": 93,
    "trigger": null,
    "name":
        "Is_the_vehicle_fitted_with_multlock_or_burglar_alarm_IMIS__FIELD_93",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Is the vehicle fitted with mult-lock or burglar alarm?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "80_IMIS_93"},
      {"name": "Yes", "value": "79_IMIS_93"}
    ],
    "childs": [
      {
        "id": 94,
        "trigger": 79,
        "name":
            "79__TRIGGER__If_yes_state_type_of_the_device_used_IMIS__FIELD_94",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "If yes state type of the device used",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "79__TRIGGER__If_yes_state_type_of_the_device_used_IMIS__FIELD_94",
          "79__TRIGGER__If_yes_state_type_of_the_device_used_IMIS__FIELD_94"
        ],
        "group": {
          "id": "None",
          "checklist": "11",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "If yes state type of the device used",
        "max_length": 500,
        "required": true,
        "childs": []
      }
    ]
  },
  {
    "id": 96,
    "trigger": null,
    "name":
        "Ever_you_had_your_proposal_declined_IMIS_CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER_FIELD_96",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Ever you had your proposal declined?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "9",
      "checklist": "11",
      "name": "CLAIM EXPERIENCE AND DECLINATURE OF COVER:",
      "type": "CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "92_IMIS_96"},
      {"name": "Yes", "value": "91_IMIS_96"}
    ],
    "childs": []
  },
  {
    "id": 97,
    "trigger": null,
    "name":
        "Been_imposed_with_special_condition_IMIS_CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER_FIELD_97",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Been imposed with special condition?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "9",
      "checklist": "11",
      "name": "CLAIM EXPERIENCE AND DECLINATURE OF COVER:",
      "type": "CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "94_IMIS_97"},
      {"name": "Yes", "value": "93_IMIS_97"}
    ],
    "childs": []
  },
  {
    "id": 98,
    "trigger": null,
    "name":
        "Been_refused_to_renew_or_cancelled_your_policy_IMIS_CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER_FIELD_98",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Been refused to renew or cancelled your policy?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "9",
      "checklist": "11",
      "name": "CLAIM EXPERIENCE AND DECLINATURE OF COVER:",
      "type": "CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "96_IMIS_98"},
      {"name": "Yes", "value": "95_IMIS_98"}
    ],
    "childs": []
  },
  {
    "id": 95,
    "trigger": null,
    "name":
        "Have_any_claim_ever_been_made_against_you_IMIS_CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER_FIELD_95",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Have any claim ever been made against you?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "9",
      "checklist": "11",
      "name": "CLAIM EXPERIENCE AND DECLINATURE OF COVER:",
      "type": "CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "88_IMIS_95"},
      {"name": "Yes", "value": "87_IMIS_95"}
    ],
    "childs": []
  },
  {
    "id": 99,
    "trigger": null,
    "name":
        "Been_required_to_increase_your_premium_IMIS_CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER_FIELD_99",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Been required to increase your premium?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "9",
      "checklist": "11",
      "name": "CLAIM EXPERIENCE AND DECLINATURE OF COVER:",
      "type": "CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "98_IMIS_99"},
      {"name": "Yes", "value": "97_IMIS_99"}
    ],
    "childs": []
  },
  {
    "id": 100,
    "trigger": null,
    "name":
        "Has_the_vehicle_been_insured_with_other_companies_IMIS_CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER_FIELD_100",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Has the vehicle been insured with other companies?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "9",
      "checklist": "11",
      "name": "CLAIM EXPERIENCE AND DECLINATURE OF COVER:",
      "type": "CLAIM_EXPERIENCE_AND_DECLINATURE_OF_COVER",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "No", "value": "100_IMIS_100"},
      {"name": "Yes", "value": "99_IMIS_100"}
    ],
    "childs": [
      {
        "id": 102,
        "trigger": 99,
        "name": "99__TRIGGER__Policy_number_IMIS__FIELD_102",
        "tag": "PolicyNumber",
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Policy number",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "99__TRIGGER__Policy_number_IMIS__FIELD_102",
          "99__TRIGGER__Policy_number_IMIS__FIELD_102"
        ],
        "group": {
          "id": "None",
          "checklist": "11",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "Policy number",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 101,
        "trigger": 99,
        "name": "99__TRIGGER__Name_of_the_company_IMIS__FIELD_101",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Name of the company",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "99__TRIGGER__Name_of_the_company_IMIS__FIELD_101",
          "99__TRIGGER__Name_of_the_company_IMIS__FIELD_101"
        ],
        "group": {
          "id": "None",
          "checklist": "11",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "Name of the company",
        "max_length": 500,
        "required": true,
        "childs": []
      },
      {
        "id": 103,
        "trigger": 99,
        "name": "99__TRIGGER__Type_of_cover_IMIS__FIELD_103",
        "tag": null,
        "min_value": null,
        "max_value": null,
        "commence": false,
        "answered_question": null,
        "tira": false,
        "label": "Type of cover",
        "description": "",
        "declaration": false,
        "type": "text",
        "possible_names": [
          "99__TRIGGER__Type_of_cover_IMIS__FIELD_103",
          "99__TRIGGER__Type_of_cover_IMIS__FIELD_103"
        ],
        "group": {
          "id": "None",
          "checklist": "11",
          "name": "NONE",
          "type": "None",
          "multiple": false
        },
        "help_text": "Type of cover",
        "max_length": 500,
        "required": true,
        "childs": []
      }
    ]
  },
  {
    "id": 20103,
    "trigger": null,
    "name": "Model_number_IMIS__FIELD_20103",
    "tag": "TiraModelNumber",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Model number",
    "description": null,
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Model number",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20093,
    "trigger": null,
    "name": "Owner_name_IMIS__FIELD_20093",
    "tag": "TiraOwnerName",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Owner name",
    "description": null,
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Owner name",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20094,
    "trigger": null,
    "name": "Owner_category_eg_sole_propriator_or_corporate_IMIS__FIELD_20094",
    "tag": "TiraOwnerCategory",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Owner category eg. sole propriator or corporate",
    "description": null,
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Owner category eg. sole propriator or corporate",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20095,
    "trigger": null,
    "name": "Owner_address_IMIS__FIELD_20095",
    "tag": "TiraOwnerAddress",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Owner address",
    "description": null,
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Owner address",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20096,
    "trigger": null,
    "name": "Vehicle_usage_eg_private_or_commercial_IMIS__FIELD_20096",
    "tag": "TiraMotorUsage",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Vehicle usage eg. private or commercial",
    "description": null,
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Vehicle usage eg. private or commercial",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20097,
    "trigger": null,
    "name": "Gross_weight_IMIS__FIELD_20097",
    "tag": "TiraGrossWeight",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Gross weight",
    "description": null,
    "declaration": false,
    "type": "decimal",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Gross weight",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20098,
    "trigger": null,
    "name": "Tare_weight_IMIS__FIELD_20098",
    "tag": "TiraTareWeight",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Tare weight",
    "description": null,
    "declaration": false,
    "type": "decimal",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Tare weight",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20099,
    "trigger": null,
    "name": "Axles_distance_IMIS__FIELD_20099",
    "tag": "TiraAxlesDistance",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Axles distance",
    "description": null,
    "declaration": false,
    "type": "integer",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Axles distance",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20100,
    "trigger": null,
    "name": "Number_of_axles_IMIS__FIELD_20100",
    "tag": "TiraNumberOfAxles",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Number of axles",
    "description": null,
    "declaration": false,
    "type": "integer",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Number of axles",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20101,
    "trigger": null,
    "name": "Fueld_used_eg_petroleum_or_diesel_IMIS__FIELD_20101",
    "tag": "TiraFuelUsed",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Fueld used eg. petroleum or diesel",
    "description": null,
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Fueld used eg. petroleum or diesel",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 20102,
    "trigger": null,
    "name": "Engine_capacity_IMIS__FIELD_20102",
    "tag": "TiraEngineCapacity",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Engine capacity",
    "description": null,
    "declaration": false,
    "type": "text",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "11",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "Engine capacity",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 104,
    "trigger": null,
    "name":
        "I_declare_that_to_the_best_of_my_knowledge_and_belief_the_answers_given_are_true_and_all_material_information_has_explained_has_been_disclosed_i_agree_that_if_any_answer_has_been_completed_by_any_other_person_such_person_shall_for_that_purpose_be_regarded_as_my_agent_and_not_agent_of_insurers_i_declare_that_this_proposal_is_for_insurance_in_the_normal_term_and_condition_of_insurers_policy_and_shall_be_incorporated_in_and_form_part_of_insurance_contract_IMIS__FIELD_104",
    "tag": null,
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label":
        "I declare that to the best of my knowledge and belief the answers given are true and all material information has explained has been disclosed. i agree that if any answer has been completed by any other person such person shall for that purpose be regarded as my agent and not agent of insurer's. i declare that this proposal is for insurance in the normal term and condition of insurer's policy and shall be incorporated in and form part of insurance contract",
    "description": "",
    "declaration": true,
    "type": "bool",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "13",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text":
        "I declare that to the best of my knowledge and belief the answers given are true and all material information has explained has been disclosed. i agree that if any answer has been completed by any other person such person shall for that purpose be regarded as my agent and not agent of insurer's. i declare that this proposal is for insurance in the normal term and condition of insurer's policy and shall be incorporated in and form part of insurance contract",
    "max_length": 500,
    "required": true,
    "childs": []
  }
];

List<Map<String, dynamic>> sampleFields2 = [
  {
    "id": 21812,
    "trigger": null,
    "name": "Please_select_pensave_term_in_years_IMIS__FIELD_21812",
    "tag": "PolicyTermTimeSelect,QuoteQuestion",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "Please select pensave term (in years)",
    "description": "",
    "declaration": false,
    "type": "select",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "1839",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "5", "value": "1879_IMIS_21812"},
      {"name": "6", "value": "1878_IMIS_21812"},
      {"name": "7", "value": "1877_IMIS_21812"},
      {"name": "8", "value": "1876_IMIS_21812"},
      {"name": "9", "value": "1875_IMIS_21812"},
      {"name": "10", "value": "1874_IMIS_21812"},
      {"name": "11", "value": "1873_IMIS_21812"},
      {"name": "12", "value": "1872_IMIS_21812"},
      {"name": "13", "value": "1871_IMIS_21812"},
      {"name": "14", "value": "1870_IMIS_21812"},
      {"name": "15", "value": "1869_IMIS_21812"}
    ],
    "childs": []
  },
  {
    "id": 21813,
    "trigger": null,
    "name": "How_much_would_you_save_IMIS__FIELD_21813",
    "tag": "QuoteQuestion",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "How much would you save",
    "description": "",
    "declaration": false,
    "type": "integer",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "1839",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "help_text": "How much would you save",
    "max_length": 500,
    "required": true,
    "childs": []
  },
  {
    "id": 21814,
    "trigger": null,
    "name": "On_what_frequency_would_you_remit_your_saving_IMIS__FIELD_21814",
    "tag": "PremiumPaymentFrequency,QuoteQuestion",
    "min_value": null,
    "max_value": null,
    "commence": false,
    "answered_question": null,
    "tira": false,
    "label": "On what frequency would you remit your saving?",
    "description": "",
    "declaration": false,
    "type": "radio",
    "possible_names": [],
    "group": {
      "id": "None",
      "checklist": "1839",
      "name": "NONE",
      "type": "None",
      "multiple": false
    },
    "max_length": 500,
    "required": true,
    "choices": [
      {"name": "Monthly", "value": "1883_IMIS_21814"},
      {"name": "Quarterly", "value": "1882_IMIS_21814"},
      {"name": "Semi-annually", "value": "1881_IMIS_21814"},
      {"name": "Annually", "value": "1880_IMIS_21814"}
    ],
    "childs": []
  }
];
