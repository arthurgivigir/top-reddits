//
//  ListTopRedditsViewController.swift
//  TopReddits
//
//  Created by Arthur Givigir on 09/11/22.
//

import Foundation
import UIKit

final class ListTopRedditsViewController: UIViewController {
    
    private var viewModel: ListTopRedditsViewModel?
    private var datasource: [RedditMessage]?
    private let refreshControl = UIRefreshControl()
    
    lazy var messagesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .backgroundPrimary
        tableView.registerCell(type: MessageTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = DefaultListTopRedditsViewModel(viewControllerDelegate: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel = DefaultListTopRedditsViewModel(viewControllerDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureNavigationController()
        configureConstraints()
        
        viewModel?.viewDidLoad()
    }
    
    @objc private func callRedditDetails() {
        navigationController?.show(RedditDetailsViewController(), sender: self)
    }
    
}

// MARK: - Private methods
private extension ListTopRedditsViewController {
    func configureViews() {
        setupPullToRefresh()
        
        view.backgroundColor = .backgroundPrimary
        view.addSubview(messagesTableView)
    }
    
    func configureNavigationController() {
        navigationItem.title = "Top Reddits"
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            messagesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Space.minimum.rawValue),
            messagesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Space.minimum.rawValue),
            messagesTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
    }
    
    func setupPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .fontColorPrimary
        refreshControl.attributedTitle = NSAttributedString(string: "Carregando...", attributes: nil)
    }
    
    @objc
    func pullToRefresh(_ sender: Any) {
        viewModel?.pullToRefresh()
    }
}

// MARK: - UITableViewDelegate
extension ListTopRedditsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension ListTopRedditsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = datasource?[indexPath.row],
              let cell: MessageTableViewCell = tableView.dequeueCell(withType: MessageTableViewCell.self, for: indexPath)
        else { return UITableViewCell(frame: .zero) }
        
        cell.setup(with: item)
        return cell
    }
}

// MARK: - ListTopRedditsViewControllerDelegate
extension ListTopRedditsViewController: ListTopRedditsViewControllerDelegate {
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.datasource = self.viewModel?.datasource
            self.messagesTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

