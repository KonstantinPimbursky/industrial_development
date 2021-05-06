//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - FeedViewOutput
protocol FeedViewOutput {
    
    var navigationController: UINavigationController? { get set }
    
    func showPost(_: Post)
}

// MARK: - ContainerView
class ContainerView: UIStackView {
    
    let post: Post = Post(title: "Пост")
    
    private let postButtonFirst: UIButton = {
        let button = UIButton()
        button.setTitle("Open Post", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let postButtonSecond: UIButton = {
        let button = UIButton()
        button.setTitle("Open Post", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        return button
    }()
    
    var onTap: ((Post) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func postButtonAction() {
        guard onTap != nil else { return }
        onTap!(post)
    }
    
    private func setupViews() {
        self.addArrangedSubview(postButtonFirst)
        self.addArrangedSubview(postButtonSecond)
        self.axis = .vertical
        self.spacing = 10
    }
}


// MARK: - PostPresenter
class PostPresenter: FeedViewOutput {
    
    var navigationController: UINavigationController?
    
    func showPost(_ post: Post) {
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

// MARK: - FeedViewController
final class FeedViewController: UIViewController {
    
    private let output = PostPresenter()
    private let containerView = ContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.navigationController = navigationController
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.onTap = output.showPost
        containerView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
}
