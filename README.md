# DigioTest

## Descrição

O DigioTest é um aplicativo de teste que exibe uma tela inicial com várias seções, cada uma contendo um tipo diferente de conteúdo, como destaques, ofertas de cashback e produtos. O objetivo do aplicativo é demonstrar a construção de uma tela inicial dinâmica com várias seções e permitir que o usuário navegue para detalhes dos itens exibidos.

## Arquitetura

O DigioTest utiliza a arquitetura VIPER (View, Interactor, Presenter, Entity, Router) com base nos princípios do Clean Architecture. Essa arquitetura divide o aplicativo em camadas e torna cada componente independente e facilmente testável. O Presenter é responsável por intermediar a comunicação entre a View e o Interactor, garantindo que a View esteja livre de lógica de negócio. O Interactor é responsável por conter as regras de negócio e obter os dados do DataSource, que é responsável por isolar as chamadas para os endpoints da API.

## Libs

1. SnapKit: Utilizada para construir o layout da tela inicial de forma programática, evitando o uso excessivo de Storyboards e garantindo uma maior flexibilidade no design das células e seções.

## Início Rápido

1. Clone o repositório do projeto.
2. Abra o terminal e navegue até o diretório raiz do projeto.
3. Execute o comando `pod install` para instalar as dependências do projeto (SnapKit).
4. Abra o projeto DigioTest.xcworkspace no Xcode.
5. Selecione o dispositivo de simulação ou conecte um dispositivo físico.
6. Pressione o botão de build e run no Xcode para instalar e executar o aplicativo no dispositivo selecionado.

## Testes

O projeto possui testes unitários para as principais funcionalidades do Presenter e Interactor. Os testes são escritos usando XCTest, a biblioteca de testes nativa do Xcode. Para executar os testes, basta abrir o projeto no Xcode, selecionar o scheme de testes e pressionar Command+U.

## Autor

Paulo Henrique dos Santos Knoop

## Outras Considerações

O aplicativo foi desenvolvido para rodar em dispositivos com iOS 12.0 ou posterior. Certifique-se de ter o Xcode instalado em sua máquina para executar o projeto. O aplicativo consome dados de uma API remota para preencher as informações exibidas na tela inicial, portanto, é necessária uma conexão de internet para o correto funcionamento do aplicativo.
