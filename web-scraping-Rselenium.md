Web Scraping da Plataforma Sucupira dos Trabalhos de Conclusão
Pós-Graduação
================

## Preenchendo formulário:

  - Anos: **2017 a 2020**;
  - Instituição de Ensino Superior: **UNIVERSIDADE FEDERAL DA BAHIA
    (UFBA)**;
  - Programa: **Ciência da Computação (28001010095P3)**.

<!-- end list -->

``` r
library(RSelenium)
```

``` r
url = 'https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/trabalhoConclusao/listaTrabalhoConclusao.xhtml'
```

``` r
# start a chrome browser
rD = rsDriver(browser = "chrome", port = 4444L, geckover = NULL, 
               chromever =  "85.0.4183.83", iedrver = NULL, phantomver = NULL)
```

    ## checking Selenium Server versions:

    ## BEGIN: PREDOWNLOAD

    ## BEGIN: DOWNLOAD

    ## BEGIN: POSTDOWNLOAD

    ## checking chromedriver versions:

    ## BEGIN: PREDOWNLOAD

    ## BEGIN: DOWNLOAD

    ## BEGIN: POSTDOWNLOAD

    ## [1] "Connecting to remote server"
    ## $acceptInsecureCerts
    ## [1] FALSE
    ## 
    ## $browserName
    ## [1] "chrome"
    ## 
    ## $browserVersion
    ## [1] "85.0.4183.102"
    ## 
    ## $chrome
    ## $chrome$chromedriverVersion
    ## [1] "85.0.4183.83 (94abc2237ae0c9a4cb5f035431c8adfb94324633-refs/branch-heads/4183@{#1658})"
    ## 
    ## $chrome$userDataDir
    ## [1] "C:\\Users\\fe-na\\AppData\\Local\\Temp\\scoped_dir21836_1215130010"
    ## 
    ## 
    ## $`goog:chromeOptions`
    ## $`goog:chromeOptions`$debuggerAddress
    ## [1] "localhost:50640"
    ## 
    ## 
    ## $networkConnectionEnabled
    ## [1] FALSE
    ## 
    ## $pageLoadStrategy
    ## [1] "normal"
    ## 
    ## $platformName
    ## [1] "windows"
    ## 
    ## $proxy
    ## named list()
    ## 
    ## $setWindowRect
    ## [1] TRUE
    ## 
    ## $strictFileInteractability
    ## [1] FALSE
    ## 
    ## $timeouts
    ## $timeouts$implicit
    ## [1] 0
    ## 
    ## $timeouts$pageLoad
    ## [1] 300000
    ## 
    ## $timeouts$script
    ## [1] 30000
    ## 
    ## 
    ## $unhandledPromptBehavior
    ## [1] "dismiss and notify"
    ## 
    ## $`webauthn:virtualAuthenticators`
    ## [1] TRUE
    ## 
    ## $webdriver.remote.sessionid
    ## [1] "86b653a97f1b5c1110c2e821d4ef0166"
    ## 
    ## $id
    ## [1] "86b653a97f1b5c1110c2e821d4ef0166"

``` r
remDr = rD$client 
remDr$navigate(url)
```

``` r
source('web-scraping-rselenium.R')
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
#Funcao gera.dataset implementada no arquivo web-scraping-rselenium.R
dados.pgcomp.chrome = gera.dataset()
```

## Tables HTML convertidas em um único data.frame resultante das consultas realizadas:

``` r
knitr::kable(head(dados.pgcomp.chrome))
```

| NM\_PRODUCAO                                                                                                                                               | NM\_DISCENTE                   | NM\_SUBTIPO\_PRODUCAO | DT\_TITULACAO | AN\_BASE |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------- | :-------------------- | :------------ | -------: |
| PLAR - UMA TECNICA PARA RECUPERAÇÃO DE ARQUITETURA DE LINHAS DE PRODUTO DE SOFTWARE                                                                        | MATEUS PASSOS SOARES CARDOSO   | DISSERTAÇÃO           | 2017-03-14    |     2017 |
| iSim: uma estratégia de agrupamento de usuários para descarregamento de dados em Redes Móveis Centradas na informação                                      | ADRIANA VIRIATO RIBEIRO        | DISSERTAÇÃO           | 2017-07-10    |     2017 |
| Predição do Desfecho Clínico por Leptospirose Baseado na Análise de Expressão Gênica em Casos Hospitalizados                                               | NIVISON RUY ROCHA NERY JUNIOR  | DISSERTAÇÃO           | 2017-05-09    |     2017 |
| Fusão de Imagens 2d, 3d e Nir para Autenticação Facial Contínua utilizando Sensores de Baixo Custo                                                         | LEONE DA SILVA DE JESUS        | DISSERTAÇÃO           | 2017-09-15    |     2017 |
| Procedimentos didáticos em Computação e sua relação com as características psicológicas dos estudantes: uma investigação no ensino de Teoria da Computação | ICARO ANDRADE SOUZA            | DISSERTAÇÃO           | 2017-09-22    |     2017 |
| BlinGui: Sistema Vestível de Detecção de Obstáculos Estáticos para Apoiar a Locomoção de Portadores de Deficiência Visual                                  | ELIDIANE PEREIRA DO NASCIMENTO | DISSERTAÇÃO           | 2017-10-11    |     2017 |

``` r
# stop the selenium server
rD$server$stop()
```

    ## [1] TRUE
