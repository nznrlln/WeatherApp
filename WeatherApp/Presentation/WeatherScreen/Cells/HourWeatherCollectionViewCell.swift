//
//  Forecast3hCollectionViewCell.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

@MainActor protocol IHourWeatherCell {
    func setupCell(with model: WeatherForecast3hModel?)
}

final class HourWeatherCollectionViewCell: UICollectionViewCell, IHourWeatherCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondaryBackground
        view.alpha = Palette.transparentAlpha

        return view
    }()
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikReg12
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .center

        return label
    }()

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = UIConstansts.imageCornerRadius
        imageView.clipsToBounds = true

        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikReg12
        label.textAlignment = .center

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

        hourLabel.text = nil
        weatherImageView.image = nil
        temperatureLabel.text = nil
    }

    func setupCell(with model: WeatherForecast3hModel?) {
        guard let model = model else { return }

        hourLabel.text = DateConverter.shared.getConvertedDate(
            initialFormat: "yyyy-MM-dd'T'HH:mm:ss",
            model.forecastTime,
            finalFormat: "HH:mm"
        )
        weatherImageView.kf.setImage(with: URL(string: "https://cdn.weatherbit.io/static/img/icons/\(model.weather.iconCode).png"))
        temperatureLabel.text = "\(model.temperature)℃"
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
            hourLabel,
            weatherImageView,
            temperatureLabel
        )
    }

    private func setupSubviewsLayout() {
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        hourLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstansts.inset)
            make.centerX.equalToSuperview()
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(UIConstansts.inset)
        }

        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom).offset(UIConstansts.offset)
            make.centerX.equalToSuperview()
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(UIConstansts.inset)
            make.height.width.equalTo(UIConstansts.imageSize)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(UIConstansts.offset)
            make.centerX.equalToSuperview()
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(UIConstansts.inset)
            make.bottom.equalToSuperview().inset(UIConstansts.inset)
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
