
from django.contrib import admin
from django.urls import path
from .import views

urlpatterns = [
    path('',views.index),
    path('login',views.logins),
    path('logout',views.logout_view),
    path('registration',views.registration),
    path('userhome',views.userhome),
    path('user_bus_booking',views.user_bus_booking),
    path('user_bus_seatbooking',views.user_bus_seatbooking),
    path('user_payment_successful',views.user_payment_successful),
    path('userprofile',views.userprofile),
    path('user_booking_history',views.user_booking_history),
    path('user_booking_cancel/<id>',views.user_booking_cancel),
    path('user_otherplaces',views.user_otherplaces),
    path('usercomplaint',views.usercomplaint),
    path('adminhome',views.adminhome),
    path('admincomplaint',views.admincomplaint),
    path('admin_buses',views.admin_buses),
    path('comp_reply/<id>',views.comp_reply),
    path('stationmaster',views.stationmasters),
    path('stationmaster_profile',views.stationmaster_profile),
    path('stationmaster_buses',views.stationmaster_buses),
    path('updt_stationmaster_buses/<id>',views.updt_stationmaster_buses),
    path('delete_stationmaster_buses/<id>',views.delete_stationsmaster_buses),
    path('stationmaster_routes',views.stationmaster_routes),
    path('delete_route/<id>',views.delete_route),
    path('stationmaster_trips',views.stationmaster_trips),
    path('stationmaster_trips/<id>',views.updt_stationmaster_trips),
    path('delete_stationmaster_trips/<id>',views.delete_stationmaster_trips),
    path('stationmaster_trip_status/<id>',views.stationmaster_trip_status),
    path('admincustomers',views.admincustomers),
    path('admin_otherplaces',views.admin_otherplaces),
    path('delete_otherplaces/<id>',views.delete_otherplaces),
    path('updt_otherplaces/<id>',views.updt_otherplaces),
    path('admin_stations',views.admin_stations),
    path('updt_adminstations/<id>',views.updt_adminstations),
    path('delete_adminstations/<id>',views.delete_adminstations),
    path('admin_places',views.admin_places),
    path('updt_places/<id>',views.updt_places),
    path('delete_places/<id>',views.delete_places),
    path('admin_employee',views.admin_employee),
    path('updt_stationmaster_employee/<id>',views.updt_stationmaster_employee),
    path('delete_stationmaster_employee/<id>',views.delete_stationmaster_employee),
    
    
    
    
    #________________________________
    
    path('views/andro_login', views.andro_login, name='andro_login'),
    path('views/viewtrips', views.viewtrips, name='viewtrips'),
    path('views/viewseat', views.viewseat, name='viewseat'),
    path('views/updatepasslocation', views.updatepass_location, name='viewseat'),
    path('views/Conductor_update_location', views.Conductor_update_location, name='Conductor_update_location'),
    path('views/Bus_view_reservation', views.Bus_view_reservation, name='Conductor_update_location'),
    
    
    
    
]
