#!/bin/bash

# gs://genetics-portal-ukbb-mr/gcta64

# ref panel gs://open-targets-ukbb/genotypes/ukb_v3_downsampled10k
# proteins gs//genetics-portal-ukbb-mr/protein-gwas/SUN/dsub/sun/
# outcomes gs://genetics-portal-ukbb-mr/outcomes/

# image debian-10

export GOOGLE_APPLICATION_CREDENTIALS="open-targets-genetics-fc5b6cda58e5.json"

project=open-targets-genetics
bucket_mount="gs://genetics-portal-ukbb-mr"
bucket="${bucket_mount}"
logs_dir="${bucket}/pan-gsmr-outputs/logs"
ref_dir="${bucket}/1000GP3_ref_panel_EUR"
proteins_dir="${bucket}/SUN2018_full_harmonised_gsmr_v2"
outcomes_dir="${bucket}/outcomes-gsmr-formatted"
out_dir="${bucket}/output"


gcta="gs://genetics-portal-analysis/mohd/gcta/gcta64"

# trying with mount
# --input-recursive PROTEINS=$proteins_dir \

dsub \
    --provider google-cls-v2 \
    --project $project \
    --regions europe-west1 \
    --logging $logs_dir \
    --boot-disk-size 500 \
    --timeout '7d' \
    --machine-type n1-highmem-4 \
    --image gcr.io/cloud-marketplace/google/debian10 \
    --script process_gcta_batch.sh \
    --credentials-file /Users/mk31/creds/open-targets-genetics-fc5b6cda58e5.json \
    --tasks tasks.tsv \
    --wait