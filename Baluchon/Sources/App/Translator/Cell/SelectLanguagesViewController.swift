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
    
    // MARK: - Privates var
    var viewModel: SelectLanguageViewModel!
    
    private let dataSource = SelectLanguageDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: dataSource)
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    private func bind(to source: SelectLanguageDataSource) {
       dataSource.didSelectItemAtIndex = viewModel.didSelectItem
    }
    
    private func bind(to VM: SelectLanguageViewModel) {
        viewModel.titleText = { [weak self] text in
            self?.navigationItem.title = text
        }
        viewModel.visibleItems = { [weak self] items in
            DispatchQueue.main.async {
                self?.dataSource.update(with: items)
                self?.tableView.reloadData()
            }
        }
    }
}
