//
//  SearchRepoViewController.swift
//  github_api_task
//
//  Created by Артем Шарапов on 04.09.2020.
//  Copyright © 2020 Artem Sharapov. All rights reserved.
//

import UIKit

class SearchRepoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var seeFavoriteButton = UIButton(type: .roundedRect)
    
    var requestTextField = UITextField() //Поле для ввода поискового запроса
    
    var sendRequestButton = UIButton(type: .roundedRect) //Кнопка отправки запроса
    
    var resultsList = UITableView()
    
    var searchResults: SearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTextField.frame = CGRect(x: view.frame.width * 0.05,
                                        y: view.frame.height * 0.11,
                                        width: view.frame.width * 0.65,
                                        height: view.frame.height * 0.05)
        requestTextField.backgroundColor = .lightGray
        requestTextField.textColor = .lightText
        
        sendRequestButton.frame = CGRect(x: requestTextField.frame.maxX + view.frame.width * 0.05,
                                         y: view.frame.height * 0.11,
                                         width: view.frame.width * 0.2,
                                         height: view.frame.height * 0.05)
        sendRequestButton.backgroundColor = .lightGray
        sendRequestButton.setTitle("Go", for: .normal)
        sendRequestButton.titleLabel?.isHidden = false
        sendRequestButton.addTarget(self, action: #selector(sendRequest(sender:)), for: .touchUpInside)
        seeFavoriteButton.frame = CGRect(x: view.frame.width * 0.05,
                                         y: requestTextField.frame.maxY + view.frame.height * 0.05,
                                         width: view.frame.width * 0.9,
                                         height: view.frame.height * 0.05)
        seeFavoriteButton.setTitle("Просмотреть избранное", for: .normal)
        seeFavoriteButton.backgroundColor = .systemYellow
        seeFavoriteButton.addTarget(self, action: #selector(seeFavorite(sender:)), for: .touchUpInside)
        
        resultsList.frame = CGRect(x: 0,
                                   y: requestTextField.frame.maxY + view.frame.height * 0.11,
                                   width: view.frame.width,
                                   height: view.frame.height - requestTextField.frame.maxY + view.frame.height * 0.05)
        resultsList.dataSource = self
        resultsList.delegate = self
        resultsList.register(SearchRepoTableCell.self, forCellReuseIdentifier: "RepoCell")
        
        view.addSubview(sendRequestButton)
        view.addSubview(requestTextField)
        view.addSubview(resultsList)
        view.addSubview(seeFavoriteButton)
    }
    
    @objc private func sendRequest(sender: UIButton) {
        let getter = DataGetter()
        searchResults = getter.getRepositoriesList(with: requestTextField.text ?? "tetris")
        view.endEditing(true)
        resultsList.reloadData()
    }
    
    @objc private func seeFavorite(sender: UIButton) {
        navigationController?.pushViewController(FavoriteReposViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.resultsList:
            return searchResults?.items.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.resultsList.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        cell.textLabel?.text = self.searchResults?.items[indexPath.row].name ?? "Полное имя отсутствует"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = searchResults?.items[indexPath.row] {
            navigationController?.pushViewController(SeparateRepoViewController(with: item), animated: false)
        }
    }
}


class SearchRepoTableCell: UITableViewCell {
    
}
