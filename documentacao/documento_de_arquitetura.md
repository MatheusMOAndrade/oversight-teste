# Oversight

**Bruno Gomes Ferreira, bgferreira@sga.pucminas.br**

**João Pedro Mairinque de Azevedo, jpmairinque@gmail.com**

**Matheus Machado de Oliveira Andrade, matheus.andrade@sga.pucminas.br**

**Matheus Vieira dos Santos, mat.vsantos@outlook.com**

**Samara Martins Ferreira, mferreira.samara@gmail.com**

---

Professores:

**Aline Norberta de Brito**

**Cleiton Silva Tavares**

---

_Curso de Engenharia de Software, Unidade Praça da Liberdade_

_Instituto de Informática e Ciências Exatas – Pontifícia Universidade de Minas Gerais (PUC MINAS), Belo Horizonte – MG – Brasil_

---

**Resumo:** O projeto Oversight é uma solução voltada para o campo de gestão de orçamentos, projetado para simplificar e aprimorar o processo de gerenciamento de recursos financeiros e de serviços. O software conta com versão Web e Mobile e permite aos usuários cadastrar produtos e serviços, agilizando o processo de elaboração de orçamentos.

Para promover uma maior velocidade na comunicação com os clientes, o Oversight incorpora uma funcionalidade de mensageria que permite o envio de orçamentos por e-mail diretamente ao cliente, para a aprovação ou não do orçamento gerado.

---

## Histórico de Revisões

| **Data**       | **Autor**      | **Descrição**                                                     | **Versão** |
| -------------- | -------------- | ----------------------------------------------------------------- | ---------- |
| **05/09/2023** | Samara Martins | Alteração na sessão 01 - preenchimento dos tópicos 1.1, 1.2 e 1.3 | 1.0        |
|                |                |                                                                   |            |
|                |                |                                                                   |            |

## SUMÁRIO

