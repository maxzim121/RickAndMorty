//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Maksim Zimens on 03.10.2024.
//

import UIKit

final class MainScreenViewController: UIViewController {

    private lazy var mainLabel: UILabel = {
        
        var mainLabel = UILabel()
        mainLabel.font = UIFont(name: "Chalkduster", size: 16)
        mainLabel.textColor = .white
        mainLabel.text = "Rick&Morty"
        return mainLabel
    }()
    
    private lazy var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        var mainCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollection.isScrollEnabled = true
        mainCollection.backgroundColor = .clear
        mainCollection.register(MainScreenViewCell.self, forCellWithReuseIdentifier: "MainScreenViewCell")
        return mainCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollection.dataSource = self
        mainCollection.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Colors.mainScreenBackgroundColor
        setupConstraints()
    }
    
    private func setupConstraints() {
        [mainLabel, mainCollection].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
            
            NSLayoutConstraint.activate([
                mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                mainCollection.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
                mainCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mainCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                mainCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }

}

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainScreenViewCell", for: indexPath) as? MainScreenViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCellContent(item: mockResults[indexPath.row])
        return cell
    }

}

extension MainScreenViewController: UICollectionViewDelegate {
    
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 150)
    }
}
