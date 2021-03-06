//
//  LanguageViewController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 04/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class SelectLanguagesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: SelectLanguageViewModel!
    
    // MARK: - Private properties
    
    private let dataSource = SelectLanguageDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: dataSource)
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
        navigationBar()
    }
    
    // MARK: - Private Functions
    
    private func bind(to source: SelectLanguageDataSource) {
        dataSource.didSelectItemAtIndex = viewModel.didSelectItem
    }
    
    private func bind(to vieModel: SelectLanguageViewModel) {
        
        viewModel.visibleItems = { [weak self] items in
            DispatchQueue.main.async {
                self?.dataSource.update(with: items)
                self?.tableView.reloadData()
            }
        }
        viewModel.nextScreen = { [weak self] screen in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if case .alert(title: let title, message: let message) = screen {
                    AlertPresenter().presentAlert(on: self, with: title, message: message)
                }
            }
        }
    }
    
    private func navigationBar() {
        
        let titleColor = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        navigationController?.navigationBar.titleTextAttributes = titleColor as [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "UITabBar.item.tintColor")
        self.title = "Select a language"
    }
}
