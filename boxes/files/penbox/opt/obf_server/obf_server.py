import gzip
import base64
from logging.config import dictConfig
from flask import Flask, send_from_directory, abort, Response
import os
import logging

app = Flask(__name__)

# Configure logging
dictConfig({
    'version': 1,
    'formatters': {'default': {
        'format': '[%(asctime)s] %(levelname)s in %(module)s: %(message)s',
    }},
    'handlers': {'wsgi': {
        'class': 'logging.StreamHandler',
        'stream': 'ext://sys.stdout',  # Ensure logs go to stdout
        'formatter': 'default'
    }},
    'root': {
        'level': 'INFO',
        'handlers': ['wsgi']
    }
})

FILE_PATHS = {
    "sharp": "/opt/windows/SharpCollection/NetFramework_4.7_x64/",
    "win": "/opt/windows/windows_weaponize/",
    "lin": "/opt/linux/linux_weaponize/"
}

@app.route("/<string:category>/<path:filename>")
def serve_file(category, filename):
    app.logger.info(f"Request received: category={category}, filename={filename}")
    
    # Check if the category is valid
    if category not in FILE_PATHS:
        app.logger.error(f"Invalid category '{category}'")
        abort(404, description="")
    
    # Get the directory based on the category
    directory = FILE_PATHS[category]

    # Ensure the file exists in the specified directory
    file_path = os.path.join(directory, filename)
    if not os.path.exists(file_path):
        app.logger.error(f"File not found: {file_path}")
        abort(404, description="")
    
    try:
        app.logger.info(f"Serving file from: {file_path}")
        with open(file_path, 'rb') as file:
            file_data = file.read()

        compressed_data = gzip.compress(file_data)
        encoded_data = base64.b64encode(compressed_data)

        response = Response(encoded_data, mimetype="application/octet-stream")
        response.headers["Content-Disposition"] = f"attachment; filename=blob.gz.enc"
        return response
    except Exception as e:
        app.logger.error(f"Error serving file: {str(e)}")
        abort(500, description="Internal Server Error")

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8880, debug=False)

