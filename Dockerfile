#FROM rasa/rasa-sdk:2.4.0
#
#COPY actions /app/actions
#
#USER root
#RUN pip install --no-cache-dir -r /app/actions/requirements-actions.txt
#RUN python -m spacy download pl_core_news_lg
#
#USER 1001
#CMD ["start", "--actions", "actions"]
FROM rasa/rasa-sdk:2.6.0

# Use subdirectory as working directory
WORKDIR /app

# Copy actions requirements
COPY actions/requirements-actions.txt ./

# Change to root user to install dependencies
USER root

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  python3 \
  python3-venv \
  python3-pip \
  python3-dev \
  # required by psycopg2 at build and runtime
  libpq-dev \
  # required for health check
  curl \
  && apt-get autoremove -y

# Make sure that all security updates are installed
RUN apt-get update && apt-get dist-upgrade -y --no-install-recommends

# Install extra requirements for actions code
RUN pip install -r requirements-actions.txt

# Copy actions code to working directory
#COPY ./actions /app/actions
COPY actions /app/actions


# Install modules from setup.py
COPY setup.py /app
COPY README.md /app
RUN pip install . --no-cache-dir

# Download spacy language data
RUN python -m spacy download pl_core_news_lg

# Don't use root user to run code
USER 1001

# Start the action server
#CMD ["start", "--actions", "actions.actions"]
CMD ["start", "--actions", "actions"]