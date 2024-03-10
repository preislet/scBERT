FROM  rocker/rstudio:latest

ARG path='/home/rstudio'
WORKDIR ${path}

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir SCBERT

RUN chown -R rstudio /home/rstudio/SCBERT

COPY attn_sum_save.py SCBERT/
COPY performer_pytorch/ SCBERT/performer_pytorch
COPY finetune.py SCBERT/
COPY lr_baseline_crossorgan.py SCBERT/
COPY predict.py SCBERT/
COPY pretrain.py SCBERT/
COPY utils.py SCBERT/
COPY requirements.txt SCBERT/


# SCBERT_data se nevejdou na git
COPY SCBERT_data/ SCBERT/SCBERT_data

RUN pip3 install -r requirements.txt

WORKDIR /home/rstudio/SCBERT
EXPOSE 8787