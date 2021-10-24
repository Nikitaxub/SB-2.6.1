//
//  ViewController.swift
//  SB-2.2.1
//
//  Created by xubuntus on 23.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 20
    }

    func getValue(fromSliderWithTag: Int) -> Float {
        guard let slider = view.viewWithTag(fromSliderWithTag) as? UISlider else { return 0}
        return round(slider.value * 100) / 100
    }

    @IBAction func sliderChangeAction(_ sender: UISlider) {
        let redSliderValue = getValue(fromSliderWithTag: 1)
        let greenSliderValue = getValue(fromSliderWithTag: 2)
        let blueSliderValue = getValue(fromSliderWithTag: 3)
        
        redValueLabel.text = String(redSliderValue)
        greenValueLabel.text = String(greenSliderValue)    
        blueValueLabel.text = String(blueSliderValue)
        
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redSliderValue), green: CGFloat(greenSliderValue), blue: CGFloat(blueSliderValue), alpha: 1.0)
    }
}

