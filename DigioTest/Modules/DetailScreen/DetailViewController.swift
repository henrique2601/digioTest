import UIKit

class DetailViewController: UIViewController {

    // MARK: Private Properties

    private let presenter: DetailPresenterProtocol
    private let screen = DetailScreen()
    private let viewModel: DetailScreenViewModel

    // MARK: Inicialization

    init(presenter: DetailPresenterProtocol, viewModel: DetailScreenViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle Methods

    override func loadView() {
        super.loadView()
        view = screen

        screen.titleLabel.text = viewModel.title
        screen.descriptionLabel.text = viewModel.description
        loadImage()
    }

    func loadImage() {
        guard let url = URL(string: viewModel.imageURL) else { return }

        ImageDownloader.shared.downloadImage(from: url, completion: { [weak self] image, _ in
            self?.screen.imageView.image = image
        })
    }
}

// MARK: Methods of DetailScreenDelegate

extension DetailViewController: DetailScreenDelegate {
}

// MARK: Methods of DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
}
