import UIKit

class WatchlistTableViewController: UITableViewController {
    
    private struct Constants {
        static let heightForRow = CGFloat(80)
        static let stockCellReuseIdentifier = "StockTableViewCellID"
    }
    
    var persistenceManager: PersistanceManager!
    let dataFetcher = APIFetchManager()
    var stockSymbols = [Stock]()
    
    func setupNavBar() {
        self.navigationItem.title = "My Watchlist"
        let addNewStockBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewStockSymbol))
        self.navigationItem.rightBarButtonItem  = addNewStockBarButtonItem
    }
    
    @objc func addNewStockSymbol() {
        let stock = Stock(context: persistenceManager.context)
        stock.symbol = "GOOG0"
        persistenceManager.saveContext()
        fetchStockSymbols()
        tableView.reloadData()
    }
    
    func deleteStockAt(indexPath: IndexPath) {
        let row = indexPath.row
        let stockToBeDeleted = stockSymbols[row]
        
        persistenceManager.context.delete(stockToBeDeleted)
        persistenceManager.saveContext()
        
        stockSymbols.remove(at: row)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func fetchStockSymbols() {
        //fetch from Core Data:
        stockSymbols = persistenceManager.fetch(Stock.self)
    }
    
    init(persistenceManager: PersistanceManager) {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.register(StockTableViewCell.classForCoder(), forCellReuseIdentifier: Constants.stockCellReuseIdentifier)
        fetchStockSymbols()
        dataFetcher.getDataFor(stock: stockSymbols.first)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteStockAt(indexPath: indexPath)
        }
        
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.stockCellReuseIdentifier, for: indexPath) as! StockTableViewCell
        cell.symbolLabel.text = stockSymbols[indexPath.row].symbol
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockSymbols.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }
}
