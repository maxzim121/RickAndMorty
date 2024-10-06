import UIKit
import Kingfisher

final class MainScreenViewCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "Chalkduster", size: 20)
        nameLabel.textColor = .white
        return nameLabel
    }()
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    private lazy var greenView: UIView = {
        var greenView = UIView()
        greenView.backgroundColor = Colors.greenViewColor
        return greenView
    }()
    
    private lazy var genderLabel: UILabel = {
        var genderLabel = UILabel()
        genderLabel.numberOfLines = 0
        genderLabel.font = UIFont(name: "Chalkduster", size: 16)
        genderLabel.textColor = .white
        return genderLabel
    }()
    
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
    
    func setupConstraints() {
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
    
    func setupCellContent(item: Results) {
        nameLabel.text = item.name
        genderLabel.text = item.gender
        guard let url = URL(string: item.image) else { return }
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url) { result in
            switch result {
            case .success(let image):
                print(image)
            case .failure(let error):
                print(error)            }
        }
    }
}
