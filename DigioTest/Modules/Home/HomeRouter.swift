import UIKit

class HomeRouter {

    // MARK: Private Properties

    private weak var viewController: UIViewController?

    // MARK: Static methods

    static func configuredViewController() -> UIViewController {
        let router = HomeRouter()
        let interactor = HomeInteractor()

        let presenter = HomePresenter(
            interactor: interactor,
            router: router
        )

        let viewController = HomeViewController(
            presenter: presenter
        )

        let navigationController = UINavigationController(rootViewController: viewController)

        router.viewController = viewController
        presenter.view = viewController
        interactor.output = presenter

        return navigationController
    }
}

// MARK: Methods of HomeRouterProtocol

extension HomeRouter: HomeRouterProtocol {
    func navigateToDetail(with viewModel: DetailScreenViewModel) {
        let detailViewController = DetailRouter.configuredViewController(viewModel: viewModel)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
