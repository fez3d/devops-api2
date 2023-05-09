pipeline {
  agent any

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
      steps {
        script {
          app = docker.build('devapitest', "Dockerfile")
        }
        echo 'Deploying....'
      }
    }
  }
}