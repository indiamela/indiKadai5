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
            let result = try calcAction(
                dividendText: dividendTextField.text ?? "",
                divisorText: divisorTextField.text ?? ""
            )
            resultLabel.text = String(result)
        } catch CalcError.dividendTextIsEmpty {
            showErrorAlert(message: "割られる数を入力してください")
        } catch CalcError.divisorTextIsEmpty {
            showErrorAlert(message: "割る数を入力してください")
        } catch CalcError.divisorIsZero {
            showErrorAlert(message: "割る数には0を入力しないでください")
        } catch {
            showErrorAlert(message: "予期しないエラーが起きました")
        }
    }

    private func calcAction(dividendText: String, divisorText: String) throws -> Double {
        guard let devidedInput = Double(dividendText) else {
            throw CalcError.dividendTextIsEmpty
        }
        guard let divisorInput = Double(divisorText) else {
            throw CalcError.divisorTextIsEmpty
        }
        guard divisorInput != 0 else {
            throw CalcError.divisorIsZero
        }
        return devidedInput / divisorInput
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "課題5", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

private enum CalcError: Error {
    case dividendTextIsEmpty
    case divisorTextIsEmpty
    case divisorIsZero
}
