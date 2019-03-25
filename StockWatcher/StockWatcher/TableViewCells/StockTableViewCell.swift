import UIKit

class StockTableViewCell: UITableViewCell {
    
    var symbolLabel = UILabel()
    var percentChangeLabel = UILabel()
    
    func addUIElements() {
        symbolLabel = UILabel(frame: CGRect(x: 119.00, y: 9, width: 216.00, height: 31.00))
        percentChangeLabel = UILabel(frame: CGRect(x: 319.00, y: 9, width: 216.00, height: 31.00))
        
        addSubview(symbolLabel)
        addSubview(percentChangeLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
