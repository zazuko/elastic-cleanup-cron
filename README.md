# Elastic cleanup cron

## Purpose

Using Elasticsearch OSS edition, there is no option to automatically delete old indices.
This project is a Docker image that should be run as a CronJob once a day, to clean all filebeat and journalbeat indices older than one week.

## Configuration

Configuration is made through the following environment variables:

- `ELASTIC_INSTANCE` (default: `http://elasticsearch-master:9200`), URL of the Elasticsearch instance.
