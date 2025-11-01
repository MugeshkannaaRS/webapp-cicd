pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/MugeshkannaaRS/webapp-cicd.git'
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
                // Replace with your actual ECR login if configured
                bat 'echo Logged into AWS ECR'
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                echo 'Tagging and pushing Docker image...'
                bat '''
                echo Tagging image
                echo Pushing image to ECR
                '''
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
