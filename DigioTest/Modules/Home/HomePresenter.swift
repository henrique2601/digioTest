import Foundation

class HomePresenter {

    // MARK: Private Properties

    weak var view: HomeViewProtocol?
    private var interactor: HomeInteractorProtocol
    private var router: HomeRouterProtocol
    private var model: HomeScreenModel?

    // MARK: Public Properties

    // MARK: Inicialization

    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Methods of HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        interactor.fetchData()
    }

    func didSelectCell(indexPath: IndexPath, section: HomeSection?) {
        guard let section = section else {
            return
        }

        switch section {
        case .spotlight:
            guard let spotlight = model?.spotlight[indexPath.row] else {
                return
            }
            showDetail(for: spotlight)
        case .cash:
            guard let cash = model?.cash else {
                return
            }
            showDetail(for: cash)
        case .products:
            guard let product = model?.products[indexPath.row] else {
                return
            }
            showDetail(for: product)
        }
    }

    private func showDetail(for spotlight: Spotlight) {
        let detailViewModel = DetailScreenViewModel(title: spotlight.name, imageURL: spotlight.bannerURL, description: spotlight.description)
        router.navigateToDetail(with: detailViewModel)
    }

    private func showDetail(for cash: Cash) {
        let detailViewModel = DetailScreenViewModel(title: cash.title, imageURL: cash.bannerURL, description: cash.description)
        router.navigateToDetail(with: detailViewModel)
    }

    private func showDetail(for product: Product) {
        let detailViewModel = DetailScreenViewModel(title: product.name, imageURL: product.imageURL, description: product.description)
        router.navigateToDetail(with: detailViewModel)
    }
}

// MARK: Methods of HomeInteractorOutputProtocol

extension HomePresenter: HomeInteractorOutputProtocol {
    func didFetchData(model: HomeScreenModel) {
        self.model = model
        view?.updateScreenWith(model)
    }

    func failToFetchData() {
        view?.showErrorAlert()
    }
}
