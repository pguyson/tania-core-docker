FROM ubuntu:16.04
RUN apt-get -y update && apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:longsleep/golang-backports && apt-get update -y && apt-get install -y nodejs golang-go git build-essential libpng-dev
RUN mkdir /root/go && export GOPATH=/root/go && export PATH=$PATH:$GOPATH/bin
RUN go get github.com/Tanibox/tania-core && go get -u github.com/golang/dep/cmd/dep
WORKDIR /root/go/src/github.com/Tanibox/tania-core
RUN /root/go/bin/dep ensure && cp conf.json.example conf.json && npm install && npm run dev
ENTRYPOINT ["go", "run", "main.go"]
EXPOSE 8080