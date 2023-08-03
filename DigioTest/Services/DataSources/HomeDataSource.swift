import Foundation

protocol HomeDataSourceProtocol {
    func fetchHomeData(completion: @escaping (Result<HomeScreenModel, Error>) -> Void)
}

class HomeDataSource: HomeDataSourceProtocol {
    func fetchHomeData(completion: @escaping (Result<HomeScreenModel, Error>) -> Void) {
        let url = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products")!
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let homeScreenModel = try decoder.decode(HomeScreenModel.self, from: data)
                completion(.success(homeScreenModel))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
