pipeline {
    agent any
    stages {
        stage ('SCM') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '6de08d07-93e4-4fa9-826f-72fdcf646110', url: 'https://github.com/ulchatur/new_docker.git']]])
            }
        }
        stage ('Deployment') {
            steps {
                sh label: '', script: '''docker --version
                cd /var/lib/jenkins/workspace/docker
                docker build -t nodejs .
                docker run -itd -p 3000:3000 --name nodejs nodejs '''
            }
        }
        stage ('Email') {
            steps {
                emailext body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:

Check console output at $BUILD_URL to view the results.''', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'ullasvardhan@gmail.com'
            }
        }
    }
    post {
        failure {
            mail to: 'ullasvardhan@gmail.com',
            subject: "pipeline status: ${currentBuild.fullDisplayName}",
            body: "build ${env.BUILD_URL} is ${currentBuild.result}"
        }
    }
}
