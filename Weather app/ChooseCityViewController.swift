//
//  ChooseCityViewController.swift
//  Weather app
//
//  Created by Сергей Золотухин on 10.01.2022.
//

import UIKit
import SnapKit

class ChooseCityViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 107/255, green: 177/255, blue: 218/255, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 107/255, green: 177/255, blue: 218/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let currentCityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "City name"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor(red: 107/255, green: 177/255, blue: 218/255, alpha: 1)
        searchBar.tintColor = .white
        return searchBar
    }()

    private let backToHomeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 2)
        button.layer.shadowRadius = 8.8
        button.layer.shadowOpacity = 0.3
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(goHomeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Constants and variables
    
//    var enteredCityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        searchBarDelegate()
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(currentCityLabel)
        backgroundView.addSubview(backToHomeButton)
        backgroundView.addSubview(searchBar)
    }
    
    private func searchBarDelegate() {
        searchBar.delegate = self
    }
    
    @objc private func goHomeButtonTapped() {
        if enteredCityName != "" {
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - UISearchBar delegate

extension ChooseCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchBarText = searchBar.text else { return }
        enteredCityName = searchBarText
    }
    
}

//MARK: - SetConstraints

extension ChooseCityViewController {
    
    private func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(scrollView)
        }
        
        currentCityLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(backgroundView).inset(view.frame.height/20)
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        
        backToHomeButton.snp.makeConstraints { make in
            make.right.equalTo(backgroundView).inset(30)
            make.top.equalTo(backgroundView).inset(50)
            make.height.width.equalTo(35)
        }
        
        searchBar.snp.makeConstraints { make in
            make.right.left.equalTo(backgroundView).inset(10)
            make.top.equalTo(currentCityLabel.snp.bottom).offset(10)
        }
    }
}
