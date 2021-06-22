//
//  SharePromptView.swift
//  newSDK
//
//  Created by LAP314MAC on 03/01/21.
//  Copyright © 2021 LAP314MAC. All rights reserved.
//

import UIKit

class SharePromptView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        // all the layout code from above
        backgroundColor = UIColor.lightGray

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        self.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.axis = .vertical

        let notice = UILabel()
        notice.numberOfLines = 0
        notice.text = "Your child has attempted to share the following photo from the camera:"
        stackView.addArrangedSubview(notice)

        let imageView = UIImageView(image: UIImage.init(named: ""))
        stackView.addArrangedSubview(imageView)

        let prompt = UILabel()
        prompt.numberOfLines = 0
        prompt.text = "What do you want to do?"
        stackView.addArrangedSubview(prompt)

        for option in ["Always Allow", "Allow Once", "Deny", "Manage Settings"] {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            stackView.addArrangedSubview(button)
        }
    }
}
