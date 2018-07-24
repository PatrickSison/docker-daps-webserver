#!/bin/bash
set -e

if [ "$TESTING_ENV" = "development" ]
then
    echo "development"
    python3 manage.py makemigrations
    python3 manage.py migrate
    python3 manage.py runserver 0.0.0.0:8080
else
    echo $TESTING_ENV
    python3 manage.py makemigrations
    python3 manage.py migrate
    python3 manage.py runserver 0.0.0.0:443
fi