
##########################################################################################
FROM eclipse-temurin:17-jdk-ubi9-minimal

RUN microdnf install -y git gcc gcc-c++ make valgrind gdb strace python3

ENV VERSION=11.1.2_PUBLIC
ENV GHIDRA_SHA=219ec130b901645779948feeb7cc86f131dd2da6c36284cf538c3a7f3d44b588
ENV GHIDRA_URL=https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.1.2_build/ghidra_11.1.2_PUBLIC_20240709.zip

RUN microdnf install -y fontconfig libXrender libXtst libXi unzip python3-psutil python3-requests python3-pip \
    && python3 -m pip install protobuf==5.28.1 \
    && curl -o /tmp/ghidra.zip -L ${GHIDRA_URL} \
    && echo "$GHIDRA_SHA /tmp/ghidra.zip" | sha256sum -c - \
    && unzip /tmp/ghidra.zip ghidra_${VERSION}/* -d / \
    && ln -s /ghidra_${VERSION}/ /ghidra \
    && chmod +x /ghidra/ghidraRun \
    && echo "===> Clean up unnecessary files..." \
    && microdnf clean all \
    && python3 -m pip install --upgrade pip \
    && rm -rf /tmp/ghidra.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY server.conf /ghidra/server/server.conf

WORKDIR /ghidra

EXPOSE 13100 13101 13102
RUN mkdir /repos
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "client" ]