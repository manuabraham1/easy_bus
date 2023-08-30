from django.db import models

# Create your models here.

class login(models.Model):
    username=models.CharField(max_length=50)
    password=models.CharField(max_length=50)
    usertype=models.CharField(max_length=20)
    
class tb_customer(models.Model):
    login=models.ForeignKey('login',on_delete=models.CASCADE)
    first_name=models.CharField(max_length=60)
    last_name=models.CharField(max_length=60)
    dob=models.CharField(max_length=20)
    gender=models.CharField(max_length=20)
    phone=models.CharField(max_length=20)
    email=models.CharField(max_length=50)
    

class tb_complaints(models.Model):
    customer=models.ForeignKey('tb_customer',on_delete=models.CASCADE)
    description=models.CharField(max_length=100)
    reply=models.CharField(max_length=100)
    complaint_date=models.CharField(max_length=10)
    
class stationmaster(models.Model):
    login=models.ForeignKey('login',on_delete=models.CASCADE)
    first_name=models.CharField(max_length=60)
    last_name=models.CharField(max_length=60)
    dob=models.CharField(max_length=20)
    gender=models.CharField(max_length=20)
    phone=models.CharField(max_length=20)
    email=models.CharField(max_length=50)
    place=models.CharField(max_length=40)

class places(models.Model):
    place_name=models.CharField(max_length=50)
    latitude=models.CharField(max_length=40)
    longitude=models.CharField(max_length=40)
    
class stations(models.Model):
    place=models.ForeignKey('places',on_delete=models.CASCADE)
    stationmaster=models.ForeignKey('stationmaster',on_delete=models.CASCADE)
    
class other_places(models.Model):
    other_places_name=models.CharField(max_length=50)
    other_places_type=models.CharField(max_length=50)
    latitude=models.CharField(max_length=40)
    longitude=models.CharField(max_length=40)
    
class routes(models.Model):
    route_name=models.CharField(max_length=50)
    starting_place=models.ForeignKey('places',on_delete=models.CASCADE,related_name='routes_starting')
    ending_place=models.ForeignKey('places',on_delete=models.CASCADE,related_name='routes_ending')
    station=models.ForeignKey('stations',on_delete=models.CASCADE)
    
class buses(models.Model):
    bus_name=models.CharField(max_length=50)
    station=models.ForeignKey('stations',on_delete=models.CASCADE)
    registration_number=models.CharField(max_length=40)
    seat_count=models.CharField(max_length=5)
    default_seat_count=models.CharField(max_length=5)
    fare_rate=models.CharField(max_length=4)
    
class trips(models.Model):
    bus=models.ForeignKey('buses',on_delete=models.CASCADE)
    route=models.ForeignKey('routes',on_delete=models.CASCADE)
    starting_time=models.CharField(max_length=15)
    ending_time=models.CharField(max_length=15)
    no_of_stops=models.CharField(max_length=10)
    trip_date=models.CharField(max_length=20)
    station=models.ForeignKey('stations',on_delete=models.CASCADE)
    trip_status=models.CharField(max_length=20)
    
class stops(models.Model):
    trip=models.ForeignKey('trips',on_delete=models.CASCADE)
    place=models.ForeignKey('places',on_delete=models.CASCADE)
    time=models.CharField(max_length=10)
    fare_rate=models.IntegerField()
    
class reservations(models.Model):
    no_of_seats=models.CharField(max_length=3)
    user=models.ForeignKey('tb_customer',on_delete=models.CASCADE)
    trip=models.ForeignKey('trips',on_delete=models.CASCADE)
    from_stop=models.ForeignKey('stops',on_delete=models.CASCADE,related_name='from_stop')
    to_stop=models.ForeignKey('stops',on_delete=models.CASCADE,related_name='to_stop')
    reservation_amount=models.CharField(max_length=5)
    reservation_status=models.CharField(max_length=15)

class payment(models.Model):
    payment_method=models.CharField(max_length=20)
    reservation=models.ForeignKey('reservations',on_delete=models.CASCADE)
    amount=models.CharField(max_length=5)
    payment_date=models.CharField(max_length=10)
    
class tbl_conductor(models.Model):
    conductor_id = models.AutoField(primary_key=True)
    login =models.ForeignKey(login,on_delete=models.CASCADE)
    bus = models.ForeignKey(buses,on_delete=models.CASCADE)
    cfname =models.CharField(max_length=100)
    clname =models.CharField(max_length=100)
    gender=models.CharField(max_length=20)
    cdob = models.CharField(max_length=100)
    cphone = models.CharField(max_length=100)
    email=models.CharField(max_length=50)
    place=models.CharField(max_length=40)
    
class tbl_bus_location(models.Model):
    location=models.AutoField(primary_key=True)
    bus =models.ForeignKey(buses,on_delete=models.CASCADE)
    latitude=models.CharField(max_length=100)
    longitude=models.CharField(max_length=100)