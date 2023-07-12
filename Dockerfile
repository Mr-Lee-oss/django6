From alpine:3.18.2
RUN apk update
RUN apk add python3
RUN apk add curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
#django 설치
RUN pip3 install django
#django 프로젝트 생성
RUN django-admin startproject wc
WORKDIR /wc/wc
RUN sed -i 's/ALLOWED_HOSTS = \[]/ALLOWED_HOSTS = \["*"]/g' settings.py
WORKDIR /wc
RUN python manage.py migrate
#django 실행
EXPOSE 8000/tcp
#RUN python3 manage.py runserver 0.0.0.0:8000 이건 안
#CMD ["python", "/wc/manage.py", "runserver", "0.0.0.0:8000"]
#CMD python manage.py runserver 0.0.0.0:8000
WORKDIR /wc
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
