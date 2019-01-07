
genQue <- function(code, first_date, last_date, page=NULL){
  
  start_date <- first_date %>% strftime('%Y-%m-%d') %>% strsplit("-") %>% .[[1]]
  end_date <- last_date  %>% strftime('%Y-%m-%d') %>% strsplit("-") %>% .[[1]]
  
  url <- paste0(
    "https://info.finance.yahoo.co.jp/history/?code=", code,
    "&sy=", start_date[1], "&sm=", start_date[2], "&sd=", start_date[3],
    "&ey=", end_date[1], "&em=", end_date[2], "&ed=", end_date[3],
    "&tm=d"
  )
  if(!is.null(page)){
    url <- paste0(url, "&p=", page)
  }
  
  return(url)
}


urlToXts <- function(url){
  con <- curl::curl(url=url)
  open(con)
  out <- readLines(con)
  close(con)
  out %>% grep('<td>',.,value=T) %>%
    gsub('(</tr>|<tr>|</td>|<td>|</table>)', ' ',.) %>%
    gsub('(^ +| +$)', '', .) %>% 
    str_split(' +') %>% 
    .[[1]] %>% 
    gsub('(年|月)', '-',.) %>% gsub('日', '', .) %>% 
    gsub(',','',.) %>% 
    matrix(nrow=3) %>% t() -> res
  
  require(xts)
  data.xts <- xts(res[,2:3] %>% apply(c(1,2), as.numeric), res[,1] %>% strptime('%Y-%m-%d'))
  
  return(data.xts)
}

getStock('aaa', '2017-12-08::2018-01-07')
getStock <- function(code, period){
  period <- period %>% str_split('(::|/)') %>% .[[1]]
  dataList <- list()
  for (i in 1:100){
    if(i==1){
      url <- genQue(code, as.Date(period[1]), as.Date(period[2]))
    }else{
      url <- genQue(code, as.Date(period[1]), as.Date(period[2]), page=i)
    }
    
    print(url)
    Sys.sleep(abs(rnorm(1)+1))
    e <- try(dataList <- append(dataList, list(urlToXts(url))))
    if(class(e)=="try-error"){
      break
    }
  }
  require(data.table)
  return(do.call("rbind.xts", dataList))
}
  
  
  
iFree <- getStock(code='0431P169', period="2017-01-01::2019-01-07")

plot(iFree)
tmp %>% plot()