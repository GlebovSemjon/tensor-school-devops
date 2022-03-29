import time
from prometheus_client.core import REGISTRY, CounterMetricFamily
from prometheus_client import start_http_server


class CustomCollector(object):

    def collect(self):

        progress_count = {}

        def read_progress(f):
            f_read = open(f, "r")
            last_line = f_read.readlines()[-1]
            return last_line

        progress_dd = CounterMetricFamily(
            "progress_dd",
            'Help text',
            labels=['progress']
        )
        progress = str(read_progress("var/out"))
        progress_dd.add_metric(['progress'], progress)
        yield progress_dd


if __name__ == '__main__':
    start_http_server(8000)
    REGISTRY.register(CustomCollector())
    while True:
        time.sleep(5)