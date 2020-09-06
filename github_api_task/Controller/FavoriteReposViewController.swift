//
//  FavoriteReposViewController.swift
//  github_api_task
//
//  Created by Артем Шарапов on 04.09.2020.
//  Copyright © 2020 Artem Sharapov. All rights reserved.
//

import UIKit

struct RepoItem {
    var nameOfRepo: String?
    var description: String?
    var fullName: String?
    var email: String?
}

class FavoriteReposViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var backButton = UIButton(type: .roundedRect)
    
    var fullNameOfRepo = UILabel()
    
    var repoDescription = UILabel()
    
    var fullNameOfOwner = UILabel()
    
    var email = UILabel()
    
    var listOfFavorite = UITableView()
    
    var items = [RepoItem]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        var fileContent = ""
        do {
            fileContent = try String(contentsOfFile: Bundle.main.path(forResource: "favorite", ofType: "txt")!)
        }
        catch {
            let alert = UIAlertController(title: "Ошибка", message: "Возникла ошибка при поиске файла", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Жаль", style: .default) { (alertAction) in
                
            }
            alert.addAction(alertAction)
            self.present(alert, animated: false)
            return
        }
        let lines = fileContent.components(separatedBy: "\n")
        var i = 0
        while i != lines.count - 1 {
            var newItem = RepoItem()
            newItem.nameOfRepo = lines[i]
            newItem.description = lines[i + 1]
            newItem.fullName = lines[i+2]
            newItem.email = lines[i + 3]
            items.append(newItem)
            i = i + 4
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfFavorite.dataSource = self
        listOfFavorite.delegate = self
        listOfFavorite.register(FavouriteRepoCellViewController.self, forCellReuseIdentifier: "FavRepoCell")
        listOfFavorite.frame = view.frame
        view.addSubview(listOfFavorite)
        print(items)
        fullNameOfRepo.frame = CGRect(x: view.frame.width * 0.05,
                                      y: view.frame.height * 0.11,
                                      width: view.frame.width,
                                      height: view.frame.height * 0.05)
        
        repoDescription.frame = CGRect(x: view.frame.width * 0.05,
                                       y: fullNameOfRepo.frame.maxY + view.frame.height * 0.05,
                                       width: view.frame.width,
                                       height: view.frame.height * 0.05)
        
        fullNameOfOwner.frame = CGRect(x: view.frame.width * 0.05,
                                       y: repoDescription.frame.maxY + view.frame.height * 0.05,
                                       width: view.frame.width,
                                       height: view.frame.height * 0.05)
        
        email.frame = CGRect(x: view.frame.width * 0.05,
                             y: fullNameOfOwner.frame.maxY + view.frame.height * 0.05,
                             width: view.frame.width,
                             height: view.frame.height * 0.05)
        backButton.frame = CGRect(x: view.frame.width * 0.05,
                                  y: email.frame.maxY + view.frame.height * 0.05,
                                  width: view.frame.width * 0.9,
                                  height: view.frame.height * 0.05)
        backButton.setTitle("Вернуться назад", for: .normal)
        backButton.backgroundColor = .orange
        backButton.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        backButton.isHidden = true
        fullNameOfRepo.isHidden = true
        repoDescription.isHidden = true
        fullNameOfOwner.isHidden = true
        email.isHidden = true
        view.addSubview(fullNameOfRepo)
        view.addSubview(repoDescription)
        view.addSubview(fullNameOfOwner)
        view.addSubview(email)
        view.addSubview(backButton)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
        backButton.isHidden = false
        fullNameOfRepo.isHidden = false
        repoDescription.isHidden = false
        fullNameOfOwner.isHidden = false
        email.isHidden = false
        fullNameOfRepo.text = items[indexPath.row].nameOfRepo
        repoDescription.text = items[indexPath.row].description
        fullNameOfOwner.text = items[indexPath.row].fullName
        email.text = items[indexPath.row].email
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.listOfFavorite:
            return self.items.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = self.listOfFavorite.dequeueReusableCell(withIdentifier: "FavRepoCell", for: indexPath)
        cell.textLabel?.text = self.items[indexPath.row].nameOfRepo ?? "Репозиторий не обнаружен"
        return cell
    }
    
    @objc private func back(sender: UIButton) {
        listOfFavorite.isHidden = false
        backButton.isHidden = true
        fullNameOfRepo.isHidden = true
        repoDescription.isHidden = true
        fullNameOfOwner.isHidden = true
        email.isHidden = true
    }
}

class FavouriteRepoCellViewController: UITableViewCell {
    
}
