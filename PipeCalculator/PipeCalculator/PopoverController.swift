//
//  PopoverController.swift
//  PipeCalculator
//
//  Created by Carson Lloyd on 4/15/18.
//  Copyright © 2018 Carson Lloyd. All rights reserved.
//

import UIKit

class PopoverController: UIViewController {
	@IBOutlet var Popover: UIView!
	func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
		return UIModalPresentationStyle.none
	}
}
