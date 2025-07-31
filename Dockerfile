FROM python:3.10-alpine

# Defina o diretório de trabalho
WORKDIR /app

# Copie o arquivo requirements.txt antes de instalar dependências
COPY ./requirements.txt /app/requirements.txt

# Instale dependências com verificação de certificado
RUN apk --no-cache add build-base cargo curl make rust supervisor && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt && \
    echo "[supervisord]" > /etc/supervisord.conf && \
    echo "nodaemon=true" >> /etc/supervisord.conf && \
    echo "[program:litellm]" >> /etc/supervisord.conf && \
    echo "command=python /app/main.py" >> /etc/supervisord.conf && \
    echo "directory=/app" >> /etc/supervisord.conf && \
    echo "autostart=true" >> /etc/supervisord.conf && \
    echo "autorestart=true" >> /etc/supervisord.conf && \
    echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf && \
    echo "stderr_logfile=/dev/stderr" >> /etc/supervisord.conf

# Defina as variáveis de ambiente para URLs de API
ENV OPENAI_API_BASE="https://flow.ciandt.com/ai-orchestration-api/v1/openai" 
ENV BEDROCK_API_BASE="https://flow.ciandt.com/ai-orchestration-api/v1/bedrock" 
ENV GEMINI_API_BASE="https://flow.ciandt.com/ai-orchestration-api/v1/google" 
ENV FOUNDRY_API_BASE="https://flow.ciandt.com/ai-orchestration-api/v1/foundry/chat/completions" 
ENV FLOW_TOKEN_URL="https://flow.ciandt.com/auth-engine-api/v1/api-key/token"

# Copie os arquivos restantes para /app/
COPY ./ /app/

# Exponha a porta 4000
EXPOSE 4000

# Inicie o supervisord
CMD ["supervisord", "-c", "/etc/supervisord.conf"]