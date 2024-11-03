FROM datajoint/datajoint

USER root

# JPN added
RUN apt-get update --fix-missing -qq \
&& apt-get install gcc git python3-pip -yqq \
&& apt-get clean  

RUN pip install --upgrade pip


# Project-specific configs
WORKDIR /app/
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY datajoint-push.py /app/datajoint-push.py

# Need this for nextflow report
RUN apt install procps -yqq