1. Create simple hello world node app (app.js)

2. Add Dockfile

2. Test docker locally:
    
    2.1 Build Image: docker build -t test-fargate .

    2.2 Run Container: docker run -i --rm -p 8080:8080 --name test-fargate test-fargate

    2.4 verify your container: docker container ls

    2.3 Check that you get a "Hello World" response

    2.4 Stop local container: docker stop test-fargate


3.add buildspec.yml
