*** Settings ***
Documentation  Simple example using AppiumLibrary
Library  AppiumLibrary
Test Tags  webdriver
Suite Setup  Open Test Application

*** Variables ***
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${ANDROID_APP}                ${CURDIR}/com-lionparcel-services-consumer.apk
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   %{ANDROID_PLATFORM_VERSION=13}
${APPIUM SERVER URL}  http://127.0.0.1:4723 
${WAIT_TIME_OUT}  20

*** Test Cases ***
User can't cek tariff when the connection to google maps is off
  Given User is on kebijakan privasi page
  And User clicks on button agree
  And User clicks Lanjutkan Tanpa Akun
  # And User close promo pop up
  And User skip lacak paket onboarding on home page
  And User close Boss Pack pop up on home page
  When User go to Cek Tarif page
  And User is in Cek Tarif page
  And User fill in origin address
  And User fill in destination address
  And User validate package detail
  And User click Request Pick Up

*** Keywords ***
Open Test Application
  Open Application  ${APPIUM SERVER URL}  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
  ...  app=${ANDROID_APP}  appWaitActivity=*
  ...  autoGrantPermissions=true

User is on kebijakan privasi page
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/btnAgree  timeout=${WAIT_TIME_OUT}

User clicks on button agree
  Click Element  id=com.lionparcel.services.consumer:id/btnAgree

User clicks Lanjutkan Tanpa Akun
  Click Element  id=com.lionparcel.services.consumer:id/txtSkip

# User close promo pop up
#   Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/ivClose  timeout=${WAIT_TIME_OUT}
#   Click Element    id=com.lionparcel.services.consumer:id/ivClose

User skip lacak paket onboarding on home page
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/txtTittle  timeout=${WAIT_TIME_OUT}
  Click Element    id=com.lionparcel.services.consumer:id/ivClose

User close Boss Pack pop up on home page
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/imgClose  timeout=${WAIT_TIME_OUT}
  Click Element    id=com.lionparcel.services.consumer:id/imgClose

User go to Cek Tarif page
  Wait Until Page Contains Element  xpath=(//android.widget.FrameLayout[@resource-id="com.lionparcel.services.consumer:id/hmtMenu"])[3]  timeout=${WAIT_TIME_OUT}
  Click Element    xpath=(//android.widget.FrameLayout[@resource-id="com.lionparcel.services.consumer:id/hmtMenu"])[3]

User is in Cek Tarif page
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/cvTariffDetail  timeout=${WAIT_TIME_OUT}

User fill in origin address
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/edtOriginAddress  timeout=${WAIT_TIME_OUT}
  Click Element    id=com.lionparcel.services.consumer:id/edtOriginAddress
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/edtRouteSearch  timeout=${WAIT_TIME_OUT}
  Click Element    id=com.lionparcel.services.consumer:id/edtRouteSearch
  Input Text  id=com.lionparcel.services.consumer:id/edtRouteSearch  Metro Utara
  Click Element  id=com.lionparcel.services.consumer:id/txtOriginRouteName

User fill in destination address
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/edtDestinationAddress  timeout=${WAIT_TIME_OUT}
  Click Element    id=com.lionparcel.services.consumer:id/edtDestinationAddress
  Wait Until Page Contains Element  id=com.lionparcel.services.consumer:id/edtRouteSearch  timeout=${WAIT_TIME_OUT}
  Click Element    id=com.lionparcel.services.consumer:id/edtRouteSearch
  Input Text  id=com.lionparcel.services.consumer:id/edtRouteSearch  Grogol Petamburan
  Page Should Contain Element    id=com.lionparcel.services.consumer:id/llDestinationRoute
  Click Element  id=com.lionparcel.services.consumer:id/llDestinationRoute

User click Cek Tarif
  Page Should Contain Element    id=com.lionparcel.services.consumer:id/edtOriginAddress
  Page Should Contain Element    id=com.lionparcel.services.consumer:id/edtDestinationAddress
  Wait Until Page Contains Element    id=com.lionparcel.services.consumer:id/btnCheckTariff  timeout=${WAIT_TIME_OUT}
  Click Element    id=com.lionparcel.services.consumer:id/btnCheckTariff

User validate package detail
  Wait Until Page Contains Element    id=com.lionparcel.services.consumer:id/llWeightSection  timeout=${WAIT_TIME_OUT}
  Page Should Contain Element    id=com.lionparcel.services.consumer:id/llWeightSection

User click Request Pick Up
  Scroll Down    id=com.lionparcel.services.consumer:id/buttonPickUp
  Page Should Contain Element    id=com.lionparcel.services.consumer:id/buttonPickUp
