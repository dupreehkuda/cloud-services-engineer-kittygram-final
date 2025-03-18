FROM python:3.9

EXPOSE 8000

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE 'kittygram_backend.settings'

ENV SECRET_KEY key

COPY ./requirements.txt ./requirements.txt

RUN apt update && apt install build-essential libpq-dev python3-dev -y && \
    python -m pip install --upgrade pip setuptools wheel && \
    python -m pip install cython && \
    pip install -r requirements.txt 
    

COPY . .

RUN python manage.py collectstatic --noinput

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]
