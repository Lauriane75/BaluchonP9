//
//  SelectLanguageTableViewCell.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 04/11/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class SelectLanguageTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var languageLabel: UILabel!

    // MARK: - Configure

      func configure(with language: String) {
          self.languageLabel.text = language
      }
}
