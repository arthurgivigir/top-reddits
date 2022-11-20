//
//  ListTopRedditsViewModel.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import Foundation

protocol ListTopRedditsViewModelInput {
    func viewDidLoad()
    func pullToRefresh()
}

protocol ListTopRedditsViewModelOutput {
    var datasource: [RedditMessage]? { get }
}

protocol ListTopRedditsViewModel: ListTopRedditsViewModelInput, ListTopRedditsViewModelOutput {}

final class DefaultListTopRedditsViewModel: ListTopRedditsViewModel {
    let topRedditsUseCase: TopRedditsUseCase
    let viewControllerDelegate: ListTopRedditsViewControllerDelegate
    var datasource: [RedditMessage]?

    init(viewControllerDelegate: ListTopRedditsViewControllerDelegate,
         topRedditsUseCase: TopRedditsUseCase = DefaultTopRedditsUseCase()) {
        self.viewControllerDelegate = viewControllerDelegate
        self.topRedditsUseCase = topRedditsUseCase
    }
    
    func viewDidLoad() {
        reloadTableView()
    }
    
    func pullToRefresh() {
        reloadTableView()
    }
}

private extension DefaultListTopRedditsViewModel {
    func reloadTableView() {
        fetchTopReddits(reloadData: true) { [weak self] result in
            switch result {
            case .success(let items):
                self?.datasource = items
                self?.viewControllerDelegate.reloadTableView()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTopReddits(reloadData: Bool, completion: @escaping (Result<[RedditMessage], NetworkError>) -> Void) {
        topRedditsUseCase.fecthTopReddits(reloadData: reloadData) { result in
            completion(result)
        }
    }
}
