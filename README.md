
# SPRING BOOT 3

Esse projeto tem objetivos apenas de aprendizado. Ele foi feito em conjunto as aulas sobre Spring Boot 3 da Alura.

## Conteudos

1.	Desenvolva uma API Rest em Java Spring Boot 3

-	 Spring Boot 3:  
A versão 3 do Spring Boot foi lançada em novembro de 2022, trazendo algumas novidades em relação à versão anterior. Dentre as principais novidades, se destacam:
Suporte ao Java 17; Migração das especificações do Java EE para o Jakarta EE; e Suporte a imagens nativas.


-	 CORS:  
Quando desenvolvemos APIs e queremos que todos os seus recursos fiquem disponíveis a qualquer cliente HTTP, uma das coisas que vem à nossa cabeça é o CORS (Cross-Origin Resource Sharing), em português, “compartilhamento de recursos com origens diferentes”.
 O CORS é um mecanismo utilizado para adicionar cabeçalhos HTTP que informam aos navegadores para permitir que uma aplicação Web seja executada em uma origem e acesse recursos de outra origem diferente. Esse tipo de ação é chamada de requisição cross-origin HTTP. Na prática, então, ele informa aos navegadores se um determinado recurso pode ou não ser acessado.


-	 ARQUIVO 'properties' ou 'YAML'?:  
As configurações de uma aplicação Spring Boot são feitas em arquivos externos, sendo que podemos usar arquivo de propriedades ou arquivo YAML. 


- Arquivo de propriedades:  
Por padrão, o Spring Boot acessa as configurações definidas no arquivo application.properties, que usa um formato de chave=valor, cada linha é uma configuração única, então é preciso expressar dados hierárquicos usando os mesmos prefixos para nossas chaves, ou seja, precisamos repetir prefixos, neste caso, spring e datasource.


- YAML Configuration:  
YAML é um outro formato bastante utilizado para definir dados de configuração hierárquica, como é feito no Spring Boot. Pegando o mesmo exemplo do nosso arquivo application.properties, podemos convertê-lo para YAML alterando seu nome para application.yml e modificando seu conteúdo. Com YAML, a configuração se tornou mais legível, pois não contém prefixos repetidos. Além de legibilidade e redução de repetição, o uso de YAML facilita o armazenamento de variáveis de configuração de ambiente, conforme recomenda o 12 Factor App, uma metodologia bastante conhecida e utilizada que define 12 boas práticas para criar uma aplicação moderna, escalável e de manutenção simples. 

  Apesar dos benefícios que os arquivos YAML nos trazem em comparação ao arquivo properties, a decisão de escolher um ou outro é de gosto pessoal. Além disso, não é recomendável ter ao mesmo tempo os dois tipos de arquivo em um mesmo projeto, pois isso pode levar a problemas inesperados na aplicação. Caso opte por utilizar YAML, fique atento, pois escrevê-lo no início pode ser um pouco trabalhoso devido às suas regras de indentação.


-	Padrão DAO
O padrão de projeto DAO, conhecido também por Data Access Object, é utilizado para persistência de dados, onde seu principal objetivo é separar regras de negócio de regras de acesso a banco de dados. Nas classes que seguem esse padrão, isolamos todos os códigos que lidam com conexões, comandos SQLs e funções diretas ao banco de dados, para que assim tais códigos não se espalhem por outros pontos da aplicação, algo que dificultaria a manutenção do código e também a troca das tecnologias e do mecanismo de persistência.


- Implementação:   
Vamos supor que temos uma tabela de produtos em nosso banco de dados. A implementação do padrão DAO seria o seguinte: Primeiro, seria necessário criar uma classe básica de domínio Produto; Em seguida, precisaríamos criar a classe ProdutoDao, que fornece operações de persistência para a classe de domínio Produto


