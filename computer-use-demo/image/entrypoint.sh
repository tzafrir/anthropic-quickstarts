#!/bin/bash
set -e

# Replace placeholders in index.html and static_content/index.html with environment variables
sed -i "s/\${STREAMLIT_URL}/${STREAMLIT_URL}/g" index.html
sed -i "s/\${VNC_URL}/${VNC_URL}/g" index.html
sed -i "s/\${STREAMLIT_URL}/${STREAMLIT_URL}/g" static_content/index.html
sed -i "s/\${VNC_URL}/${VNC_URL}/g" static_content/index.html

./start_all.sh
./novnc_startup.sh

python http_server.py > /tmp/server_logs.txt 2>&1 &

STREAMLIT_SERVER_PORT=8501 python -m streamlit run computer_use_demo/streamlit.py > /tmp/streamlit_stdout.log &

echo "✨ Computer Use Demo is ready!"
echo "➡️  Open http://localhost:8080 in your browser to begin"

# Keep the container running
tail -f /dev/null
