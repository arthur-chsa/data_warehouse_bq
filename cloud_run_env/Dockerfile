FROM ghcr.io/dbt-labs/dbt-bigquery:1.7.9

# Install dependencies
RUN apt-get update && apt-get install -y git curl jq

# Set working directory
WORKDIR /app

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]