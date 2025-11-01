pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/MugeshkannaaRS/webapp-cicd.git', branch: 'main'
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building the application...'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running unit tests...'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
            }
        }

        stage('Deploy to AWS ECS') {
            steps {
                echo 'Deploying to AWS ECS...'
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
