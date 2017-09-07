###################################
# Dockerfile to build the Python Nairobi blog
###################################
FROM bravissimolabs/alpine-git:latest

# Who dat boy
MAINTAINER Brian Muhia poppingtonic@gmail.com

RUN git clone https://github.com/Python-Nairobi/pynbo-blog

# Work in this directory, from here
WORKDIR pynbo-blog

# Smallest(?) python image I could imagine building
RUN apk add --no-cache python3 perl && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache

# Expose these two directories, so the editor can access the files
VOLUME content output

# Get dependencies, from the README.md
RUN git submodule update --init --recursive

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["start 8000"]

ENTRYPOINT ./develop_server.sh
