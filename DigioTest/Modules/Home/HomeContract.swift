import Foundation

// MARK: View Output (Screen -> View)
protocol HomeScreenDelegate: AnyObject {
}

// MARK: View Output (Presenter -> View)
protocol HomeViewProtocol: AnyObject {
    func updateScreenWith(_ model: HomeScreenModel)
    func showErrorAlert()
}

// MARK: View Input (View -> Presenter)
protocol HomePresenterProtocol: AnyObject {

    func viewDidLoad()
    func didSelectCell(indexPath: IndexPath, section: HomeSection?)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol HomeInteractorProtocol: AnyObject {
    func fetchData()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol HomeInteractorOutputProtocol: AnyObject {
    func didFetchData(model: HomeScreenModel)
    func failToFetchData()
}

// MARK: Router Input (Presenter -> Router)
protocol HomeRouterProtocol: AnyObject {
    func navigateToDetail(with viewModel: DetailScreenViewModel)
}
