//
//  SeparateRepoViewController.swift
//  github_api_task
//
//  Created by Артем Шарапов on 04.09.2020.
//  Copyright © 2020 Artem Sharapov. All rights reserved.
//

import UIKit

class SeparateRepoViewController: UIViewController {
    
    var item: Item?
    
    var user: User?
    
    var fullNameOfRepo = UILabel()
    
    var repoDescription = UILabel()
    
    var fullNameOfOwner = UILabel()
    
    var email = UILabel()
    
    var addToFavoriteButton = UIButton(type: .roundedRect)
    
    var getter = DataGetter()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(with newItem: Item) {
        super.init(nibName: nil, bundle: nil)
        item = newItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        fullNameOfRepo.backgroundColor = .white
        repoDescription.backgroundColor = .white
        fullNameOfOwner.backgroundColor = .white
        email.backgroundColor = .white
        fullNameOfRepo.textColor = .black
        repoDescription.textColor = .black
        fullNameOfOwner.textColor = .black
        email.textColor = .black
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backItem?.backBarButtonItem?.action = #selector(beauty(sender:))
        fullNameOfRepo.frame = CGRect(x: view.frame.width * 0.05,
                                      y: navigationController?.navigationBar.frame.maxY ?? 0 + view.frame.height * 0.05,
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
        
        addToFavoriteButton.frame = CGRect(x: view.frame.width * 0.05,
                                           y: email.frame.maxY + view.frame.height * 0.05,
                                           width: view.frame.width * 0.9,
                                           height: view.frame.height * 0.05)
        addToFavoriteButton.backgroundColor = .yellow
        addToFavoriteButton.setTitle("Добавить в избранное", for: .normal)
        repoDescription.text = item?.description ?? "Описание отсутствует"
        if let userLogin = item?.owner.login {
            user = getter.getUser(with: userLogin)
            fullNameOfRepo.text = (userLogin + "/" + (item?.name ?? " " ) )
        }
        if let gettedUser = user {
            fullNameOfOwner.text = gettedUser.name ?? "Имя владельца отсутствует"
            email.text = gettedUser.email ?? "E-mail отсутствует"
        }
        addToFavoriteButton.addTarget(self, action: #selector(addToFavorite(sender:)), for: .touchUpInside)
        
        view.addSubview(fullNameOfRepo)
        view.addSubview(repoDescription)
        view.addSubview(fullNameOfOwner)
        view.addSubview(email)
        view.addSubview(addToFavoriteButton)
        
        
    }
    
    @objc private func beauty(sender: UIBarButtonItem) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func addToFavorite(sender: UIButton) {
        var fileURL = URL(fileURLWithPath: " ")
        if let path = Bundle.main.path(forResource: "favorite", ofType: "txt") {
            fileURL = URL(fileURLWithPath: path)
        }
        else {
            print("Error")
            return
        }
        do {
            try item?.name?.write(to: fileURL, atomically: false, encoding: .utf8)
            try item?.description?.write(to: fileURL, atomically: false, encoding: .utf8)
            try user?.name?.write(to: fileURL, atomically: false, encoding: .utf8)
            try user?.email?.write(to: fileURL, atomically: false, encoding: .utf8)
            let alert = UIAlertController(title: "Внимание", message: "Репозиторий успешно добавлен в избранное", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                print("bye")
            }
            alert.addAction(action)
            self.present(alert, animated: false)
        }
        catch {
            let alert = UIAlertController(title: "Внимание", message: "Произошла ошибка при добавлении репозитория в избранное", preferredStyle: .alert)
            let action = UIAlertAction(title: ":(", style: .default) { (action) in
                print("bye")
            }
            alert.addAction(action)
            self.present(alert, animated: false)
            print("Ошибка при записи в файл")
            return
        }
    }
}
