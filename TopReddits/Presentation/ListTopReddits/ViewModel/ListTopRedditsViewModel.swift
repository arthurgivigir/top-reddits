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
    func infiniteScroll()
}

protocol ListTopRedditsViewModelOutput {
    var datasource: [RedditMessage]? { get }
    var sections: Int { get }
}

protocol ListTopRedditsViewModel: ListTopRedditsViewModelInput, ListTopRedditsViewModelOutput {}

enum MessagesSections: Int, CaseIterable {
    case messages
    case loading
}

final class DefaultListTopRedditsViewModel: ListTopRedditsViewModel {
    let topRedditsUseCase: TopRedditsUseCase
    let viewControllerDelegate: ListTopRedditsViewControllerDelegate
    var datasource: [RedditMessage]?
    var sections: Int = MessagesSections.allCases.count

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
    
    func infiniteScroll() {
        loadMoreData()
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
    
    func loadMoreData() {
        fetchTopReddits(reloadData: false) { [weak self] result in
            switch result {
            case .success(let items):
                self?.datasource?.append(contentsOf: items)
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
