//
//  CoordinateSpaceTests.swift
//  CoordinateSpaceTests
//
//  Created by Joesus on 5/9/17.
//  Copyright © 2017 Joesus. All rights reserved.
//

import XCTest
@testable import CoordinateSpace

class CoordinateSpaceTests: XCTestCase {

    var viewController: ViewController!
    var detailViewController: DetailViewController!

    override func setUp() {
        super.setUp()

        guard let navController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController,
            let vc = navController.topViewController as? ViewController else {
            return XCTFail("Could not instantiate ViewController from Main storyboard")
        }
        vc.loadViewIfNeeded()
        viewController = vc
        
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return XCTFail("Could not instantiate DetailViewControllr from Main storyboard")
        }
        detailVC.loadViewIfNeeded()
        detailViewController = detailVC
    }
    
    override func tearDown() {
        viewController = nil

        super.tearDown()
    }

    func testViewControllerHasTableView() {
        guard let _ = viewController.tableView else {
            return XCTFail("ViewController should have tableView property set")
        }
    }

    func testDetailViewControllerHasImageView() {
        guard let _ = detailViewController.imageView else {
            return XCTFail("DetailViewController should have imageView property set")
        }
    }
}




