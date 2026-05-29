ARG PYTHON_VERSION=3.13
FROM python:${PYTHON_VERSION}-slim-bookworm AS builder
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        python3-dev \
        libffi-dev \
        pkg-config \
        zlib1g-dev \
        git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . /src
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --upgrade pip wheel \
 && pip wheel --wheel-dir /wheels \
      "dfvfs @ git+https://github.com/oh6hay/dfvfs.git@compressed-stream-seek" \
 && pip wheel --wheel-dir /wheels --find-links=/wheels .   # plaso + remaining deps
FROM python:${PYTHON_VERSION}-slim-bookworm AS runtime
LABEL org.opencontainers.image.title="plaso (from source)" \
      org.opencontainers.image.source="https://github.com/log2timeline/plaso"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    PYTHONUNBUFFERED=1
RUN --mount=type=bind,from=builder,source=/wheels,target=/wheels \
    pip install --no-cache-dir --no-index --find-links=/wheels plaso \
    && python -c "import plaso; print('built plaso', plaso.__version__)"
WORKDIR /usr/local/bin
COPY --chmod=a+x config/docker/plaso-switch.sh plaso-switch.sh
RUN useradd --create-home --uid 1000 analyst
USER analyst
WORKDIR /home/analyst
VOLUME ["/data"]
ENTRYPOINT ["/usr/local/bin/plaso-switch.sh"]
