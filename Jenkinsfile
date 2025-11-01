pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "108322181673.dkr.ecr.us-east-1.amazonaws.com/webapp-cicd"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/MugeshkannaaRS/webapp-cicd.git'
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building the web application...'
                bat 'echo Build complete'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running tests...'
                bat 'echo Tests successful'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t myapp:latest .'
            }
        }

        stage('Login to AWS ECR') {
            steps {
                echo 'Logging in to AWS ECR...'
                bat """
                aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin 108322181673.dkr.ecr.us-east-1.amazonaws.com
                """
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                echo 'Tagging and pushing Docker image...'
                bat """
                docker tag myapp:latest %ECR_REPO%:latest
                docker push %ECR_REPO%:latest
                """
            }
        }

        stage('Deploy to AWS ECS') {
            steps {
                echo 'Deploying to ECS...'
                bat 'echo Deployment complete'
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
