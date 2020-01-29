import UIKit

class GamesCell: UICollectionViewCell {
    
    static let reuseID = "GamesCell"
    let gameImage = ImageView(frame: .zero)
    let gameLabel = Label(textAligment: .center, fontSize: 16)
    var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureContainerView()
        configureGamesCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerView(){
        addSubview(containerView)
        
        containerView.backgroundColor = .systemGray5
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func configureGamesCell(){
        
        containerView.addSubview(gameImage)
        containerView.addSubview(gameLabel)
        
        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            gameImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            gameImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            gameImage.heightAnchor.constraint(equalTo: gameImage.widthAnchor),
            
            gameLabel.topAnchor.constraint(equalTo: gameImage.bottomAnchor, constant: 12),
            gameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            gameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            gameLabel.heightAnchor.constraint(equalToConstant: 20)
            
            
        ])
    }
}
