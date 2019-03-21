import UIKit

class EditStockListTableViewController: UITableViewController {
    
    var persistenceManager: PersistanceManager!
    var apiManager: APIManager!
    
    var stocks = [Stock]()

    init(apiManager: APIManager,persistenceManager: PersistanceManager,stocks: [Stock]) {
        self.apiManager = apiManager
        self.persistenceManager = persistenceManager
        self.stocks = stocks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setEditing(true, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
