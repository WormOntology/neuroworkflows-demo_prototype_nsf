# FROM datajoint/datajoint

# USER root

# # JPN added (the python3, python3-pip might not be necessary)
# # RUN apt-get update --fix-missing -qq \
# # && apt-get install gcc git python3 python3-pip -yqq \
# # && apt-get clean  

# RUN apt-get update --fix-missing -qq \
# && apt-get install gcc git -yqq \
# && apt-get clean  

# #RUN pip install --upgrade pip
# #RUN apt-get install pipx --y
# RUN apt-get install pipx -yqq


# # Project-specific configs
# WORKDIR /app/
# COPY requirements.txt /app/requirements.txt
# # JPN
# #RUN pip install -r requirements.txt
# RUN pipx install cookiecutter
# #RUN pipx install requirements.txt
# RUN pipx runpip cookiecutter install -r requirements.txt

# #RUN python3 -m pip install -r requirements.txt

# COPY datajoint-push.py /app/datajoint-push.py

# # Need this for nextflow report
# RUN apt install procps -yqq

# #RUN mysql CREATE USER 'root'@'%' IDENTIFIED BY 'simple'; 
# #RUN mysql GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

FROM datajoint/datajoint

USER root

RUN apt-get update && apt-get clean

RUN apt-get autoclean

RUN apt-get update --fix-missing -qq \
&& apt-get install gcc git -yqq \
&& apt-get clean

# JPN
#RUN pip install --upgrade pip

# Project-specific configs
WORKDIR /app/
COPY requirements.txt /app/requirements.txt
#RUN pip install -r requirements.txt
# JPN
RUN apt-get install pipx -yqq
RUN pipx install cookiecutter
RUN pipx runpip cookiecutter install -r requirements.txt

COPY datajoint-push.py /app/datajoint-push.py

# Need this for nextflow report
RUN apt install procps -yqq