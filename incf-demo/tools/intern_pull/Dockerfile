# docker build -t intern/pull .
# docker run --rm intern/pull
# Boilerplate

FROM python:3.9.17-slim
RUN apt-get update --fix-missing -qq \
&& apt-get install gcc git -yqq \
&& apt-get clean
RUN pip install --upgrade pip

# Project-specific configs
WORKDIR /app/
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# Tool specific configs
COPY intern_pull.py /app/intern_pull.py

# Nextflow docker execution does not support entrypoints
#ENTRYPOINT [ "python", "/app/intern_pull.py"]
