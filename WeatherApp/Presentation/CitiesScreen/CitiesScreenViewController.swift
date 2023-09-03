//
//  CitiesScreenViewController.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

@MainActor protocol CitiesScreenViewInput: AnyObject {

}

class CitiesScreenViewController: UIViewController, CitiesScreenViewInput {

    // MARK: - Properties
    var viewModel: ICitiesScreenViewModel? {
        didSet {
            configureRX()
        }
    }

    private let disposeBag = DisposeBag()

    private lazy var addCityBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addCityButtonTap)
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

    private let citiesCollectionLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(UIConstansts.rowHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = UIConstansts.spacing
        section.contentInsets = .init(
            top: UIConstansts.inset,
            leading: UIConstansts.inset,
            bottom: UIConstansts.inset,
            trailing: UIConstansts.inset
        )
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }()

    private lazy var citiesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: citiesCollectionLayout
        )
        collectionView.toAutoLayout()
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(
            CityCollectionViewCell.self,
            forCellWithReuseIdentifier: CityCollectionViewCell.identifier
        )
//
//        collectionView.dataSource = self
//        collectionView.delegate = self

        collectionView.backgroundColor = Palette.clearBackground

        return collectionView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        viewInitialSettings()
        viewModel?.viewDidLoad()
    }

    // MARK: - Methods + layout
    private func viewInitialSettings() {
        self.navigationItem.rightBarButtonItems = [addCityBarButton]
        self.title = "Города"
        view.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewLayout()
    }

    private func setupSubviews() {
        view.addSubviews(
            backgroundImage,
            citiesCollectionView
        )
    }

    private func setupSubviewLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        citiesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configureRX() {
        bindCollectionView()
        bindAlert()
    }

    private func bindCollectionView() {
        viewModel?.citiesList.bind(
            to: citiesCollectionView.rx.items(
                cellIdentifier: CityCollectionViewCell.identifier,
                cellType: CityCollectionViewCell.self)) { index, model, cell in
                    cell.setupCell(model: model)
                }.disposed(by: disposeBag)

        _ = citiesCollectionView
            .rx
            .setDelegate(self)

        citiesCollectionView
            .rx
            .itemSelected
            .subscribe { [weak self] event in
                if let indexPath = event.element {
                    self?.viewModel?.didSelectItem(index: indexPath.item)
                }
            }
    }

    private func bindAlert() {
        viewModel?.alert.subscribe { event in
            guard let model = event.element else { return }
            let alert = AlertBuilder.buildAlertController(for: model)
        }.disposed(by: disposeBag)
    }

    @objc private func addCityButtonTap() {
            viewModel?.addCityButtonTap()
    }

}

extension CitiesScreenViewController: UICollectionViewDelegate {

}

// MARK: - UIConstansts
fileprivate enum UIConstansts {
    static let rowHeight: CGFloat = 44
    static let spacing: CGFloat = 4
    static let inset: CGFloat = 8
}
