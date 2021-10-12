
if [[ "$(docker images -q cpp_dev_env:latest 2> /dev/null)" == "" ]]; then
    docker build -f Dockerfile.dev . -t cpp_dev_env
fi


docker run -ti --rm -v ${PWD}:/home/app cpp_dev_env bash
