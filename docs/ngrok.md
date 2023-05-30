# Class 12: ngrok

We will use [ngrok]() to publish a server running on a private Colab Virtual Machine.

## Proxying HTTP from VM

Access a Virtual Machine on Colab or Codespaces.

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

As the last step, start the ngrok server. The code below runs with the Python wrapper (install with `pip install pyngrok --quiet`).
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

## Authentication with OAuth 2.0 
```
As a bonus we can set up OAuth 2.0 authentication, here with Google:
```console
ngrok http 5000 --oauth=google --log=stdout --log-level=info
INFO[05-30|09:06:27] no configuration paths supplied 
WARN[05-30|09:06:27] ngrok config file found at legacy location, move to XDG location xdg_path=/root/.config/ngrok/ngrok.yml legacy_path=/root/.ngrok2/ngrok.yml
INFO[05-30|09:06:27] using configuration at default config path path=/root/.ngrok2/ngrok.yml
INFO[05-30|09:06:27] open config file                         path=/root/.ngrok2/ngrok.yml err=nil
t=2023-05-30T09:06:27+0000 lvl=info msg="starting web service" obj=web addr=127.0.0.1:4040 allow_hosts=[]
t=2023-05-30T09:06:27+0000 lvl=info msg="client session established" obj=tunnels.session obj=csess id=e091fe4f2de3
t=2023-05-30T09:06:27+0000 lvl=info msg="tunnel session started" obj=tunnels.session
t=2023-05-30T09:06:27+0000 lvl=info msg="started tunnel" obj=tunnels name=command_line addr=http://localhost:5000 url=https://8e00-35-197-38-167.ngrok-free.app
```
Visit the address `https://8e00-35-197-38-167.ngrok-free.app` and go through Google sign-in!

```{tip}
For brevity and more features, the command line interface is preferred over the Python wrapper.
```



## Code

The example is [available on GitHub](https://colab.research.google.com/gist/maciejskorski/b6185a0f1a48abbc63e3a82b89a86b42/nginx-demo.ipynb).

## References

* [ngrok homepage](https://ngrok.com/)
* [ngrok Python wrapper](https://pyngrok.readthedocs.io/)
* [OAuth 2.0 homepage](https://oauth.net/2/)