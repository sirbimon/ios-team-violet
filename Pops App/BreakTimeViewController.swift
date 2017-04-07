
import UIKit

class BreakTimeViewController: UIViewController {

    let viewModel = BreakTimeViewModel.singleton
    
    lazy var viewWidth: CGFloat = self.view.frame.width
    lazy var viewHeight: CGFloat = self.view.frame.height
    lazy var itemWidth: CGFloat = self.view.frame.width * (269/self.view.frame.width)
    lazy var itemHeight: CGFloat = self.view.frame.height * (45/self.view.frame.height)
    
    let entertainMeButton = UIButton()
    let lineDividerView = UIView()
    let characterMessageHeader = UILabel()
    let characterMessageBody = UILabel()
    let circleBackgroundForCharacterImageView = UIImageView()
    let headerView = UIView()
    let userAppsBackgroundView = UIView()
    let settingsButton = UIButton()
    let leaderBoardButton = UIButton()
    
    let popsWindowView = UIView()
    let popsIcon = UIImageView()
    
    var popsBottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUserAppsBackground()
        setupUserApps()
        setupEntertainMeButton()
        setupLineDividerView()
        setupCharacterMessageBody()
        setupCharacterMessageHeader()
        setupPopsWindow()
        setupPopsIcon()
        setupHeaderView()
        setupSettingsButton()
        setupLeaderBoardButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animatePopsPopup()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func presentBreakEntertainmentVC() {
        let breakEntertainmentVC = BreakEntertainmentViewController()
        present(breakEntertainmentVC, animated: false, completion: nil)
    }
    
