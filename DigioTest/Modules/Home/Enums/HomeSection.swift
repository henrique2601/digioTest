import UIKit

enum HomeSection: Int {
    case spotlight
    case cash
    case products

    var title: String {
        switch self {
        case .spotlight:
            return "Olá, Maria"
        case .cash:
            return "Digio Cash"
        case .products:
            return "Produtos"
        }
    }

    var height: CGFloat {
        switch self {
        case .spotlight:
            return 170
        case .cash:
            return 110
        case .products:
            return 140
        }
    }
}
