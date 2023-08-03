import UIKit

class DetailRouter {

    // MARK: Private Properties

    private weak var viewController: UIViewController?

    // MARK: Static methods

    static func configuredViewController(viewModel: DetailScreenViewModel) -> UIViewController {
        let router = DetailRouter()
        let interactor = DetailInteractor()

        let presenter = DetailPresenter(
            interactor: interactor,
            router: router
        )

        let viewController = DetailViewController(
            presenter: presenter,
            viewModel: viewModel
        )

        router.viewController = viewController
        presenter.view = viewController
        interactor.output = presenter

        return viewController
    }
}

// MARK: Methods of DetailRouterProtocol

extension DetailRouter: DetailRouterProtocol {
}
