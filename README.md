# BP-TF-STEP
BP bash step for terraform execution

## Setup
* Clone the code available at [BP-TF-STEP](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-TF-STEP)
* Build the docker image

```
git submodule init
git submodule update
docker build -t ot/tf:0.1 .
```
*git submodule update --recursive --remote*

## Testing
This section will give you a walkthrough of how you can use this image to do various types of testing
Some of the global environment variables that control the behaviour of scanning
* INSTRUCTION | Default - plan | For possible values check tf documentation

* Do local testing via image only

```
# terraform plan
docker run -it --rm -v $PWD:/src -e WORKSPACE=/src -e CODEBASE_DIR=terraform_code -e IMAGE_TAG=0.1 ot/tf:0.1
```
* Debug
```
docker run -it --rm -v $PWD:/src -e WORKSPACE=/src -e CODEBASE_DIR=terraform_code --entrypoint sh ot/tf:0.1
```

## Reference
* [Base Docker image](https://hub.docker.com/r/hashicorp/terraform/)

