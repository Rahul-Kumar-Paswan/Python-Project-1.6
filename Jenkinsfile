pipeline {
  agent any
  
  stages{

    stage('Increment Version') {
      steps {
        script {
          echo " hello dear"
          def currentVersion = sh(
            script: "python3 -c \"import re; match = re.search(r'version=\\\\'(.*?)\\\\'', open('setup.py').read()); print(match.group(1) if match else '143')\"",
              returnStdout: true
              ).trim()

          echo "Previous Version: ${currentVersion}"
          // Split the version into major, minor, and patch parts
          def versionParts = currentVersion.split('\\.')

          // Access the version parts using index
          def major = versionParts[0]
          def minor = versionParts[1]
          def patch = versionParts[2]

          echo "Current Version: ${currentVersion}"
          echo "Major: ${major}"
          echo "Minor: ${minor}"
          echo "Patch: ${patch}"
          echo "old versionParts : ${versionParts}"
                    
          // Increment the patch part
          versionParts[-1] = String.valueOf(versionParts[-1].toInteger() + 1)
          echo "new versionParts : ${versionParts}"
                    
          // Join the version parts back together
          def newVersion = versionParts.join('.')
          echo "newVersion : ${newVersion}"
                    
          // Update the setup.py file with the new version
          sh "sed -i \"s/version='${currentVersion}'/version='${newVersion}'/\" setup.py"

          echo "New Version: ${newVersion}"
          env.IMAGE_NAME = "$newVersion-$BUILD_NUMBER"
          echo "New IMAGE_NAME: ${IMAGE_NAME}"
        }
      }
    }

    stage('Clean Build Artifacts') {
      steps {
        echo " hello dear welcome to  my world !!!!"
        sh 'rm -rf build/ dist/ *.egg-info/'
        echo " hello dear welcome to  my world !!!!"
      }
    }
    
    stage('Build Image') {
      steps {
        echo "hello"
        sh "docker build -t my-python-project:${IMAGE_NAME} ."
        sh "docker tag my-python-project:${IMAGE_NAME} rahulkumarpaswan/my-python-project:${IMAGE_NAME}"
        sh "docker push rahulkumarpaswan/my-python-project:${IMAGE_NAME}"
      }
    }

    stage('Deploy') {
      steps {
        echo "Deploy to EC2........."
        }
    }

    /* stage('Checkout') {
      steps {
        git credentialsId: 'git-credentials', url: 'https://github.com/Rahul-Kumar-Paswan/Python-Project-1.6.git'
      }
    } */

    stage('Git Commit Update') {
      steps {
        script {
          echo "adding updates to git"
          withCredentials([usernamePassword(credentialsId: 'git-credentials', passwordVariable: 'PASS' , usernameVariable: 'USER')]){
            echo "Pass : ${PASS}"
            sh 'git config --global user.name "Rahul-Kumar-Paswan"'
            sh 'git config --global user.email "jekins@gmail.com"'

            sh 'git status'
            sh 'git branch'
            sh 'git config --list'

            sh "git remote set-url origin https://Rahul-Kumar-Paswan:P@swan341@github.com/Rahul-Kumar-Paswan/Python-Project-1.6.git"
            // https://Rahul-Kumar-Paswan:P@swan341@github.com/Rahul-Kumar-Paswan/Python-Project-1.6.git
            // sh 'git remote set-url origin https://github.com/Rahul-Kumar-Paswan/Python-Project-1.6.git'
            sh 'git add .'
            sh 'git commit -m "cli: version updates"'
            sh 'git push origin HEAD:main'
          }
        }
      }
    }

  }
}



