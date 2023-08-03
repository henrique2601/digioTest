import UIKit

protocol SectionCellDelegate {
    func didSelectCell(indexPath: IndexPath, section: HomeSection?)
}

class SectionCell: UICollectionViewCell {
    static let identifier = "SectionCell"

    private var collectionView: UICollectionView!
    private var model: HomeScreenModel?
    private var section: HomeSection?
    var delegate: SectionCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(SpotlightCell.self, forCellWithReuseIdentifier: SpotlightCell.identifier)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
    }

    func configureWith(_ model: HomeScreenModel?, section: HomeSection?) {
        self.model = model
        self.section = section
        collectionView.reloadData()
    }
}

extension SectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.section {
        case .spotlight:
            return model?.spotlight.count ?? 0
        case .cash:
            return 1 // Cash cell
        case .products:
            return model?.products.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.section {
        case .spotlight:
            return cellForSpotlight(at: indexPath)
        case .cash:
            return cellForCash(at: indexPath)
        case .products:
            return cellForProduct(at: indexPath)
        default:
            return UICollectionViewCell()
        }
    }

    private func cellForSpotlight(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpotlightCell.identifier, for: indexPath) as! SpotlightCell
        if let spotlight = model?.spotlight[indexPath.row], let url = URL(string: spotlight.bannerURL) {
            cell.configure(imageURL: url, indexPath: indexPath)
        }
        return cell
    }

    private func cellForCash(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpotlightCell.identifier, for: indexPath) as! SpotlightCell
        if let cash = model?.cash, let url = URL(string: cash.bannerURL) {
            cell.configure(imageURL: url, indexPath: indexPath)
        }
        return cell
    }

    private func cellForProduct(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        if let product = model?.products[indexPath.row], let url = URL(string: product.imageURL) {
            cell.configure(imageURL: url, indexPath: indexPath)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(indexPath: indexPath, section: section)
    }
}

extension SectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch section {
        case .spotlight:
            let width = collectionView.bounds.width - 55
            let height: CGFloat = 170
            return CGSize(width: width, height: height)
        case .cash:
            let width = collectionView.bounds.width - 40
            let height: CGFloat = 110
            return CGSize(width: width, height: height)
        case .products:
            let width: CGFloat = 130
            let height: CGFloat = 140
            return CGSize(width: width, height: height)
        default:
            return CGSize.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
