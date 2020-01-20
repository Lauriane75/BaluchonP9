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

    @IBOutlet weak var requestLanguageButton: UIButton!
    @IBOutlet weak var arrowTranslateButton: UIButton!
    @IBOutlet weak var resultLanguageButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var requestTextField: UITextField!
    @IBOutlet weak var resultArrowButton: UIButton!
    @IBOutlet weak var resultTranslationLabel: UILabel!

    // MARK: - Properties

    var viewModel: TranslatorViewModel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()

        elementsCustom()

        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))

        view.addGestureRecognizer(tap)

        settingNotificationCenter()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    private func bind(to viewModel: TranslatorViewModel) {
        viewModel.requestTextField = { [weak self] text in
            DispatchQueue.main.async {
            self?.requestTextField.text = text
            }
        }
        viewModel.resultText = { [weak self] text in
            DispatchQueue.main.async {
            self?.resultTranslationLabel.text = text
            }
        }
        viewModel.requestLanguageTextButton = { [weak self] text in
            DispatchQueue.main.async {
            self?.requestLanguageButton.setTitle(text, for: .normal)
            }
        }
        viewModel.resultLanguageTextButton = { [weak self] text in
            DispatchQueue.main.async {
            self?.resultLanguageButton.setTitle(text, for: .normal)
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

    // MARK: - View actions

    @IBAction func didPressTranslateButton(_ sender: Any) {
        viewModel.didPressTranslatButton(for: requestTextField.text!)
    }

    @IBAction func didPressClearButton(_ sender: Any) {
        viewModel.didPressClearButton()
        requestTextField.text = ""
    }

    @IBAction func didSelectRequestLanguageButton(_ sender: Any) {
        viewModel.didSelectLanguageType(for: .request)
    }

    @IBAction func didSelectResultLanguageButton(_ sender: Any) {
        viewModel.didSelectLanguageType(for: .result)
    }

    // MARK: - Private Files

    fileprivate func elementsCustom() {
        requestLanguageButton.layer.cornerRadius = 15
        resultLanguageButton.layer.cornerRadius = 15
       }

    @objc private func hideKeyBoard() {
        requestTextField.resignFirstResponder()
        clearButton.resignFirstResponder()
        resultArrowButton.resignFirstResponder()

    }

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           hideKeyBoard()
            return true
    }

    fileprivate func settingNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func keyboardWillChange(notification: Notification) {

        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?          NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height

        if notification.name == UIResponder.keyboardWillShowNotification ||
                notification.name == UIResponder.keyboardWillChangeFrameNotification {
                view.frame.origin.y = -(keyboardHeight/2)
        } else {
                view.frame.origin.y = 0
        }
    }
}
