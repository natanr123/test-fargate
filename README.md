- Create simple hello world node app (app.js)
- Add Dockfile (From example source)
- Test docker locally:
    - Build Image: docker build -t test-fargate .
    - Run Container: docker run -i --rm -p 8080:8080 --name test-fargate test-fargate
    - verify your container: docker container ls
    - Check that you get a "Hello World" response
    - Stop local container: docker stop test-fargate
- Add buildspec.yml (From example source)
- Create GitHub repository and push your files to it
- Create an ECS Repository (also called Amazon ECR) name it: test-fargate-repo
- Create an ECS new Task Definition
    - Task Definition Name: Hello-Word-Task-Def
    - Task Memory 0.5GB
    - Task CPU 0.25 vCPU
    - Click on Add Container button
        - Container name: hello-world-container
        - image: abcd (It does not matter and will be overridden anyway another option is to use nginx:1.13.9-alpine)
        - Click on Add Button
    - Click on Create
- Create a ECS Cluster
    - Choose Networking Only
    - Cluster name: hello-world-cluster
- Create new ECS Service for 
    - Task Definition: Hello-World-Task-Def
    - Lunch type: FARGATE
    - Cluster: hello-world-cluster
    - Service Name: hello-world-service
    - Number of tasks: 1
    - Click on Next step
    - Choose VPC
    - Choose all the Subnets for this VPC
    - Click on Next Step
    - Click on Next Step
    - Click on Create Service
- Create a Code pipeline
    - Pipeline name: hello-world-pipeline
    - Remember the role name (it should be AWSCodePipelineServiceRole-us-west-2-hello-world-pipeline)
    - Click Next
    - Set the Repository to your github repository
    - Click Next
    - Build provider: AWS CodeBuild
    - Click on Create Project
        - Project Name: hello-world-code-build
        - Operating system: Ubuntu
        - Runtime: Docker
        - Runtime version: Choose latest
        - Remember the Role name (it should be: codebuild-hello-world-code-build-service-role)
        - Clock on Continue to CodePipeline and wait for the popup to be closed
        - Expand Additional Configuration and Add Environment variables
            - AWS_ACCOUNT_ID value = your own AWS account id. example: 123456789000 (google AWS_ACCOUNT_ID to figure out how to find it)
            - IMAGE_REPO_NAME value = test-fargate-repo
            - CONTAINER_NAME value = hello-world-container
            
    - Click Next   
    - Deploy provider: Amazon ECS
    - Cluster name: hello-world-cluster
    - Service name: hello-world-service
    - Image definitions file: images.json
    - Open a new browser tab and go to AWS IAM console
        - Open the Roles tab
        - Refresh the list by clicking  on the Refresh arrows button
        - Search for codebuild-hello-world-code-build-service-role and choose it
        - Click on Attach policies
        - Find AmazonEC2ContainerRegistryPowerUser mark it and click Attach Policy
        - Go back the CodePipeline Review page
    - Click on Create pipeline
        - Wait for the pipeline release to finish. It will fail in Deploy stage
        - Check the details you should see this message "The provided role does not have sufficient permissions to access ECS"
    - Open a new browser tab and go to AWS IAM console
        - Open the Roles tab
        - Refresh the list by clicking  on the Refresh arrows button
        - Search for AWSCodePipelineServiceRole-us-west-2-hello-world-pipeline and choose it
        - Click on Attach policies
        - Find AdministratorAccess mark it and click Attach Policy
        - Go back the CodePipeline Release page
    - Click Release Change All stages should succeed now
- Check that the container actually work and will show the hello world message
    - Open the Amazon ECS page
    - Choose hello-world-cluster
    - Under Network Access Click on the security group link
        - Edit inbound rules
            - Add All traffic rule
            - Click on Save Rules
            - Go back to the cluster page
    - Open the task tab
    - Click on the first (and only) task
    - In the network section you should see the Public IP
    - Go to it with port 8080
    
    
    
    
        
