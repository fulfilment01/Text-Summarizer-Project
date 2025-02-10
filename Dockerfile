FROM python:3.8-slim-buster

# Update and install AWS CLI
RUN apt update -y && apt install awscli -y

# Set the working directory inside the container
WORKDIR /app

# Copy application files into the container
COPY . /app

# Remove the text summarizer directory if it already exists (ensure clean clone)
RUN rm -rf /app/src/text-summarizer-project

# Optionally, clone the repository if needed
RUN git clone https://github.com/fulfilment01/Text-Summarizer-Project.git /app/src/text-summarizer-project

# Install Python dependencies from requirements.txt without user input
RUN pip install --no-input -r requirements.txt

# Upgrade accelerate and uninstall/reinstall specific packages if necessary
RUN pip install --upgrade accelerate
RUN pip uninstall -y transformers accelerate
RUN pip install transformers accelerate

# Set the default command to run your application
CMD ["python3", "app.py"]