APPIUM_PORT= [2003,2005,4601,4603,5580,5582,5554,5556]
EMULATOR_PORT= [5580,5582,5554,5556]
// common function
def notify_result_to_slack(channel,jenkin_path){
        echo "Publish Robot Framework test results"
        String prefix = ":white_check_mark:"
        env.ROBOT_MAKNET = sh(script: "python3 ${WORKSPACE}/resources/library/tags.py output.xml", returnStdout: true).trim()
        echo env.ROBOT_MAKNET
               if (tm('${ROBOT_FAILED}').toInteger() > 0) {
                  prefix = ":firecracker:"
               }
               String robotlog = tm('${BUILD_URL}/robot/report/log.html')
               robotlog = robotlog.replaceAll("localhost:8080", jenkin_path)
               echo "${robotlog}"
               def full_msg = "${prefix}  ${JOB_NAME}  #${BUILD_NUMBER} \n *VERSION* : Android${env.APP_VER}.apk \n *INCLUDED* : ${env.INCLUDE} \n ${ROBOT_MAKNET} \n after ${currentBuild.durationString} \n (<${robotlog}|Report>)"
               env.NOTI_MSG = "${full_msg}"

        slackSend(channel: "${channel}", message:  "${full_msg}")
}

def start_android_emulator(EMULATOR_NAME){
    count = 1
    for(int i in EMULATOR_PORT){
        echo "starting emulator... count ${count}"
        sh "nohup $ANDROID_HOME/emulator/emulator @${EMULATOR_NAME}0${count} -port ${i} > log_emu_0${count}.txt &"
        count = count+1
        sh "sleep 5"
    }
    sleep 30
}

def stop_android_emulator(){
    for(int i in EMULATOR_PORT){
        echo "STOP EMULATOR running on Port ${i}"
        try {
            sh "kill -9 \$(lsof -t -i :${i})"
        }
        catch(err) {
            echo "EMULATOR running on Port ${i} is stopped"
        }
    }
}

def start_appium(){
    for(int i in APPIUM_PORT){
        echo "STARTING Appium Port ${i}"
        try {
            sh "appium --port ${i} &"
            echo "Waiting for appium to start for 5s"
            sh "sleep 5"
            sh "curl http://0.0.0.0:${i}/wd/hub/status"
        }
        catch(err) {
            echo "appium ${i} is started"

        }
    }
}

def stop_appium(){
    for(int i in APPIUM_PORT){
        echo "STOP Appium Port ${i}"
        try {
            sh "kill -9 \$(lsof -t -i :${i})"
        }
        catch(err) {
            echo "appium ${i} is stopped"
        }
    }
}

// Send result to dumbledore v2
def notify_result_to_dumbledore_v2(report_html_file,output_xml_file){
    try{
        echo "report_html_file : ${report_html_file}"
        echo "output_xml_file : ${output_xml_file}"
        sh "ls -la ${WORKSPACE}"
        sh """
        curl --location --request POST 'http://125.26.15.143:21000/upload_result' \
            --form 'report_html_file=@"${report_html_file}"' \
            --form 'output_xml_file=@"${output_xml_file}"' \
            --form 'job_name="${JOB_NAME}"' \
            --form 'build_url="${BUILD_URL}"' \
            --form 'build_number="${BUILD_NUMBER}"' \
            --form 'branch_name="${GIT_BRANCH}"' \
            --form 'log_type="robot"'
        """
    }
    catch(err){
        echo "error while notifying_result_to_dumbledore_v2"
    }
}

def doppio_report(){
    echo "new doppio report"
    sh '''
        ls -la
        python3 $WORKSPACE/report_sender.py
    '''
}

return this