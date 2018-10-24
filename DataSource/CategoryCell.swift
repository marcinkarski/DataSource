import UIKit

class CategoryCell: UITableViewCell {
    
    var item: Category? {
        didSet {
            titleLabel.text = item?.key
//            valueLabel?.text = item?.value
        }
    }
    
    internal let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Name"
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    internal let separatorLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 50, width: 100, height: 1))
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        addSubview(titleLabel)
        addSubview(separatorLine)
        
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16), titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)])
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
