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
            discordSend description: "Jenkins Pipeline Build", footer: "Footer Text", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/823661234359500850/98GVlzQwe9k2b_RBP6leZFhef-1ydpHYKE960V1KQBL4aDnHEBIdc6Z95nnqKit7IziL"
        #stay with your dirty hands of this discordwebhook
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
            to: "jenkins@teunis.dev"; 
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
            to: "jenkins@teunis.dev"; 
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
            to: "jenkins@teunis.dev"; 
        }
    }
}
