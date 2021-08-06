FROM rasa/rasa-sdk:latest

# Use subdirectory as working directory
WORKDIR /app

# Copy any additional custom requirements, if necessary (uncomment next line)
# COPY actions/requirements-actions.txt ./

# Change back to root user to install dependencies
USER root

# Install extra requirements for actions code, if necessary (uncomment next line)
# RUN pip install -r requirements-actions.txt

# Copy actions folder to working directory
COPY . /app/actions
#COPY ../action /app/actions

RUN pip install --no-cache-dir -r /app/actions/requirements-actions.txt

# By best practices, don't run the code with root user
USER 1001
#
#COPY actions /app/actions
#
#USER root
#
#RUN pip install --no-cache-dir -r /app/actions/requirements-actions.txt
#RUN pip install -U pip setuptools wheel \
#    && pip install -U spacy \
##    && python -m spacy download pl_core_news_lg
#    && python -m spacy download pl_core_news_sm

#EXPOSE 5055
#ENTRYPOINT ["rasa"]
