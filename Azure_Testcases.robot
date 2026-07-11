*** Settings ***
Library  SeleniumLibrary
Library  Collections
Resource  ../../Resources/Azure_Resources.robot
Resource  ../../Resources/Generic_Resources.robot
Resource  ../../Resources/Complex_Resources.robot
Test Setup    Open browser and login as admin and go to home page   ${browser_selected}   ${driver_path}  ${url}
Test Teardown   Logout From BridgeNAS Application
Test Timeout    ${test_timeout}


*** Test Cases ***
TC 2301 : Create New Azure Repo
    [Tags]  TC_2301
    [Documentation]  Objective : Verify Admin can add New Azure Repository
     ...               1)Login to Bridgenas website using Browser
     ...               2)Go to Configure Page
     ...               3)Open Add New Repository form, fill the values and add repository
     ...               4)Verify Newly Added Repository
     ...               5)Create Azure Repo Using User Input
     ...               6) Delete created Azure Repo (Destroy Env)
    Go To Configure Page
    Add New Azure Repository         ${azure_repo2_det}
    Go To Newly Created Repo         ${azure_repo2_det}[azure_name]
    Delete Created Azure Repo        ${azure_repo2_det}[azure_name]


TC 2302 : Verify Add Container in Azure Repo with Valid and Invalid input
    [Tags]  TC_2302
    [Documentation]   Objective: Verify Addition of New Container in Repository with Valid and Invalid input
    ...               1)Login using Browser
    ...               2)Create Container with invalid name
    ...                 i) Give Container name with more than 63 character and less than 3 character
    ...                 ii) Use Special characters like comma,underscore,inverted comma,dollar symbol etc
    ...                 iii) Create Container with same name twice
    ...               3)Platform to show error message for above name (Verify Error in the Popup)
    ...               4)Create Container with valid name
    ...                 i)Use more than 2 and less than 63 character
    ...               5)Platform to show message Container created successfully (Verify Created Container Successfully with Popup)
    ...               6)Delete Created Container (Destroy Setup)
    Go To Configure Page
    Add New Azure Repository                              ${azure_repo2_det}
    Go To Newly Created Repo                              ${azure_repo2_det}[azure_name]
    Create Azure Container with invalid random name
    Create Azure Container with invalid name              ${invalid_bucket_name}
    Platform to show error message in Azure
    Create Container with valid random name
    Create Container with valid name                      ${new_azure_cont_name}
    Platform to show message container created successfully
    Delete valid name container in azure                  ${new_azure_cont_name}
    Delete Created Azure Repo                             ${azure_repo2_det}[azure_name]


TC 2303 : Add Directory to Favorite in Azure Repository
    [Tags]  TC_2303
    [Documentation]  Objective: Add Folder to favorites and Check Added folder in Favorites also add same folder to 2 times to favorites
    ...                 1)Login to Bridgenas website using Browser
    ...                 2) Select Any of the Container Name
    ...                 3) Add any of the folder to favorite
    ...                 Scenerios :
    ...                  i) User adds 5th folder to fav section, 1st folder will get eliminated from the list
    ...                  ii) Add same folder to favorite 2 or more times
    Go To Configure Page
    Add New Azure Repository         ${azure_repo2_det}
    Go To Newly Created Repo         ${azure_repo2_det}[azure_name]
    # User cannot add Directory to Azure Repo
    Choose Container from list       ${azure_container_name}
    Go to Favorite
    Add Folder to Fav in Azure      ${azure_src_name}  ${source_type_azure}  ${bucket_name_azure}  ${file_name_azure}

TC 2304 : Delete Container from Azure Repository
    [Tags]     TC_2304
    [Documentation]   Objective: Delete 2 Container at the same time in Repository
    ...                  1)Login to Bridgenas website using Browser
    ...                  2)Intialize the setup
    ...                  3)Select Delete Container Icon
    ...                  4)Select any Container name from Dropdown
    Go To Configure Page
    Add New Azure Repository                      ${azure_repo2_det}
    Go To Newly Created Repo                      ${azure_repo2_det}[azure_name]
    create container in azure repo                ${azure_repo_name}
    Select Delete Container Icon
    Delete valid name container in azure          ${new_azure_cont_name}
    Delete Created Azure Repo                     ${azure_repo2_det}[azure_name]


