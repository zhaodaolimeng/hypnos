FROM ubuntu:16.04

LABEL MAINTAINER="John Beieler <jbeieler@caerusassociates.com>"

RUN apt-get update && apt-get install -y git python-dev python-pip 

ADD . /src

RUN cd /src; pip install -r requirements.txt

RUN cd /src/petrarch; python setup.py install;

EXPOSE 5002

CMD ["python", "/src/app.py"]
