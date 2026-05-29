# Atividade 05 - Evolução Arquitetural da Aplicação (mobile_arquitetura_02)

Este projeto implementa uma arquitetura em camadas (UI, ViewModel, Repository, DataSources) em Flutter, incluindo tratamento de estados (carregando, sucesso, erro) e um sistema de cache local utilizando `shared_preferences`.

## Questionário de Reflexão (Atividade 2)

**1. Em qual camada foi implementado o mecanismo de cache? Explique por que essa decisão é adequada dentro da arquitetura proposta.**
O mecanismo de cache foi implementado na **Camada de Dados**, especificamente em um `LocalDataSource`, sendo orquestrado pelo `Repository`. Essa decisão é adequada porque a responsabilidade de decidir de onde os dados vêm (se da API ou do cache) deve ser exclusiva do Repository. Isso mantém o ViewModel e a UI completamente agnósticos sobre a origem da informação, respeitando o Princípio da Responsabilidade Única (SRP).

**2. Por que o ViewModel não deve realizar chamadas HTTP diretamente?**
Porque a responsabilidade do ViewModel é apenas gerenciar o estado da interface da aplicação (UI) e repassar ações do usuário. Se ele fizesse chamadas HTTP, haveria um forte acoplamento entre a lógica de apresentação e a infraestrutura de rede, tornando o código difícil de testar, manter e evoluir.

**3. O que poderia acontecer se a interface acessasse diretamente o DataSource?**
A interface ficaria extremamente acoplada aos detalhes de implementação da busca de dados (como URLs, bibliotecas HTTP, ou queries de banco). Qualquer mudança na forma como os dados são obtidos ou armazenados exigiria a reescrita de partes da interface (UI). Além disso, a UI ficaria poluída com lógicas complexas, dificultando a leitura e a criação de testes unitários.

**4. Como essa arquitetura facilitaria a substituição da API por um banco de dados local?**
Como a UI e o ViewModel conversam apenas com o `Repository` (que funciona como um contrato/fachada), substituir a API por um banco de dados local exigiria alterações **apenas** na camada de Dados (criando um novo DataSource ou alterando o Repository). Nenhuma linha de código da Interface (UI) ou do ViewModel precisaria ser alterada, garantindo uma manutenção muito mais segura e modular.