//Global runner config
RP_ENDPOINT ='http://10.88.9.127:8080'
RP_UUID = '497f76de-ed96-4c75-96b3-73900e628ab8'
RP_LAUNCH = 'superadmin_TEST_EXAMPLE'
RP_PROJECT= "${RP_PROJECT}"

def send_to_report(RP_PROJECT){
    try {
        echo "==== start response ====="
            echo "==== ${RP_PROJECT} === ${SERVER_OS} =="
            response = bat(script: '''curl --header "Content-Type: application/json" \
                                             --header "Authorization: Bearer %RP_UUID%" \
                                             --request POST \
                                             --data '{"name":"'%RP_PROJECT%'","description":"Test browser stack","startTime":"'%(date +%s)000'","mode":"DEFAULT","attributes":[{"key":"build","value":"0.1"},{"value":"test"}]}' \
                                             %RP_ENDPOINT%/api/v1/%RP_PROJECT%/launch | jq -r .id''' ,
                                       returnStdout: true).trim()   
        echo "==== end response ====="
    }
    catch (err) {
        echo "==== ${err} ====="
    }
}

return this
