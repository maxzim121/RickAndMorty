import UIKit
import Kingfisher

final class CharacterScreenViewController: UIViewController {
    
    var viewModel: CharacterScreenViewModel
    
    // MARK: - UI components
    
    private lazy var loadingLabel = UILabel.createCustomLabel(
        text: "Loading...",
        fontSize: 30,
        textColor: Colors.greenViewColor
    )
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = Colors.greenViewColor?.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private lazy var name = UILabel.createCustomLabel(
        fontSize: 30,
        textColor: Colors.greenViewColor
    )
    
    private lazy var genderLabel = UILabel.createCustomLabel(
        text: "Gender:",
        fontSize: 16,
        textColor: Colors.secondaryTextColor
    )
    
    private lazy var gender = UILabel.createCustomLabel(
        fontSize: 18,
        textColor: .white
    )
    
    private lazy var specieLabel = UILabel.createCustomLabel(
        text: "Specie:",
        fontSize: 16,
        textColor: Colors.secondaryTextColor
    )
    
    private lazy var specie = UILabel.createCustomLabel(
        fontSize: 18,
        textColor: .white
    )
    
    private lazy var statusLabel = UILabel.createCustomLabel(
        text: "Status:",
        fontSize: 16,
        textColor: Colors.secondaryTextColor
    )
    
    private lazy var status = UILabel.createCustomLabel(
        fontSize: 18,
        textColor: .white
    )
    
    private lazy var originLabel = UILabel.createCustomLabel(
        text: "Origin:",
        fontSize: 16,
        textColor: Colors.secondaryTextColor
    )
    
    private lazy var origin = UILabel.createCustomLabel(
        fontSize: 16,
        textColor: .white
    )
    
    private lazy var lastLocationLabel = UILabel.createCustomLabel(
        text: "Last seen:",
        fontSize: 16,
        textColor: Colors.secondaryTextColor
    )
    
    private lazy var lastLocation = UILabel.createCustomLabel(
        fontSize: 16,
        textColor: .white
    )
    
    private lazy var genderStackView = UIStackView.createCustomStack(views: [genderLabel, gender])
    private lazy var statusStackView = UIStackView.createCustomStack(views: [statusLabel, status])
    private lazy var specieStackView = UIStackView.createCustomStack(views: [specieLabel, specie])
    private lazy var originStackView = UIStackView.createCustomStack(views: [originLabel, origin])
    private lazy var lastLocationStackView = UIStackView.createCustomStack(views: [lastLocationLabel, lastLocation])

    private lazy var backButton: UILabel = {
        let backButton = UILabel()
        backButton.text = "← Characters"
        backButton.isUserInteractionEnabled = true
        backButton.font = UIFont(name: "Chalkduster", size: 16)
        backButton.textColor = .white
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.addGestureRecognizer(recognizer)
        return backButton
    }()
    
    private lazy var greenSeparator: UIView = {
        let greenSeparator = UIView()
        greenSeparator.backgroundColor = Colors.greenViewColor
        return greenSeparator
    }()
    
    // MARK: - Initialisation
    
    init(viewModel: CharacterScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Colors.mainScreenBackgroundColor
        setupConstraints()
        binding()
        viewModel.fetchCharacter()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        [imageView, name, statusStackView, specieStackView, genderStackView, backButton, greenSeparator, lastLocationStackView, originStackView, loadingLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isHidden = true
        }
        [backButton, loadingLabel].forEach {$0.isHidden = false}
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            name.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            name.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            
            genderStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            genderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genderStackView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16 + (view.frame.width - 32)/3),
            
            specieStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            specieStackView.leadingAnchor.constraint(equalTo: genderStackView.trailingAnchor),
            specieStackView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16 + (view.frame.width - 32)/3*2),
            
            statusStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            statusStackView.leadingAnchor.constraint(equalTo: specieStackView.trailingAnchor),
            statusStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            greenSeparator.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            greenSeparator.heightAnchor.constraint(equalToConstant: 1),
            greenSeparator.topAnchor.constraint(equalTo: specieStackView.bottomAnchor, constant: 10),
            greenSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            originStackView.topAnchor.constraint(equalTo: greenSeparator.bottomAnchor, constant: 10),
            originStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            originStackView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            
            lastLocationStackView.topAnchor.constraint(equalTo: greenSeparator.bottomAnchor, constant: 10),
            lastLocationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastLocationStackView.leadingAnchor.constraint(equalTo: originStackView.trailingAnchor, constant: 5)
        ])
    }
    
    private func setupComponents(item: CharacterResponseStruct) {
        name.adjustsFontSizeToFitWidth = true
        name.numberOfLines = 1
        name.text = item.name
        guard let url = URL(string: item.image) else { return }
        imageView.kf.setImage(with: url)
        gender.text = item.gender
        status.text = item.status
        specie.text = item.species
        origin.text = item.origin.name
        lastLocation.text = item.location.name
        
        [imageView, name, statusStackView, specieStackView, genderStackView, greenSeparator, lastLocationStackView, originStackView].forEach {
            $0.layoutIfNeeded()
            $0.isHidden = false
        }
        loadingLabel.isHidden = true
    }
    
    private func binding() {
        viewModel.onDataLoaded = { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setupComponents(item: result)
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
        let alert = UIAlertController(title: "Could not load character information.", message: "Check your connection and try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.viewModel.fetchCharacter()
        })
        alert.addAction(UIAlertAction(title: "Back to list", style: .default) { [weak self] _ in
            self?.viewModel.backButtonTapped()
        })
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Objc methods
    
    @objc private func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
}
