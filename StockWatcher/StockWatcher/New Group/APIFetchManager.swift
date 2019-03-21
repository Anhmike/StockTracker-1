import Foundation

class APIFetchManager {
    
    private var dispatchGroup: DispatchGroup!
    
    //Public API:
    
    func updateStocks(stocks: [Stock], dispatchGroup: DispatchGroup) {
        self.dispatchGroup = dispatchGroup
        for s in stocks {
            getDataFor(stock: s)
        }
    }
    
    func getSymbolSearchResultsFor(stem: String) {        
        let url = getSymbolSearchURL(stem: stem)
    }
    
    //Internal methods:
    
    private func getSymbolSearchURL(stem: String) -> URL? {
        var urlString = AlphaVantage.URLS.baseURL
        urlString += "function=\(AlphaVantage.Functions.symbolSearch)"+"&"
        urlString += "keywords=\(stem)"+"&"
        urlString += "apikey="+AlphaVantage.Keys.demo
        return URL(string: urlString)
    }
    
    private func getQuoteURL() -> URL? {
        var urlString = AlphaVantage.URLS.baseURL
        urlString += "function=\(AlphaVantage.Functions.quoteEndpoint)"+"&"
        urlString += "symbol=\("MSFT")"+"&"
        urlString += "apikey="+AlphaVantage.Keys.demo
        return URL(string: urlString)
    }
    
    private func getDataFor(stock: Stock)  {
        let url = getQuoteURL()
        dispatchGroup.enter()
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    self.dispatchGroup.leave()
                    return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! [String:[String:Any?]?]
                if let globalQuote = jsonResponse["Global Quote"] {
                    if let stockData = globalQuote {
                        if stockData[AlphaVantage.QuoteKeys.symbol] != nil {
                            self.updateIthStock(stock, stockData)
                        }
                    }
                }
                self.dispatchGroup.leave()
            } catch let parsingError {
                print("Parsing JSON error", parsingError)
                self.dispatchGroup.leave()
            }
            
        }
        task.resume()
    }
    
    private func updateIthStock(_ stock: Stock,_ data: [String:Any?]) {
        if let percentChange = data[AlphaVantage.QuoteKeys.percentChange] as? String {
            stock.percentChange = percentChange
        }
        
        //update other stock parameters...
    }
}
