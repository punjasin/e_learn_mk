retryprefix = "--prerunmodifier DataDriver.rerunfailed:output.xml --output rerun.xml -r rerunreport.html"
browser_stack_path=  "/Users/bit1/Documents/Browserstack/BrowserStackLocal"
max_retry = 1
key=  "AqBaFNqaqEp79cgoyGyc"



def runtest_browser_stack(CONCERRENT,RP_ENDPOINT,RP_UUID,RP_LAUNCH,RP_PROJECT,TEST_PATH,RESPONSE,PLATFORM,LANG,REPORTPORTAL){
    // ====== map param and set to variable ======
    echo "==== runtest_browser_stack ==="
    device_variable=  "-v doppio_farm:False -v browserstack:True -v platform:${PLATFORM} -v chromedriverExecutable:None"
    if("${REPORTPORTAL}"=="False")
    {
        echo "==== IF == RESPONSE === False ==="
        reportportal_variable= ""
        listener = ""
    }
    else{
        echo "==== ELSE == RESPONSE === not False ==="
        listener = "--listener robotframework_reportportal.listener"
        reportportal_variable= "--variable RP_UUID:${RP_UUID} --variable RP_ENDPOINT:${RP_ENDPOINT} --variable RP_LAUNCH:${RP_LAUNCH} --variable RP_LAUNCH:${RP_LAUNCH} --variable RP_LAUNCH_UUID:'${RESPONSE}' --variable RP_PROJECT:${RP_PROJECT}"
    }
    concerrent=  "--processes ${CONCERRENT}"
    INCLUDE= "${INCLUDE}"
    EXCLUDE= "${EXCLUDE}"

    try {
        echo "====== start testing with command ======"
        sh "pwd"
        sh "ls"
        sh "${browser_stack_path} --key ${key} --daemon stop"
        sh "${browser_stack_path} --key ${key} --daemon start"
        sh "pabot --pabotlib --pabotlibport 0  ${concerrent} ${listener} ${reportportal_variable} ${device_variable} -v lang:${LANG} ${INCLUDE} ${EXCLUDE} ${TEST_PATH}"
        echo "command: pabot --pabotlib --pabotlibport 0  ${concurrent} ${listener} ${reportportal_variable} ${device_variable} ${VARIABLE} ${INCLUDE} ${EXCLUDE} ${TEST_PATH}"
        sh 'echo "finish running 1st round"'
        sh "${browser_stack_path} --key ${key} --daemon stop"
        echo "====== end testing with command ======"
    }
    catch (err) {
    }
    robot(
          outputPath: './',
          outputFileName: 'output.xml',
          reportFileName: 'report.html',
          logFileName: 'log.html',
          disableArchiveOutput: false,
          passThreshold: 100.0,
          unstableThreshold: 100.0,
          otherFiles: '*.png,*.jpg'
    )
}
def killAllEmu(){
    try{
        echo "killing all emu"
        sh """
                taskkill /F /IM qemu-system-x86_64.exe
            """
    }
    catch(err){
        echo "error while trying to kill all emu or no emu is opened"
    }
}
return this