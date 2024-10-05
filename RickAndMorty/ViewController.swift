//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maksim Zimens on 03.10.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Проверка сервиса
    
    let network = NetworkClient.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPage()
        fetchCharacter()
        
    }
    
    func fetchPage() {
        network.fetchPage(pageId: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                assertionFailure("\(error)")
            }
        }
    }
    
    func fetchCharacter() {
        network.fetchCharacter(id: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                assertionFailure("\(error)")
            }
        }
    }

}

