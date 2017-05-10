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

    override func setUp() {
        super.setUp()

        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController else {
            return XCTFail("Could not instantiate ViewController from Main storyboard")
        }
        vc.loadViewIfNeeded()

        viewController = vc
    }
    
    override func tearDown() {
        viewController = nil

        super.tearDown()
    }

    func testViewControllerHasImageView() {
        guard let imageView = viewController.imageView else {
            return XCTFail("ViewController should have imageView property set")
        }
        XCTAssertEqual(imageView.frame.width, 50,
                       "ImageView should have correct width of \(50)")
        XCTAssertEqual(imageView.frame.height, 50,
                       "ImageView should have correct height of \(50)")
        XCTAssertNotNil(imageView.image,
                        "ImageView should have image by default")
        XCTAssertFalse(imageView.isHidden,
                       "ImageView should not be hidden by default")
    }

    func testImageViewIsEmbeddedInView() {
        XCTAssertNotEqual(viewController.imageView.superview, viewController.view,
                          "ImageView superview should not be main view")
    }

    func testViewControllerHasSecondImageView() {
        guard let secondImageView = viewController.secondImageView else {
            return XCTFail("ViewController should have secondImageView property set")
        }
        XCTAssertEqual(secondImageView.frame.width, 100,
                       "SecondImageView should have correct width of \(100)")
        XCTAssertEqual(secondImageView.frame.height, 100,
                       "SecondImageView should have correct height of \(100)")
        XCTAssertNil(secondImageView.image,
                     "SecondImageView should not have an image by default")
        XCTAssertTrue(secondImageView.isHidden,
                       "SecondImageView should be hidden by default")
    }

    func testSwapImagesShowsHidesViewsCorrectly() {
        guard let imageView = viewController.imageView,
            let secondImageView = viewController.secondImageView else {
            return XCTFail("Outlets for imageView and secondImageView should be set on ViewController")
        }

        viewController.viewWillAppear(true)
        viewController.swapImages(UIButton())

        let predicate = NSPredicate { _,_ in
            secondImageView.isHidden == false
        }
        expectation(for: predicate, evaluatedWith: self, handler: nil)

        XCTAssertTrue(imageView.isHidden,
                      "Swapping images should hide first imageView")

        waitForExpectations(timeout: 2) { _ in
            XCTAssertFalse(secondImageView.isHidden,
                           "Swapping images should unhide secondImageView")
        }
    }
}




