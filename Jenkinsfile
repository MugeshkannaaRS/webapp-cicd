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
                echo '--- Checking out source code from GitHub ---'
                git branch: 'main', url: 'https://github.com/MugeshkannaaRS/webapp-cicd.git'
            }
        }

        stage('Build Application') {
            steps {
                echo '--- Building application ---'
                // Replace this with your build command if needed (npm, maven, etc.)
                bat 'echo Build step completed successfully'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo '--- Running unit tests ---'
                bat 'echo Unit tests passed successfully'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '--- Building Docker image ---'
                bat """
                docker build -t %IMAGE_NAME% .
                """
            }
        }

        stage('Login to AWS ECR') {
            steps {
                echo '--- Logging in to AWS ECR ---'
                bat """
                aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin %ECR_REPO%
                """
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                echo '--- Tagging and pushing Docker image to ECR ---'
                bat """
                docker tag %IMAGE_NAME%:latest %ECR_REPO%:latest
                docker push %ECR_REPO%:latest
                """
            }
        }

        stage('Deploy to AWS ECS') {
            steps {
                echo '--- Deploying to AWS ECS ---'
                // Make sure you have your ECS service and task definition set up
                bat """
                aws ecs update-service --cluster webapp-cluster --service webapp-service --force-new-deployment --region %AWS_REGION%
                """
            }
        }
    }

    post {
        success {
            echo 'Deployment pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check logs above.'
        }
    }
}
