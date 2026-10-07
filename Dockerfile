# =============================================================
# Dockerfile for Hugging Face Spaces (FastAPI Dog AI Server)
# =============================================================
FROM python:3.10-slim

# Install system dependencies (libsndfile for librosa/audio processing)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsndfile1 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application and model files
COPY . .

# Hugging Face Spaces expects the app on port 7860
EXPOSE 7860

# Start FastAPI server
CMD ["uvicorn", "ai_server:app", "--host", "0.0.0.0", "--port", "7860"]
