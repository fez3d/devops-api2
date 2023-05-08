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
      agent {
        dockerfile true
      }
      steps {
        echo 'Deploying....'
      }
    }
  }
}