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
            echo 'I will always say Hello!'
        }
        success {
            step([$class: 'Mailer',
                notifyeveryBuild: true,
                recipients: "teunish@outlook.com",
                sendToIndividuals: true])"
        }
        aborted {
            echo 'I was aborted'
        }
        failure {
            mail to: 'teunish@outlook.com',
            subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
            body: "Something is wrong with ${env.BUILD_URL}"
        }
    }
}
