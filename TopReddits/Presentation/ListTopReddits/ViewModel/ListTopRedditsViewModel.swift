//
//  ListTopRedditsViewModel.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import Foundation

protocol ListTopRedditsViewModelInput {
    func viewDidLoad()
}

protocol ListTopRedditsViewModelOutput {
    var datasource: [RedditMessage]? { get }
}

protocol ListTopRedditsViewModel: ListTopRedditsViewModelInput, ListTopRedditsViewModelOutput {}

final class DefaultListTopRedditsViewModel: ListTopRedditsViewModel {
    let topRedditsRepository: TopRedditsRepository
    let viewControllerDelegate: ListTopRedditsViewControllerDelegate
    var datasource: [RedditMessage]?

    init(viewControllerDelegate: ListTopRedditsViewControllerDelegate,
         topRedditsRepository: TopRedditsRepository = DefaultTopRedditsRepository()) {
        self.viewControllerDelegate = viewControllerDelegate
        self.topRedditsRepository = topRedditsRepository
    }
    
    func viewDidLoad() {
        fetchTopReddits()
    }
}
extension DefaultListTopRedditsViewModel {
    private func fetchTopReddits() {
        topRedditsRepository.fecthTopReddits { [weak self] result in
            switch result {
            case .success(let items):
                self?.datasource = items
                self?.viewControllerDelegate.reloadTableView()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
