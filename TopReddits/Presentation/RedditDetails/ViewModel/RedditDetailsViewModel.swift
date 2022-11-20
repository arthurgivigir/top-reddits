//
//  RedditDetailsViewModel.swift
//  TopReddits
//
//  Created by Arthur Givigir on 20/11/22.
//

import Foundation
import UIKit

protocol RedditDetailsViewModelInput {
    var viewControllerDelegate: RedditDetailsViewControllerDelegate? { get set }
    
    func openLink()
    func writeToPhotoAlbum(image: UIImage)
}

protocol RedditDetailsViewModelOutput {
    var message: RedditMessage { get }
}

protocol RedditDetailsViewModel: RedditDetailsViewModelInput, RedditDetailsViewModelOutput {}

final class DefaultRedditDetailsViewModel: RedditDetailsViewModel {
    let message: RedditMessage
    let imageSaver = ImageSaver()
    var viewControllerDelegate: RedditDetailsViewControllerDelegate?
    
    init(message: RedditMessage) {
        self.message = message
        setupImageSaver()
    }
    
    func openLink() {
        if let urlString = message.url, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        imageSaver.writeToPhotoAlbum(image: image)
    }
    
    func setupImageSaver() {
        imageSaver.successHandler = { [weak self] in
            self?.viewControllerDelegate?.showMessage("Success", message: "Image saved!")
        }
        
        imageSaver.errorHandler = { [weak self] error in
            self?.viewControllerDelegate?.showMessage("Error", message: "Oh no, something goes wrong!")
        }
    }
}


class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveComplete), nil)
    }

    @objc func saveComplete(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
