FROM rasa/rasa-sdk:2.4.0

COPY actions /app/actions

USER root
RUN pip install --no-cache-dir -r /app/actions/requirements-actions.txt
RUN python -m spacy download pl_core_news_lg

USER 1001
CMD ["start", "--actions", "actions"]