//
//  SimpleCleanButton.swift
//  FirebaseRegistrationPractice
//
//  Created by Арсентий Халимовский on 06.06.2023.
//

import UIKit

final class CleaningButton: UIButton {
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCleaningButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCleaningButton() {
        // setImage(UIImage(named: "xmark"), for: .normal)
        setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        tintColor = .black
        widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
