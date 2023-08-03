import Foundation

class DetailPresenter {

    // MARK: Private Properties

    weak var view: DetailViewProtocol?
    private var interactor: DetailInteractorProtocol
    private var router: DetailRouterProtocol

    // MARK: Public Properties


    // MARK: Inicialization

    init(interactor: DetailInteractorProtocol, router: DetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Methods of DetailPresenterProtocol

extension DetailPresenter: DetailPresenterProtocol {
}

// MARK: Methods of DetailInteractorOutputProtocol

extension DetailPresenter: DetailInteractorOutputProtocol {
}
