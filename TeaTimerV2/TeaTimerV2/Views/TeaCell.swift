import UIKit

class TeaCell: UICollectionViewCell {

    // MARK: Properties

    var teaNameLabel = UILabel()
    var teaImageView = UIImageView(image: UIImage(named: "teacup"))

    // MARK: Initialiser
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: Private methods

    private func setupViews() {

        contentView.backgroundColor = .systemYellow

        // Tea name label
        contentView.addSubview(teaNameLabel)
        teaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teaNameLabel.textColor = .white
        teaNameLabel.textAlignment = .center
        
        // Tea imageview
        contentView.addSubview(teaImageView)
        teaImageView.translatesAutoresizingMaskIntoConstraints = false
        teaImageView.contentMode = .scaleAspectFit

        // Constraints
        NSLayoutConstraint.activate([
            teaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            teaImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            teaImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            teaImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            teaImageView.bottomAnchor.constraint(equalTo: teaNameLabel.topAnchor, constant: -8),
            teaNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            teaNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            teaNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
