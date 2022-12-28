//
//  RootViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.07.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var timer: Timer?
    private var countOfUnsecTr = 0.0
    
    private lazy var button1: CustomButton = {
        let button = CustomButton(title: NSLocalizedString(LocalizitedKeys.keyPostNameOne, comment: ""),
                                  titleColor: .black,
                                  backgroundButtonColor: .systemRed,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 1, autoLayout: true)
        button.addTargetForButton = { self.showPost() }
        return button
    }()
    
    private lazy var button2: CustomButton = {
        let button = CustomButton(title: NSLocalizedString(LocalizitedKeys.keyPostNameTwo, comment: ""),
                                  titleColor: .black,
                                  backgroundButtonColor: .systemTeal,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 1,
                                  autoLayout: true)
        button.addTargetForButton = { self.showPost() }
        return button
    }()
    
    private lazy var textField: UITextField = {
        let text = UITextField()
        text.placeholder = NSLocalizedString(LocalizitedKeys.keyPlaceholderTextForChec, comment: "")
        text.text = ""
        text.textAlignment = .center
        text.textColor = .black
        text.layer.borderColor = UIColor.black.cgColor
        text.isUserInteractionEnabled = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.addTarget(self, action: #selector(startTimer), for: .allTouchEvents)
        return text
    }()
    
    private lazy var textFieldResult: UITextField = {
        let text = UITextField()
        text.text = ""
        text.textAlignment = .center
        text.textColor = .black
        text.layer.borderColor = UIColor.black.cgColor
        text.isUserInteractionEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: LocalizitedKeys.keyCheckEnteredWord,
                                  titleColor: .black,
                                  backgroundButtonColor: .blue,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 1,
                                  autoLayout: false)
        button.addTargetForButton = { self.checker() }
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(frame: CGRect(x: 100, y: 100, width: 140, height: 100))
        vStack.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        vStack.alignment = .center
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.distribution = .fillEqually
        vStack.addArrangedSubview(button1)
        vStack.addArrangedSubview(button2)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //self.view.addSubview(self.vStack)
        //self.vStack.center = self.view.center
        
        // настраиваем вью, если темная тема
        isCurrentThemeDark()
        setupView()
    }
    
    private func setupView(){
        view.addSubview(textField)
        view.addSubview(checkGuessButton)
        view.addSubview(textFieldResult)
        
        NSLayoutConstraint.activate([
            
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textFieldResult.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            textFieldResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            textFieldResult.widthAnchor.constraint(equalToConstant: 70),
            
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            checkGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    @objc private func startTimer(){
        // суть - даем 15 с на ввод слова пользователю. Если не успел, то поднимаем Аларм и считаем такие алармы
        // таймер (счетчик) отключаем только тогда, когда введено слово + отправлено на проверку
        // чтобы не было утечки памяти нужно проверять и создавать только 1 таймер
        if timer == nil {
            timer = Timer(timeInterval: 15.0,
                          target: self,
                          selector: #selector(alarmNote),
                          userInfo: nil,
                          repeats: true)
            RunLoop.main.add(timer!, forMode: .default)
        }}
    
    enum FeedError: Error {
        case fieldIsEmpty
        case incorrectData
    }
    
    @objc private func alarmNote(){
        countOfUnsecTr += 1
        // аларм, что не успели
        let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyTimeCheckWordExpired, comment: ""),
                                      message: NSLocalizedString(LocalizitedKeys.keyTryAgainFaster, comment: ""),
                                      preferredStyle: .alert)
        let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyTimeAlertOk, comment: ""),
                                        style: .default)
        alarm.addAction(alarmAction)
        present(alarm, animated: true)
    }
    
    private func isTextFieldEmpty(for textFied: String?) -> Bool {
        if textFied == "" {
            return true
        } else {
            return false
        }
    }
    
    @objc private func checker() {
        
        // отключаем таймер
        timer?.invalidate()
        timer = nil
        
        // уберем клавиатуру, чтобы пользователь за новым словом пошел в поле
        view.endEditing(true)
        
        print("Количество попыток, при которых пользователь не успел ввести слово за 15 секунд - ",countOfUnsecTr)
        
        if isTextFieldEmpty(for: textField.text) == true {
            // Поскольку два режима, то явно выявить можно один, а второй через исключение
            // Если поле пустое, то 1 режим
            // Иначе - без указания на режим
            let typeOfAction = 1
            //if textField.text == "" {
            do {
                try makeAlarmForError(typeOfError: typeOfAction)
            } catch FeedViewController.FeedError.fieldIsEmpty {
                // поле пустое
                let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyNotEnteredField, comment: ""),
                                              message: NSLocalizedString(LocalizitedKeys.keyEnteredDataInFiled, comment: "") ,
                                              preferredStyle: .alert)
                let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyTimeAlertOk, comment: ""),
                                                style: .default)
                alarm.addAction(alarmAction)
                present(alarm, animated: true)
            } catch FeedViewController.FeedError.incorrectData {
                // поле заполнено невалидными данными (по идее это никогда не произойдет тк на поле нет таких ограничений)
                let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyThereIsNoCorrectData, comment: ""),
                                              message: NSLocalizedString(LocalizitedKeys.keyCheckInteredDataAndTryAgain, comment: ""),
                                              preferredStyle: .alert)
                let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyTimeAlertOk, comment: ""),
                                                style: .default)
                alarm.addAction(alarmAction)
                present(alarm, animated: true)
            } catch {
                // по идее это какая-то ошибка, которую мы вообще не знаем сейчас, поэтому задаем общее наименование
                let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyUnexpectedError, comment: ""),
                                              message: NSLocalizedString(LocalizitedKeys.keyUnxpectedErrorText, comment: "") + error.localizedDescription,
                                              preferredStyle: .alert)
                let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyTimeAlertOk, comment: ""),
                                                style: .default)
                alarm.addAction(alarmAction)
                present(alarm, animated: true)
            }
            
        } else {
            if FeedModel().check(word: textField.text!) {
                textFieldResult.text = NSLocalizedString(LocalizitedKeys.keyYes, comment: "")
                textFieldResult.textColor = .green
            } else {
                textFieldResult.text = NSLocalizedString(LocalizitedKeys.keyNo, comment: "")
                textFieldResult.textColor = .red
            }
        }
        
    }
    // метод позволяет выкинуть ошибку и к ней создать Аларм
    // поскольку ошибок только 2, то можно расписать так
    private func makeAlarmForError(typeOfError type: Int) throws {
        if type == 1 {
            throw FeedViewController.FeedError.fieldIsEmpty }
        else {
            throw FeedViewController.FeedError.incorrectData
        }
    }
    
    @objc private func showPost(){
        let postScene = PostViewController()
        self.navigationController?.pushViewController(postScene, animated: true)
        postScene.title = post.title
    }
    
    func isCurrentThemeDark(){
        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark) {
            print("Current Theme is dark")
            // меняю цвет вью на серый
            view.backgroundColor = .lightGray
            // меняю фон NavigationBar на серый
            navigationController?.navigationBar.backgroundColor = .lightGray
        } else {
            print("Current Theme is not dark or I can not recognize it")
        }
    }
}

//var post = Post(title: "Поменял текст в заголовке")
var post = Post(title: NSLocalizedString(LocalizitedKeys.keyChangeTitileButtonText, comment: ""),
                author: "Self",
                description: "bla",
                image: "cat.png",
                likes: 5,
                views: 5,
                uniqID: UUID().uuidString)
