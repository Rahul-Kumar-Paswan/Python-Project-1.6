FROM python
COPY . /app
WORKDIR /app
RUN python setup.py sdist bdist_wheel
RUN pip install -r requirements.txt
WORKDIR /app/dist
RUN pip install project_package-*.tar.gz
RUN pip install project_package-*.whl
WORKDIR /app
EXPOSE  3000
CMD ["python", "-m" ,"project_package.main"]
