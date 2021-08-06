FROM rasa/rasa-x:latest

COPY actions /app/actions

USER root
#RUN pip3 install rasa-x --pre --extra-index-url https://pypi.rasa.com/simple
RUN export RASA_X_PASSWORD="Kamil100!"
RUN pip install --no-cache-dir -r /app/actions/requirements-actions.txt
RUN pip install -U pip setuptools wheel \
    && pip install -U spacy \
#    && python -m spacy download pl_core_news_lg
    && python -m spacy download pl_core_news_sm

USER 1001
#CMD ["start", "--actions", "actions"]

ENTRYPOINT ["rasa"]