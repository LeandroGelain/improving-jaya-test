# Octo Events Test

Octo Events é uma API responsável por armazenar as iterações em issues de um repositório GitHub por meio de webhooks.

## Environment

Ruby 2.7.0
Rails 7.0.4 
Base de Dados PostgreSQL

## Instalação e Configuração

Obs: É necessário ter o Docker instalado para executar o projeto.

### Criando o Webhook

1) No repositório do Github, acessar `Settings > Webhooks`
2) Selecionar `Add webhook`  
3) Em `Payload URL` incluir a URL da API para o Endpoint de Payload. No caso: `{base_url}/events`  
4) Definir `Content-Type` como `application/json`  
5) Selecionar `Let me select individual events` nas opções e Escolher `Issues` & `Issue comments`  
6) Marcar Active no checkbox  
7) Clicar em `Add Webhook`  
8) Acessar `Settings > Environments`
9) Criar um novo ambiente e adicionar uma chave `SECRET_TOKEN` com o `Authtoken` do ngrok.


Para testar o funcionamento do webhook em ambiente de desenvolvimento local, foi utilizado o `ngrok`, [Link da documentação](https://ngrok.com/).  
Neste caso, o ngrok já foi configurando junto ao docker, mas para identificar a url da sua conexão, basta acessar a [página que lista os agentes](https://dashboard.ngrok.com/tunnels/agents) e selecionar o que é correspondente a sua porta localhost.

## Rodando o Projeto

Apenas com o comando a baixo os containers do banco de dados, da aplicação rails e do ngrok serão configurados e iniciados.

```
docker compose up -d
```

## Testes

Todos os testes do projeto são feito com RSpec, comandos para executa-los:

```
docker exec -it octo_api /bin/sh

rspec
```

## Documentação

| HTTP | Rota | Descrição |
| ----------- | ---- | --------- |
| **POST** | /events | Webhook que recebe eventos do Github e os armazena na Base de Dados |
| **GET** | /issues/{issue_number}/events | Listagem de eventos filtrados pelo número do issue |

### Postman Collection

Postman_Collection.json na raíz do projeto.  