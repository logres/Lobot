# FROM python:3.9 as requirements-stage

# WORKDIR /tmp

# COPY ./pyproject.toml ./poetry.lock* /tmp/

# RUN curl -sSL https://install.python-poetry.org -o install-poetry.py

# RUN python install-poetry.py --yes

# ENV PATH="${PATH}:/root/.local/bin"

# RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9

WORKDIR /app

# COPY --from=requirements-stage /tmp/requirements.txt /app/requirements.txt

COPY ./ /app/

# RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list &&apt-get clean && apt-get update

COPY sources.list /etc/apt/

RUN apt-get clean && apt-get update

RUN apt-get install -y cmake && apt-get install -y ffmpeg && pip install --no-cache-dir --upgrade -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
