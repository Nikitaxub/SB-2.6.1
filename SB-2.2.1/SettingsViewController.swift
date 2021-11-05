    //
//  ViewController.swift
//  SB-2.2.1
//
//  Created by xubuntus on 23.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Public Propertiea
    var viewColor: UIColor! 
    var colorFillingViewController: ColorFillingViewController!
    
    // MARK: - Private Properties
    private var redValue: Float = 0
    private var greenValue: Float = 0
    private var blueValue: Float = 0
    
    private enum Color: CaseIterable {
        case red, green, blue
    }
    
    // MARK: - Life Circle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 20
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        unwrapUIColor()
        updateUI(becauseOfColor: nil)
    }

    // MARK: - IB Actions
    @IBAction func sliderChangeAction(_ sender: UISlider) {
        let changedColor: Color
        switch sender {
        case redSlider:
            changedColor = .red
            redValue = redSlider.value
        case greenSlider:
            changedColor = .green
            greenValue = greenSlider.value
        default:
            changedColor = .blue
            blueValue = blueSlider.value
        }

        updateUI(becauseOfColor: changedColor)
    }
    
    @IBAction func doneButtonPressed() {
        colorFillingViewController.setNewBackground(forColor: viewColor)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func modifyValue(_ rawValue: Float) -> String {
        "\(round(rawValue * 100) / 100)"
    }
    
    private func updateUI(becauseOfColor: Color?) -> Void {
        viewColor = UIColor(red: CGFloat(redValue),
                            green: CGFloat(greenValue),
                            blue: CGFloat(blueValue),
                            alpha: 1.0)
        colorView.backgroundColor = viewColor
        
        if let changedColor = becauseOfColor {
            updateStack(ofColor: changedColor)
        } else {
            for color in Color.allCases {
                updateStack(ofColor: color)
            }
        }
    }
    
    private func updateStack(ofColor: Color) -> Void {
        switch ofColor {
        case .red:
            let modifiedRedValue = modifyValue(redValue)
            redLabel.text = modifiedRedValue
            redTextField.text = modifiedRedValue
            redSlider.value = redValue
        case .green:
            let modifiedGreenValue = modifyValue(greenValue)
            greenLabel.text = modifiedGreenValue
            greenTextField.text = modifiedGreenValue
            greenSlider.value = greenValue
        case .blue:
            let modifiedBlueValue = modifyValue(blueValue)
            blueLabel.text = modifiedBlueValue
            blueTextField.text = modifiedBlueValue
            blueSlider.value = blueValue
        }
    }
    
    private func unwrapUIColor() -> Void {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        viewColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        (redValue, greenValue, blueValue, _) = (Float(red), Float(green), Float(blue), Float(alpha))
    }
    
    private func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldFloat = Float(textField.text ?? ""), (0...1).contains(textFieldFloat) else {
            textField.becomeFirstResponder()
            showAlert(title: "Invalid value", message: "Enter a value from 0 to 1")
            return
        }
        
        let changedColor: Color
        switch textField {
        case redTextField:
            changedColor = .red
            redValue = textFieldFloat
        case greenTextField:
            changedColor = .green
            greenValue = textFieldFloat
        default:
            changedColor = .blue
            blueValue = textFieldFloat
        }
        
        updateUI(becauseOfColor: changedColor)
    }
}

