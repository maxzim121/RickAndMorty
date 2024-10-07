import UIKit
import Kingfisher

final class CharacterScreenViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = Colors.greenViewColor?.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let name = UILabel()
        name.text = "Name:"
        name.font = UIFont(name: "Chalkduster", size: 30)
        name.textAlignment = .center
        name.textColor = Colors.greenViewColor
        return name
    }()

    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "Gender:"
        genderLabel.font = UIFont(name: "Chalkduster", size: 16)
        genderLabel.textColor = Colors.secondaryTextColor
        genderLabel.textAlignment = .center
        return genderLabel
    }()
    
    private lazy var gender: UILabel = {
        let gender = UILabel()
        gender.font = UIFont(name: "Chalkduster", size: 20)
        gender.textColor = .white
        gender.textAlignment = .center
        return gender
    }()
    
    private lazy var specieLabel: UILabel = {
        let specieLabel = UILabel()
        specieLabel.text = "Specie:"
        specieLabel.font = UIFont(name: "Chalkduster", size: 16)
        specieLabel.textColor = Colors.secondaryTextColor
        specieLabel.textAlignment = .center
        return specieLabel
    }()
    
    private lazy var specie: UILabel = {
        let specie = UILabel()
        specie.font = UIFont(name: "Chalkduster", size: 20)
        specie.textColor = .white
        specie.textAlignment = .center
        return specie
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Status:"
        statusLabel.font = UIFont(name: "Chalkduster", size: 16)
        statusLabel.textColor = Colors.secondaryTextColor
        statusLabel.textAlignment = .center
        return statusLabel
    }()
    
    private lazy var status: UILabel = {
        let status = UILabel()
        status.font = UIFont(name: "Chalkduster", size: 20)
        status.textColor = .white
        status.textAlignment = .center
        return status
    }()
    
    private lazy var originLabel: UILabel = {
        let originLabel = UILabel()
        originLabel.text = "Origin:"
        originLabel.font = UIFont(name: "Chalkduster", size: 16)
        originLabel.textColor = Colors.secondaryTextColor
        originLabel.textAlignment = .center
        return originLabel
    }()
    
    private lazy var origin: UILabel = {
        let origin = UILabel()
        origin.font = UIFont(name: "Chalkduster", size: 20)
        origin.textColor = .white
        origin.textAlignment = .center
        return origin
    }()
    
    private lazy var lastLocationLabel: UILabel = {
        let lastLocationLabel = UILabel()
        lastLocationLabel.text = "Last seen:"
        lastLocationLabel.font = UIFont(name: "Chalkduster", size: 16)
        lastLocationLabel.textColor = Colors.secondaryTextColor
        lastLocationLabel.textAlignment = .center
        return lastLocationLabel
    }()
    
    private lazy var lastLocation: UILabel = {
        let lastLocation = UILabel()
        lastLocation.font = UIFont(name: "Chalkduster", size: 20)
        lastLocation.textColor = .white
        lastLocation.textAlignment = .center
        return lastLocation
    }()
    
    private lazy var genderStackView: UIStackView = {
        var genderStackView = UIStackView()
        genderStackView.axis = .vertical
        genderStackView.spacing = 5
        genderStackView.addArrangedSubview(genderLabel)
        genderStackView.addArrangedSubview(gender)
        return genderStackView
    }()
    
    private lazy var statusStackView: UIStackView = {
        var statusStackView = UIStackView()
        statusStackView.axis = .vertical
        statusStackView.spacing = 5
        statusStackView.addArrangedSubview(statusLabel)
        statusStackView.addArrangedSubview(status)
        return statusStackView
    }()
    
    private lazy var specieStackView: UIStackView = {
        var specieStackView = UIStackView()
        specieStackView.axis = .vertical
        specieStackView.spacing = 5
        specieStackView.addArrangedSubview(specieLabel)
        specieStackView.addArrangedSubview(specie)
        return specieStackView
    }()
    
    private lazy var originStackView: UIStackView = {
        var originStackView = UIStackView()
        originStackView.axis = .vertical
        originStackView.spacing = 5
        originStackView.addArrangedSubview(originLabel)
        originStackView.addArrangedSubview(origin)
        return originStackView
    }()
    
    private lazy var lastLocationStackView: UIStackView = {
        var lastLocationStackView = UIStackView()
        lastLocationStackView.axis = .vertical
        lastLocationStackView.spacing = 5
        lastLocationStackView.addArrangedSubview(lastLocationLabel)
        lastLocationStackView.addArrangedSubview(lastLocation)
        return lastLocationStackView
    }()

    
    private lazy var backButton: UILabel = {
        let backButton = UILabel()
        backButton.text = "← Characters"
        backButton.font = UIFont(name: "Chalkduster", size: 16)
        backButton.textColor = .white
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backButtonTapped)))
        return backButton
    }()
    
    private lazy var greenSeparator: UIView = {
        let greenSeparator = UIView()
        greenSeparator.backgroundColor = Colors.greenViewColor
        return greenSeparator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Colors.mainScreenBackgroundColor
        setupConstraints()
        setupComponents(item: mockCharacter)
        
    }
    
    func setupConstraints() {
        [imageView, name, statusStackView, specieStackView, genderStackView, backButton, greenSeparator, lastLocationStackView, originStackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            imageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            name.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
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
            greenSeparator.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 10),
            greenSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            originStackView.topAnchor.constraint(equalTo: greenSeparator.bottomAnchor, constant: 10),
            originStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            originStackView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            
            lastLocationStackView.topAnchor.constraint(equalTo: greenSeparator.bottomAnchor, constant: 10),
            lastLocationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastLocationStackView.leadingAnchor.constraint(equalTo: originStackView.trailingAnchor)
        ])
    }
    
    func setupComponents(item: CharacterResponseStruct) {
        name.text = item.name
        guard let url = URL(string: item.image) else { return }
        imageView.kf.setImage(with: url)
        gender.text = item.gender
        status.text = item.status
        specie.text = item.species
        origin.text = item.origin.name
        lastLocation.text = item.location.name
    }
    
    
    
    @objc func backButtonTapped() {
        
    }
    
}