- Padrão Repository:  
De acordo com o famoso livro Domain-Driven Design, de Eric Evans: "O repositório é um mecanismo para encapsular armazenamento, recuperação e comportamento de pesquisa, que emula uma coleção de objetos."
Simplificando, um repositório também lida com dados e oculta consultas semelhantes ao DAO. No entanto, ele fica em um nível mais alto, mais próximo da lógica de negócios de uma aplicação. Um repositório está vinculado à regra de negócio da aplicação e está associado ao agregado dos seus objetos de negócio, retornando-os quando preciso.
Só que devemos ficar atentos, pois assim como no padrão DAO, regras de negócio que estão envolvidas com processamento de informações não devem estar presentes nos repositórios. Os repositórios não devem ter a responsabilidade de tomar decisões, aplicar algoritmos de transformação de dados ou prover serviços diretamente a outras camadas ou módulos da aplicação. Mapear entidades de domínio e prover as funcionalidades da aplicação são responsabilidades muito distintas.


-	Anotações do Bean Validation:  
O Bean Validation é composto por diversas anotações que devem ser adicionadas nos atributos em que desejamos realizar as validações. Vimos algumas dessas anotações, como a @NotBlank, que indica que um atributo do tipo String não pode ser nulo e nem vazio.
Entretanto, existem dezenas de outras anotações que podemos utilizar em nosso projeto, para os mais diversos tipos de atributos. Você pode conferir uma lista com as principais anotações do Bean Validation na documentação oficial da especificação.


-	Erro na migration:  
Conforme orientado ao longo dessa aula é importante sempre parar o projeto ao criar os arquivos de migrations, para evitar que o Flyway os execute antes da hora, com o código ainda incompleto, causando com isso problemas.
Entretanto, eventualmente pode acontecer de esquecermos de parar o projeto e algum erro acontecer ao tentar inicializar a aplicação. Perceba na mensagem de erro que é indicado que alguma migration falhou, impedindo assim que o projeto seja inicializado corretamente. Esse erro também pode acontecer se o código da migration estiver inválido, contendo algum trecho de SQL digitado de maneira incorreta.
Para resolver esse problema será necessário acessar o banco de dados da aplicação e executar o seguinte comando sql: 
'delete from flyway_schema_history where success = 0;'
O comando anterior serve para apagar na tabela do Flyway todas as migrations cuja execução falhou. Após isso, basta corrigir o código da migration e executar novamente o projeto.


-	DTOs ou entidades?  
Estamos utilizando DTOs para representar os dados que recebemos e devolvemos pela API, mas você provavelmente deve estar se perguntando “Por que ao invés de criar um DTO não devolvemos diretamente a entidade JPA no Controller?”. Para fazer isso, bastaria alterar o método listar no Controller.


- Os problemas de receber/devolver entidades JPA:  
De fato é muito mais simples e cômodo não utilizar DTOs e sim lidar diretamente com as entidades JPA nos controllers. Porém, essa abordagem tem algumas desvantagens, inclusive causando vulnerabilidade na aplicação para ataques do tipo Mass Assignment.
Um dos problemas consiste no fato de que, ao retornar uma entidade JPA em um método de um Controller, o Spring vai gerar o JSON contendo todos os atributos dela, sendo que nem sempre esse é o comportamento que desejamos.
Eventualmente podemos ter atributos que não desejamos que sejam devolvidos no JSON, seja por motivos de segurança, no caso de dados sensíveis, ou mesmo por não serem utilizados pelos clientes da API.


- DTO:  
O padrão DTO (Data Transfer Object) é um padrão de arquitetura que era bastante utilizado antigamente em aplicações Java distribuídas (arquitetura cliente/servidor) para representar os dados que eram enviados e recebidos entre as aplicações cliente e servidor.
O padrão DTO pode (e deve) ser utilizado quando não queremos expor todos os atributos de alguma entidade do nosso projeto, situação igual a dos salários dos funcionários mostrado no exemplo de código anterior. Além disso, com a flexibilidade e a opção de filtrar quais dados serão transmitidos, podemos poupar tempo de processamento.


