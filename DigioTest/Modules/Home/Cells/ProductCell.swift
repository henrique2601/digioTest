import UIKit

class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    private var indexPath: IndexPath?

    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    private let shadowLayer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.4
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(shadowLayer)
        addSubview(container)
        container.addSubview(imageView)

        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(4)
        }

        shadowLayer.snp.makeConstraints { make in
            make.edges.equalTo(container)
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }

    func configure(imageURL: URL, indexPath: IndexPath) {
        self.indexPath = indexPath

        ImageDownloader.shared.downloadImage(from: imageURL, indexPath: indexPath) { [weak self] downloadedImage, downloadedIndexPath in
            guard let self = self, self.indexPath == downloadedIndexPath else {
                return // Cell has been reused, ignore the downloaded image
            }

            self.imageView.image = downloadedImage
        }
    }
}
