//
//  ViewController.swift
//  Weather app
//
//  Created by Сергей Золотухин on 27.12.2021.
//

import UIKit
import SnapKit
import CoreLocation

class MainViewController: UIViewController {
    
    //MARK: - View units options
    
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
        //        label.text = "Core location"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chooseCityButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "menu-icon")
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.layer.shadowOffset = CGSize(width: 5, height: 2)
        button.layer.shadowRadius = 8.8
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //        label.text = "+9 C"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionImage: UIImageView = {
        let imageView = UIImageView()
        //        imageView.image = UIImage(named: "01d")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherConditionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //        label.text = "Sunny"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Feels like:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let feelsLikeValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //        label.text = "-10"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Wind speed:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeedValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //        label.text = "4"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hourlyForecastLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Hourly forecast"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hourlyForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 107/255, green: 177/255, blue: 218/255, alpha: 1)
        collectionView.bounces = false
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let tenDaysForecastLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "10-DAY FORECAST"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tenDaysForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 107/255, green: 177/255, blue: 218/255, alpha: 1)
        tableView.register(tenDaysForecastCellTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private var minTemperatureStackView = UIStackView()
    private var maxTemperatureStackView = UIStackView()
    private var minAndMAxTemperaturStackView = UIStackView()
    
    //MARK: - Constants and variables
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var models = [DayWeather]()
    var modelsHourly = [HourlyWeather]()
    var current: CurrentWeather?
    
    //MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        tableViewDelegate()
        collectionViewDelegate()
        setConstraints()
        
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupLocation()
    }
    
    //MARK: - COnfigurations
    
    private func config() {
        
    }
    
    //MARK: - Setup views
    
    private func setupViews() {
        
        minTemperatureStackView = UIStackView(arrangedSubViews: [feelsLikeLabel, feelsLikeValueLabel],
                                              axis: .horizontal,
                                              spacing: 0,
                                              distribution: .fillEqually)
        
        maxTemperatureStackView = UIStackView(arrangedSubViews: [windSpeedLabel, windSpeedValueLabel],
                                              axis: .horizontal,
                                              spacing: 0,
                                              distribution: .fillEqually)
        minAndMAxTemperaturStackView = UIStackView(arrangedSubViews: [minTemperatureStackView, maxTemperatureStackView],
                                                   axis: .horizontal,
                                                   spacing: 5,
                                                   distribution: .fillEqually)
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(currentCityLabel)
        backgroundView.addSubview(chooseCityButton)
        backgroundView.addSubview(currentTemperatureLabel)
        backgroundView.addSubview(conditionImage)
        backgroundView.addSubview(weatherConditionLabel)
        backgroundView.addSubview(minAndMAxTemperaturStackView)
        backgroundView.addSubview(hourlyForecastLabel)
        backgroundView.addSubview(hourlyForecastCollectionView)
        backgroundView.addSubview(tenDaysForecastLabel)
        backgroundView.addSubview(tenDaysForecastTableView)
    }
    
    private func tableViewDelegate() {
        tenDaysForecastTableView.delegate = self
        tenDaysForecastTableView.dataSource = self
    }
    
    private func collectionViewDelegate() {
        hourlyForecastCollectionView.delegate = self
        hourlyForecastCollectionView.dataSource = self
    }
    
    //MARK: - Update main view
    
    func updateMainView() {
        guard let current = current else { return }
        
        currentTemperatureLabel.text = "\(Int(current.temp))°"
        weatherConditionLabel.text = "\(current.weather.first!.main)"
        conditionImage.image = UIImage(named: current.weather.first!.icon)
        feelsLikeValueLabel.text = "\(Int(current.feels_like))°"
        windSpeedValueLabel.text = "\(Int(current.wind_speed))"
    }
    
    //MARK: - Location
    
    func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        // проверка, включены ли службы геолокации
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            //устанавливаем необходимую точность
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            //запускаем слежение за нашим местоположением
            locationManager.startUpdatingLocation()
        }
    }
}

//MARK: - UITableView

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tenDaysForecastCellTableViewCell
        cell.configureCell(with: models[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

//MARK: CollectionView

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelsHourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HourlyForecastCollectionViewCell
        
        cell.configureCVCell(with: modelsHourly[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: 100,
            height: collectionView.frame.height
        )
    }
}

//MARK: - Location manager

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            guard let currentLocation = currentLocation else { return }
            requestWeatherForLocation(long: currentLocation.coordinate.longitude,
                                      lat: currentLocation.coordinate.latitude)
            
            getPlaceFrom(location: currentLocation) { cityName, error in }
        }
    }
    
    func getPlaceFrom(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] place, error in
            
            guard let self = self else { return }
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = place?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            let cityName = placemark.locality
            
            DispatchQueue.main.async {
                self.currentCityLabel.text = cityName
            }
            
            completion(place, error)
        }
    }
    
    @objc private func menuButtonTapped() {
        let chooseCityVC = ChooseCityViewController()
        self.present(chooseCityVC, animated: true)
    }
}

extension MainViewController {
    
    func requestWeatherForLocation(long: Double, lat: Double) {
        
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=alerts,minutely&units=metric&appid=\(apiKey)"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard let data = data else { return }
            
            var mapped: WeatherData?
            
            do {
                mapped = try JSONDecoder().decode(WeatherData.self, from: data)
                
            } catch let error {
                print(error)
            }
            
            guard let result = mapped else { return }
            
            let entries = result.daily
            self.models.append(contentsOf: entries)
            
            let hourlyEntries = result.hourly
            self.modelsHourly.append(contentsOf: hourlyEntries)
            
            let current = result.current
            self.current = current
            
            DispatchQueue.main.async { [self] in
                updateMainView()
                tenDaysForecastTableView.reloadData()
                hourlyForecastCollectionView.reloadData()
            }
        }
        task.resume()
    }
}

//MARK: - SetConstraints

extension MainViewController {
    
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
        
        chooseCityButton.snp.makeConstraints { make in
            make.right.equalTo(backgroundView).inset(30)
            make.top.equalTo(backgroundView).inset(100)
            make.height.width.equalTo(35)
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(currentCityLabel.snp.bottom).offset(0)
        }
        
        conditionImage.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(currentTemperatureLabel.snp.bottom).offset(5)
            make.height.width.equalTo(65)
        }
        
        weatherConditionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(conditionImage.snp.bottom).offset(5)
        }
        
        minAndMAxTemperaturStackView.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(weatherConditionLabel.snp.bottom).offset(5)
        }
        
        hourlyForecastLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(minAndMAxTemperaturStackView.snp.bottom).offset(20)
        }
        
        hourlyForecastCollectionView.snp.makeConstraints { make in
            make.right.left.equalTo(10)
            make.top.equalTo(hourlyForecastLabel.snp.bottom).offset(5)
            make.height.equalTo(100)
        }
        
        tenDaysForecastLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(hourlyForecastCollectionView.snp.bottom).offset(20)
        }
        
        tenDaysForecastTableView.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView)
            make.top.equalTo(tenDaysForecastLabel.snp.bottom).offset(10)
            make.bottom.equalTo(backgroundView).inset(10)
            make.right.left.equalTo(backgroundView).inset(10)
        }
    }
}