2.	Aplicando boas praticas e projetando uma API Rest

-	Mensagens em português:  
Por padrão o Bean Validation devolve as mensagens de erro em inglês, entretanto existe uma tradução dessas mensagens para o português já implementada nessa especificação. 
No protocolo HTTP existe um cabeçalho chamado Accept-Language, que serve para indicar ao servidor o idioma de preferência do cliente disparando a requisição. Podemos utilizar esse cabeçalho para indicar ao Spring o idioma desejado, para que então na integração com o Bean Validation ele busque as mensagens de acordo com o idioma indicado.
No Insomnia, e nas outras ferramentas similares, existe uma opção chamada Header que podemos incluir cabeçalhos a serem enviados na requisição. Se adicionarmos o header Accept-Language com o valor pt-br, as mensagens de erro do Bean Validation serão automaticamente devolvidas em português. 
Obs: O Bean Validation tem tradução das mensagens de erro apenas para alguns poucos idiomas.


-	hashing de senha:  
Senhas são informações sensíveis e não devem ser armazenadas em texto aberto, pois se uma pessoa mal-intencionada conseguir obter acesso ao banco de dados, ela conseguirá ter acesso às senhas de todos os usuários. Para evitar esse problema, você deve sempre utilizar algum algoritmo de hashing nas senhas antes de armazená-las no banco de dados. Hashing nada mais é do que uma função matemática que converte um texto em outro texto totalmente diferente e de difícil dedução.
Existem diversos algoritmos de hashing que podem ser utilizados para fazer essa transformação nas senhas dos usuários, sendo que alguns são mais antigos e não mais considerados seguros hoje em dia, como o MD5 e o SHA1. Os principais algoritmos recomendados atualmente são: Bcrypt, Scrypt, Argon2 e PBKDF2.


- JSON Web Token, ou JWT, é um padrão utilizado para a geração de tokens, que nada mais são do que Strings, representando, de maneira segura, informações que serão compartilhadas entre dois sistemas.


- controle de acesso por url:  
Na aplicação utilizada no curso não teremos perfis de acessos distintos para os usuários. Entretanto, esse recurso é utilizado em algumas aplicações e podemos indicar ao Spring Security que determinadas URLs somente podem ser acessadas por usuários que possuem um perfil específico.
Por exemplo, suponha que em nossa aplicação tenhamos um perfil de acesso chamado de ADMIN, sendo que somente usuários com esse perfil possam excluir médicos e pacientes. Podemos indicar ao Spring Security tal configuração alterando o método securityFilterChain, na classe SecurityConfigurations


- controle de acesso por anotações:  
Outra maneira de restringir o acesso a determinadas funcionalidades, com base no perfil dos usuários, é com a utilização de um recurso do Spring Security conhecido como Method Security, que funciona com a utilização de anotações em métodos.
o método foi anotado com @Secured("ROLE_ADMIN"), para que apenas usuários com o perfil ADMIN possam disparar requisições para detalhar um médico. A anotação @Secured pode ser adicionada em métodos individuais ou mesmo na classe, que seria o equivalente a adicioná-la em todos os métodos.
Atenção! Por padrão esse recurso vem desabilitado no spring Security, sendo que para o utilizar devemos adicionar a seguinte anotação na classe Securityconfigurations do projeto.

3. Documente, teste e prepare uma API para o deploy

