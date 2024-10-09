import UIKit
import Kingfisher

final class MainScreenViewCell: UICollectionViewCell {
    
    // MARK: - Private variables
    
    private(set) var characterId: Int?
    
    // MARK: - UI components
    
    private lazy var nameLabel = UILabel.createCustomLabel(
        fontSize: 20,
        textColor: .white,
        alignment: .left
    )
    
    private lazy var genderLabel = UILabel.createCustomLabel(
        fontSize: 16,
        textColor: .white,
        alignment: .left
    )
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    private lazy var greenView: UIView = {
        var greenView = UIView()
        greenView.backgroundColor = Colors.greenViewColor
        return greenView
    }()
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterId = nil
        imageView.image = nil
        nameLabel.text = nil
        genderLabel.text = nil
    }
    
    // MARK: - Initialisation
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = Colors.collectionViewColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        [nameLabel, imageView, genderLabel, greenView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            greenView.widthAnchor.constraint(equalToConstant: 5),
            greenView.topAnchor.constraint(equalTo: imageView.topAnchor),
            greenView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            greenView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height/3),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            genderLabel.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentView.frame.height/3),
            genderLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            genderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public methods
    
    func setupCellContent(item: Results) {
        characterId = item.id
        nameLabel.text = item.name
        genderLabel.text = item.gender
        guard let url = URL(string: item.image) else { return }
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
}
