# Stage 1: Build Rust components
FROM rust:latest AS builder

# Set the working directory
WORKDIR /app

# Copy application code into the container
COPY . .

# Build the Rust application
RUN cargo build --release

# Stage 2: Set up Python environment
FROM python:3.8-slim-buster

# Install necessary system dependencies
RUN apt-get update -y && \
    apt-get install -y git build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the compiled Rust binary from the builder stage
COPY --from=builder /app/target/release/your_rust_binary /app/

# Copy Python application files into the container
COPY . /app

# Install Python dependencies
RUN pip install --no-input -r requirements.txt

# Set the default command to run your application
CMD ["python3", "app.py"]
