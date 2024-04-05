#!/bin/bash
echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/F1rstCap1tal/Logo/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

function install_avail_dependencies {
    sudo apt update && sudo apt upgrade -y
    sudo apt full-upgrade -y
}

function install_avail {
    curl -sL https://get.avail.sh | bash
}

function install_service {
if tmux has-session -t avail 2>/dev/null; then
  echo "Останавливаем сессию tmux 'avail'..."
  tmux kill-session -t avail
fi
SERVICE_FILE="/etc/systemd/system/avail-light.service"

if [ -f "$SERVICE_FILE" ]; then
    echo "Удаляем старый сервисный файл..."
    sudo rm "$SERVICE_FILE"
fi
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald
cat <<EOF | sudo tee $SERVICE_FILE > /dev/null

[Unit]
Description=Avail Light Client
After=network.target
StartLimitIntervalSec=0

[Service]
User=$USER
ExecStart=$HOME/.avail/bin/avail-light --network goldberg --config $HOME/.avail/config/config.yml --identity $HOME/.avail/identity/identity.toml
Restart=always
RestartSec=120
LimitNOFILE=10000

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload

sudo systemctl enable avail-light.service

sudo systemctl restart avail-light.service

echo "Service 'avail-light' succesfully started."
}

function main {
    install_avail_dependencies
    install_avail
    install_service
}

main