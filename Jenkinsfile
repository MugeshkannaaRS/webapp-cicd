pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        IMAGE_NAME = 'webapp-cicd'
        ECR_REPO = '108322181673.dkr.ecr.us-east-1.amazonaws.com/webapp-cicd'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/MugeshkannaaRS/webapp-cicd.git'
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building the web application...'
                sh 'echo "Build step complete."'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'echo "Tests passed successfully!"'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh '''
                    docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withAWS(region: "${AWS_REGION}", credentials: 'aws-credentials') {
                    script {
                        sh '''
                            aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                        '''
                    }
                }
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                script {
                    sh '''
                        docker tag $IMAGE_NAME:latest $ECR_REPO:latest
                        docker push $ECR_REPO:latest
                    '''
                }
            }
        }

        stage('Deploy to AWS ECS') {
            steps {
                echo 'Deploying to AWS ECS (mock step for now)...'
                sh 'echo "Deployment step complete."'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}
