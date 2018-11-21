- Create simple hello world node app (app.js)

- Add Dockfile

- Test docker locally:
    
    - Build Image: docker build -t test-fargate .

    -  Run Container: docker run -i --rm -p 8080:8080 --name test-fargate test-fargate

    - verify your container: docker container ls

    - Check that you get a "Hello World" response

    - Stop local container: docker stop test-fargate


- Add buildspec.yml


- Create GitHub repository and push your files to it
