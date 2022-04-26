FROM faucet/python3:8.0.1
RUN pip install kubernetes
WORKDIR  /app
COPY get_pods_total.py get_pods_total.py
ENTRYPOINT ["python", "get_pods_total.py"]
EXPOSE 9100/tcp