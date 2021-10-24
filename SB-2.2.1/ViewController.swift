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

    func useValue(fromSliderWithTag: Int) -> Float {
        guard let slider = view.viewWithTag(fromSliderWithTag) as? UISlider else { return 0 }
        let sliderValue = round(slider.value * 100) / 100
        if let sliderLabel = slider.superview?.subviews.filter({$0 is UILabel})[1] as? UILabel {
            sliderLabel.text = String(sliderValue)
        }
        
        return sliderValue
    }

    @IBAction func sliderChangeAction(_ sender: UISlider) {
        let redSliderValue = useValue(fromSliderWithTag: 1)
        let greenSliderValue = useValue(fromSliderWithTag: 2)
        let blueSliderValue = useValue(fromSliderWithTag: 3)

        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redSliderValue), green: CGFloat(greenSliderValue), blue: CGFloat(blueSliderValue), alpha: 1.0)
    }
}

