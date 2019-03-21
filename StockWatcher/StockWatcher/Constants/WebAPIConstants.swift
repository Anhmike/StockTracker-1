import Foundation

struct AlphaVantage {
    
    struct URLS {
        static let baseURL = "https://www.alphavantage.co/query?"
    }
    
    struct Keys {
        static let demo = "demo"
        static let key = "YMA0KO9MO9P7PZ96"
    }
    
    struct Functions {
        static let quoteEndpoint = "GLOBAL_QUOTE"
        static let symbolSearch = "SYMBOL_SEARCH"
    }
    
    struct QuoteKeys {
        static let symbol = "01. symbol"
        static let open = "02. open"
        static let high = "03. high"
        static let low = "04. low"
        static let volume = "06. volume"
        static let percentChange = "10. change percent"
    }
}
