import UIKit

final class ViewController: UIViewController {
    
    private let model = Model.fetchData()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        let height = view.frame.width - 32
        tableView.register(TableCell.self, forCellReuseIdentifier: "Cell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = height
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.title = "DataSource"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        let photo = model[indexPath.row]
        cell.imageBox = photo
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class TableCell: UITableViewCell {
    
    var imageBox: Model! {
        didSet {
            photoView.image = UIImage(named: imageBox.image)
            nameLabel.text = imageBox.name
        }
    }
    
    internal let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(white: 0.95, alpha: 1.0).cgColor
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
