//
//  LabelClass.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 02/08/21.
//

import UIKit

class LabelTittle: UILabel {

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      initializeLabel()
  }

  override init(frame: CGRect) {
      super.init(frame: frame)
      initializeLabel()
  }

  func initializeLabel() {
    self.textAlignment = .left
    self.font = UIFont(name: "Helvetica-Bold", size: 23)
    self.textColor = UIColor.blue
    self.text = "Promedio General:"
  }

}
