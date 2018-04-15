//
//  WebView.swift
//  PipeCalculator
//
//  Created by Carson Lloyd on 4/15/18.
//  Copyright © 2018 Carson Lloyd. All rights reserved.
//

import Foundation
import WebKit

class WebView: UIViewController , WKNavigationDelegate {
	@IBOutlet weak var webView: WKWebView!

/*	override func loadView() {
		//webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}*/

	override func viewDidLoad() {
		print("I'M IN");
		super.viewDidLoad();

		let strURL = URL(string: "http://10.250.56.133:5000/minrestrainedlength?design_pressure=60&depth=3&soil_type=Sand%2FSilt&trench_type=4&safety_factor=1")!;
		webView.load(URLRequest(url: strURL));
		webView.allowsBackForwardNavigationGestures = true;
	}
}
