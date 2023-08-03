import Foundation

// MARK: View Output (Screen -> View)
protocol DetailScreenDelegate: AnyObject {
}

// MARK: View Output (Presenter -> View)
protocol DetailViewProtocol: AnyObject {
}

// MARK: View Input (View -> Presenter)
protocol DetailPresenterProtocol: AnyObject {
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol DetailInteractorProtocol: AnyObject {
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol DetailInteractorOutputProtocol: AnyObject {
}

// MARK: Router Input (Presenter -> Router)
protocol DetailRouterProtocol: AnyObject {
}
