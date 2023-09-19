FROM datajoint/datajoint
RUN pip install --upgrade pip

USER root

RUN apt-get update --fix-missing -qq \
&& apt-get install gcc git -yqq \
&& apt-get clean

# Project-specific configs
WORKDIR /app/
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY datajoint-push.py /app/datajoint-push.py

# Need this for nextflow report
RUN apt install procps -yqq