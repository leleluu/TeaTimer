import UIKit

class TeaCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var teaNameLabel = UILabel()
    
    private func setupViews() {
        contentView.backgroundColor = .systemYellow

        // TeaNameLabel
        contentView.addSubview(teaNameLabel)
        teaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teaNameLabel.textColor = .white
        teaNameLabel.textAlignment = .center
        teaNameLabel.numberOfLines = 2

        // Constraints
        NSLayoutConstraint.activate([
            teaNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            teaNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            teaNameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 8),
            teaNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
