#### <div style="text-align:right">C-XJH-0005 </div>
####
# <div style="text-align: center"><span style="color:crimson"> < CONFIDENTIAL >   < CONFIDENTIAL >  < CONFIDENTIAL ></span> </div>
####
# API Authentication Service INTERNAL Documentation

***

### 1. Overview

> This document provides pragmatic information on the JWT based authentication approach of the project's API.
>
> 
The Authentication approach combines the benefits of long-term but weak refresh tokens with short-term, more powerful access tokens.

**Note:** The API ist still in a very early alpha version, so changes to the general approach and this document will happen.
***

### 2. Refresh token

1. Claim a refresh token
   >  <span style="color:lawngreen"> POST </span> /user
   This creates user and account records. The created account is unverified an needs to be confirmed by the user.
   ####
   ###### Data parameters
    1. **email** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The email address to be used for login and the username for the account
    2. **first_name** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The user's given names ( first name + middle name *[if any]* ) as stated on their identity card
    3. **last_name** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The user's surname as stated on their identity card
    4. **password** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The password to be used for login
    5. **password_confirmation** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The password to be used for login (Verification point)
   ####
   ###### Response
   **200: OK**
    ```   
            {
                "message": "Account registered! Please activate your account at GET http://localhost:3000/api/v0/user/verify "
            }
    ```
   ####
   **400: Bad request**
    ```   
            {
                "error": {
                    "email": [
                        {
                            "error": "ERR_INVALID"",
                            "description": "Attribute is malformed or unknown
                        }
                    ] 
                }       
            }
    ```
   You may expect the following errors:
    + ``ERR_BLANK``: When a required attribute is blank
    + ``blank``: When the password attribute is blank
    + ``confirmation``: When password != password_confirmation
    + ``ERR_INVALID``: When a required attribute is malformed or unknown
   ####   
   **422: Unprocessable entity**
    ```   
            {
                "error": {
                    "email": [
                        {
                            "error": "ERR_TAKEN",
                            "description": "Attribute is taken"
                        }
                    ]   
                }       
            }
    ```
   ####
   **500: Internal Server Error**
    ```   
            {
                "error": "Please try again later. If this error persists, we recommend to contact our support team."
            }
    ```
   ####
***
2. Verify user credentials <span style="color:yellow"> NOT IMPLEMENTED </span>
   >  <span style="color:lawngreen"> GET </span> /user/verify
   Test to make sure the Registration worked and to start the first session. (In future: See whether aut0 token works)
   ####
   ###### Data parameters
    1. **email** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The email address used for login
    2. **password** *<span style="color:crimson">REQUIRED </span>*
        + String
        + The password used for login
   ###### Response
   **200: OK** <span style="color:yellow"> (NOT IMPLEMENTED - ACHTUNG: hier ist Konzept wg. unpassender db -> schema für jeden user typ (0: privat, 1: privat+arbeitgeber, 2: firma + arbeitgeber )+ 1 gesamt directory; man brraucht die db integrationen und va tabellenrelationen wi z.b. bei locations, und es muss ein vorbau bzw. test implementierung von dem cv zeugs geben) </span>
    ```   
            {
                "id": 123,
                "email": "john.doe@versuchundirrtum.com",
                "created_at": "2023-01-01",
                "updated_at": "2023-01-04",
                "activity_status": 1,
                "image_url": "https://storage.versuchundirrtum.com/img/user/dnliha3092jfon74839hf.jpg",
                "user_type": 0,
                "first_name": "John Robert",
                "last_name": "Doe",
                "birthdate": "2000-01-01",
                "code_nationality": "US",
                "location": {
                                "code_country": "IT",
                                "administrative_area": "VE",
                                "sub_administrative_area": "",
                                "locality": "Venezia",
                                "postal_code": "30124",
                                "address": "P.za San Marco, 57"
                                "premise": "Caffè Florian",
                                "latitude": 45.4337062,
                                "longitude": 12.3353557
                            },
                "cv":         {
                                "description": "",
                                "rating_score": 0.0,
                                "reviews": [],
                                "last_activities": [],
                                "tags": []
                             }
            }
    ```
   ####
   **400: Bad request**
    ```   
            {
                "error": {
                    "email": [
                        {
                            "error": "ERR_INVALID",
                            "description": "Attribute is malformed or unknown"
                        }
                    ]   
                }       
            }
    ```
   You may expect the following errors:
    + ``ERR_BLANK``: When a required attribute is blank
    + ``ERR_DISABLED``: The login for the given credentials is disabled
    + ``ERR_INVALID``: When the given attribute is malformed or unknown
   ####
   **401: Unauthorized**
    ```   
            {
                    "password": [
                        {
                            "error": "ERR_INVALID",
                            "description": "Attribute is malformed or unknown"
                        }
                    ]   
                }       
            }
    ```
   ####
   **403: Forbidden**
    ```   
            {
                "error": {
                    "system": [
                        {
                            "error": "ERR_BLOCKED",
                            "description": "Proceeding is restricted"
                        }
                    ]
                }       
            }
    ```
   ####
   **500: Internal Server Error**
    ```   
            {
                "error": "Please try again later. If this error persists, we recommend to contact our support team"
            }
    ```
   ####

***
####



