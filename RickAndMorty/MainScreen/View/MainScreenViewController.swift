import UIKit

final class MainScreenViewController: UIViewController, UICollectionViewDelegate {
    
    let viewModel: MainScreenViewModel
    
    // MARK: - UI components
    
    private lazy var loadingLabel = UILabel.createCustomLabel(
        text: "Loading...",
        fontSize: 30,
        textColor: Colors.greenViewColor
    )

    private lazy var mainLabel = UILabel.createCustomLabel(
        text: "Rick&Morty",
        fontSize: 16,
        textColor: Colors.greenViewColor
    )
    
    private lazy var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.footerReferenceSize = CGSize(width: view.frame.size.width - 32, height: 60)
        var mainCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCollection.isUserInteractionEnabled = true
        mainCollection.isScrollEnabled = true
        mainCollection.backgroundColor = .clear
        mainCollection.register(MainScreenViewCell.self, forCellWithReuseIdentifier: "MainScreenViewCell")
        return mainCollection
    }()
    
    // MARK: - Initialisation
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollection.dataSource = self
        mainCollection.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Colors.mainScreenBackgroundColor
        setupConstraints()
        setupBindings()
        viewModel.fetchPage()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        [mainLabel, mainCollection, loadingLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
            
            NSLayoutConstraint.activate([
                mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                mainCollection.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
                mainCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mainCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                mainCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    private func setupBindings() {
        viewModel.onDataLoaded = { [weak self] items in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loadingLabel.isHidden = true
                self.mainCollection.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showError(errorMessage)
            }
        }
        
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Network error", message: "Check your connection and try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.viewModel.fetchPage()
        })
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - UICollectionViewDataSource
 
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.countItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainScreenViewCell", for: indexPath) as? MainScreenViewCell else {
            return UICollectionViewCell()
        }
        if let item = viewModel.getItem(at: indexPath.row) {
            cell.setupCellContent(item: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.nextPage(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MainScreenViewCell,
              let characterId = cell.characterId else { return }
        viewModel.showCharacter(id: characterId)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 150)
    }
}
