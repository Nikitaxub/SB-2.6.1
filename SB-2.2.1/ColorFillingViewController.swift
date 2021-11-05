//
//  ColorFillingViewController.swift
//  SB-2.2.1
//
//  Created by xubuntus on 05.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewBackground(forColor: UIColor)
}

class ColorFillingViewController: UIViewController {
    
    @IBOutlet var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButton.setTitle("", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.viewColor = view.backgroundColor
        settingsVC.colorFillingViewController = self
    }
}

extension ColorFillingViewController: SettingsViewControllerDelegate {
    func setNewBackground(forColor: UIColor) {
        view.backgroundColor = forColor
    }
}
