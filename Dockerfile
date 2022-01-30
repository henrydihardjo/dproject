FROM python:3.10
WORKDIR /dproj
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src/ .
CMD ["json_to_csv"]