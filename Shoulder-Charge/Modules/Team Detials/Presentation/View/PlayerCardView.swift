import UIKit

@IBDesignable
class PlayerCardView: UIView {


    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var playerImageView: UIImageView!
    @IBOutlet private weak var borderImageContainer: UIView!
    @IBOutlet private weak var playerNumberLabel: UILabel!
    @IBOutlet private weak var playerNameLabel: UILabel!
    @IBOutlet private weak var playerPositionLabel: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        let nib = UINib(nibName: "PlayerCardView", bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        setupUI()
    }


    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

      
        borderImageContainer.backgroundColor = .clear
        borderImageContainer.layer.cornerRadius = borderImageContainer.bounds.width / 2
        borderImageContainer.layer.borderWidth = 3
        borderImageContainer.layer.borderColor = UIColor(named: "Primary")?.cgColor
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0).cgColor
        borderImageContainer.clipsToBounds = false

        borderImageContainer.layer.shadowColor = UIColor(named: "Primary")?.cgColor
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0).cgColor
        borderImageContainer.layer.shadowRadius = 8
        borderImageContainer.layer.shadowOpacity = 0.8
        borderImageContainer.layer.shadowOffset = .zero

     
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        playerImageView.layer.cornerRadius = playerImageView.bounds.width / 2
        playerImageView.backgroundColor = UIColor(white: 0.15, alpha: 1)


        playerNumberLabel.font = UIFont.boldSystemFont(ofSize: 13)
        playerNumberLabel.textColor = .black
        playerNumberLabel.textAlignment = .center
        playerNumberLabel.backgroundColor = UIColor(named: "Primary")
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0)
        playerNumberLabel.layer.cornerRadius = playerNumberLabel.bounds.width / 2
        playerNumberLabel.clipsToBounds = true

        playerNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        playerNameLabel.textColor = .white
        playerNameLabel.textAlignment = .center
        playerNameLabel.numberOfLines = 1


        playerPositionLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        playerPositionLabel.textColor = UIColor(named: "Primary")
            ?? UIColor(red: 0.2, green: 1.0, blue: 0.2, alpha: 1.0)
        playerPositionLabel.textAlignment = .center
        playerPositionLabel.numberOfLines = 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        borderImageContainer.layer.cornerRadius = borderImageContainer.bounds.width / 2
        playerImageView.layer.cornerRadius = playerImageView.bounds.width / 2
        playerNumberLabel.layer.cornerRadius = playerNumberLabel.bounds.height / 2
    }

   
    func config(
        imageURL: String?,
        playerName: String?,
        playerPosition: String?,
        playerNumber: Int?
    ) {

        if let urlString = imageURL, let url = URL(string: urlString) {
            loadImage(from: url)
        } else {
            playerImageView.image = nil
        }


        if let name = playerName, !name.isEmpty {
            playerNameLabel.text = name.uppercased()
            playerNameLabel.isHidden = false
        } else {
            playerNameLabel.isHidden = true
        }


        if let position = playerPosition, !position.isEmpty {
            playerPositionLabel.text = position.uppercased()
            playerPositionLabel.isHidden = false
        } else {
            playerPositionLabel.isHidden = true
        }

     
        if let number = playerNumber {
            playerNumberLabel.text = "\(number)"
            playerNumberLabel.isHidden = false
        } else {
            playerNumberLabel.isHidden = true
        }
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self, let data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                UIView.transition(with: self.playerImageView,
                                  duration: 0.25,
                                  options: .transitionCrossDissolve) {
                    self.playerImageView.image = image
                }
            }
        }.resume()
    }
}
