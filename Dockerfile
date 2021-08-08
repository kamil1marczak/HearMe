ARG PYTHON_VERSION=3.8-slim-buster

# define an alias for the specfic python version used in this file.
FROM python:${PYTHON_VERSION} as python

ENV PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_PATH=/opt/poetry \
    VENV_PATH=/opt/venv \
    POETRY_VERSION=1.1.7
ENV PATH="$POETRY_PATH/bin:$VENV_PATH/bin:$PATH"

# Python build stage
FROM python as python-build-stage



RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        # deps for installing poetry
        curl \
        # deps for building python deps
        build-essential \
    \
    # install poetry - uses $POETRY_VERSION internally
    && curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python \
    && mv /root/.poetry $POETRY_PATH \
    && poetry --version \
    \
    # configure poetry & make a virtualenv ahead of time since we only need one
    && python -m venv $VENV_PATH \
    && poetry config virtualenvs.create false --local \
#    && poetry config settings.virtualenvs.create false \
    \
    # cleanup
    && rm -rf /var/lib/apt/lists/*

COPY poetry.lock pyproject.toml ./
RUN poetry install --no-interaction --no-ansi -vvv

FROM python as python-run-stage

#COPY --from=python-build-stage /app/venv /app/venv/
COPY --from=python-build-stage $VENV_PATH $VENV_PATH

#ENV PATH /app/venv/bin:$PATH
RUN python -m spacy download pl_core_news_lg

WORKDIR /app
COPY . ./

USER 1001

# set entrypoint for interactive shells
ENTRYPOINT ["rasa"]

# command to run when container is called to run
CMD ["shell", "--debug", "--enable-api", "--port", "5005"]
#CMD ["run", "--enable-api", "--port", "5005"]
