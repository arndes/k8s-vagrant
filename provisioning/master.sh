#!/bin/bash

echo "Prepare ansible ..."

sudo apt update > /dev/null 2>&1
sudo apt install python3-venv sshpass -y > /dev/null 2>&1
python3 -m venv venv > /dev/null
source venv/bin/activate > /dev/null 
pip install --upgrade -r ansible/requirements.txt > /dev/null

echo "Run ansible ..."

cd ansible && ansible-playbook playbook.yml

# deactivate && cd .. && rm -rf ansible venv