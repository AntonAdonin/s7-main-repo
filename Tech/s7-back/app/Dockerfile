# Используем официальный образ Python
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN apt update && apt install -y python3-dev gcc
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt
COPY .. .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
