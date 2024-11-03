#FROM python:3.9.17-slim
# JPN
FROM python:3.10-slim


# RUN apt-get update --fix-missing -qq \
# && apt-get install gcc git python3-pip -yqq \
# && apt-get clean

RUN apt-get update --fix-missing -qq \
&& apt-get install gcc git -yqq \
&& apt-get clean

RUN pip install --upgrade pip


# Project-specific configs
WORKDIR /app/
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY centroids.py /app/centroids.py

# Need this for nextflow report
RUN apt install procps -yqq