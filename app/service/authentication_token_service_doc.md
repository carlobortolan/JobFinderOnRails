#### <div style="text-align:right">C-XJH-0005 </div>
####
# <div style="text-align: center"><span style="color:crimson"> < CONFIDENTIAL >   < CONFIDENTIAL >  < CONFIDENTIAL ></span> </div>
####
# AuthenticationTokenService INTERNAL Documentation

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
    ```   
    AuthenticationTokenService::Refresh::Encoder.call(<user_id>,[<man_interval>])
    ```
   This creates a refresh token for a given user.
   ####
   ###### Data parameters
    1. ``<user_id>`` *<span style="color:crimson">REQUIRED </span>*
        + Integer
        + The user ``id`` of the subject of the token (``sub`` claim)
        + A user to this ``id`` must exist
        + The user to this ``id`` must be verified (``activity_status`` == 1)
        + The user to this ``id`` must not be blocked (listed on ``UserBlacklist``)
    2. ``<man_interval>`` *<span style="color:grey">OPTIONAL </span>*
        + Integer
        + Validity time interval of the token in seconds after the issuing time of the token
        + (0.5 hours ==) 1800 <= ``<man_interval>`` <= 1209600 (== 336 hours == 2 weeks)
        + If ```<man_interval>``` is blank, or ```<man_interval>``` is too big/small, the token will expire after 4 hours

   ####
   ###### Pipeline
   First, the inputs are checked for correct formatting. Then the token claims are populated:
   + ``sub`` - who owns the token?:``<user_id>``
   + ``iat`` - when was the token issued?: An exact timestamp in seconds after 1am of the 01 01 1970
   + ``exp`` - when does the token expire?: If ``<man_interval>`` is not given/blank => 4 hours from now; If ``<man_interval>`` is given: => (``<man_interval>`` divided by 3600) hours from now. If ``<man_interval>`` is in the required format, but ``<man_interval>`` is either smaller that 1800 or greater than 1209600, ``exp`` is either set to the 0.5 hours or the 336 hours/2 weeks - what ever is closer to ``<man_interval>``
   + ``jti`` - a unique identifier: A MD5 encoded, unique String
   + ``iss`` - who issued the token?: The name of the machine that issues this token
   The claims get wrapped in a hash (payload) and this hash is given to teh JWT.encode method, which encodes the claims ito a JWT token using the HS256 algorithm and a secret key.
   ####
   ###### Return
    ```   
    "<refresh_token>"
    ```
   ####
   ###### Exceptions
   ```
   AuthenticationTokenService::InvalidInput
   ```
   You should only expect the following subclasses:
    + ``::SUB``: When ``<user_id>`` is malformed 
    + ``::CustomEXP``: When ``<man_interval>`` is malformed
   ####   
   ```
   AuthenticationTokenService::InvalidUser
   ```
   You should only expect the following subclasses:
    + ``::Unkown``: When there is no user for ``<user_id>`` 
    + ``::Inactive::NotVerified``: When the user for ``<user_id>`` is not verified (``activity_status`` == 0)
    + ``::Inactive::Blocked``: When the user for ``<user_id>`` has a record on ``UserBlacklist``
   ####
***
2. Decipher a refresh token
   ```   
    AuthenticationTokenService::Refresh::Decoder.call(<token>)
    ```
   This decodes a refresh token and returns its claims.
   ####
   ###### Data parameters
    1. ``<token>`` *<span style="color:crimson">REQUIRED </span>*
        + String
        + ``<refresh_token>`` must be a JWT, solely issued by the ``AuthenticationTokenService::Refresh::Encoder`` class
        + ``<refresh_token>`` must not be blocked (listed on ``AuthBlacklist``)

   ####
   ###### Pipeline
   First, the inputs are checked for correct formatting. Then ``<refresh_token>`` gets decoded.
   Third, ``<refresh_token>`` and its claims get verified.
   ####
   ###### Return
    ```   
    [{<refresh_token_claims>}]
    ```
   ####
   ###### Exceptions
   ```
   AuthenticationTokenService::InvalidInput
   ```
   You should only expect the following subclasses:
    + ``::Token``: When ``<refresh_token>`` is malformed
   ####   
     ```
   JWT
   ```
   You should only expect the following subclasses:
    + ``::ExpiredSignature``: When ``<refresh_token>`` has expired
    + ``::InvalidIssuerError``: When ``<refresh_token>`` was issued by an unknown issuer
    + ``::InvalidJtiError``: When ``<refresh_token>`` has a record on ``AuthBlacklist`` (the token is blocked)
    + ``::InvalidIatError``: When ``<refresh_token>`` was timestamped incorrectly
    + ``::InvalidSubError``: When the owner of ``<refresh_token>`` is unknown
    + ``::VerificationError``: When ``<refresh_token>`` was encoded with an unknown secret key and/or was tampered with
    + ``::IncorrectAlgorithm``: When ``<refresh_token>`` was encoded using a unknown/incompatible algorithm
   ####
