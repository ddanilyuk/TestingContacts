//
//  PartOverlayViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

protocol PartOverlayViewController: UIViewController {
    var contentView: UIView! { get set }
    var backgroundView: UIView! { get set }
}
