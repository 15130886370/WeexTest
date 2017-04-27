//
//  ScanView.swift
//  SetUpProductList
//
//  Created by ittmomWang on 17/3/22.
//  Copyright © 2017年 ittmomProject. All rights reserved.
//

import UIKit
import Then
import SnapKit

class ScanView: UIView {

    var codeView: UIImageView!
    var scanLine: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCostomView()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    private func setUpCostomView() {
        self.codeView = UIImageView().then {
            $0.image = UIImage.init(named: "pick_bg")
            self.addSubview($0)
            $0.snp.makeConstraints{ make in
                make.top.equalTo(self.snp.top).offset(128)
                make.height.width.equalTo(280)
                make.centerX.equalTo(self.snp.centerX)
            }
        }
        self.scanLine = UIImageView().then {
            $0.image = UIImage.init(named: "line")
            $0.isHidden = true
            
            self.addSubview($0)
            $0.snp.makeConstraints{ make in
                make.top.equalTo(self.codeView.snp.top)
                make.height.equalTo(5)
                make.centerX.equalTo(self.snp.centerX)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
