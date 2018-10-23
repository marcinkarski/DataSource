import UIKit

final class ViewController: UIViewController {
    
    private let viewModel = DataSource()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        let height = view.frame.width - 32
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = height
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.title = "DataSource"
        view.addSubview(tableView)
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        tableView.dataSource = viewModel
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
