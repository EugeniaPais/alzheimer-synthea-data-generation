
Dockerfile for alzheimer data generation with [Synthea](https://github.com/synthetichealth/synthea).
The docker file can be replaced with any other configuration and the docker comands keep the same.

Run the code to generate the image
``` docker build --tag alzheimer-1000 - < Dockerfile  ```

Run the code to generate the data
``` docker run -v ./docker_output:/output -it alzheimer-1000 ```