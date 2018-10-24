import UIKit

class AboutCell: UITableViewCell {
    
    var item: ViewModelItem? {
        didSet {
            guard  let item = item as? ViewModelAboutItem else { return }
            aboutLabel.text = item.about
        }
    }
    
    internal let aboutLabel: UILabel = {
        let aboutLabel = UILabel()
        aboutLabel.text = "Name"
        aboutLabel.backgroundColor = .clear
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.font = UIFont.systemFont(ofSize: 16)
        aboutLabel.textAlignment = .left
        aboutLabel.numberOfLines = 0
        return aboutLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        addSubview(aboutLabel)
        
        NSLayoutConstraint.activate([aboutLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), aboutLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16), aboutLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), aboutLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)])
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
