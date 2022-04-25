from http.server import BaseHTTPRequestHandler
from http.server import HTTPServer
from kubernetes import client, config

def get_pod():
    config.load_kube_config()

    v1 = client.CoreV1Api()
    ret = v1.list_pod_for_all_namespaces(watch=False)
    pods_total = f'# number of pods in the cluster\ncluster_pods_total {len(ret.items)}'
    return  pods_total

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        pods = get_pod()
        self.send_response(200)
        self.send_header("Content-type", "text/plain; charset=utf-8")
        self.end_headers()
        self.wfile.write(pods.encode('utf-8'))

def run(server_class=HTTPServer, handler_class=BaseHTTPRequestHandler):
  server_address = ('', 9100)
  httpd = server_class(server_address, SimpleHTTPRequestHandler)
  try:
      httpd.serve_forever()
  except KeyboardInterrupt:
      httpd.server_close()

if __name__ == "__main__":
    run()