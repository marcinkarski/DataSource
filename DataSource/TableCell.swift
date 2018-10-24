import UIKit

class TableCell: UITableViewCell {
    
    var imageRequest: URLSessionDataTask?
    
    var imageBox: Profile? {
        didSet {
            photoView.image = UIImage(named: imageBox?.avatarURL ?? "")
            nameLabel.text = imageBox?.name
        }
    }
    
    func configure(with profile: Profile) {
        nameLabel.text = profile.name
        loadImage(for: profile)
    }
    
    func loadImage(for profile: Profile) {
        guard let url = URL(string: profile.avatarURL) else { return }
        let service = APIService()
        imageRequest = service.requestImage(withURL: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView?.image = image
            case .failure(let error):
                print(error)
            }
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
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        addSubview(photoView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16), photoView.topAnchor.constraint(equalTo: topAnchor, constant: 16), photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16), photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0), nameLabel.leftAnchor.constraint(equalTo: photoView.leftAnchor, constant: 16), nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16), nameLabel.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
