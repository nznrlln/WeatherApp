//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit

@MainActor protocol ICurrentWeatherCell {
    func setupCell(with model: CurrentWeatherModel?, cityName:  String?)
}

class CurrentWeatherCollectionViewCell: UICollectionViewCell, ICurrentWeatherCell {

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
        label.font = Fonts.rubikMed24
        label.numberOfLines = 2

        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikMed24

        return label
    }()

    private let currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikLight14
        label.textColor = Palette.secondaryText

        return label
    }()

    private let temperatureRangeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikReg20

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(
        with model: CurrentWeatherModel?,
        cityName: String?
    ) {
        guard let model = model else { return }

        cityLabel.text = cityName ?? nil
        temperatureLabel.text = "\(model.temperature)℃"
        currentWeatherLabel.text = model.weather.description
        temperatureRangeLabel.text = "\(model.temperature - 5)℃ - \(model.temperature + 5)℃"
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
            cityLabel,
            temperatureLabel,
            currentWeatherLabel,
            temperatureRangeLabel
        )
    }

    private func setupSubviewsLayout() {
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(UIConstansts.inset)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom).offset(UIConstansts.offset)
        }

        currentWeatherLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(UIConstansts.offset)

        }

        temperatureRangeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentWeatherLabel.snp.bottom).offset(UIConstansts.offset)
            make.bottom.equalToSuperview().inset(UIConstansts.inset)
        }
    }

}

// MARK: - UIConstansts
fileprivate enum UIConstansts {
    static let cellCornerRadius: CGFloat = 4

    static let inset: CGFloat = 8
    static let offset: CGFloat = 8
}
