//
//  RatingControl.swift
//  FoodTracker
//
//  Created by 张润峰 on 16/8/17.
//  Copyright © 2016年 张润峰. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let fulledStarImage = UIImage(named: "5_filledStar_2x")
        let emptyStarImage = UIImage(named: "5_emptyStar_2x")
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.adjustsImageWhenHighlighted = false
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(fulledStarImage, for: .selected)
            button.setImage(fulledStarImage, for: [.highlighted, .selected])
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
            ratingButtons += [button]
            addSubview(button)
        }
        
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionState()
    }
    
//    override func intrinsicContentSize() -> CGSize {
//        return CGSize(width: 240, height: 44)
//    }
   
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionState()
    }
    
    func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = (index < rating)
        }
    }
    
}
