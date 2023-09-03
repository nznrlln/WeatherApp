//
//  CityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 02.09.2023.
//

import UIKit

@MainActor protocol ICityCell {
    func setupCell(model: CityModel?)
}

final class CityCollectionViewCell: UICollectionViewCell, ICityCell {

    private let backView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondaryBackground
        view.alpha = Palette.transparentAlpha

        return view
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikReg16

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cityLabel.text = nil
    }

    func setupCell(model: CityModel?) {
        guard let model = model else { return }

        cityLabel.text = model.city
    }

    private func cellInitialSetting() {
        self.layer.cornerRadius = UIConstansts.cellCornerRadius
        self.clipsToBounds = true

        setupSubviews()
        setupSubviewsLayout()
    }
    private func setupSubviews() {
        contentView.addSubviews(
            backView,
            cityLabel
        )
    }

    private func setupSubviewsLayout() {
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        cityLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(UIConstansts.inset)
        }
    }
}

// MARK: - UIConstansts
fileprivate enum UIConstansts {
    static let cellCornerRadius: CGFloat = 4

    static let inset: CGFloat = 8
    static let offset: CGFloat = 8

    static let imageSize: CGFloat = 44
    static let imageCornerRadius: CGFloat = 4
}

