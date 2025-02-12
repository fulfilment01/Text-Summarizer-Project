FROM python:3.8-slim-buster

# Update package lists and install necessary packages:
# - git: for cloning repositories.
# - awscli: for AWS command line utilities.
# - build-essential: for gcc and other compilation tools.
# - curl: for downloading files (e.g. Rust installer).
RUN apt-get update -y && \
    apt-get install -y \
    git \
    awscli \
    build-essential \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# (Optional) Install Rust and Cargo if you require Rust-based packages.
# Uncomment the lines below if your project needs them.
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
#     export PATH="/root/.cargo/bin:${PATH}"

# Set the working directory inside the container
WORKDIR /app

# Copy application files into the container
COPY . /app

# (Optional) Remove an existing clone if needed
RUN rm -rf /app/src/text-summarizer-project

# Clone the repository (if required)
RUN git clone https://github.com/fulfilment01/Text-Summarizer-Project.git /app/src/text-summarizer-project

# Install Python dependencies from requirements.txt without user input
RUN pip install --no-input -r requirements.txt

# Upgrade accelerate and uninstall/reinstall specific packages if necessary
RUN pip install --upgrade accelerate && \
    pip uninstall -y transformers accelerate && \
    pip install transformers accelerate

# Set the default command to run your application
CMD ["python3", "app.py"]