- formatação de datas:  
Como foi demonstrado no vídeo anterior, o Spring tem um padrão de formatação para campos do tipo data quando esses são mapeados em atributos do tipo LocalDateTime. Entretanto, é possível personalizar tal padrão para utilizar outras formatações de nossa preferência.
Por exemplo, imagine que precisamos receber a data/hora da consulta no seguinte formato: dd/mm/yyyy hh:mm. Para que isso seja possível, precisamos indicar ao Spring que esse será o formato ao qual a data/hora será recebida na API, sendo que isso pode ser feito diretamente no DTO, com a utilização da anotação @JsonFormat.  
No atributo pattern indicamos o padrão de formatação esperado, seguindo as regras definidas pelo padrão de datas do Java. Você pode encontrar mais detalhes nesta página do JavaDoc.
Essa anotação também pode ser utilizada nas classes DTO que representam as informações que a API devolve, para que assim o JSON devolvido seja formatado de acordo com o pattern configurado. Além disso, ela não se restringe apenas à classe LocalDateTime, podendo também ser utilizada em atributos do tipo LocalDate e LocalTime.


- Service Pattern:  
O Padrão Service é muito utilizado na programação e seu nome é muito comentado. Mas apesar de ser um nome único, Service pode ser interpretado de várias maneiras: pode ser um Use Case (Application Service); um Domain Service, que possui regras do seu domínio; um Infrastructure Service, que usa algum pacote externo para realizar tarefas; etc.
Apesar da interpretação ocorrer de várias formas, a ideia por trás do padrão é separar as regras de negócio, as regras da aplicação e as regras de apresentação para que elas possam ser facilmente testadas e reutilizadas em outras partes do sistema.
Existem duas formas mais utilizadas para criar Services. Você pode criar Services mais genéricos, responsáveis por todas as atribuições de um Controller; ou ser ainda mais específico, aplicando assim o S do SOLID: Single Responsibility Principle (Princípio da Responsabilidade Única). Esse princípio nos diz que uma classe/função/arquivo deve ter apenas uma única responsabilidade.
Pense em um sistema de vendas, no qual provavelmente teríamos algumas funções como: Cadastrar usuário, Efetuar login, Buscar produtos, Buscar produto por nome, etc. Logo, poderíamos criar os seguintes Services: CadastroDeUsuarioService, EfetuaLoginService, BuscaDeProdutosService, etc.
Mas é importante ficarmos atentos, pois muitas vezes não é necessário criar um Service e, consequentemente, adicionar mais uma camada e complexidade desnecessária à nossa aplicação. Uma regra que podemos utilizar é a seguinte: se não houverem regras de negócio, podemos simplesmente realizar a comunicação direta entre os controllers e os repositories da aplicação.


- princípios SOLID:  
SOLID é uma sigla que representa cinco princípios de programação:
Single Responsibility Principle (Princípio da Responsabilidade Única);  
Open-Closed Principle (Princípio Aberto-Fechado);  
Liskov Substitution Principle (Princípio da Substituição de Liskov);  
Interface Segregation Principle (Princípio da Segregação de Interface);  
Dependency Inversion Principle (Princípio da Inversão de Dependência);  
Cada princípio representa uma boa prática de programação, que quando aplicadas facilita muito a sua manutenção e extensão. Tais princípios foram criados por Robert Martin, conhecido como Uncle Bob, em seu artigo Design Principles and Design Patterns.


- OpenAPI Initiative:  
A documentação é algo muito importante em um projeto, principalmente se ele for uma API Rest, pois nesse caso podemos ter vários clientes que vão precisar se comunicar com ela, necessitando então de uma documentação que os ensinem como realizar essa comunicação de maneira correta.
Por muito tempo não existia um formato padrão de se documentar uma API Rest, até que em 2010 surgiu um projeto conhecido como Swagger, cujo objetivo era ser uma especificação open source para design de APIs Rest. Depois de um tempo, foram desenvolvidas algumas ferramentas para auxiliar pessoas desenvolvedoras a implementar, visualizar e testar suas APIs, como o Swagger UI, Swagger Editor e Swagger Codegen, tornando-se assim muito popular e utilizado ao redor do mundo.
Em 2015, o Swagger foi comprado pela empresa SmartBear Software, que doou a parte da especificação para a fundação Linux. Por sua vez, a fundação renomeou o projeto para OpenAPI. Após isso, foi criada a OpenAPI Initiative, uma organização focada no desenvolvimento e evolução da especificação OpenAPI de maneira aberta e transparente.
A OpenAPI é hoje a especificação mais utilizada, e também a principal, para documentar uma API Rest. A documentação segue um padrão que pode ser descrito no formato yaml ou JSON, facilitando a criação de ferramentas que consigam ler tais arquivos e automatizar a criação de documentações, bem como a geração de códigos para consumo de uma API.
Você pode obter mais detalhes no site oficial da OpenAPI Initiative.


