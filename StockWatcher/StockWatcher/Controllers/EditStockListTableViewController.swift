import UIKit

class EditStockListTableViewController: UITableViewController {
    
    var persistenceManager: PersistanceManager!
    var apiManager: APIManager!
    
    var stocks = [Stock]()
    
    func setupNavBar() {
        self.navigationItem.title = "Edit Watchlist"
        let addNewStockBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewStockSymbol))
        self.navigationItem.rightBarButtonItem = addNewStockBarButtonItem
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = nil
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc func addNewStockSymbol() {
        let addNewStockScreen = AddStockTableViewController()
        navigationController?.pushViewController(addNewStockScreen, animated: true)
    }

    init(apiManager: APIManager,persistenceManager: PersistanceManager,stocks: [Stock]) {
        self.apiManager = apiManager
        self.persistenceManager = persistenceManager
        self.stocks = stocks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.setEditing(true, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
