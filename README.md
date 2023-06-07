<h1 align="center">
    <img width="30%" src= "https://github.com/joaopedro96/kabum-app/assets/84334801/53b258d8-fd15-42b1-afba-c8621ba77512" />
    <br>
    KaBuM! App
</h1>

<h4 align="center">
  Representação da página inicial do aplicativo da e-commerce KaBuM!
</h4>

<p align="center">
  <img width="25%" src= "https://github.com/joaopedro96/kabum-app/assets/84334801/7fdb6a34-f279-4d19-b407-18600134f62e" />
</p>


## 🖥️ Sobre o projeto
Este projeto apresenta uma proposta de desenvolvimento da página inicial do aplicativo da KaBuM!, com ênfase na tabela de produtos  vista na secão “Em Destaque”.


## 🚀 Feature adicionais

Adicionalmente a tabela de produtos foi também implementado as seguintes features:
- Icone do aplicativo
- Splash Screen
- Loading Screen
- Barra de navegação (com search bar e icone de carrinho de compras)
- Badge icon adicionado para contagem dos produtos no carrinho de compra
- Tab Bar (constando os 4 itens conforme aplicativo original e uma tela modelo para exemplo de navegação)
- Demonstração da navegação para tela de “Detalhes do Produto” ao clicar em qualquer célula da tabela


## ⚙️ Configurações gerais

As seguintes configurações foram definidas para este projeto:
- Opções de tema: Claro (Light Mode)
- Orientação: Retrato (Portrait)
- Versão mínima do sistema operacional: iOS 13.0


## 🌐 API
- Endpoint: https://servicespub.prod.api.aws.grupokabum.com.br/home/v1/home/produto
- Método: GET
- Parametros:
  * app: Int -> indicação de origem
  * limite: Int -> limite de produtos por página
  * pagina: Int -> offset da página a ser carregada


## 💼 Stacks utilizadas

Os seguintes recursos foram utilizados no desenvolvimento deste projeto:
- Swift
- UIKit
- MVVM
- Cocoapods (Alamofire / Kingfisher, RxSwift)
- View Code
- Autolayout
- Delegate Pattern
- Dependency Injection
