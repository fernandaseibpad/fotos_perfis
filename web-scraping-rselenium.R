library(RSelenium)
library(lubridate)
library(XML)

gera.dataset = function(anos = list("2017", "2018", "2019", "2020"), instituicao = list("ufba")){
  
  dados = list()
  
  inst = remDr$findElement(using = "id", 'form:j_idt31:inst:input')
  
  inst$sendKeysToElement(instituicao)
  
  Sys.sleep(2)
  
  remDr$findElement(using = "xpath", "//select[@name = 'form:j_idt31:inst:listbox']/option[@value = '4354']")$clickElement()
  
  Sys.sleep(4)
  
  remDr$findElement(using = "xpath", "//select[@name = 'form:j_idt31:j_idt96']/option[@value = '205551']")$clickElement()
  
  for(i in anos){
    
    ano <- remDr$findElement(using = "id", "form:j_idt31:ano")
    
    ano$clearElement()
    
    ano$sendKeysToElement(list(i))
    
    remDr$findElement(using = "xpath", "//input[@value = 'Consultar']")$clickElement()
    
    Sys.sleep(3)
    
    html.table = htmlParse(remDr$getPageSource()[[1]])
    
    table = readHTMLTable(html.table)[[3]]
    
    if(is.null(dados)){
      dados = table
    }else{
      dados = rbind(dados, table)
    }
    
    Sys.sleep(5)
    
  }
  
  remDr$close()

  dados = dados[,-ncol(dados)]
  names(dados) = c("NM_PRODUCAO", "NM_DISCENTE", "NM_SUBTIPO_PRODUCAO", "DT_TITULACAO")
  
  dados$DT_TITULACAO = dmy(dados$DT_TITULACAO)
  
  dados = cbind(dados, "AN_BASE" = year(dados$DT_TITULACAO))
  
  dados = dados[!duplicated.data.frame(dados),]
  
  dados
  
}

url = 'https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/trabalhoConclusao/listaTrabalhoConclusao.xhtml'

# start a chrome browser
rD = rsDriver(browser = "chrome", port = 4444L, geckover = NULL, 
               chromever =  "latest", iedrver = NULL, phantomver = NULL)

remDr = rD$client 
remDr$navigate(url)

dados.pgcomp.chrome = gera.dataset()

# stop the selenium server
rD$server$stop()