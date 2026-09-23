#!/bin/bash
# Atualização dos pacotes do sistema
sudo apt update -y

# Instalação do Nginx
sudo apt install nginx -y

# Criação de uma pagina HTML personalizada para o portifólio
cat <<EOT > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Meu Portfólio Cloud Azure</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h1 {
            color: #0078d4;
            margin-top: 50px;
        }
        p {
            color: #333;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <h1>Projeto de infraestrutura como Codigo (IaC)</h1>
    <p>Esta maquina virtual Linux foi provisionada via <strong>Terraform</strong> e configurada automaticamente via script <strong>Bash</strong>.</p>
    <p>Usando o servidor web <strong>Nginx</strong>, esta página HTML foi criada para demonstrar a automação do processo.</p>
</body>
</html>
EOF

#Garante que o Nginx seja iniciado e habilitado para iniciar automaticamente com a VM
sudo systemctl start nginx
sudo systemctl enable nginx