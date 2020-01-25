import UIKit

class ImageView: UIImageView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImage(){
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
    }
}
