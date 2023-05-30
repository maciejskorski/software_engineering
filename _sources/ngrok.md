# Class 12: ngrok

We will use [ngrok]() to publish a server running on a private Colab Virtual Machine.


Access a Virtual Machine on Colab or Codespaces. Install the Python wrapper `ngrok` with `pip install pyngrok --quiet`. 

Start a simple http server (here on port 5000):
```python
import _thread as thread
import http.server
import socketserver

Handler = http.server.SimpleHTTPRequestHandler

def start_server():
    # Setup stuff here...
    with socketserver.TCPServer(("", 5000), Handler) as httpd:
      httpd.serve_forever()
    
# start the server in a background thread
thread.start_new_thread(start_server, ())
```

As the last step, start the ngrok server:
```python
from pyngrok import ngrok

# Terminate open tunnels if exist
ngrok.kill()

# Setting the authtoken (optional)
# Get your authtoken from https://dashboard.ngrok.com/auth
NGROK_AUTH_TOKEN = "2FSPi7SWydYp4hJlGzr3XDDT2qZ_2nRDVc628Fc4he4znxSSV"
ngrok.set_auth_token(NGROK_AUTH_TOKEN)

# Open an HTTPs tunnel on port 5000 for http://localhost:5000
public_url = ngrok.connect(5000,oauth_provider='google').public_url
print("Tracking URL:", public_url)
```
Access the application under the public url. Enjoy!
