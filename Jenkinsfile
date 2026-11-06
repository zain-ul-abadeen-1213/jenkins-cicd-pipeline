pipeline {
    agent any

    environment {
        APP_NAME   = 'zaintech-web'
        DEPLOY_DIR = "/var/jenkins_home/deployed/zaintech-web"
    }

    stages {
        stage('Verify') {
            steps {
                // Code arrives via the automatic SCM checkout of this Jenkinsfile's repo.
                sh 'sh check.sh'
            }
        }
        stage('Package') {
            steps {
                sh '''
                    mkdir -p dist
                    tar -czf dist/${APP_NAME}-${BUILD_NUMBER}.tar.gz index.html style.css app.js
                    ls -lh dist/
                '''
                archiveArtifacts artifacts: 'dist/*.tar.gz', fingerprint: true
            }
        }
        stage('Deploy (local)') {
            steps {
                sh '''
                    mkdir -p ${DEPLOY_DIR}/releases ${DEPLOY_DIR}/current
                    cp dist/${APP_NAME}-${BUILD_NUMBER}.tar.gz ${DEPLOY_DIR}/releases/
                    tar -xzf dist/${APP_NAME}-${BUILD_NUMBER}.tar.gz -C ${DEPLOY_DIR}/current
                    printf "app=%s\nbuild=%s\ndeployed=%s\n" "${APP_NAME}" "${BUILD_NUMBER}" "$(date)" > ${DEPLOY_DIR}/DEPLOYED.txt
                    cat ${DEPLOY_DIR}/DEPLOYED.txt
                '''
            }
        }
    }

    post {
        success { echo "Pipeline SUCCESS - ${APP_NAME} build ${BUILD_NUMBER} deployed to ${DEPLOY_DIR}" }
        failure { echo "Pipeline FAILED - check the stage logs above" }
    }
}
