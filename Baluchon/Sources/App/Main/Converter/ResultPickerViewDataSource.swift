//
//  ResultPickerViewDataSource.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 08/10/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

final class ResultPickerViewDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Properties

    private var items: [String] = []

    // MARK: - Public

    func update(with items: [String]) {
        self.items = items
    }

    var didSelectItemAt: ((Int) -> Void)?

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < items.count else { return nil }
        return items[row]
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectItemAt?(row)
    }

}