1. [Apresentação](#apresentacao "Apresentação") <br />
   1.1. Problema <br />
   1.2. Objetivos do trabalho <br />
   1.3. Definições e Abreviaturas <br />

2. [Requisitos](#requisitos "Requisitos") <br />
   ' 2.1. Requisitos Funcionais <br />
   2.2. Requisitos Não-Funcionais <br />
   2.3. Restrições Arquiteturais <br />
   2.4. Mecanismos Arquiteturais <br />

3. [Modelagem](#modelagem "Modelagem e projeto arquitetural") <br />
   3.1. Visão de Negócio <br />
   3.2. Visão Lógica <br />
   3.3. Modelo de dados (opcional) <br />

4. [Avaliação](#avaliacao "Avaliação da Arquitetura") <br />
   4.1. Cenários <br />
   4.2. Avaliação <br />

5. [Referências](#referencias "REFERÊNCIAS")<br />

6. [Apêndices](#apendices "APÊNDICES")<br />

<a name="apresentacao"></a>

# 1. Apresentação

No cenário atual dos negócios, a agilidade e a eficiência são cruciais para o sucesso de qualquer empresa. A gestão de orçamentos, bem como a comunicação efetiva com os clientes, são elementos fundamentais nesse contexto. Este projeto de software foi concebido para atender a essas necessidades específicas, permitindo que os usuários criem orçamentos de maneira simplificada e, em seguida, os enviem diretamente aos clientes por e-mail.

## 1.1. Problema

No cenário de mercado atual, grande parte das empresas que fornecem serviços e/ou produtos possuem a necessidade de gerir um orçamento para seus clientes antes do ato da compra. Porém, uma boa parte dessas empresas ainda realizam essa tarefa de forma manual ou não conseguem adiquirir um software adequado para isso, tendo em vista os altos custos dessas aplicações, uma vez que, costumam se tratar de softwares mais completos e genéricos, voltados para toda a gestão empresarial (ERP¹).

## 1.2. Objetivos do trabalho

O objetivo geral deste trabalho é apresentar uma descrição completa e detalhada do projeto arquitetural da aplicação que será desenvolvida. A arquitetura da aplicação desempenha um papel crítico na garantia da funcionalidade, escalabilidade, segurança e eficiência do software. Portanto, o principal propósito deste trabalho é proporcionar uma visão abrangente da arquitetura da aplicação, destacando seus principais componentes e como eles interagem para atender aos requisitos do sistema.

## 1.3. Definições e Abreviaturas

1. ERP - (Enterprise Resource Planning) é um software empresarial que integra processos e melhora a eficiência organizacional.
2. RF - (Requisito Funcional) requisitos que o sistema de software ou o componente de sistema deve ser capaz de executar.
3. RNF - (Requisito Não Funcional) restrições nos serviços e nas funções oferecidas pelo sistema.

<a name="requisitos"></a>

# 2. Requisitos

_Esta seção descreve os requisitos comtemplados nesta descrição arquitetural, divididos em dois grupos: funcionais e não funcionais._

## 2.1. Requisitos Funcionais

| **ID** | **Descrição**                                                                                | **Prioridade** |
| ------ | -------------------------------------------------------------------------------------------- | -------------- |
| RF001  | O administrador pode gerenciar o usuário no sistema                                          | Alta           |
| RF002  | O usuário pode fazer login no sistema                                                        | Alta           |
| RF003  | O usuário pode gerenciar ativos                                                              | Alta           |
| RF004  | O usuário pode gerenciar cliente                                                             | Alta           |
| RF005  | O usuário pode gerenciar orçamento                                                           | Alta           |
| RF006  | O usuário pode acionar o envio do orçamento para cliente por email                           | Alta           |
| RF007  | O usuário Master pode cadastrar empresa                                                      | Média          |
| RF008  | O usuário Master pode cadastrar um administrador                                             | Média          |
| RF009  | O usuário pode emitir PDF do orçamento                                                       | Baixa          |
| RF010  | O usuário pode inserir percentual de lucro relativo ao orçamento                             | Média          |
| RF011  | O usuário pode buscar cliente por: nome, email, endereço ou data                             | Média          |
| RF012  | O sistema de reconhecer a recusa ou aceitação do orçamento do cliente via email              | Alta           |
| RF013  | O usuário pode buscar orçamento pelo ID ou nome                                              | Média          |
| RF014  | O usuário pode visualizar listas de orçamentos divididas por status                          | Baixa          |
| RF015  | O cliente pode modificar o status do orçamento a partir da aceitação do email                | Média          |
| RF016  | O usuário pode visualizar a quantidade de orçamentos em cada status                          | Baixa          |

## 2.2. Requisitos Não-Funcionais

_Enumere os requisitos não-funcionais previstos para a sua aplicação. Entre os requisitos não funcionais, inclua todos os requisitos que julgar importante do ponto de vista arquitetural ou seja os requisitos que terão impacto na definição da arquitetura. Os requisitos devem ser descritos de forma completa e preferencialmente quantitativa._

| **ID** | **Descrição**                                                                                |
| ------ | -------------------------------------------------------------------------------------------- |
| RNF001 | O sistema deverá ter executabilidade no chrome e firefox                                     |
| RNF002 | O sistema terá sistema de criptografia de autenticação de usuário JWT (sistema-usuário)      |
| RNF003 | O sistema terá autenticação AES relativa às interações internas do sistema (sistema-sistema) |

## 2.3. Restrições Arquiteturais

- O software deverá ser desenvolvido em TypeScript e Dart;
- A comunicação da API deve seguir o padrão RESTful no backend;
- A implementação do microserviço de mensageria será via RabbitMQ;
- A O front-end será desenvolvido utilizando Flutter e Next.js;
- O banco de dados será implementado pelo PostgreSQL.

## 2.4. Mecanismos Arquiteturais

| **Análise**       | **Design**         | **Implementação**   |
| ----------------- | ------------------ | ------------------- |
| Persistência      | ORM                | PostgresSQL         |
| Front end Mobile  | Clean Architecture | Flutter             |
| Front end Web     | Strategy           | Next.js             |
| Back end          | Micro serviços     | Node.ts             |
| Integração        | N/A                | TCP                 |
| Log do sistema    | N/A                | N/A                 |
| Teste de Software | unitário           | Jest                |
| Deploy            | Distribuído        | Docker + Kubernetes |

<a name="modelagem"></a>

# 3. Modelagem e projeto arquitetural

_A solução será desenvolvida atravez do padrão arquitetural de micro serviços, no qual o cliente interage sempre com o serviço de autenticação primeiro e, após ser autenticado, é redirecionado para o serviço REST que detém as informações relacionadas à requisição realizada. O serviço de mensageria entra na recepção de aprovação ou reprovação dos orçamentos, no qual o email enviado é o `producer` que envia a resposta para a fila, da qual o `consumer` atualiza o estado do orçamento._

![Visão Geral da Solução](imagens/visao.png "Visão Geral da Solução")

**Figura 1 - Visão Geral da Solução (fonte: https://medium.com)**

## 3.1. Visão de Negócio (Funcionalidades)

1. O sistema deve separar os usuários em três níveis de permissão (basic, admin e master)
2. O sistema deve permitir gerenciamento de `companies` (empresas)
3. O sistema deve permitir gerenciamento de `users` (usuários)
4. O sistema deve permitir gerenciamento de `customers` (clientes)
5. O sistema deve permitir gerenciamento de `addresses` (endereços)
6. O sistema deve permitir gerenciamento de `services` (serviços e materiais)
7. O sistema deve permitir gerenciamento de `budgets` (orçamentos)
8. O sistema deve permitir gerenciamento de `budgetServices` (serviços do orçamento)
9. O sistema deve solicitar aprovação do usuário por email
10. O sistema deve processar aprovações/reprovações consumindo uma fila no RabbitMQ

### Descrição resumida dos Casos de Uso / Histórias de Usuário

### 3.1.1 Casos de Uso

![Caso de uso](imagens/usercase.png)


### 3.1.2 Histórias de Usuário

- UC01 - Como usuário do Oversight, quero poder fazer login no sistema, porque quero poder utilizar as funcionalidade do sistema

- UC02 - Como usuário do Oversight, quero gerenciar clientes, porque poderei direcionar para qual cliente o orçamento será feito

- UC03 - Como usuário do Oversight, quero gerenciar orçamentos, porque poderei orçar o projeto do cliente baseado em seus ativos

- US04 - Como usuário do Oversight, quero poder gerenciar ativos, porque minha empresa necessitará desse cadastro para gerar um orçamento

- UC05 - Como usuário do Oversight, quero poder emitir PDF do orçamento gerado, porque desejo usar o PDF gerado em outras mídias.

- UC06 - Como usuário do Oversight, quero poder visualizar a quantidade de orçamentos, porque poderei ter uma métrica de quantos orçamentos foram abertos

- UC07 - Como usuário do Oversight, quero poder visualizar a lista de orçamentos, porque poderei ter uma noção visual sobre os orçamentos que estão abertos

- UC08 - Como usuário do Oversight, desejo inserir o percentual de l- ucro relativo ao orçamento, porque poderei ter uma métrica se estarei l- ucrando ou não ao comparar o que foi orçado inicialmente com a exercício do projeto

- UC09- Como usuário do Oversight quero poder acionar o envio do orçamento para cliente por e-mail, porque desejo que os clientes possam validar o orçamento gerado, para prosseguir ou não com o projeto

- UC10 - Como usuário do Oversight desejo poder visualizar o status do orçamento, ou seja: em andamento, recusa ou aceitação. Porque quero saber se o cliente deseja prosseguir com o projeto ou se o orçamento deve ser revisado

- UC11 - Como administrador do Oversight, quero poder gerenciar usuários no sistema. Porque poderei ter um controle dos usuários que terão acesso ao sistema.

- UC12 - Como usuário Master, quero poder cadastrar empresa para o uso do Oversight, porque quero ter um controle de quais empresas terão acesso ao aplicativo

- UC13 - Como usuário Master, quero cadastrar um administrador do sistema, pois esse usuário é um funcionário da empresa que terá um controle maior de os demais, ele poderá fazer a gestão dos outros funcionários que utilizarão o sistema

## 3.2. Visão Lógica

### Diagrama de Classes

![Diagrama de classes](imagens/classes.png "Diagrama de classes")

**Figura 2 – Diagrama de classes (exemplo). Fonte: o próprio autor.**


### Diagrama de componentes

![Diagrama de componentes](imagens/componentes.png "Diagrama de componentes")

**Figura 3 – Diagrama de Componentes (exemplo). Fonte: o próprio autor.**


## 3.3. Modelo de dados

![Diagrama de Entidade Relacionamento (ER) ](imagens/der.png "Diagrama de Entidade Relacionamento (ER) ")

**Figura 4 – Diagrama de Entidade Relacionamento (ER) - exemplo. Fonte: o próprio autor.**


<a name="avaliacao"></a>

# 4. Avaliação da Arquitetura

_Esta seção descreve a avaliação da arquitetura apresentada, baseada no método ATAM._

## 4.1. Cenários

_Apresente os cenários de testes utilizados na realização dos testes da sua aplicação. Escolha cenários de testes que demonstrem os requisitos não funcionais sendo satisfeitos. Os requisitos a seguir são apenas exemplos de possíveis requisitos, devendo ser revistos, adequados a cada projeto e complementados de forma a terem uma especificação completa e auto-explicativa._

**Cenário 1 - Acessibilidade:** Suspendisse consequat consectetur velit. Sed sem risus, dictum dictum facilisis vitae, commodo quis leo. Vivamus nulla sem, cursus a mollis quis, interdum at nulla. Nullam dictum congue mauris. Praesent nec nisi hendrerit, ullamcorper tortor non, rutrum sem. In non lectus tortor. Nulla vel tincidunt eros.

**Cenário 2 - Interoperabilidade:** Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce ut accumsan erat. Pellentesque in enim tempus, iaculis sem in, semper arcu.

**Cenário 3 - Manutenibilidade:** Phasellus magna tellus, consectetur quis scelerisque eget, ultricies eu ligula. Sed rhoncus fermentum nisi, a ullamcorper leo fringilla id. Nulla lacinia sem vel magna ornare, non tincidunt ipsum rhoncus. Nam euismod semper ante id tristique. Mauris vel elit augue.

**Cenário 4 - Segurança:** Suspendisse consectetur porta tortor non convallis. Sed lobortis erat sed dignissim dignissim. Nunc eleifend elit et aliquet imperdiet. Ut eu quam at lacus tincidunt fringilla eget maximus metus. Praesent finibus, sapien eget molestie porta, neque turpis congue risus, vel porttitor sapien tortor ac nulla. Aliquam erat volutpat.

## 4.2. Avaliação

_Apresente as medidas registradas na coleta de dados. O que não for possível quantificar apresente uma justificativa baseada em evidências qualitativas que suportam o atendimento do requisito não-funcional. Apresente uma avaliação geral da arquitetura indicando os pontos fortes e as limitações da arquitetura proposta._

| **Atributo de Qualidade:** | Segurança                                                                                                                                                                                                                                                              |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Requisito de Qualidade** | Acesso aos recursos restritos deve ser controlado                                                                                                                                                                                                                      |
| **Preocupação:**           | Os acessos de usuários devem ser controlados de forma que cada um tenha acesso apenas aos recursos condizentes as suas credenciais.                                                                                                                                    |
| **Cenários(s):**           | Cenário 4                                                                                                                                                                                                                                                              |
| **Ambiente:**              | Sistema em operação normal                                                                                                                                                                                                                                             |
| **Estímulo:**              | Acesso do administrador do sistema as funcionalidades de cadastro de novos produtos e exclusão de produtos.                                                                                                                                                            |
| **Mecanismo:**             | O servidor de aplicação (Rails) gera um _token_ de acesso para o usuário que se autentica no sistema. Este _token_ é transferido para a camada de visualização (Angular) após a autenticação e o tratamento visual das funcionalidades podem ser tratados neste nível. |
| **Medida de Resposta:**    | As áreas restritas do sistema devem ser disponibilizadas apenas quando há o acesso de usuários credenciados.                                                                                                                                                           |

**Considerações sobre a arquitetura:**

| **Riscos:**                  | Não existe |
| ---------------------------- | ---------- |
| **Pontos de Sensibilidade:** | Não existe |
| _ **Tradeoff** _ **:**       | Não existe |

Evidências dos testes realizados

_Apresente imagens, descreva os testes de tal forma que se comprove a realização da avaliação._

<a name="referencias"></a>

# 5. REFERÊNCIAS

_Como um projeto da arquitetura de uma aplicação não requer revisão bibliográfica, a inclusão das referências não é obrigatória. No entanto, caso você deseje incluir referências relacionadas às tecnologias, padrões, ou metodologias que serão usadas no seu trabalho, relacione-as de acordo com a ABNT._

Verifique no link abaixo como devem ser as referências no padrão ABNT:

http://www.pucminas.br/imagedb/documento/DOC\_DSC\_NOME\_ARQUI20160217102425.pdf

**[1]** - _ELMASRI, Ramez; NAVATHE, Sham. **Sistemas de banco de dados**. 7. ed. São Paulo: Pearson, c2019. E-book. ISBN 9788543025001._

**[2]** - _COPPIN, Ben. **Inteligência artificial**. Rio de Janeiro, RJ: LTC, c2010. E-book. ISBN 978-85-216-2936-8._

**[3]** - _CORMEN, Thomas H. et al. **Algoritmos: teoria e prática**. Rio de Janeiro, RJ: Elsevier, Campus, c2012. xvi, 926 p. ISBN 9788535236996._

**[4]** - _SUTHERLAND, Jeffrey Victor. **Scrum: a arte de fazer o dobro do trabalho na metade do tempo**. 2. ed. rev. São Paulo, SP: Leya, 2016. 236, [4] p. ISBN 9788544104514._

**[5]** - _RUSSELL, Stuart J.; NORVIG, Peter. **Inteligência artificial**. Rio de Janeiro: Elsevier, c2013. xxi, 988 p. ISBN 9788535237016._

<a name="apendices"></a>

# 6. APÊNDICES

_Inclua o URL do repositório (Github, Bitbucket, etc) onde você armazenou o código da sua prova de conceito/protótipo arquitetural da aplicação como anexos. A inclusão da URL desse repositório de código servirá como base para garantir a autenticidade dos trabalhos._
