//
//  ViewController.swift
//  indiKadai5
//
//  Created by Taishi Kusunose on 2021/12/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var dividendTextField: UITextField!
    @IBOutlet private weak var divisorTextField: UITextField!
    @IBOutlet private weak var resultLabel: UILabel!

    @IBAction func onTapCalcButton(_ sender: Any) {
        do {
            try calcAction()
        } catch CalcError.dividendTextIsEmpty {
            showErrorAlert("割られる数を入力してください")
        } catch CalcError.divisorTextIsEmpty {
            showErrorAlert("割る数を入力してください")
        } catch CalcError.divisorIsZero {
            showErrorAlert("割る数には0を入力しないでください")
        } catch {
            showErrorAlert("予期しないエラーが起きました")
        }
    }

    private func calcAction() throws {
        guard let devidedInput = dividendTextField.text.flatMap({Double($0)}) else {
            throw CalcError.dividendTextIsEmpty
        }
        guard let divisorInput = divisorTextField.text.flatMap({Double($0)}) else {
            throw CalcError.divisorTextIsEmpty
        }
        guard divisorInput != 0 else {
            throw CalcError.divisorIsZero
        }
        resultLabel.text = String(devidedInput/divisorInput)
    }

    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "課題5", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default))
        self.present(alert, animated: true)
    }
}

fileprivate enum CalcError: Error {
    case dividendTextIsEmpty
    case divisorTextIsEmpty
    case divisorIsZero
}
