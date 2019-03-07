import UIKit

class StockTableViewCell: UITableViewCell {
    
    var symbolLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.symbolLabel = UILabel(frame: CGRect(x: 119.00, y: 9, width: 216.00, height: 31.00))
        self.addSubview(self.symbolLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
