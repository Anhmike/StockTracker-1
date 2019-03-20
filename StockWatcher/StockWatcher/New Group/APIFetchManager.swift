import Foundation

class APIFetchManager {
    
    var dispatchGroup: DispatchGroup!
    
    struct APIStrings {
        
        static let baseURL = "https://www.alphavantage.co/query?"
        static let apiKey = "YMA0KO9MO9P7PZ96"
        static let demoKey = "demo"
        
        enum Functions {
            static let quoteEndpoint = "GLOBAL_QUOTE"
            static let symbolSearch = "SYMBOL_SEARCH"
        }
    }
    
    enum GlobalQuoteDictKeys {
        static let symbol = "01. symbol"
        static let open = "02. open"
        static let high = "03. high"
        static let low = "04. low"
        static let volume = "06. volume"
        static let percentChange = "10. change percent"
    }
    
    func updateStocks(stocks: [Stock], dispatchGroup: DispatchGroup) {
        self.dispatchGroup = dispatchGroup
        for s in stocks {
            getDataFor(stock: s)
        }
    }
    
    func getSymbolSearchResultsFor(stem: String) {
        //Used for searching for a stock by symbol code:
        
        var url = APIStrings.baseURL
        url += "function=\(APIStrings.Functions.symbolSearch)"+"&"
        url += "keywords=\(stem)"+"&"
        url += "apikey="+APIStrings.apiKey
    }
    
    private func getDataFor(stock: Stock)  {
        var urlString = APIStrings.baseURL
        urlString += "function=\(APIStrings.Functions.quoteEndpoint)"+"&"
        urlString += "symbol=\("MSFT")"+"&"
        urlString += "apikey="+APIStrings.demoKey
        let url = URL(string: urlString)
        
        dispatchGroup.enter()
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! [String:[String:Any?]?]
                if let globalQuote = jsonResponse["Global Quote"] {
                    if let stockData = globalQuote {
                        if stockData[GlobalQuoteDictKeys.symbol] != nil {
                            self.updateIthStock(stock, stockData)
                            self.dispatchGroup.leave()
                        }
                    }
                }
            } catch let parsingError {
                print("Parsing JSON error", parsingError)
            }
        }
        task.resume()
        
    }
    
    private func updateIthStock(_ stock: Stock,_ data: [String:Any?]) {
//        stock.high = data[APIStrings.GlobalQuoteDictKeys.high] as? String
//        stock.low = data[APIStrings.GlobalQuoteDictKeys.low] as? String
        stock.percentChange = data[GlobalQuoteDictKeys.percentChange] as? String
    }
}
