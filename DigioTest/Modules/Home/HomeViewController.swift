import UIKit

class HomeViewController: UIViewController {

    // MARK: Private Properties

    private let presenter: HomePresenterProtocol
    private let screen = HomeScreen()
    var homeScreenModel: HomeScreenModel?

    // MARK: Inicialization

    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle Methods

    override func loadView() {
        super.loadView()
        view = screen
        screen.delegate = self
        screen.collectionView.delegate = self
        screen.collectionView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        let backItem = UIBarButtonItem()
        backItem.title = "Voltar"
        navigationItem.backBarButtonItem = backItem
    }
}

// MARK: Methods of HomeScreenDelegate

extension HomeViewController: HomeScreenDelegate {
}

// MARK: Methods of HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func updateScreenWith(_ model: HomeScreenModel) {
        homeScreenModel = model
        DispatchQueue.main.async { [weak self] in
            self?.screen.collectionView.reloadData()
        }
    }

    func showErrorAlert() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Erro", message: "Não foi possível baixar os dados. Verifique sua conexão de internet e tente novamente.", preferredStyle: .alert)
            let tryAgainAction = UIAlertAction(title: "Tentar Novamente", style: .default) { [weak self] _ in
                self?.presenter.viewDidLoad()
            }
            alert.addAction(tryAgainAction)
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCell.identifier, for: indexPath) as? SectionCell,
              let section = HomeSection(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.configureWith(homeScreenModel, section: section)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = HomeSection(rawValue: indexPath.section)
        let width = collectionView.bounds.width
        return CGSize(width: width, height: section?.height ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: section > 0 ? 40 : 0)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView,
            kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        switch indexPath.section {
        case HomeSection.cash.rawValue:
            // Texto a ser formatado
            let text = "digio Cash"
            let attributedString = NSMutableAttributedString(string: text)
            let grayAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
            let cashRange = (text as NSString).range(of: "Cash")
            attributedString.addAttributes(grayAttributes, range: cashRange)
            headerView.titleLabel.attributedText = attributedString
        case HomeSection.products.rawValue:
            headerView.titleLabel.text = "Produtos"
        default:
            headerView.titleLabel.text = ""
        }

        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0) // Adjust the insets as needed
    }
}

extension HomeViewController: SectionCellDelegate {
    func didSelectCell(indexPath: IndexPath, section: HomeSection?) {
        presenter.didSelectCell(indexPath: indexPath, section: section)
    }
}
