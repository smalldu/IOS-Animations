/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ImageViewCard: UIImageView {
  
  var title: String!
  var didSelect: ((ImageViewCard)->())?
  
  convenience init(imageNamed: String, title name: String) {
    self.init()
    
    image = UIImage(named: imageNamed)
    contentMode = .scaleAspectFill
    clipsToBounds = true
    
    title = name
    
    autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.flexibleHeight.rawValue | UIViewAutoresizing.flexibleWidth.rawValue)
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
  
  override func didMoveToSuperview() {
    isUserInteractionEnabled = true
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageViewCard.didTapHandler(_:))))
  }
  
  func didTapHandler(_ tap: UITapGestureRecognizer) {
    didSelect?(self)
  }
}
