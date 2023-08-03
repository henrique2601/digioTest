import XCTest
@testable import DigioTest

class HomeInteractorTests: XCTestCase {

    var sut: HomeInteractor!
    var mockOutput: MockHomeInteractorOutput!
    var mockDataSource: MockHomeDataSource!

    override func setUp() {
        super.setUp()
        sut = HomeInteractor()
        mockOutput = MockHomeInteractorOutput()
        mockDataSource = MockHomeDataSource()
        sut.output = mockOutput
        sut.dataSource = mockDataSource
    }

    override func tearDown() {
        sut = nil
        mockOutput = nil
        mockDataSource = nil
        super.tearDown()
    }

    // MARK: - Test Methods

    func testFetchData_Success() {
        // Given
        let expectedModel = HomeScreenModel(spotlight: [],
                                            products: [],
                                            cash: Cash(title: "", bannerURL: "", description: ""))
        mockDataSource.fetchedHomeData = expectedModel

        // When
        sut.fetchData()

        // Then
        XCTAssertTrue(mockOutput.didFetchDataCalled)
        XCTAssertFalse(mockOutput.failToFetchDataCalled)
        XCTAssertEqual(mockOutput.homeScreenModel, expectedModel)
    }

    func testFetchData_Failure() {
        // Given
        mockDataSource.shouldReturnError = true

        // When
        sut.fetchData()

        // Then
        XCTAssertFalse(mockOutput.didFetchDataCalled)
        XCTAssertTrue(mockOutput.failToFetchDataCalled)
        XCTAssertNil(mockOutput.homeScreenModel)
    }
}

// MARK: - Mock Classes

class MockHomeInteractorOutput: HomeInteractorOutputProtocol {
    var didFetchDataCalled = false
    var failToFetchDataCalled = false
    var homeScreenModel: HomeScreenModel?

    func didFetchData(model: HomeScreenModel) {
        didFetchDataCalled = true
        homeScreenModel = model
    }

    func failToFetchData() {
        failToFetchDataCalled = true
    }
}

class MockHomeDataSource: HomeDataSourceProtocol {
    var shouldReturnError = false
    var fetchedHomeData = HomeScreenModel(
        spotlight: [],
        products: [],
        cash: Cash(title: "", bannerURL: "", description: "")
    )

    func fetchHomeData(completion: @escaping (Result<HomeScreenModel, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: 500, userInfo: nil)))
        } else {
            completion(.success(fetchedHomeData))
        }
    }
}
