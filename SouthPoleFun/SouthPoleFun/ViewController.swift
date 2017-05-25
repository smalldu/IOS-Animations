/*
* Copyright (c) 2015 Razeware LLC
*/

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var penguin: UIImageView!
  @IBOutlet var slideButton: UIButton!
  
  var isLookingRight: Bool = true {
    didSet {
      let xScale: CGFloat = isLookingRight ? 1 : -1
      penguin.transform = CGAffineTransform(scaleX: xScale, y: 1)
      slideButton.transform = penguin.transform
    }
  }

  var penguinY: CGFloat!
  
  var walkSize: CGSize!
  var slideSize: CGSize!
  
  let animationDuration = 1.0
  
  var walkFrames = [
    UIImage(named: "walk01.png")!,
    UIImage(named: "walk02.png")!,
    UIImage(named: "walk04.png")!
  ]
  
  var slideFrames = [
    UIImage(named: "slide01.png")!,
    UIImage(named: "slide02.png")!,
    UIImage(named: "slide01.png")!
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //grab the sizes of the different sequences
    walkSize = walkFrames[0].size
    print(walkSize)
    slideSize = slideFrames[0].size
    
    //setup the animation
    penguinY = penguin.frame.origin.y
    
    loadWalkAnimation()
  }
  
  func loadWalkAnimation() {
    penguin.animationImages = walkFrames
    penguin.animationDuration = animationDuration / 3
    penguin.animationRepeatCount = 3

  }
  
  func loadSlideAnimation() {
    penguin.animationImages = slideFrames
    penguin.animationDuration = animationDuration
    penguin.animationRepeatCount = 1

  }
  
  @IBAction func actionLeft(_ sender: AnyObject) {
    isLookingRight = false
    penguin.startAnimating()
    
    UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
      self.penguin.center.x -= self.walkSize.width
      }, completion: nil)

  }
  
  @IBAction func actionRight(_ sender: AnyObject) {
    isLookingRight = true
    
    penguin.startAnimating()
    UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
      self.penguin.center.x += self.walkSize.width
      }, completion: nil)

  }
  
  @IBAction func actionSlide(_ sender: AnyObject) {
    loadSlideAnimation()
    
    penguin.frame = CGRect(
      x: penguin.frame.origin.x,
      y: penguinY + (walkSize.height - slideSize.height),
      width: slideSize.width,
      height: slideSize.height)

    penguin.startAnimating()

    UIView.animate(withDuration: animationDuration - 0.02, delay: 0.0, options: .curveEaseOut, animations: {
      self.penguin.center.x += self.isLookingRight ?
        self.slideSize.width : -self.slideSize.width
      }, completion: {_ in
        // animation is complete
        self.penguin.frame = CGRect(
          x: self.penguin.frame.origin.x,
          y: self.penguinY,
          width: self.walkSize.width,
          height: self.walkSize.height)
        self.loadWalkAnimation()
    })

  }
}

