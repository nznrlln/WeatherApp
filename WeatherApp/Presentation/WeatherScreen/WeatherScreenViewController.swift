//
//  ViewController.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit
import RxSwift

@MainActor protocol WeatherScreenViewInput: AnyObject {

}

final class WeatherScreenViewController: UIViewController, WeatherScreenViewInput {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MARK: - Data
    private var weather: CityWeatherModel? {
        didSet {
            displayWeather()
        }
    }
    private var cityName: String?

    // MARK: - Dependencies
    private let viewModel: IWeatherScreenViewModel

    private lazy var citiesBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "list.bullet"),
            style: .plain,
            target: self,
            action: #selector(citiesButtonTap)
        )
        button.tintColor = Palette.blackAndWhite

        return button
    }()

    private lazy var refreshBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .plain,
            target: self,
            action: #selector(refreshButtonTap)
        )
        button.tintColor = Palette.blackAndWhite

        return button
    }()

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "DefaultBackground")
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private let weatherCollectionLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            let contentSize = layoutEnvironment.container.contentSize

            switch sectionType {
            case .currentWeather:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(UIConstansts.currentCellHeight)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitem: item,
                    count: sectionType.numberOfItems
                )

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: UIConstansts.inset,
                    leading: UIConstansts.inset,
                    bottom: UIConstansts.inset / 2,
                    trailing: UIConstansts.inset
                )

                return section

            case .hourForecast:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(UIConstansts.hourCellWidth),
                    heightDimension: .absolute(UIConstansts.hourCellHeight)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let itemsWidth: CGFloat = CGFloat(sectionType.numberOfItems) * UIConstansts.hourCellWidth
                let spacingWidth: CGFloat = CGFloat(sectionType.numberOfItems - 1) * UIConstansts.spacing
                let groupWidth: CGFloat = itemsWidth + spacingWidth
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(groupWidth),
                    heightDimension: .absolute(UIConstansts.hourCellHeight)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitem: item,
                    count: sectionType.numberOfItems
                )
                group.interItemSpacing = .fixed(UIConstansts.spacing)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(
                    top: UIConstansts.inset / 2,
                    leading: UIConstansts.inset,
                    bottom: UIConstansts.inset / 2,
                    trailing: UIConstansts.inset
                )
                section.orthogonalScrollingBehavior = .continuous

                return section

            case .dateForecast:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(UIConstansts.dateCellHeight)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

//                let itemsHeight: CGFloat = CGFloat(sectionType.numberOfItems * 150)
//                let spacingHeight: CGFloat = CGFloat((sectionType.numberOfItems - 1) * 8)
//                let groupHeight: CGFloat = itemsHeight + spacingHeight + 32
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .absolute(groupHeight)
//                )
//                let group = NSCollectionLayoutGroup.vertical(
//                    layoutSize: groupSize,
//                    subitem: item,
//                    count: sectionType.numberOfItems
//                )
//                group.interItemSpacing = .fixed(UIConstansts.spacing)

//                let itemsHeight: CGFloat = CGFloat(sectionType.numberOfItems * 150)
//                let spacingHeight: CGFloat = CGFloat((sectionType.numberOfItems - 1) * 8)
//                let groupHeight: CGFloat = itemsHeight + spacingHeight + 32
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(UIConstansts.dateCellHeight)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = UIConstansts.spacing
                section.contentInsets = .init(
                    top: UIConstansts.inset / 2,
                    leading: UIConstansts.inset,
                    bottom: UIConstansts.inset,
                    trailing: UIConstansts.inset
                )

                return section
            }
        }
    }()

    private lazy var weatherCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: weatherCollectionLayout
        )
        collectionView.toAutoLayout()
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(
            CurrentWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.identifier
        )
        collectionView.register(
            HourWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: HourWeatherCollectionViewCell.identifier
        )
        collectionView.register(
            DateWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: DateWeatherCollectionViewCell.identifier
        )

        collectionView.dataSource = self
//        collectionView.delegate = self

        collectionView.backgroundColor = Palette.clearBackground
        
        return collectionView
    }()

    init(viewModel: IWeatherScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configureRX()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        viewInitialSettings()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    private func displayWeather() {
        DispatchQueue.main.async {
            self.weatherCollectionView.reloadData()
        }
    }


    // MARK: - Methods + layout
    private func viewInitialSettings() {
        // hide back button title in nav bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.leftBarButtonItems = [refreshBarButton]
        self.navigationItem.rightBarButtonItems = [citiesBarButton]
        view.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewLayout()
    }

    private func setupSubviews() {
        view.addSubviews(
            backgroundImage,
            weatherCollectionView
        )
    }

    private func setupSubviewLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        weatherCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureRX() {
        bindData()
    }

    private func bindData() {
        viewModel.cityWeather.subscribe { [weak self] event in
            self?.weather = event.element
        }.disposed(by: disposeBag)

        viewModel.currentCityName.subscribe{ [weak self] event in
            self?.cityName = event.element
        }.disposed(by: disposeBag)

    }

    @objc private func citiesButtonTap() {
            viewModel.citiesButtonTap()
    }

    @objc private func refreshButtonTap() {
        //    presenter?.reloadData()
    }


}

// MARK: - UICollectionViewDataSource
extension WeatherScreenViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        return sectionType.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }

        switch sectionType {
        case .currentWeather:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrentWeatherCollectionViewCell.identifier,
                for: indexPath
            ) as! CurrentWeatherCollectionViewCell
            cell.setupCell(with: weather?.currentWeather, cityName: cityName)

            return cell

        case .hourForecast:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HourWeatherCollectionViewCell.identifier,
                for: indexPath
            ) as! HourWeatherCollectionViewCell
            cell.setupCell(with: weather?.forecast24h?[indexPath.item])

            return cell

        case .dateForecast:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DateWeatherCollectionViewCell.identifier,
                for: indexPath
            ) as! DateWeatherCollectionViewCell
            cell.setupCell(with: weather?.forecast16d?[indexPath.item])

            return cell

        }
        
    }

}

//// MARK: - UICollectionViewDelegate
//extension WeatherScreenViewController: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
//
//}

// MARK: - UIConstansts
fileprivate enum UIConstansts {
    static let currentCellHeight: CGFloat = 150
    static let hourCellWidth: CGFloat = 60
    static let hourCellHeight: CGFloat = 120
    static let dateCellHeight: CGFloat = 70

    static let inset: CGFloat = 8
    static let spacing: CGFloat = 8
}