- testes com in-memory database:  
Podemos realizar os testes de interfaces repository utilizando um banco de dados em memória, como o H2, ao invés de utilizar o mesmo banco de dados da aplicação.
Caso você queira utilizar essa estratégia de executar os testes com um banco de dados em memória, será necessário incluir o H2 no projeto, adicionando a seguinte dependência no arquivo pom.xml.  
É necessário remover as anotações @AutoConfigureTestDatabase e @ActiveProfiles na classe de teste, deixando-a apenas com a anotação @DataJpaTest.
Também pode apagar o arquivo application-test.properties, pois o Spring Boot realiza as configurações de url, username e password do banco de dados H2 de maneira automática.

## Aprendizados
1.	Criar um projeto Spring Boot utilizando o site do Spring Initializr;
2.	Importar o projeto no IntelliJ e executar uma aplicação Spring Boot pela classe contendo o método main;
3.	Criar uma classe Controller e mapear uma URL nela utilizando as anotações @RestController e @RequestMapping;
4.	Realizar uma requisição de teste no browser acessando a URL mapeada no Controller.
5.	Mapear requisições POST em uma classe Controller;
6.	Enviar requisições POST para a API utilizando o Insomnia;
7.	Enviar dados para API no formato JSON;
8.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
9.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
10.	Mapear requisições POST em uma classe Controller;
11.	Enviar requisições POST para a API utilizando o Insomnia;
12.	Enviar dados para API no formato JSON;
13.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
14.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
15.	Mapear requisições POST em uma classe Controller;
16.	Enviar requisições POST para a API utilizando o Insomnia;
17.	Enviar dados para API no formato JSON;
18.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
19.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
20.	Mapear requisições POST em uma classe Controller;
21.	Enviar requisições POST para a API utilizando o Insomnia;
22.	Enviar dados para API no formato JSON;
23.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
24.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
25.	Mapear requisições POST em uma classe Controller;
26.	Enviar requisições POST para a API utilizando o Insomnia;
27.	Enviar dados para API no formato JSON;
28.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
29.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
30.	Mapear requisições POST em uma classe Controller;
31.	Enviar requisições POST para a API utilizando o Insomnia;
32.	Enviar dados para API no formato JSON;
33.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
34.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
35.	Mapear requisições POST em uma classe Controller;
36.	Enviar requisições POST para a API utilizando o Insomnia;
37.	Enviar dados para API no formato JSON;
38.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
39.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
40.	Mapear requisições POST em uma classe Controller;
41.	Enviar requisições POST para a API utilizando o Insomnia;
42.	Enviar dados para API no formato JSON;
43.	Utilizar a anotação @RequestBody para receber os dados do corpo da requisição em um parâmetro no Controller;
44.	Utilizar o padrão DTO (Data Transfer Object), via Java Records, para representar os dados recebidos em uma requisição POST.
45. Funcionam os Filters em uma requisição;
46. Implementar um filter criando uma classe que herda da classe OncePerRequestFilter, do Spring;
47. Utilizar a biblioteca Auth0 java-jwt para realizar a validação dos tokens recebidos na API;
48. Realizar o processo de autenticação da requisição, utilizando a classe SecurityContextHolder, do Spring;
49. Liberar e restringir requisições, de acordo com a URL e o verbo do protocolo HTTP.
50. Implementar uma nova funcionalidade no projeto; 
51. Avaliar quando é necessário criar uma classe Service na aplicação; 
52. Criar uma classe Service, com o objetivo de isolar códigos de regras de negócio, utilizando para isso a anotação @Service; 
53. Implementar um algoritmo para a funcionalidade de agendamento de consultas; 
54. Realizar validações de integridade das informações que chegam na API; 
55. Implementar uma consulta JPQL (Java Persistence Query Language) complexa em uma interface repository, utilizando para isso a anotação @Query.
56. Isolar os códigos de validações de regras de negócio em classes separadas, utilizando nelas a anotação @Component do Spring; 
57. Finalizar a implementação do algoritmo de agendamento de consultas; 
58. Utilizar os princípios SOLID para deixar o código da funcionalidade de agendamento de consultas mais fácil de entender, evoluir e testar.
59. Adicionar a biblioteca SpringDoc no projeto para que ela faça a geração automatizada da documentação da API; 
60. Analisar a documentação do SpringDoc para entender como realizar a sua configuração em um projeto; 
61. Acessar os endereços que disponibilizam a documentação da API nos formatos yaml e html; 
62. Utilizar o Swagger UI para visualizar e testar uma API Rest; 
63. Configurar o JWT na documentação gerada pelo SpringDoc.
64. Escrever testes automatizados em uma aplicação com Spring Boot; 
65. Escrever testes automatizados de uma interface Repository, seguindo a estratégia de usar o mesmo banco de dados que a aplicação utiliza; 
66. Sobrescrever propriedades do arquivo application.properties, criando outro arquivo chamado application-test.properties que seja carregado apenas ao executar os testes, utilizando para isso a anotação @ActiveProfiles; 
67. Escrever testes automatizados de uma classe Controller, utilizando a classe MockMvc para simular requisições na API; 
68. Testar cenários de erro 400 e código 200 no teste de uma classe controller.
69. Funciona o build de uma aplicação com Spring Boot; 
70. Utilizar arquivos de propriedades específicos para cada profile, alterando em cada arquivo as propriedades que precisam ser modificadas; 
71. Configurar informações sensíveis da aplicação, como dados de acesso ao banco de dados, via variáveis de ambiente; 
72. Realizar o build do projeto via Maven; 
73. Executar a aplicação via terminal, com o comando java -jar, passando as variáveis de ambiente como parâmetro.
    

