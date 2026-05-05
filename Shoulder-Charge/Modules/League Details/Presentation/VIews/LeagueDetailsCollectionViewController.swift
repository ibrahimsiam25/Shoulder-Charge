import UIKit
import SDWebImage


class LeagueDetailsCollectionViewController: UICollectionViewController, LeagueDetailsViewProtocol {


    static let reuseIdentifierFinished    = "finishedCell"
    static let reuseIdentifierUpComing    = "upcomingCell"
    static let reuseIdentifierParticipant = "LeagueParticipantCollectionViewCell"
    static let containerReuseIdentifier   = "FinishedEventsContainerCell"
    static let headerReuseIdentifier      = "SectionHeaderView"

   
    var presenter: LeagueDetailsPresenterProtocol!
    var isDataLoaded = false

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
    }

    private func setupUI() {
        setupCells()
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        setupLoadingIndicator()
    }

    private func setupNavigationBar() {
        let appearance = LocalizationManager.shared.makeNavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Primary") ?? UIColor.systemGreen,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary") ?? .systemGreen
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 15
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.sd_setImage(with: presenter.getLeagueLogo(), placeholderImage: UIImage(named: "LeagueLogo"))

        let titleLabel = UILabel()
        titleLabel.text = presenter.getLeagueName()
        titleLabel.textColor = UIColor(named: "Primary") ?? .systemGreen
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(stack)

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 30),
            logoImageView.heightAnchor.constraint(equalToConstant: 30),
            stack.topAnchor.constraint(equalTo: containerView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        navigationItem.titleView = containerView
        navigationItem.backButtonDisplayMode = .minimal
        updateFavoriteButton()
    }

    private func updateFavoriteButton() {
        let isFav = presenter.isFavoriteLeague()
        let imageName = isFav ? "star.fill" : "star"
        let color: UIColor = isFav ? (UIColor(named: "Primary") ?? .systemYellow) : .gray
        
        let favoriteBtn = UIBarButtonItem(
            image: UIImage(systemName: imageName),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
        favoriteBtn.tintColor = color
        navigationItem.rightBarButtonItem = favoriteBtn
    }

    @objc private func favoriteTapped() {
        presenter.toggleFavorite()
        updateFavoriteButton()
        
   
        UIView.animate(withDuration: 0.15, animations: {
            self.navigationItem.rightBarButtonItem?.customView?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.navigationItem.rightBarButtonItem?.customView?.transform = .identity
            }
        })
    }
  
    private func setupCells() {
        collectionView.register(UINib(nibName: "UpComingEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Self.reuseIdentifierUpComing)
        collectionView.register(UINib(nibName: "FinishedEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Self.reuseIdentifierFinished)
        collectionView.register(UINib(nibName: "LeagueParticipantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Self.reuseIdentifierParticipant)
        collectionView.register(FinishedEventsContainerCell.self, forCellWithReuseIdentifier: Self.containerReuseIdentifier)
        
        collectionView.register(SectionHeaderView.self, 
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, 
                              withReuseIdentifier: Self.headerReuseIdentifier)
    }

    private func setupLoadingIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


    func reloadData() {
        isDataLoaded = true
        collectionView.reloadData()
    }

    func toggleLoading(_ val: Bool) {
        val ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        collectionView.isUserInteractionEnabled = !val
    }
}
