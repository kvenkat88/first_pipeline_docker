#FROM gcr.io/google-appengine/python
#FROM python:2.7.15

FROM python:3.6.5-alpine3.7

MAINTAINER HPS Engineering and QA Team

WORKDIR  /usr/src/app


COPY . /usr/src/app

#RUN pwd print the current working directory
#RUN echo "$PWD"

# copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /usr/src/app/requirements.txt

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

#copy . .

ENV PYTHONPATH="/usr/src/app/external"
ENV CYC_SERVER=""
ENV DATA_DIR=""
ENV TRANSLATION_DATA=""
ENV RASA_DIR=""
ENV SPACY_MODEL_DIR=""
ENV PROCESSED_PASSAGES_DIR=""
ENV MONGO_HOST=""
ENV MONGO_DB="app-database"
ENV SUPPORTED_MONGO_COLLECTIONS="app-collection"


# tell docker what port to expose
#EXPOSE 8000
