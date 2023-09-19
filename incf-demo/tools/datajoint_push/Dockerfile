FROM datajoint/datajoint
RUN pip install --upgrade pip

# Project-specific configs
WORKDIR /app/
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY datajoint-push.py /app/datajoint-push.py
