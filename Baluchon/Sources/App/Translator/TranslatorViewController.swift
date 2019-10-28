//
//  TranslatorViewController.swift
//  Baluchon
//
//  Created by Lauriane Haydari on 17/09/2019.
//  Copyright © 2019 Lauriane Haydari. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var requestLanguageButton: UILabel!
    @IBOutlet weak var arrowChangeButton: UIButton!
    @IBOutlet weak var resultLanguageButton: UILabel!

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var requestTextField: UITextField!

    @IBOutlet weak var resultArrowButton: UIButton!
    @IBOutlet weak var resultTranslationLabel: UILabel!

    // MARK: - Properties

    var viewModel: TranslatorViewModel!

    weak var delegate: TranslatorViewControllerDelegate?

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to viewModel: TranslatorViewModel) {
        viewModel.resultText = { [weak self] text in
            self?.requestTextField.text = text
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

    // MARK: - View actions


    @IBAction func didPressArrowChangeButton(_ sender: Any) {
//        viewModel.didPressResultArrowButton(text: <#T##String#>, from: <#T##String#>, to: <#T##String#>)
    }
    @IBAction func didTapRequestTextField(_ sender: Any) {
        let text = requestTextField.text
        viewModel.didTapRequestTextField(text: text)
    }

    @IBAction func didPressClearButton(_ sender: Any) {
        viewModel.didPressClearButton()
        requestTextField.text = ""
    }

    @IBAction func didPressResultTranslationButton(_ sender: Any) {
        viewModel.didPressResultTranslationButton()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        requestTextField.resignFirstResponder()
    }
}
