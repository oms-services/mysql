FROM          python:3.7-alpine

RUN           mkdir /app
COPY          requirements.txt /app

RUN           apk --no-cache add --virtual build-dependencies \
                build-base \
                py-mysqldb \
                gcc \
                libc-dev \
                libffi-dev \
                mariadb-dev \
                && pip install -qq -r /app/requirements.txt \
                && rm -rf .cache/pip \
                && apk del build-dependencies

COPY          app.py /app

ENTRYPOINT    ["python", "/app/app.py"]
