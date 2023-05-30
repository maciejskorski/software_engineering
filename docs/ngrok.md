# Class 12: ngrok

We will use [ngrok]() to publish a server running on a private Colab Virtual Machine.

## Proxying HTTP from VM

Access a Virtual Machine on Colab or Codespaces. Install the Python wrapper `ngrok` with `pip install pyngrok --quiet`. 

Start a simple http deamon (here on port 5000):
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
NGROK_AUTH_TOKEN = "<Get your authtoken from https://dashboard.ngrok.com/auth>"
ngrok.set_auth_token(NGROK_AUTH_TOKEN)

# Open an HTTPs tunnel on port 5000 for http://localhost:5000
public_url = ngrok.connect(5000).public_url
print("Tracking URL:", public_url)
```
Access the application under the public url. Enjoy!
```console
Tracking URL: https://e108-35-184-192-139.ngrok-free.app
```
As a bonus we can set up OAuth 2.0 authentication, here with google accounts:
```console
!ngrok http --oauth google 5000
# https://5bd6-35-197-38-167.ngrok-free.app
```



## Code

The example is [available on GitHub](https://colab.research.google.com/gist/maciejskorski/b6185a0f1a48abbc63e3a82b89a86b42/nginx-demo.ipynb).
