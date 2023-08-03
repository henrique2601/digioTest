import Foundation

class HomeInteractor {

    // MARK: Private Properties

    weak var output: HomeInteractorOutputProtocol?
    var dataSource: HomeDataSourceProtocol = HomeDataSource()
}

// MARK: Methods of HomeInteractorProtocol

extension HomeInteractor: HomeInteractorProtocol {

    func fetchData() {
        dataSource.fetchHomeData { [weak self] result in
            switch result {
            case .success(let homeScreenModel):
                self?.output?.didFetchData(model: homeScreenModel)
            case .failure(_):
                self?.output?.failToFetchData()
            }
        }
    }
}
