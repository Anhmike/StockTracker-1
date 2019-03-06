import UIKit

class WatchlistTableViewController: UITableViewController {
    
    var persistenceManager: PersistanceManager!
    
    let dataFetcher = StockDataFetcherManager()
    var stockSymbols = [String]()
    
    func setupNavBar() {
        self.navigationItem.title = "My Watchlist"
        let addNewStockBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem  = addNewStockBarButtonItem
    }
    
    func fetchStockSymbols() {
        //fetch from Core Data:
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
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
