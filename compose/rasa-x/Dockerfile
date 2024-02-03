# use a python container as a starting point
FROM python:3.13.0a3-slim


RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential
#    pip install --no-cache-dir ujson
RUN pip install --upgrade pip==20.2

RUN python -m pip install --use-feature=2020-resolver rasa-x==0.42.0 --extra-index-url https://pypi.rasa.com/simple \
    rasa[spacy] \
    git+https://github.com/RasaHQ/rasalit
# install dependencies of interest
RUN python -m spacy download pl_core_news_lg

#RUN python -m pip install rasa[spacy] && \
#    python -m spacy download pl_core_news_lg
#    python -m spacy download pl_core_news_sm
#RUN python -m pip install rasa-x --extra-index-url https://pypi.rasa.com/simple

#RUN export RASA_X_PASSWORD="Kamil100!"
# set workdir and copy data files from disk
# note the latter command uses .dockerignore
WORKDIR /app
ENV HOME=/app
COPY . .

# train a new rasa model
#RUN rasa train nlu

# set the user to run, don't run as root
USER 1001

# set entrypoint for interactive shells
ENTRYPOINT ["rasa"]

# command to run when container is called to run
#CMD ["rasa", "x", "–enable-api", "-p", "5005", "–cors", "*", "–no-prompt"]
#CMD ["run", "--enable-api", "--port", "5005"]