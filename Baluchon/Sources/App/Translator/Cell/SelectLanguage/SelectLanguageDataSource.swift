//
//  SelectLanguageDataSource.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 04/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class SelectLanguageDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Private

    private enum VisibleItem {
        case item(language: String)
    }

    private var items: [VisibleItem] = []

    // MARK: - Public

    var didSelectItemAtIndex: ((Int) -> Void)?

    func update(with items: [SelectLanguageViewModel.ItemLabel]) {
        self.items = items.map { item -> VisibleItem  in
            switch item {
            case .language(text: let text):
                return .item(language: text)
            }
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < items.count else {
            fatalError("Error! No service connection")
        }

        switch items[indexPath.item] {
        case .item(language: let language):
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! SelectLanguageTableViewCell
            cell.configure(with: language)
            return cell
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < items.count else {
            assertionFailure("Error! Index out of Range")
            return
        }
        let index = indexPath.item
        didSelectItemAtIndex?(index)
    }
}
