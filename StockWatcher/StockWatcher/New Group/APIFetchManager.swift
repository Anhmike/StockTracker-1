import Foundation

class APIFetchManager {
    
    //let baseURL = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&apikey=demo"
    let baseURL = "https://www.alphavantage.co/query?"
    let apiKey = ""
    
    init() {
        
    }
    
    func constructURLFor(function: String, stock: Stock, interval: String) -> URL? {
        let urlString = baseURL + "function=\(function)" + "function=\(function)" + "function=\(function)"
        return URL(string: urlString)
    }
    
    func getDataFromAPIFor(stock: Stock) {
        if let url = constructURLFor(function: "", stock: stock, interval: "5min") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data, error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                    print(jsonResponse) //Response result
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }
    }
}
