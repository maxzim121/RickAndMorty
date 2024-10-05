//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maksim Zimens on 03.10.2024.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Проверка сервиса
    
    var coordinator: MainScreenCoordinator
    
    let network = NetworkClient.shared
    
    var timer: Timer?
    
    init(coordinator: MainScreenCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
//        fetchPage()
//        fetchCharacter()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ [weak self] _ in
            self?.coordinator.showNextScreen()}
    }
    
    func fetchPage() {
        network.fetchPage(pageId: 1) { [weak self] result in
            guard self != nil else { return }
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
            guard self != nil else { return }
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                assertionFailure("\(error)")
            }
        }
    }

}

