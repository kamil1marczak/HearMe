FROM rasa/rasa-sdk:latest

COPY actions /app/actions

USER root
RUN pip install --no-cache-dir -r /app/actions/requirements-actions.txt
RUN pip install -U pip setuptools wheel \
    && pip install -U spacy \
    && python -m spacy download pl_core_news_lg

USER 1001
CMD ["start", "--actions", "actions"]

