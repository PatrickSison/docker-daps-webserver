#!/bin/bash
set -e

if [ "$TESTING_ENV" = "development" ]
then
    echo "development"
    cd /app
    pip3 install -r requirements.txt
    pip3 uninstall --yes celery
    cd celery-master/
    python3 setup.py install 
    cd ..
    python3 manage.py makemigrations
    python3 manage.py migrate
    (python3 manage.py runserver 0.0.0.0:8080 & sleep 10 && celery -A api.celery worker --beat  -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler)
else
    echo $TESTING_ENV
    cd /app
    pip3 install -r requirements.txt
    pip3 uninstall --yes celery
    cd celery-master/
    python3 setup.py install 
    cd ..
    python3 manage.py makemigrations
    python3 manage.py migrate
    (python3 manage.py runserver 0.0.0.0:8080 & sleep 10 && celery -A api.celery worker --beat  -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler)
fi