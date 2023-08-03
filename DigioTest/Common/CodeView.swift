protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
}
