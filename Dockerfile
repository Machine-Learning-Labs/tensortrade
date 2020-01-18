# Optimized with fromlatest.io
FROM python:3.6

ENV PYTHONUNBUFFERED=1

RUN RUN apt-get update -y && \
    apt-get install pandoc -y && \
    apt-get install python-mpi4py -y &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /

COPY . ./

RUN pip install --upgrade pip &&\
    pip install -e .[tf,baselines,tensorforce,ta,ccxt,fbm,docs,tests] &&\
    pip install -r ./requirements.txt &&\
    pip install -r ./examples/requirements.txt
