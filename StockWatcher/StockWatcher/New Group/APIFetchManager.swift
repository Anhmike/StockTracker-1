import Foundation

class APIFetchManager {
    
    struct APIStrings {
        
        static let baseURL = "https://www.alphavantage.co/query?"
        static let apiKey = "YMA0KO9MO9P7PZ96"
        static let demoKey = "demo"
        
        enum Functions {
            static let quoteEndpoint = "GLOBAL_QUOTE"
            static let symbolSearch = "SYMBOL_SEARCH"
        }
    }
    
    func getSymbolSearchResultsFor(stem: String) {
        var url = APIStrings.baseURL
        url += "function=\(APIStrings.Functions.symbolSearch)"+"&"
        url += "keywords=\(stem)"+"&"
        url += "apikey="+APIStrings.apiKey
    }
    
    func getDataFor(stock: Stock?) -> [String:Any?] {
//        guard let stock = stock else {return [String:Any?]()}
        
        var urlString = APIStrings.baseURL
        urlString += "function=\(APIStrings.Functions.quoteEndpoint)"+"&"
        urlString += "symbol=\("MSFT")"+"&"
        urlString += "apikey="+APIStrings.demoKey
        let url = URL(string: urlString)
        print(urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as! [String:[String:Any?]?]
                if let globalQuote = jsonResponse["Global Quote"] {
                    if let stock = globalQuote {
                        if let symbol = stock["01. symbol"] as? String {
                            print(symbol)
                        }
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        return [String:Any?]()
    }
    
    func updateStocks(stocks: [Stock]) {
        for s in stocks {
            
        }
    }
}
