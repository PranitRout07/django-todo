FROM ubuntu
WORKDIR /app
COPY requirements.txt /app/requirements.txt
COPY . /app/
RUN apt-get update && \
    apt-get install -y python3.11 python3-pip && \
    pip3 install -r requirements.txt && \
    python3 manage.py makemigrations && \
    python3 manage.py migrate 
EXPOSE 8000
ENTRYPOINT [ "python3" ]
CMD [ "manage.py","runserver","0.0.0.0:8000" ]