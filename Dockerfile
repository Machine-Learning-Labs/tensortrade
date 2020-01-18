# Optimized with fromlatest.io
FROM python:3.6

ENV PYTHONUNBUFFERED=1

RUN apt-get update -y && \
  apt-get install -y \
  build-essential \
  pandoc \
  mpich \
  openmpi-bin \
  openmpi-common \
  mpi-default-bin \
  python-mpi4py &&\
  apt-get autoremove -y &&\
  apt-get clean -y &&\
  rm -rf /var/lib/apt/lists/*

WORKDIR /

COPY . ./

RUN pip install --upgrade pip &&\
    pip install -e .[tf,baselines,tensorforce,ta,ccxt,fbm,docs,tests] &&\
    pip install -r ./requirements.txt &&\
    pip install -r ./examples/requirements.txt