
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
Atenção! Por padrão esse recurso vem desabilitado no spring Security, sendo que para o utilizar devemos adicionar a seguinte anotação na classe Securityconfigurations do projeto

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
