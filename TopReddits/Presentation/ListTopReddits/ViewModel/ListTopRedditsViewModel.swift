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
        loadFromRefresh()
    }
    
    func infiniteScroll() {
        loadMoreData()
    }
}

private extension DefaultListTopRedditsViewModel {
    func reloadTableView() {
        viewControllerDelegate.startLoading()
        
        fetchTopReddits(reloadData: true) { [weak self] items in
            self?.datasource = items
            self?.viewControllerDelegate.stopLoading()
        }
    }
    
    func loadFromRefresh() {
        fetchTopReddits(reloadData: true) { [weak self] items in
            self?.datasource = items
        }
    }
    
    func loadMoreData() {
        fetchTopReddits(reloadData: false) { [weak self] items in
            self?.datasource?.append(contentsOf: items)
        }
    }
    
    func fetchTopReddits(reloadData: Bool, completion: @escaping ([RedditMessage]) -> Void) {
        topRedditsUseCase.fecthTopReddits(reloadData: reloadData) { [weak self]  result in
            switch result {
            case .success(let entities):
                self?.viewControllerDelegate.reloadTableView()
                completion(entities)
                
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    func handleError(_ error: NetworkError) {
        switch error {
        case .notConnected:
            viewControllerDelegate.showErrorMessage("Ohhh no... It's look like you're without internet!")
        default:
            viewControllerDelegate.showErrorMessage("Ohhh no... Something really BAD happened")
        }
    }
}
