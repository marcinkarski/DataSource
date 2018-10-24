import UIKit

class TableCell: UITableViewCell {
    
    var imageBox: Model? {
        didSet {
            photoView.image = UIImage(named: imageBox?.image ?? "")
            nameLabel.text = imageBox?.name
        }
    }
    
    internal let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    internal let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.backgroundColor = .clear
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        nameLabel.layer.shadowOpacity = 0.5
        nameLabel.layer.shadowRadius = 0.5
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        addSubview(photoView)
        photoView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), photoView.topAnchor.constraint(equalTo: topAnchor, constant: 16), photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0), nameLabel.leftAnchor.constraint(equalTo: photoView.leftAnchor, constant: 16), nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16), nameLabel.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
