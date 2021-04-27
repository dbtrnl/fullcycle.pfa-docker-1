CREATE DATABASE IF NOT EXISTS fc;

SET autocommit = 0;

-- Setando encoding correto
SET character_set_client = utf8;
SET character_set_connection = utf8;
SET character_set_results = utf8;
SET collation_connection = utf8_general_ci;

-- Usar a DB fullcycle
USE fc;

-- Cria tabela caso ela não exista:
CREATE TABLE IF NOT EXISTS fc_modules (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL
);

START TRANSACTION;
  INSERT INTO fc_modules (name)
  VALUES
    ('Docker'),
    ('Padrões e técnicas avançadas com Git e Github'),
    ('Integração contínua'),
    ('Kubernetes'),
    ('Fundamentos de Arquitetura de software'),
    ('Comunicação'),
    ('RabbitMQ'),
    ('Autenticação e Keycloak'),
    ('Domain Driven Design e Arquitetura hexagonal'),
    ('Arquitetura do projeto prático - Codeflix'),
    ('Microsserviço: Catálogo de vídeos com Laravel ( Back-end )'),
    ('Microsserviço: Catálogo de vídeos com React ( Front-end )'),
    ('Microsserviço de Encoder de Vídeo com Go Lang'),
    ('Microsserviço - API do Catálogo com Node.JS (Back-end)'),
    ('Autenticação entre os microsserviços');
COMMIT;