//
//  ViewController.swift
//  PipeCalculator
//
//  Created by Carson Lloyd on 4/14/18.
//  Copyright © 2018 Carson Lloyd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


	@IBOutlet weak var Info: UIBarButtonItem!
	@IBOutlet weak var DP: UIPickerView!
	var pickerDataSource: [[String]] = [[String]]()

	override func viewDidLoad() {
		super.viewDidLoad();
		self.DP.delegate = self
		self.DP.dataSource = self
		pickerDataSource = [["1", "2", "3", "4"],
							["1", "2", "3", "4"],
							["Clay 1", "Silt 1", "Clay 2", "Silt 2", "Coh-Gran", "Sand/Silt", "Good Sand/Gravel"],
							["2", "3", "4", "5"],
							["1.5","2.0","2.5"]];
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerDataSource[component].count
	}
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 5 // match number or arrays in pickerDataSource
	}
	// The data to return for the row and component (column) that's being passed in
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerDataSource[component][row]
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		// This method is triggered whenever the user makes a change to the picker selection.
		// The parameter named row and component represents what was selected.
	}

	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
	{
		switch (component){
		case 0:
			return 80.0;
		case 1:
			return 90.0;
		case 2:
			return 260.0;
		case 3:
			return 90.0;
		case 4:
			return 80.0;
		default:
			return 0;
		}
	}
}
