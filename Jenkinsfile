pipeline {
    agent
		{
        dockerfile true  //to indicate dockerfile in the same directory/current location
         //{
         //filename  'Dockerfile'
         //args "-u root -v /var/run/docker.sock:/var/run/docker.sock"
         //}
        }

    environment {
        projectName = 'ProjectTemplate'
        emailTo = 'VenkateshKri@hcl.com'
        emailFrom = 'VenkateshKri-jenkins@hcl.com'
        //VIRTUAL_ENV = "${env.WORKSPACE}/venv"
        //PATH="/var/lib/jenkins/miniconda3/bin:$PATH"
    }

    stages {

        stage("List and Stop all Containers"){
            steps{
                // List all containers (only IDs)
                echo "List all containers (only IDs)"
                sh 'docker ps -aq'
                //Stop all running containers
                echo "Stop all running containers"
                sh 'docker stop $(docker ps -aq)'
            }

        }

        stage("Cleaning Existing Resources") {
            steps {
                echo "Cleaning up all running,unused(dangling) and stopped docker images and containers"

                //Delete all stopped containers
                sh ' docker ps -q -f status=exited | xargs --no-run-if-empty docker rm'

                // Delete all dangling (unused) images
                sh 'docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi'

            }
        }

        stage ("Code Pull"){
            steps{

            //Let's make sure we have the repository cloned to our workspace

                checkout scm
            }
        }

        stage('Build Image') {
            //This builds the actual image; synonymous to docker build on the command line
            // https://stackoverflow.com/questions/28349392/how-to-push-a-docker-image-to-a-private-repository

            steps {
                // docker build -t reference tag name and directory to look for dockerfile( . -> current dir)
                echo 'Building an image for deployment'
                sh 'docker build -t hps-api:latest .'
                //sh 'docker push ./API_Tier'
            }
        }

        stage('Run Docker Image and Setup CYC Server Env') {

            steps {
                echo 'Test environment build and setup'
                sh 'docker run --rm -d --name api-tier-0.1.12.9.7.2018.1 -p 5000:5000 --env CYC_SERVER="https://10.82.98.105/" api-tier-0.1.12'
            }
        }
    }

    post {

        always {
            //https://mdyzma.github.io/2017/10/14/python-app-and-jenkins/
            echo "code for always running the code"
        }
        failure {
            echo "sectionn for failure"
        }
        success {
			echo "sectionn for success"
        }
    }
}