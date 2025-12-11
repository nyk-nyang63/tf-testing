    pipeline {
        agent any 
        environment {
            // Set AWS credentials as environment variables for Terraform
            AWS_ACCESS_KEY_ID = credentials('5dd75ca8-dc78-4b18-acc0-f1a9ef256450')
            AWS_SECRET_ACCESS_KEY = credentials('6f062640-716a-4432-9acb-60e628e59707')
        }
        stages {
            stage('Terraform Init') {
                steps {
                    sh 'terraform init'
                }
            }
            stage('Terraform Plan') {
                steps {
                    sh 'terraform plan -out=tfplan' // Save plan to a file
                }
            }
            stage('Terraform Apply') {
                steps {
                    input "Proceed with Terraform Apply?" // Manual approval for apply
                    sh 'terraform apply tfplan' // Apply the saved plan
                }
            }
            // Optional: Stage for Terraform Destroy
            // stage('Terraform Destroy') {
            //     steps {
            //         input "Proceed with Terraform Destroy?"
            //         sh 'terraform destroy -auto-approve' 
            //     }
            // }
        }
        post {
            always {
                // Cleanup or notification steps
            }
        }
    }
