FROM balenalib/generic-amd64-ubuntu-golang:1.20-focal as builder

MAINTAINER ybyang7@iflytek.com
WORKDIR /workspace

COPY . .

RUN make

WORKDIR /root/
RUN cp /workspace/bin/linux/avp_linux_amd64 .
RUN cp -rf /workspace/.kube .
#RUN cp /etc/kubernetes/pki/ca.crt .
RUN chmod +x /root/${BIN_NAME}
ENTRYPOINT ["/root/avp_linux_amd64"]
CMD ["server", "--kubeconfig", "/root/.kube/config"]