***
### 3. Access token

1. Claim an access token
    ```   
    AuthenticationTokenService::Access::Encoder.call(<refresh_token>)
    ```
   This creates an access token if a given refresh token is valid.
   ####
   ###### Data parameters
    1. ``<refresh_token>`` *<span style="color:crimson">REQUIRED </span>*
        + String
        + ``<refresh_token>`` must be a JWT, solely issued by the ``AuthenticationTokenService::Refresh::Encoder`` class
        + ``<refresh_token>`` must not be blocked (listed on ``AuthBlacklist``)

   ####
   ###### Pipeline
   First, the inputs are checked for correct formatting. Then ``<refresh_token>`` gets decoded.
   Third, ``<refresh_token>`` and its claims get verified. Finally an access token is generated based on the claims of ``<refresh_token>``:
   + ``sub`` - who owns the token?:``<user_id>``
   + ``exp`` - when does the token expire?: An access token is valid for 0.3333 hours (20 min)
   + ``scp``*<span style="color:yellow">- specifies the access rights of the token:  </span>* 
   + ``iss`` - who issued the token?: The name of the machine that issues this token
   ####
   ###### Return
    ```   
    "<access_token>"
    ``` 
   ####
   ###### Exceptions
   ```
   AuthenticationTokenService::InvalidInput
   ```
   You should only expect the following subclasses:
    + ``::Token``: When ``<refresh_token>`` is malformed
   ####   
     ```
   JWT
   ```
   You should only expect the following subclasses:
    + ``::ExpiredSignature``: When ``<refresh_token>`` has expired
    + ``::InvalidIssuerError``: When ``<refresh_token>`` was issued by an unknown issuer
    + ``::InvalidJtiError``: When ``<refresh_token>`` has a record on ``AuthBlacklist`` (the token is blocked)
    + ``::InvalidIatError``: When ``<refresh_token>`` was timestamped incorrectly
    + ``::InvalidSubError``: When the owner of ``<refresh_token>`` is unknown
    + ``::VerificationError``: When ``<refresh_token>`` was encoded with an unknown secret key and/or was tampered with
    + ``::IncorrectAlgorithm``: When ``<refresh_token>`` was encoded using a unknown/incompatible algorithm
   ####
***
2. Decipher an access token
    ```   
    AuthenticationTokenService::Access::Decoder.call(<access_token>)
    ```
   This decodes an access token and returns its claims.
   ####
   ###### Data parameters
    1. ``<access_token>`` *<span style="color:crimson">REQUIRED </span>*
        + String
        + ``<access_token>`` must be a JWT, solely issued by the ``AuthenticationTokenService::Access::Encoder`` class

   ####
   ###### Pipeline
   First, the inputs are checked for correct formatting. Then ``<access_token>`` gets decoded.
   Neither ``<access_token>`` nor its claimed get further verified.
   ####
   ###### Return
    ```   
    [{<access_token_claims>}]
    ``` 
   ####
   ###### Exceptions
   ```
   AuthenticationTokenService::InvalidInput
   ```
   You should only expect the following subclasses:
    + ``::Token``: When ``<access_token>`` is malformed
   ####   
     ```
   JWT
   ```
   You should only expect the following subclasses:
    + ``::ExpiredSignature``: When ``<access_token>`` has expired
    + ``::InvalidIssuerError``: When ``<access_token>`` was issued by an unknown issuer
    + ``::VerificationError``: When ``<access_token>`` was encoded with an unknown secret key and/or was tampered with
    + ``::IncorrectAlgorithm``: When ``<access_token>`` was encoded using a unknown/incompatible algorithm
   ####
***
####



