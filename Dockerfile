# Use the slim Python image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy requirements first to leverage Docker's build cache
COPY requirements.txt .

# Install dependencies (including CPU-only torch)
# This installs packages globally *within the container's* Python
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY ./app /app

# Expose the port
EXPOSE 8000

# Run the application
# uvicorn is now in the global PATH (e.g., /usr/local/bin/uvicorn)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]