## Links de interesse
https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Release-Notes

https://12factor.net/

https://jakarta.ee/specifications/bean-validation/3.0/jakarta-bean-validation-spec-3.0.html#builtinconstraints

https://cheatsheetseries.owasp.org/cheatsheets/Mass_Assignment_Cheat_Sheet.html

https://http.cat/ || https://http.dog/

https://docs.spring.io/spring-boot/docs/current/reference/html/application-properties.html

https://docs.spring.io/spring-data/jpa/reference/jpa/query-methods.html

https://jwt.io/introduction

https://www.alura.com.br/artigos/o-que-e-json-web-tokens?_gl=1*3ch8q7*_ga*NDI2NTU4ODUwLjE3MDg4Njk4OTg.*_ga_1EPWSW3PCS*MTcwOTczMTM3OC4yOS4xLjE3MDk3MzMwMjUuMC4wLjA.*_fplc*QmhKVUdVZXhHTHltZnRUN1ZQcHBtUlVTdFppeTRzaU9PRDZHUk9hSFZJSWFMeVEwbyUyRmxxUW9QS0J2czFXTkJLVXZDUGxCVUpaM1ZGJTJCajhHSEVuZHNkYlhZaU9qTVpIMnhCQmxVRlZZdHhRMEZBZk1FJTJCQlNGUnpaRkFUQTVBJTNEJTNE

https://docs.spring.io/spring-security/reference/servlet/authorization/method-security.html

http://staff.cs.utu.fi/~jounsmed/doos_06/material/DesignPrinciplesAndPatterns.pdf

https://www.openapis.org/

https://spec.openapis.org/oas/latest.html#schema