TC 2305 : Download File In Azure Repository
    [Tags]  TC_2305
    [Documentation]  Objective: Download File in Selected Container check the downloads folder in local system for the downloaded file Download same file for more than 2 times
    ...                   1)Login to Bridgenas website using Browser
    ...                   2)Select Any of the Container Name
    ...                      i) Download file from the files list
    ...                      ii) Download same file for more than 2 times
    ...                      iii) Check the downloaded file in the download folder
    ...                      iv) Verify the loaction of downloaded file
    Go To Configure Page
    Add New Azure Repository                      ${azure_repo2_det}
    Go To Newly Created Repo                      ${azure_repo2_det}[azure_name]
    Choose Container from list                    ${azure_container_name}
    Upload Excel Files in the Platform            ${AddFileExcel}
    Download File From Selected Azure Container   ${azure_cont_name}  ${azure_obj_name}  ${azure_repo_name}
    Delete uploaded file                          ${azure_container_name}    ${uploaded_file_name}   ${azure_repo2_det}[azure_name]
    Delete Created Azure Repo                     ${azure_repo2_det}[azure_name]

TC 2306 : Upload File In Azure Repository
    [Tags]   TC_2306
    [Documentation]  Objective: User can upload 2 same files at the same time and try to upload folders
    ...                1)Login to Bridgenas website using Browser
    ...                2)Select the Container
    ...                3) Upload file from Local System
    ...                  i) Verify Added File is visible under the Container
    ...                  ii) User upload the file for 2nd time file already present should be shown
    ...                  iii) Upload Excel Files in the Platform
    Go To Configure Page
    Add New Azure Repository                      ${azure_repo2_det}
    Go To Newly Created Repo                      ${azure_repo2_det}[azure_name]
    Choose Container from list                    ${azure_container_name}
    Select Upload Button
    Upload file with pause and resume         ${20}    sample_60mb.pdf
    Delete uploaded file                      ${azure_container_name}    ${uploaded_file_name}   ${azure_repo2_det}[azure_name]
    Delete file in using python               sample_60mb.pdf
    Delete Created Azure Repo                 ${azure_repo2_det}[azure_name]
    
TC 2307 : Edit Azure Repository
    [Tags]  TC_2307
    [Documentation]   Objective : Verify Admin can Edit and Delete Azure Repository
    ...                1)Login to Bridgenas website using Browser
    ...                2)Go to Configure Page
    ...                3)Select Azure Edit option
    ...                4)Edit and Verify Azure Repository
    ...                5)Delete Azure Repository (Destroy the setup)
    Go To Configure Page
    Select Azure Edit option
    Edit Azure Repository
    Delete Azure Repository (Destroy the setup)

TC 2308 : Delete File In Azure Repository
    [Tags]  TC_2308
    [Documentation]  Objective: Delete 2 or more files and folders from repository at the same time
    ...                1)Login to Bridgenas website using Browser
    ...                2)Select Any of the Container Name
    ...                3)Delete file and folder from Azure repository
    ...                  i) Delete 2 or more folder simultaneously
    ...                  ii) Delete 2 or more files simultaneously
    Go To Configure Page
    Add New Azure Repository                  ${azure_repo2_det}
    Go To Newly Created Repo                  ${azure_repo2_det}[azure_name]
    Choose Container from list                ${azure_container_name}
    Upload file with pause and resume         ${20}    sample_60mb.pdf
    Delete uploaded file                      ${azure_container_name}    ${uploaded_file_name}   ${azure_repo2_det}[azure_name]
    Delete file in using python               sample_60mb.pdf
    Delete Created Azure Repo                 ${azure_repo2_det}[azure_name]
hello
