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
	var url: String = ""

	override func viewDidLoad() {
		print(url);
		super.viewDidLoad();

		let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed);
		let strURL = URL(string: encoded!);
		print(strURL);
		webView.load(URLRequest(url: strURL!));
	}
}
