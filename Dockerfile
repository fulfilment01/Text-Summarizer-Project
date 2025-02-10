FROM python:3.8-slim-buster

# Install Git
RUN apt-get update && apt-get install -y git

WORKDIR /app

# Clone the repository after installing git
RUN git clone https://github.com/fulfilment01/Text-Summarizer-Project.git /app/src/text-summarizer-project

COPY . /app

RUN pip install -r requirements.txt
RUN pip install --no-input -r requirements.txt
RUN pip install --upgrade accelerate
RUN pip uninstall -y transformers accelerate
RUN pip install transformers accelerate

CMD ["python3", "app.py"]