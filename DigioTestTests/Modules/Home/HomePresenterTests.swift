import XCTest
@testable import DigioTest

class HomePresenterTests: XCTestCase {

    // MARK: - Test Properties

    var presenter: HomePresenter!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!
    var mockView: MockHomeView!

    // MARK: - Test Lifecycle

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()
        mockView = MockHomeView()
        presenter = HomePresenter(interactor: mockInteractor, router: mockRouter)
        presenter.view = mockView
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        mockRouter = nil
        mockView = nil
        presenter = nil
        try super.tearDownWithError()
    }

    // MARK: - Test Methods

    func testViewDidLoadCallsFetchData() {
        // Given

        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(mockInteractor.fetchDataCalled)
    }

    func testDidSelectCellWithSpotlight() {
        // Given
        let spotlight = Spotlight(name: "Spotlight 1", bannerURL: "https://example.com/spotlight1", description: "Description 1")
        let model = HomeScreenModel(spotlight: [spotlight],
                                    products: [],
                                    cash: Cash(title: "", bannerURL: "", description: ""))
        presenter.didFetchData(model: model)

        // When
        presenter.didSelectCell(indexPath: IndexPath(row: 0, section: 0), section: .spotlight)

        // Then
        XCTAssertTrue(mockRouter.navigateToDetailCalled)
    }

    func testDidSelectCellWithCash() {
        // Given
        let cash = Cash(title: "Cash 1", bannerURL: "https://example.com/cash1", description: "Cash Description 1")
        presenter.didFetchData(model: HomeScreenModel(spotlight: [], products: [], cash: cash))

        // When
        presenter.didSelectCell(indexPath: IndexPath(row: 0, section: 0), section: .cash)

        // Then
        XCTAssertTrue(mockRouter.navigateToDetailCalled)
    }

    func testDidSelectCellWithProducts() {
        // Given
        let product = Product(name: "Product 1", imageURL: "https://example.com/product1", description: "Product Description 1")
        let model = HomeScreenModel(spotlight: [],
                                    products: [product],
                                    cash: Cash(title: "", bannerURL: "", description: ""))
        presenter.didFetchData(model: model)

        // When
        presenter.didSelectCell(indexPath: IndexPath(row: 0, section: 0), section: .products)

        // Then
        XCTAssertTrue(mockRouter.navigateToDetailCalled)
    }

    func testDidFetchDataUpdatesModelAndView() {
        // Given
        let spotlight = Spotlight(name: "Spotlight 1", bannerURL: "https://example.com/spotlight1", description: "Description 1")
        let model = HomeScreenModel(spotlight: [spotlight],
                                    products: [],
                                    cash: Cash(title: "", bannerURL: "", description: ""))

        // When
        presenter.didFetchData(model: model)

        // Then
        XCTAssertNotNil(mockView.updatedModel)
    }

    func testFailToFetchDataShowsErrorAlert() {
        // Given

        // When
        presenter.failToFetchData()

        // Then
        XCTAssertTrue(mockView.showErrorAlertCalled)
    }
}

// MARK: - Mock Classes

class MockHomeInteractor: HomeInteractorProtocol {
    var fetchDataCalled = false

    func fetchData() {
        fetchDataCalled = true
    }
}

class MockHomeRouter: HomeRouterProtocol {
    var navigateToDetailCalled = false

    func navigateToDetail(with viewModel: DetailScreenViewModel) {
        navigateToDetailCalled = true
    }
}

class MockHomeView: HomeViewProtocol {
    var updatedModel: HomeScreenModel?
    var showErrorAlertCalled = false

    func updateScreenWith(_ model: HomeScreenModel) {
        updatedModel = model
    }

    func showErrorAlert() {
        showErrorAlertCalled = true
    }
}
