#!/bin/bash
set -e

if [ "$TESTING_ENV" = "development" ]
then
    echo "development"
    cd /app/api
    pip install -r requirements.txt
    python3 manage.py makemigrations
    python3 manage.py migrate
    python3 manage.py runserver 0.0.0.0:8080 & (cd /app/web && react-scripts start)
else
    echo $TESTING_ENV
    cd /app/api
    pip install -r requirements.txt
    python3 manage.py makemigrations
    python3 manage.py migrate
    (python3 manage.py runserver 0.0.0.0:443 & sleep 10 && pip uninstall --yes celery  && cd celery-master/ && python setup.py install && cd ..&& celery -A api.celery worker --beat  -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler)
fi