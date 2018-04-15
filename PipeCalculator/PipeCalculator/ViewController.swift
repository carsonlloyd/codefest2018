//
//  ViewController.swift
//  PipeCalculator
//
//  Created by Carson Lloyd on 4/14/18.
//  Copyright © 2018 Carson Lloyd. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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

	var pressure: String = "1" // THESE MATCH THE DEFAULTS
	var depth: String = "1"
	var soil: String = "Clay 1"
	var trench: String = "2"
	var safety: String = "1.5"
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch (component){
		case 0:
			pressure = pickerDataSource[component][row];
			print(pressure);
			vars2str();
			break;
		case 1:
			depth = pickerDataSource[component][row];
			print(depth);
			vars2str();
			break;
		case 2:
			soil = pickerDataSource[component][row];
			print(soil);
			vars2str();
			break;
		case 3:
			trench = pickerDataSource[component][row];
			print(trench);
			vars2str();
			break;
		case 4:
			safety = pickerDataSource[component][row];
			print(safety);
			vars2str();
			break;
		default:
			break;
		}
	}

	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		switch (component) {
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

	func vars2str() -> String {
		let outstr: String = "http://10.250.56.133:5000/minrestrainedlength?design_pressure=" + pressure + "&depth=" + depth + "&soil_type=" + soil + "&trench_type=" + trench + "&safety_factor=" + safety;

		return outstr;
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is WebView {
			let vc = segue.destination as? WebView
			vc?.url = vars2str();
		}
	}

}
