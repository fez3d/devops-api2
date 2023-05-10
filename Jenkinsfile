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
        echo 'Deploying....'
        script {
          app = docker.build("sicei-master:1.0.0-${BUILD_NUMBER}")
        }

        sh 'sudo docker stop $(sudo docker ps -a -q)'
        sh 'sudo docker run -p 3000:3000 --network="host" -d sicei-master:1.0.0-${BUILD_NUMBER}'
      }
    }
  }
}