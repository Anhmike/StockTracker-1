import UIKit

class WatchlistTableViewController: UITableViewController {
    
    let apiManager = APIManager()
    var persistenceManager: PersistanceManager!
    
    var stocks = [Stock]()
    
    func registerTableViewCells() {
        tableView.register(StockTableViewCell.classForCoder(), forCellReuseIdentifier: WatchListConstants.TableViewCell.ReuseIdentifier)
    }
    
    func setupNavBar() {
        self.navigationItem.title = "My Watchlist"
        let addNewStockBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewStockSymbol))
        self.navigationItem.rightBarButtonItem  = addNewStockBarButtonItem
    }
    
    @objc func addNewStockSymbol() {
        /*
        let stock = Stock(context: persistenceManager.context)
        stock.symbol = "MSFT"
        persistenceManager.saveContext()
        fetchStockSymbolsFromDatabase()
        updateAndLoad(stocks: [stock])
        */
        
        let editStockListScreen = EditStockListTableViewController(apiManager: apiManager, persistenceManager: persistenceManager, stocks: stocks)
        navigationController?.pushViewController(editStockListScreen, animated: true)
        
    }
    
    func deleteStockAt(indexPath: IndexPath) {
        let row = indexPath.row
        let stockToBeDeleted = stocks[row]
        
        persistenceManager.context.delete(stockToBeDeleted)
        persistenceManager.saveContext()
        
        stocks.remove(at: row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func fetchStockSymbolsFromDatabase() {
        stocks = persistenceManager.fetch(Stock.self)
    }
    
    func updateAndLoad(stocks: [Stock]) {
        guard stocks.count > 0 else { return }

        let dispatchGroup = DispatchGroup()
        apiManager.updateStocks(stocks: stocks,dispatchGroup: dispatchGroup)
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    //Init methods:
    
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
        registerTableViewCells()
        fetchStockSymbolsFromDatabase()
        //addNewStockSymbol()
        updateAndLoad(stocks: stocks)
    }
    
    //Tableview methods:
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteStockAt(indexPath: indexPath)
        }
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListConstants.TableViewCell.ReuseIdentifier, for: indexPath) as! StockTableViewCell
        cell.symbolLabel.text = stocks[indexPath.row].symbol
        cell.percentChangeLabel.text = stocks[indexPath.row].percentChange
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WatchListConstants.TableViewCell.height
    }
}
