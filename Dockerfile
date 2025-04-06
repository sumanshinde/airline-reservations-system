# Use an official Python runtime as a base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the current project files into the container
COPY . /app/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Django runs on
EXPOSE 8000

# Ensure the static files directory exists
RUN mkdir -p /app/staticfiles

# Collect static files (IMPORTANT)
RUN python manage.py collectstatic --noinput

# Start the Django application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "capstone.wsgi:application"]
