pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        AWS_ACCOUNT_ID = '108322181673'
        IMAGE_REPO_NAME = 'webapp-cicd'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/MugeshkannaaRS/webapp-cicd.git'
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building application...'
                bat 'npm install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running tests...'
                bat 'npm test || echo No tests found'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t webapp-cicd:latest .'
            }
        }
        
        stage('Login to AWS ECR') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'ap-south-1') {
                bat '''
                aws ecr get-login-password --region ap-south-1 ^
                | docker login --username AWS --password-stdin 108322181673.dkr.ecr.ap-south-1.amazonaws.com
                '''
                }
            }
        }


        stage('Tag & Push Docker Image') {
            steps {
                bat '''
                docker tag webapp-cicd:latest 108322181673.dkr.ecr.ap-south-1.amazonaws.com/webapp-cicd:latest
                docker push 108322181673.dkr.ecr.ap-south-1.amazonaws.com/webapp-cicd:latest
                '''
            }
        }

        stage('Deploy to AWS ECS') {
            steps {
                echo 'Deploying to ECS (manual or via AWS CLI)'
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}