    func setupEntertainMeButton() {
        entertainMeButton.backgroundColor = Palette.lightBlue.color
        entertainMeButton.layer.cornerRadius = 2.0
        entertainMeButton.layer.masksToBounds = true
        entertainMeButton.setTitle("entertain me", for: .normal)
        entertainMeButton.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14.0)
        entertainMeButton.addTarget(self, action: #selector(presentBreakEntertainmentVC), for: .touchUpInside)
        
        view.addSubview(entertainMeButton)
        entertainMeButton.translatesAutoresizingMaskIntoConstraints = false
        entertainMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        entertainMeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 269/viewWidth).isActive = true
        entertainMeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 45/viewHeight).isActive = true
        entertainMeButton.bottomAnchor.constraint(equalTo: userAppsBackgroundView.topAnchor, constant: -viewHeight * (90.0/667.0)).isActive = true
    }
    
    func setupLineDividerView() {
        lineDividerView.backgroundColor = Palette.lightGrey.color
        lineDividerView.layer.cornerRadius = 2.0
        lineDividerView.layer.masksToBounds = true
        
        view.addSubview(lineDividerView)
        lineDividerView.translatesAutoresizingMaskIntoConstraints = false
        lineDividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineDividerView.bottomAnchor.constraint(equalTo: entertainMeButton.topAnchor, constant: -viewHeight * (25/viewHeight)).isActive = true
        lineDividerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 269/viewWidth).isActive = true
        lineDividerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/viewHeight).isActive = true
    }
    
    func setupCharacterMessageBody() {
        characterMessageBody.numberOfLines = 0
        characterMessageBody.textColor = Palette.grey.color
        characterMessageBody.textAlignment = .left
        characterMessageBody.font = UIFont(name: "Avenir-Heavy", size: 14.0)
        characterMessageBody.text = "I made it easy for you to catch up on texts, email and Facebook. I’m also pretty entertaining, so feel free to spend your break with me."
        
        view.addSubview(characterMessageBody)
        characterMessageBody.translatesAutoresizingMaskIntoConstraints = false
        characterMessageBody.bottomAnchor.constraint(equalTo: lineDividerView.topAnchor, constant: -viewHeight * (20/viewHeight)).isActive = true
        characterMessageBody.leadingAnchor.constraint(equalTo: lineDividerView.leadingAnchor).isActive = true
        characterMessageBody.trailingAnchor.constraint(equalTo: lineDividerView.trailingAnchor).isActive = true
    }
    
    func setupCharacterMessageHeader() {
        characterMessageHeader.numberOfLines = 0
        characterMessageHeader.textColor = UIColor.black
        characterMessageHeader.textAlignment = .left
        characterMessageHeader.font = UIFont(name: "Avenir-Black", size: 14.0)
        characterMessageHeader.text = "It’s time for a 5 minute break!"
        
        view.addSubview(characterMessageHeader)
        characterMessageHeader.translatesAutoresizingMaskIntoConstraints = false
        characterMessageHeader.bottomAnchor.constraint(equalTo: characterMessageBody.topAnchor, constant: -viewHeight * (5/viewHeight)).isActive = true
        characterMessageHeader.leadingAnchor.constraint(equalTo: characterMessageBody.leadingAnchor).isActive = true
        characterMessageHeader.trailingAnchor.constraint(equalTo: characterMessageBody.trailingAnchor).isActive = true
    }
    
    func setupPopsWindow() {
        view.addSubview(popsWindowView)
        popsWindowView.translatesAutoresizingMaskIntoConstraints = false
        popsWindowView.backgroundColor = Palette.salmon.color
        popsWindowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popsWindowView.bottomAnchor.constraint(equalTo: characterMessageHeader.topAnchor, constant: -viewHeight * (40/667)).isActive = true
        popsWindowView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        popsWindowView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        popsWindowView.layer.cornerRadius = 50.0
        popsWindowView.layer.masksToBounds = true
    }
    
    func setupPopsIcon() {
        popsIcon.image = UIImage(named: "IC_POPS")
        popsIcon.contentMode = .scaleAspectFit
        
        popsWindowView.addSubview(popsIcon)
        popsIcon.translatesAutoresizingMaskIntoConstraints = false
        popsIcon.backgroundColor = UIColor.clear
        
        popsBottomAnchorConstraint = popsIcon.bottomAnchor.constraint(equalTo: popsWindowView.bottomAnchor, constant: 100)
        popsBottomAnchorConstraint.isActive = true
        popsIcon.centerXAnchor.constraint(equalTo: popsWindowView.centerXAnchor, constant: 0).isActive = true
        popsIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        popsIcon.widthAnchor.constraint(equalToConstant: 52).isActive = true
        popsIcon.layer.masksToBounds = true
    }
    
    func setupHeaderView() {
        headerView.backgroundColor = Palette.salmon.color
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: viewHeight * (5/viewHeight)).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func setupUserAppsBackground() {
        userAppsBackgroundView.backgroundColor = Palette.lightGrey.color
        view.addSubview(userAppsBackgroundView)
        
        userAppsBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        userAppsBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        userAppsBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        userAppsBackgroundView.heightAnchor.constraint(equalToConstant: viewHeight * (110/667)).isActive = true
        userAppsBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupUserApps() {
        let messagesApp = UIView()
        messagesApp.backgroundColor = Palette.green.color
        
        let messagesIconView = UIImageView()
        messagesIconView.image = UIImage(named: "IC_MessagesApp")
        messagesApp.addSubview(messagesIconView)
        messagesIconView.translatesAutoresizingMaskIntoConstraints = false
        messagesIconView.widthAnchor.constraint(equalToConstant: viewWidth * (22/375)).isActive = true
        messagesIconView.heightAnchor.constraint(equalToConstant: viewWidth * (22/375)).isActive = true
        messagesIconView.centerYAnchor.constraint(equalTo: messagesApp.centerYAnchor).isActive = true
        messagesIconView.centerXAnchor.constraint(equalTo: messagesApp.centerXAnchor).isActive = true
        
        let emailApp = UIView()
        emailApp.backgroundColor = Palette.salmon.color
        
        let emailIconView = UIImageView()
        emailIconView.image = UIImage(named: "IC_Email App")
        emailApp.addSubview(emailIconView)
        emailIconView.translatesAutoresizingMaskIntoConstraints = false
        emailIconView.widthAnchor.constraint(equalToConstant: viewWidth * (20/375)).isActive = true
        emailIconView.heightAnchor.constraint(equalToConstant: viewWidth * (20/375)).isActive = true
        emailIconView.centerYAnchor.constraint(equalTo: emailApp.centerYAnchor).isActive = true
        emailIconView.centerXAnchor.constraint(equalTo: emailApp.centerXAnchor).isActive = true
        
        let facebookApp = UIView()
        facebookApp.backgroundColor = Palette.navy.color
        
        let facebookIconView = UIImageView()
        facebookIconView.image = UIImage(named: "facebook")
        facebookApp.addSubview(facebookIconView)
        facebookIconView.translatesAutoresizingMaskIntoConstraints = false
        facebookIconView.widthAnchor.constraint(equalToConstant: viewWidth * (20/375)).isActive = true
        facebookIconView.heightAnchor.constraint(equalToConstant: viewWidth * (20/375)).isActive = true
        facebookIconView.centerYAnchor.constraint(equalTo: facebookApp.centerYAnchor).isActive = true
        facebookIconView.centerXAnchor.constraint(equalTo: facebookApp.centerXAnchor).isActive = true
        
        let apps = [messagesApp, emailApp, facebookApp]
        
        apps.forEach { (app) in
            app.translatesAutoresizingMaskIntoConstraints = false
            app.heightAnchor.constraint(equalToConstant: viewWidth * (70/375)).isActive = true
            app.widthAnchor.constraint(equalToConstant: viewWidth * (70/375)).isActive = true
            app.layer.cornerRadius = (viewWidth * (70/375)) / 2
            app.layer.masksToBounds = true
        }
        
        let stackView = UIStackView(arrangedSubviews: apps)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
    
        userAppsBackgroundView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: userAppsBackgroundView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: userAppsBackgroundView.centerYAnchor).isActive = true
    }
    
    func setupSettingsButton() {
        settingsButton.setBackgroundImage(#imageLiteral(resourceName: "IC_Settings-1"), for: .normal)
        
        headerView.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0).isActive = true
        settingsButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 21.0).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 21.0).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 21.0).isActive = true
    }
    
    func setupLeaderBoardButton() {
        leaderBoardButton.setBackgroundImage(#imageLiteral(resourceName: "IC_Leaderboard"), for: .normal)
        
        headerView.addSubview(leaderBoardButton)
        leaderBoardButton.translatesAutoresizingMaskIntoConstraints = false
        leaderBoardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0).isActive = true
        leaderBoardButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 21.0).isActive = true
        leaderBoardButton.heightAnchor.constraint(equalToConstant: 21.0).isActive = true
        leaderBoardButton.widthAnchor.constraint(equalToConstant: 23.0).isActive = true
    }
    
    func animatePopsPopup() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            self.popsBottomAnchorConstraint.constant = 10
            self.view.layoutIfNeeded()
        }
    }



}