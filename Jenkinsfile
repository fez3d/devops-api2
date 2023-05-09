pipeline {
  agent none

  stages {
    stage('Build') {
      steps {
        echo 'Building..'
        sh 'bundle install'

      }
    }
    stage('Test') {
      steps {
        echo 'Testing..'
        sh 'rspec'
      }
    }
    stage('Deploy') {
      script {
        app = docker.build('devapitest', "./Dockerfile")
      }
      steps {
        echo 'Deploying....'
      }
    }
  }
}