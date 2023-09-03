//
//  Forecast1dCollectionViewCell.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

@MainActor protocol IDateWeatherCell {
    func setupCell(with model: WeatherForecast1dModel?)
}

class DateWeatherCollectionViewCell: UICollectionViewCell, IDateWeatherCell {

    private let backView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondaryBackground
        view.alpha = Palette.transparentAlpha

        return view
    }()

    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = UIConstansts.imageCornerRadius
        imageView.clipsToBounds = true
        
        return imageView
    }()

    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikLight12
        label.textColor = Palette.secondaryText
        label.textAlignment = .center

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.rubikReg16

        return label
    }()

    private let weatherLabel: UILabel = {
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
        label.textAlignment = .right

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

        dateLabel.text = nil
        weatherImageView.image = nil
        humidityLabel.text = nil
        weatherLabel.text = nil
        temperatureRangeLabel.text = nil
    }

    func setupCell(with model: WeatherForecast1dModel?) {
        guard let model = model else { return }

        dateLabel.text = DateConverter.shared.getConvertedDate(
            initialFormat: "yyyy-MM-dd",
            model.forecastDate,
            finalFormat: "E, dd MMMM yyyy"
        )
        weatherImageView.kf.setImage(with: URL(string: "https://cdn.weatherbit.io/static/img/icons/\(model.weather.iconCode).png"))
        humidityLabel.text = "\(model.humidity) %"
        weatherLabel.text = model.weather.description
        temperatureRangeLabel.text = "\(model.temperatureMin)℃ - \(model.temperatureMax)℃"
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
            weatherImageView,
            humidityLabel,
            dateLabel,
            weatherLabel,
            temperatureRangeLabel
        )
    }

    private func setupSubviewsLayout() {
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(UIConstansts.inset)
            make.height.width.equalTo(UIConstansts.imageSize)
        }

        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.leading.trailing.equalTo(weatherImageView)
            make.bottom.equalToSuperview().inset(UIConstansts.inset)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstansts.inset)
            make.leading.equalTo(weatherImageView.snp.trailing).offset(UIConstansts.offset)
            make.trailing.equalTo(temperatureRangeLabel.snp.leading).offset(-UIConstansts.offset).priority(.medium)
            make.bottom.equalTo(contentView.snp.centerY)
        }

        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.equalTo(weatherImageView.snp.trailing).offset(UIConstansts.offset)
            make.trailing.equalTo(temperatureRangeLabel.snp.leading).offset(-UIConstansts.offset).priority(.medium)
            make.bottom.equalToSuperview().inset(UIConstansts.inset)
        }

        temperatureRangeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstansts.inset)
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
