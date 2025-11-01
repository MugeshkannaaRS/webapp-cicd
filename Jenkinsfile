
pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO_NAME = 'webapp-cicd-demo'
        IMAGE_TAG = "v${BUILD_NUMBER}"
        AWS_ACCOUNT_ID = "<your-aws-account-id>"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/<your-username>/webapp-cicd-demo.git'
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building the application...'
                // If it's a Node app:
                bat 'npm install'
                bat 'npm run build'
                // Or if it’s Java:
                // bat 'mvn clean package'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running tests...'
                bat 'npm test' // replace with mvn test if Java
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat "docker build -t ${ECR_REPO_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Login to AWS ECR') {
            steps {
                echo 'Logging in to AWS ECR...'
                bat "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
            }
        }

        stage('Tag & Push Docker Image') {
            steps {
                echo 'Pushing Docker image to ECR...'
                bat "docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                bat "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
            }
        }

        stage('Deploy to AWS ECS') {
            steps {
                echo 'Deploying container to AWS ECS...'
                // Option 1: Update ECS Service
                bat "aws ecs update-service --cluster myCluster --service myService --force-new-deployment --region ${AWS_REGION}"
                // Option 2: Deploy to EC2 (manual steps can be added later)
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
