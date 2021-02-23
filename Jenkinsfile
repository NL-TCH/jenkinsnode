pipeline {
    agent any
    stages {
        stage('Clone repository') {
            steps{
                /* Let's make sure we have the repository cloned to our workspace */
                script{
                    checkout scm
                }
            }
        }

        stage('Build image') {
            steps{
                /* This builds the actual image; synonymous to
                * docker build on the command line */
                script{
                    app = docker.build("dockerteun/hellonode")
                }
            }
        }

        stage('Test image') {
            steps{
                /* Ideally, we would run a test framework against our image.
                * For this example, we're using a Volkswagen-type approach ;-) */
                script{
                    app.inside {
                        sh 'echo "Tests passed"'
                    }
                }
            }
        }

        stage('Push image') {
            steps{
                /* Finally, we'll push the image with two tags:
                 * First, the incremental build number from Jenkins
                 * Second, the 'latest' tag.
                 * Pushing multiple tags is cheap, as all the layers are reused. */
                script{
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
    }
 
    post { 
        always { 
            echo 'Build finished'
        }
        success {
            echo 'Build successfull'
            mail bcc: '',
            body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}",
            cc: '',
            charset: 'UTF-8',
            from: '',
            mimeType: 'text/html',
            replyTo: '',
            subject: "SUCCESS CI: Project name -> ${env.JOB_NAME}",
            to: "teunish@outlook.com"; 
        }
        aborted {
            echo 'Build aborted'
            mail bcc: '',
            body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}",
            cc: '',
            charset: 'UTF-8',
            from: '',
            mimeType: 'text/html',
            replyTo: '',
            subject: "ABORTED CI: Project name -> ${env.JOB_NAME}",
            to: "teunish@outlook.com"; 
        }
        failure {
            echo 'Build failure'
            mail bcc: '',
            body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}",
            cc: '',
            charset: 'UTF-8',
            from: '',
            mimeType: 'text/html',
            replyTo: '',
            subject: "FAILURE CI: Project name -> ${env.JOB_NAME}",
            to: "teunish@outlook.com"; 
        }
    }
}
