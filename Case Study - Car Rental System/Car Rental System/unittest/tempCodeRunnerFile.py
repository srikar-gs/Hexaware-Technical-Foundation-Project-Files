    def test_create_car(self):
        # Test case to check if a car is created successfully
        vehicle_id= int(input("Enter Id: "))
        make = input("Enter make: ")
        model = input("Enter model: ")
        year = int(input("Enter year: "))
        daily_rate = float(input("Enter daily rate: "))
        available = bool(input("Enter status: "))
        passenger_capacity = int(input("Enter passenger capacity: "))
        engine_capacity = int(input("Enter engine capacity: "))

        car = Vehicle(vehicle_id=vehicle_id,make=make, model=model, year=year, daily_rate=daily_rate, available=available,passenger_capacity=passenger_capacity, engine_capacity=engine_capacity)

        car_id = self.service_provider.add_car(car)
        self.assertIsNone(car_id)