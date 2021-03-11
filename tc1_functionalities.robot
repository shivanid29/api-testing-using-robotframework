*** Settings ***
Library  RequestsLibrary
Library  Collections


*** Variables ***
#${base}=          https://reqres.in/api/
${token}        QpwL5tke4Pnpja7X4


*** Test Cases ***
AddCustomer
    create session         mysession         https://reqres.in/api      verify=True
    ${body}      create dictionary           email=eve.holt@reqres.in           password=pistol
    ${header}      create dictionary           Content-Type=application/json
    ${response}        post request        mysession      /register          data=${body}         headers=${header}

    log to console          ${response.status_code}
    log to console        ${response.content}


    ${response_body}=           convert to string        ${response.content}
    should be equal     ${response_body}        {"id":4,"token":"QpwL5tke4Pnpja7X4"}

LogintoAccount
    create session      mynewsession            https://reqres.in/api      verify=True
    ${body_for_login}=      create dictionary       email=eve.holt@reqres.in        password=cityslicka
    ${header_auth}=     create dictionary       Authorization=${token}      Content-Type=application/json
    ${response_body_login}=     post request     mynewsession          /login      data=${body_for_login}      headers=${header_auth}

    log to console      ${response_body_login.status_code}

    ${response_login}       convert to string       ${response_body_login.content}
    should be equal      ${response_login}           {"token":"QpwL5tke4Pnpja7X4"}


DeleteUser
    create session      mylastsession        https://reqres.in/api      verify=True
    ${delete_response}      delete request      mylastsession       /users/2

    ${final_delete_response}        convert to string       ${delete_response.status_code}
    should be equal         ${final_delete_response}        204









