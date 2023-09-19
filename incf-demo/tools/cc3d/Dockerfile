FROM python:3.9.17-slim
RUN pip install --upgrade pip

# Project-specific configs
WORKDIR /app/
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY centroids.py /app/centroids.py