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

		var i: Int = 0;
		var pressures: [String] = [String]();
		while i <= 200 {
			var myStr = String(i);
			pressures.append(myStr);
			i += 1;
		}
		var x: Double = 0.0;
		var depths: [String] = [String]();
		while x <= 60.0 {
			var myStr = String(x);
			depths.append(myStr);
			x += 0.5;
		}
		var y: Double = 0.0;
		var safeties: [String] = [String]();
		while y <= 5.0 {
			var myStr = String(y);
			safeties.append(myStr);
			y += 0.5;
		}

		pickerDataSource = [pressures,
							depths,
							["Clay 1", "Silt 1", "Clay 2", "Silt 2", "Coh-Gran", "Sand/Silt", "Good Sand/Gravel"],
							["2", "3", "4","5"],
							safeties];
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

	var pressure: String = "0"; // THESE MATCH THE DEFAULTS
	var depth: String = "0.0";
	var soil: String = "Clay 1"
	var trench: String = "2"
	var safety: String = "0.0";
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
			return 140.0;
		case 1:
			return 100.0;
		case 2:
			return 450.0;
		case 3:
			return 100.0;
		case 4:
			return 140.0;
		default:
			return 0;
		}
	}

	func vars2str() -> String {
		let outstr: String = "http://45.56.89.158:5000/minrestrainedlength?design_pressure=" + pressure + "&depth=" + depth + "&soil_type=" + soil + "&trench_type=" + trench + "&safety_factor=" + safety;

		return outstr;
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is WebView {
			let vc = segue.destination as? WebView
			vc?.url = vars2str();
		}
	}

}
