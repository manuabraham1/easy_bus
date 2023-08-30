from django.shortcuts import render,HttpResponse
from django.http import JsonResponse
from my_application.models import*
from django.contrib.auth import logout
from django.shortcuts import redirect
from datetime import date,datetime
from django.core.mail import send_mail
from django.db.models import Q,F
from django.db.models import Count
import requests

def index(request):
    q=places.objects.all()
    if request.method=="POST":
        origin=request.POST['origin']
        destination=request.POST['destination']
        date=request.POST['busdate']
        s=1
        if origin==destination:
            return HttpResponse("<script> alert('Your Source and Destination are Same');window.location=''</script>")
        # t=stops.objects.filter(Q(place_id=origin)| Q(place_id=destination))
        # trip = trips.objects.filter(id__in=stops.objects.filter(t))
        og=places.objects.get(id=origin)
        dt=places.objects.get(id=destination)
        combined_stops_query = stops.objects.none()
        
        try:
            
            # tripp = trips.objects.filter(Q(stops__place=og) | Q(stops__place=dt)).filter(trip_date=date).annotate(count=Count('id')).filter(count__gte=2,stops__place=og,stops__id__lt=F('stops__trip_id__stops__id'),stops__trip_id__stops__place=dt)
            
            tripp = trips.objects.filter(
            Q(stops__place=og) | Q(stops__place=dt),
            trip_date=date,trip_status='scheduled'
            ).annotate(
                count=Count('id'),
            ).filter(
                count__gte=2,
                stops__place=og,
                stops__id__lt=F('stops__trip_id__stops__id'),
                stops__trip_id__stops__place=dt,
            ).annotate(
                fare_difference=F('stops__trip_id__stops__fare_rate') - F('stops__fare_rate')
            )
                
            print(tripp)
            if not tripp:
                return HttpResponse("<script> alert('No Bus Service for this Sources and Destinations');window.location=''</script>")
            else:
                for tr in tripp:
                
                    combined_stops_query |= stops.objects.filter(trip=tr).filter(Q(place=og) | Q(place=dt))

                    
                print(combined_stops_query)
            
        except:
            return HttpResponse("<script> alert('No Bus Service for this Sources and Destinations');window.location=''</script>")
        
        
        return render(request,'index.html',{'date':date,'s':s,'trip':tripp,'og':og,'dt':dt,'stop':combined_stops_query})
    return render(request,'index.html',{'place':q})

def logout_view(request):
    logout(request)
    return redirect('/login')


def userhome(request):
    try:
        request.session['login_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q1=places.objects.all()
    if request.session['login_id']:
        userid=request.session['login_id']
        id=login.objects.get(id=userid)
        q=tb_customer.objects.get(login=id)
        if q:
            name=q.first_name
    if request.method=="POST":
        origin=request.POST['origin']
        destination=request.POST['destination']
        date=request.POST['busdate']
        s=1
        if origin==destination:
            return HttpResponse("<script> alert('Your Source and Destination are Same');window.location='userhome'</script>")
        
        
        og=places.objects.get(id=origin)
        dt=places.objects.get(id=destination)
        combined_stops_query = stops.objects.none()
        
        try:
            
            # tripp = trips.objects.filter(Q(stops__place=og) | Q(stops__place=dt)).filter(trip_date=date).annotate(count=Count('id')).filter(count__gte=2,stops__place=og,stops__id__lt=F('stops__trip_id__stops__id'),stops__trip_id__stops__place=dt)
            tripp = trips.objects.filter(
            Q(stops__place=og) | Q(stops__place=dt),
            trip_date=date,trip_status='scheduled'
            ).annotate(
                count=Count('id'),
            ).filter(
                count__gte=2,
                stops__place=og,
                stops__id__lt=F('stops__trip_id__stops__id'),
                stops__trip_id__stops__place=dt,
            ).annotate(
                fare_difference=F('stops__trip_id__stops__fare_rate') - F('stops__fare_rate')
            )
                
            print(tripp)
            if not tripp:
                return HttpResponse("<script> alert('No Bus Service for this Sources and Destinations');window.location=''</script>")
            else:
                for tr in tripp:
                
                    combined_stops_query |= stops.objects.filter(trip=tr).filter(Q(place=og) | Q(place=dt))
            
        except:
            return HttpResponse("<script> alert('No Bus Service for this Sources and Destinations');window.location=''</script>")
    

        return render(request,'user_home.html',{'date':date,'s':s,'name':name,'trip':tripp,'stop':combined_stops_query,'og':og,'dt':dt})
    return render(request,'user_home.html',{'name':name,'place':q1})


def user_booking_history(request):
    if request.session['login_id']:
            userid=request.session['login_id']
            id=login.objects.get(id=userid)
            q=tb_customer.objects.get(login=id)
    res=reservations.objects.filter(user=q).order_by('-id')
    formatted_reservations = []
    for reservation in res:
        trip_date_str = reservation.trip.trip_date
        trip_date_obj = datetime.strptime(trip_date_str, "%Y-%m-%d").date()
        formatted_trip_date = trip_date_obj.strftime("%d-%m-%Y")

        payments = payment.objects.filter(reservation_id=reservation.id)
        total_amount = sum(int(payment_obj.amount) for payment_obj in payments)
        
        bus_loc= tbl_bus_location.objects.filter(bus=reservation.trip.bus)
        
        for i in bus_loc:
            lati=i.latitude
            longi=i.longitude
        if reservation.trip.trip_status=='departed':
            distance2=get_distance(lati, longi, reservation.from_stop.place.latitude, reservation.from_stop.place.longitude)
            distance1 = get_distance(lati, longi, reservation.to_stop.place.latitude, reservation.to_stop.place.longitude)
            print(distance1)
            dist2=distance2['distance']
            dist1=distance1['distance']
            hduration2=distance2['duration_hours']
            hduration1=distance1['duration_hours']
            mduration2=distance2['duration_minutes']
            mduration1=distance2['duration_minutes']
        else:
            dist1=None
            dist2=None
            hduration1=None
            hduration2=None
            mduration2=None
            mduration1=None
        # print(reservation.to_stop.place.latitude)
        # print(reservation.to_stop.place.longitude)
        
        formatted_reservation = {
            'id': reservation.id,
            'cust1':reservation.user.first_name,
            'cust2':reservation.user.last_name,
            'trip': reservation.trip.route.route_name,
            'trip_date_formatted': formatted_trip_date,
            'bus_name':reservation.trip.bus.bus_name,
            'bus_reg':reservation.trip.bus.registration_number,
            'source': reservation.from_stop.place.place_name+'-- '+reservation.from_stop.time,
            'destination': reservation.to_stop.place.place_name+'-- '+reservation.to_stop.time,
            'no_of_seat': reservation.no_of_seats,
            'total_fare': total_amount,
            'trip_status': reservation.trip.trip_status,
            'lati': lati,
            'longi': longi,
            'distance1': dist1,
            'distance2': dist2,
            'hduration1': hduration1,
            'hduration2': hduration2,
            'mduration1': mduration1,
            'mduration2': mduration2,
                
        }

        formatted_reservations.append(formatted_reservation)    
    return render(request,'user_booking_history.html',{'resev':formatted_reservations,'res':res})


def get_distance(origin_lat, origin_lng, dest_lat, dest_lng):
                url = f"https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins={origin_lat},{origin_lng}&destinations={dest_lat},{dest_lng}&key=AIzaSyASPjP-qoSz1pYAV47A1cUY0TqdlmLls20"
                response = requests.get(url)
                data = response.json()

                # Extract distance in meters
                distance = data['rows'][0]['elements'][0]['distance']['value']/1000
                
                duration_seconds = data['rows'][0]['elements'][0]['duration']['value']
                duration_minutes = duration_seconds // 60
                duration_hours = duration_minutes // 60
                duration_minutes %= 60
                return {'distance':distance,'duration_hours':duration_hours,'duration_minutes':duration_minutes}

def user_booking_cancel(request,id):
    bc=reservations.objects.get(id=id)
    nseat=bc.no_of_seats
    amt=bc.reservation_amount
    totamt=int(amt)-10
    bus=bc.trip.bus
    totseat=int(bus.seat_count)+int(nseat)
    bus.seat_count=totseat
    bus.save()
    bc.delete()
    reply='Your Booking Cancellation is successful \n\nBooking Cancellation Details:\nCustomer Name: '+bc.user.first_name+' '+bc.user.last_name+'\nTotal Refundable Amount: '+str(totamt)+'\nYour payment will be refunded within 10 business working days'
    send_mail('Your Booking Cancellation is Successful',reply,'easybus578@gmail.com',[bc.user.email],fail_silently=False)
    return render(request,'user_cancellation.html',{'totamt':totamt})

def user_bus_booking(request):
    if request.method=="POST":
        fstop=request.POST['from_stop']
        tstop=request.POST['to_stop']
        fare_rate=request.POST['fare_rate']
        fstop=stops.objects.get(id=fstop)
        tstop=stops.objects.get(id=tstop)
        trp=stops.objects.filter(trip=fstop.trip)
        trpp=trips.objects.get(id=fstop.trip_id)
        seat_avail=buses.objects.get(id=trpp.bus_id)
        seat_ct=int(seat_avail.seat_count)
        start_time_str=fstop.time
        end_time_str=tstop.time
        start_time = datetime.strptime(start_time_str, '%H:%M')
        end_time = datetime.strptime(end_time_str, '%H:%M')
        time_difference = end_time - start_time
        hours = time_difference.seconds // 3600
        minutes = (time_difference.seconds % 3600) // 60
    return render(request,'user_bus_booking.html',{'fstop':fstop,'tstop':tstop,'hour':hours,'min':minutes,'trp':trp,'fare_rate':fare_rate,'seat_count':seat_ct})

def user_bus_seatbooking(request):
    if request.method=="POST":
        num_seat=request.POST['seat_count']
        base_fare=request.POST['base_fare']
        if num_seat == '7':
            num_seats=int(num_seat)-1
            total_fare=int(num_seats)*int(base_fare)
        else:
            total_fare=int(num_seat)*int(base_fare)
        from_stop=request.POST['from_stop']
        to_stop=request.POST['to_stop']
        trip_id=request.POST['trip_id']
        from_stop=stops.objects.get(id=from_stop)
        to_stop=stops.objects.get(id=to_stop)
        trip_id=trips.objects.get(id=trip_id)
    return render(request,'user_bus_seatbooking.html',{'total_fare':total_fare,'num_seat':num_seat,'base_fare':base_fare,'from_stop':from_stop,'to_stop':to_stop})    
        
def user_payment_successful(request):
    if request.method=="POST":
        num_seat=request.POST['num_seat']
        from_stop=request.POST['from_stop']
        to_stop=request.POST['to_stop']
        total_fare=request.POST['total_fare']
        payment_method=request.POST['payment-methods']
        from_stop=stops.objects.get(id=from_stop)
        to_stop=stops.objects.get(id=to_stop)
        trip=trips.objects.get(id=from_stop.trip_id)
        bus=buses.objects.get(id=from_stop.trip.bus_id)
        bs=int(bus.seat_count)
        ns=int(num_seat)
        bus.seat_count=bs-ns
        bus.save()
        if request.session['login_id']:
            userid=request.session['login_id']
            id=login.objects.get(id=userid)
            q=tb_customer.objects.get(login=id)
        res=reservations(no_of_seats=num_seat,reservation_amount=total_fare,reservation_status='Confirmed',from_stop=from_stop,to_stop=to_stop,trip=trip,user=q)
        c_date=date.today()
        p=payment(payment_method=payment_method,amount=total_fare,payment_date=c_date,reservation=res)
        res.save()
        p.save()
        reply='Your Booking is successful \n\nBooking Details:\nCustomer Name: '+q.first_name+' '+q.last_name+'\nBooking Date: '+str(c_date)+'\nTrip Date: '+trip.trip_date+'\nBus Name: '+trip.bus.bus_name+' ('+trip.bus.registration_number+')\nFrom Place and Time: '+from_stop.place.place_name+' '+from_stop.time+'\nTo Place and Time: '+to_stop.place.place_name+' '+from_stop.time+'\nNumber of Seats: '+num_seat+'\nTotal Fare: '+total_fare+'\nPayment Method: '+payment_method
        send_mail('Your Booking is Successful',reply,'easybus578@gmail.com',[q.email],fail_silently=False)
    return render(request,'user_payment_successful.html',{'from_stop':from_stop,'to_stop':to_stop,'total_fare':total_fare,'current_date':c_date})

       
def user_otherplaces(request):
    try:
        request.session['login_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=other_places.objects.all()
    return render(request,'user_otherplaces.html',{'places':obj})

def usercomplaint(request):
    c_date=date.today()
    try:
        request.session['login_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    lid=request.session['login_id']
    qq=tb_customer.objects.get(login_id=lid)
    q=tb_complaints.objects.filter(customer=qq.id).order_by('-id')
    if qq:
        cid=qq.id
    if request.method=="POST":
        message=request.POST['message']
        q=tb_complaints(description=message,reply='pending',complaint_date=c_date,customer_id=cid)
        q.save()
        return HttpResponse("<script> alert('Your response has been recorded');window.location='usercomplaint'</script>")
    return render(request,'user_complaint.html',{'complaint':q})

def userprofile(request):
    try:
        request.session['login_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    userid=request.session['login_id']
    id=login.objects.get(id=userid)
    obj=tb_customer.objects.get(login=id)
    return render(request,'user_profile.html',{'cust':obj,'usern':id})

def logins(request):
    if request.method=="POST":
        user=request.POST['username']
        password=request.POST['password']
        try:
            q=login.objects.get(username=user,password=password)
            
            if q:
                if q.usertype=='user':
                    request.session['login_id']=q.pk
                    return HttpResponse("<script> alert('Login Success');window.location='userhome'</script>")
                elif q.usertype=='admin':
                    request.session['admin_id']=q.pk
                    return HttpResponse("<script> alert('Admin Login Success'); window.location='adminhome'</script>")
                elif q.usertype=='station_master':
                    request.session['station_id']=q.pk
                    return HttpResponse("<script> alert('Station Master Login Success'); window.location='stationmaster'</script>")
        except:
            return HttpResponse("<script> alert('Invalid username & password'); window.location='login'</script>")
    return render(request,'login.html')

def registration(request):
    if request.method=="POST":
        fname=request.POST['fname']
        lname=request.POST['lname']
        email=request.POST['email']
        phone=request.POST['phone']
        dob=request.POST['dob']
        gender=request.POST['gender']
        user=request.POST['username']
        password=request.POST['password']
        l=login.objects.filter(usertype='user')
        
        for i in l:
            c=tb_customer.objects.filter(login=i)
            for j in c:
                if(phone==j.phone):
                    return HttpResponse("<script> alert('Phone number already exist'); window.location='registration'</script>")
            if(user==i.username):
                return HttpResponse("<script> alert('Username already exist'); window.location='registration'</script>")
            if(user==i.username and password==i.password):
                return HttpResponse("<script> alert('Username and Password already exist'); window.location='registration'</script>")
        q=login(username=user,password=password,usertype='user')
        q.save()
        q1=tb_customer(first_name=fname,last_name=lname,email=email,phone=phone,dob=dob,gender=gender,login=q)
        q1.save()
        return HttpResponse("<script> alert('Registered Successfully'); window.location='login'</script>")
    return render(request,'registration.html')

def adminhome(request):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    res=reservations.objects.all().order_by('-id')
    res_count=reservations.objects.all().count()
    bus_count=buses.objects.all().count()
    payment_sale=payment.objects.all()
    tot_amt=0
    for i in payment_sale:
        amt=int(i.amount)
        tot_amt=tot_amt+amt
    return render(request,'admin_home.html',{'res':res,'res_count':res_count,'bus_count':bus_count,'total_sales':tot_amt})

def admincomplaint(request):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q=tb_complaints.objects.filter(reply='pending')
    return render(request,'admin_complaint.html',{'compview':q})

def admincustomers(request):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    cust=tb_customer.objects.all()
    return render(request,'admin_customers.html',{'customers':cust})

def admin_buses(request):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    bus=buses.objects.all()
    return render(request,'admin_buses.html',{'bus':bus})

def admin_otherplaces(request):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    otherplace=other_places.objects.all()
    if request.method=="POST":
        placename=request.POST['placeName']
        placetype=request.POST['placeType']
        lati=request.POST['lati']
        longi=request.POST['longi']
        q=other_places(other_places_name=placename,other_places_type=placetype,latitude=lati,longitude=longi)
        q.save()
        return HttpResponse("<script> alert('Place added successfully'); window.location='/admin_otherplaces'</script>")
    return render(request,'admin_otherplaces.html',{'otherplace':otherplace})

def delete_otherplaces(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=other_places.objects.get(id=id)
    obj.delete()
    return HttpResponse("<script> alert('Place Deleted'); window.location='/admin_otherplaces'</script>")

def updt_otherplaces(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=other_places.objects.get(id=id)
    if request.method=="POST":
        placename=request.POST['placeName']
        obj.other_places_name=placename
        placetype=request.POST['placeType']
        obj.other_places_type=placetype
        lati=request.POST['lati']
        obj.latitude=lati
        longi=request.POST['longi']
        obj.longitude=longi
        obj.save()
        return HttpResponse("<script> alert('Place Updated successfully'); window.location='/admin_otherplaces'</script>")
    return render(request,'admin_otherplaces.html',{'obj':obj})

def admin_places(request):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    place=places.objects.all()
    if request.method=="POST":
        placename=request.POST['placeName']
        lati=request.POST['lati']
        longi=request.POST['longi']
        q=places(place_name=placename,latitude=lati,longitude=longi)
        q.save()
        return HttpResponse("<script> alert('Place added successfully'); window.location='/admin_places'</script>")
    return render(request,'admin_places.html',{'place':place})

def updt_places(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=places.objects.get(id=id)
    if request.method=="POST":
        placename=request.POST['placeName']
        obj.place_name=placename
        lati=request.POST['lati']
        obj.latitude=lati
        longi=request.POST['longi']
        obj.longitude=longi
        obj.save()
        return HttpResponse("<script> alert('Place Updated successfully'); window.location='/admin_places'</script>")
    return render(request,'admin_places.html',{'obj':obj})

def delete_places(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=places.objects.get(id=id)
    obj.delete()
    return HttpResponse("<script> alert('Place Deleted'); window.location='/admin_places'</script>")

def admin_stations(request):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q=stations.objects.all()
    fk=stations.objects.values_list('place_id',flat=True)
    rfkp=places.objects.exclude(id__in=fk)
    fk1=stations.objects.values_list('stationmaster_id',flat=True)
    rfks=stationmaster.objects.exclude(id__in=fk1)
    if request.method=="POST":
        spn=request.POST['station-place']
        sm=request.POST['station-master']
        
        place=places.objects.get(id=spn)
        sm_mail=stationmaster.objects.get(id=sm)
        q=stations(place_id=spn,stationmaster_id=sm)
        q.save()
        reply='You have been alloted a Station, so you can login now \n Station Name: '+place.place_name
        send_mail('You have been alloted a Station',reply,'easybus578@gmail.com',[sm_mail.email],fail_silently=False)
        return HttpResponse("<script> alert('New Station has been created');window.location='/admin_stations'</script>")
    return render(request,'admin_stations.html',{'station':q,'remainplace':rfkp,'remainstationmaster':rfks})

def updt_adminstations(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=stations.objects.get(id=id)
    fk=stations.objects.values_list('place_id',flat=True)
    rfkp=places.objects.exclude(id__in=fk)
    fk1=stations.objects.values_list('stationmaster_id',flat=True)
    rfks=stationmaster.objects.exclude(id__in=fk1)
    if request.method=="POST":
        r=stationmaster.objects.get(id=request.POST['station-master'])
        obj.stationmaster_id=r
        obj.save()
        return HttpResponse("<script> alert('Station Updated'); window.location='/admin_stations'</script>")
    return render(request,'admin_stations.html',{'stations':obj,'remainplace':rfkp,'remainstationmaster':rfks})
    
def delete_adminstations(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=stations.objects.get(id=id)
    obj.delete()
    return HttpResponse("<script> alert('Station Deleted'); window.location='/admin_stations'</script>")
    
def comp_reply(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=tb_complaints.objects.get(id=id)
    if request.method=="POST":
        reply=request.POST['reply']
        obj.reply=reply
        custid=obj.customer_id
        obj1=tb_customer.objects.get(id=custid)
        email=obj1.email
        send_mail('Reply for your complaint',reply,'easybus578@gmail.com',[email],fail_silently=False)
        obj.save()
        return HttpResponse("<script> alert('Reply sented Successfully'); window.location='/admincomplaint'</script>")
    return render(request,'admin_complaint.html',{'replyid':obj})

def admin_employee(request):
    obj=stationmaster.objects.all()
    obj1=tbl_conductor.objects.all()
    buss=buses.objects.all()
    if request.method=="POST":
        # if request.POST['add_submit']:
        if 'add_submit' in request.POST:
            fname=request.POST['fname']
            lname=request.POST['lname']
            dob=request.POST['dob']
            gender=request.POST['gender']
            phone=request.POST['phone']
            email=request.POST['email']
            place=request.POST['place']
            no=phone[-4:]
            usern=fname+no
            stat=stationmaster.objects.all()
            for i in stat:
                if(phone==i.phone):
                    return HttpResponse("<script> alert('Phone Number already exist'); window.location='/admin_employee'</script>")
            q1=login(username=fname,password=usern,usertype='station_master')
            q1.save()
            reply='Username:'+fname+'\n'+'Password: (Your first name and your last 4 digit of your phone number. eg:manu4844)'
            q=stationmaster(first_name=fname,last_name=lname,dob=dob,gender=gender,phone=phone,email=email,place=place,login=q1)
            q.save()
            send_mail('You have been added as Station Master, Username and Password is provided in the email',reply,'easybus578@gmail.com',[email],fail_silently=False)
            return HttpResponse("<script> alert('Station Master added successfully'); window.location='/admin_employee'</script>")
        # elif request.POST['add_submit']:
        elif 'con_submit' in request.POST:
            fname=request.POST['fname']
            lname=request.POST['lname']
            dob=request.POST['dob']
            gender=request.POST['gender']
            phone=request.POST['phone']
            email=request.POST['email']
            place=request.POST['place']
            bus=request.POST['bus']
            b=buses.objects.get(id=bus)
            
            no=phone[-4:]
            usern=fname+no
            cond=tbl_conductor.objects.filter(bus_id=bus)
            print("conductor",cond)
            if cond:
                return HttpResponse("<script> alert('Phone Number or Bus already exist'); window.location='/admin_employee'</script>")
            else:
                q1=login(username=fname,password=usern,usertype='bus')
                q1.save()
                q=tbl_conductor(cfname=fname,clname=lname,cdob=dob,cphone=phone,login=q1,bus_id=bus,gender=gender,email=email,place=place)
                q.save()
                reply='Username:'+fname+'\n'+'Password: (Your first name and your last 4 digit of your phone number. eg:manu4844) \n You can login through the app'
                send_mail('You have been added as Conductor, Username and Password is provided in the email',reply,'easybus578@gmail.com',[email],fail_silently=False)
                return HttpResponse("<script> alert('Conductor added successfully'); window.location='/admin_employee'</script>")
    ccc=tbl_conductor.objects.all()    
    return render(request,'admin_employee.html',{'emp':obj,'cond':obj1,'buss':buss,'con':ccc})

def updt_stationmaster_employee(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=stationmaster.objects.get(id=id)
    if request.method=="POST":
        fname=request.POST['fname']
        obj.first_name=fname
        lname=request.POST['lname']
        obj.last_name=lname
        obj.dob=request.POST['dob']
        obj.gender=request.POST['gender']
        obj.phone=request.POST['phone']
        obj.email=request.POST['email']
        obj.place=request.POST['place']
        obj.save()
        return HttpResponse("<script> alert('Employee Updated successfully'); window.location='/admin_employee'</script>")
    return render(request,'admin_employee.html',{'obj':obj})

def delete_stationmaster_employee(request,id):
    try:
        request.session['admin_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=stationmaster.objects.get(id=id)
    qq=obj.login_id
    q=login.objects.get(id=qq)
    obj.delete()
    q.delete()
    return HttpResponse("<script> alert('Employee Deleted'); window.location='/admin_employee'</script>")

def stationmasters(request):
    current_date = date.today()
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q=stationmaster.objects.get(login=request.session['station_id'])
    if q:
        try:
            qq=stations.objects.get(stationmaster=q.id)
        except:
            return HttpResponse("<script> alert('You have not been assigned any Station');window.location='login'</script>")
        if qq:
            qqq=places.objects.get(id=qq.place_id)
    current_date_str = datetime.strftime(current_date, "%Y-%m-%d")
    trp=trips.objects.filter(station=qq).filter(trip_date=current_date_str)
    plc=places.objects.get(id=qq.place_id)
    frm_stp=stops.objects.filter(place=plc)
    print(frm_stp)
    res=reservations.objects.none()
    
    if(frm_stp):
        for i in frm_stp:
            res|=reservations.objects.filter(from_stop=i,trip_id__trip_date=current_date_str)
    else:
        res=None
    return render(request,'stationmaster_home.html',{'placename':qqq.place_name,'name':q.first_name +" "+ q.last_name,'q':qqq,'trp':trp,'res':res})

def stationmaster_profile(request):
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q=stationmaster.objects.get(login=request.session['station_id'])
    return render(request,'stationmaster_profile.html',{'name':q.first_name +" "+ q.last_name,'cust':q})

def stationmaster_routes(request):
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q=stationmaster.objects.get(login=request.session['station_id'])
    if q:
        qq=stations.objects.get(stationmaster=q.id)
        if qq:
            qqq=places.objects.get(id=qq.place_id)
    rfkp=places.objects.all()
    # r=routes.objects.filter(starting_place=qqq.id)
    r=routes.objects.filter(station_id=qq.id)
    if request.method=="POST":
        starting_place=request.POST['starting_place']
        start_place=places.objects.get(id=starting_place)
        end_place=request.POST['ending_place']
        obj=places.objects.get(id=end_place)
        route_name=request.POST['route_name']
        a=routes(route_name=route_name,starting_place=start_place,ending_place=obj,station=qq)
        a.save()
        return HttpResponse("<script> alert('Your have created route');window.location='/stationmaster_routes'</script>")
    return render(request,'stationmaster_routes.html',{'name':q.first_name +" "+ q.last_name,'place':qqq,'endplace':rfkp,'routes':r})

def delete_route(request,id):
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    obj=routes.objects.get(id=id)
    obj.delete()
    return HttpResponse("<script> alert('Your have deleted route');window.location='/stationmaster_routes'</script>")

def stationmaster_trips(request):
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q=stationmaster.objects.get(login=request.session['station_id'])
    # fk = routes.objects.select_related('starting_place', 'ending_place')
    pfk=places.objects.all()
    # pfk = places.objects.defer('routes_starting__starting_place_id', 'routes_ending__ending_place_id').all()
    # fk = places.objects.exclude()
    # tfkp=places.objects.exclude(id__in=fk['starting_place_id'])
    if q:
        qq=stations.objects.get(stationmaster=q.id)
        if qq:
            qqq=places.objects.get(id=qq.place_id)
    # r=routes.objects.filter(starting_place_id=qqq.id)
    r=routes.objects.all()
    trip=trips.objects.filter(station=qq)
    c_datetime=datetime.today()
    c_time=c_datetime.strftime("%H:%M")
    c_date=c_datetime.date()
    for i in trip:
        date=datetime.strptime(i.trip_date,"%Y-%m-%d")
        date=date.date()
        if date < c_date:
            i.trip_status='completed'
            i.save()
        elif date == c_date:
            
            s_time=datetime.strptime(i.starting_time,"%H:%M").time()
            s_time=s_time.strftime("%H:%M")
            e_time=datetime.strptime(i.ending_time,"%H:%M").time()
            e_time=e_time.strftime("%H:%M")
            if s_time <= c_time:
                i.trip_status='departed'
                i.save()
                if e_time <= c_time:
                    i.trip_status='completed'
                    i.save()
    # tfk=trips.objects.filter(station=qq).values_list('bus_id')
    bus=buses.objects.filter(station=qq.id)
    # c_time=datetime.today()
    
    # hr=c_time.hour
    # min=c_time.minute
    # print(hr,min)
    if request.method=="POST":
        bus_name=request.POST['bus_name']
        b=buses.objects.get(id=bus_name)
        route=request.POST['route']
        r=routes.objects.get(id=route)
        tripdate=request.POST['trip_date']
        # date=datetime.strptime(tripdate,"%Y-%m-%d")
        # date=date.date()
        # c_time=datetime.today()
        # c_date1=c_time.date()
        starting_time=request.POST['starting_time']
        ending_time=request.POST['ending_time']
        # c_time1=c_time.strftime("%H:%M")
        # s_time=datetime.strptime(starting_time,"%H:%M").time()
        
        # e_time=datetime.strptime(ending_time,"%H:%M").time()
        
        # s_time=s_time.strftime("%H:%M")
        
        # e_time=e_time.strftime("%H:%M")
        
        # print(c_time1)
        # print(s_time)
        # print(e_time)
        # if date < c_date1:
        #     return HttpResponse("<script> alert('Please select future date');window.location='stationmaster_trips'</script>")
        # elif date == c_date1:
        #     if c_time1 > s_time and c_time1 > e_time:
        #          return HttpResponse("<script> alert('Please select future time');window.location='stationmaster_trips'</script>")
        num_stops=int(request.POST['num_stops'])
        for i in trip:
            if(i.trip_date==tripdate and i.bus==b):
                if(starting_time < i.ending_time and ending_time > i.starting_time) or \
                    (starting_time < i.starting_time and ending_time > i.ending_time) or \
                    (starting_time == i.starting_time and ending_time == i.ending_time):
                        return HttpResponse("<script> alert('This Bus already have trip on this time');window.location='stationmaster_trips'</script>")
        # c_date=date.today()
        # c_time=datetime.today()
        # print(c_time)
        t=trips(bus=b,route=r,trip_date=tripdate,starting_time=starting_time,ending_time=ending_time,no_of_stops=num_stops,station=qq,trip_status='scheduled')
        t.save()
        for i in range(1,num_stops+1):
            time=request.POST.get('time_'+str(i),None)
            stop=request.POST.get('stop_'+str(i),None)
            fare=request.POST.get('fare_'+str(i),None)
            p=places.objects.get(id=stop)
            if time and stop:
                s=stops(time=time,place=p,trip=t,fare_rate=fare)
                s.save()
        return HttpResponse("<script> alert('Your have inserted trip');window.location='stationmaster_trips'</script>")
    return render(request,'stationmaster_trips.html',{'name':q.first_name +" "+ q.last_name,'routes':r,'bus':bus,'stops':pfk,'trip':trip})

def updt_stationmaster_trips(request,id):
    q=stationmaster.objects.get(login=request.session['station_id'])
    obj=trips.objects.get(id=id)
    r=routes.objects.filter(id=obj.route_id)
    if q:
        qq=stations.objects.get(stationmaster=q.id)
    tfk=trips.objects.filter(station=qq).values_list('bus_id')
    bus=buses.objects.filter(station=qq.id).exclude(id__in=tfk)
    return render(request,'stationmaster_trips.html',{'name':q.first_name +" "+ q.last_name,'obj':obj,'routes':r,'bus':bus})
    
def delete_stationmaster_trips(request,id):
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    t=trips.objects.get(id=id)
    s=stops.objects.filter(trip=id)
    t.delete()
    s.delete()
    return HttpResponse("<script> alert('Your have deleted trip');window.location='/stationmaster_trips'</script>")

def stationmaster_trip_status(request,id):
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    t=trips.objects.get(id=id)
    if t.trip_status == 'scheduled':
        t.trip_status='departed'
        t.save()
        return HttpResponse("<script> alert('Trip has been departed');window.location='/stationmaster_trips'</script>")
    elif t.trip_status == 'departed':
        t.trip_status='completed'
        buss=t.bus
        seat=buss.default_seat_count
        buss.seat_count=seat
        buss.save()
        t.save()
        return HttpResponse("<script> alert('Trip has been completed');window.location='/stationmaster_trips'</script>")
    
def stationmaster_buses(request):
    try:
        request.session['station_id']
    except:
        return HttpResponse("<script> alert('Your have been logged out');window.location='login'</script>")
    q=stationmaster.objects.get(login=request.session['station_id'])
    if q:
        qq=stations.objects.get(stationmaster=q.id)
    bus=buses.objects.filter(station=qq.id)
    if request.method=="POST":
        busname=request.POST['bus_name']
        regno='KL-'+request.POST['registration_number1']+'-'+request.POST['registration_number2']+'-'+request.POST['registration_number3']
        seatcount=request.POST['seating_capacity']
        fare=request.POST['fare_rate']
        lati=request.POST['lati']
        longi=request.POST['longi']
        bb=buses.objects.all()
        for i in bb:
            if regno == i.registration_number:
                return HttpResponse("<script> alert('Already exist a bus in this registration number');window.location='/stationmaster_buses'</script>")
        q=buses(bus_name=busname,registration_number=regno,seat_count=seatcount,default_seat_count=seatcount,station=qq,fare_rate=fare)
        q.save()
        b=tbl_bus_location(latitude=lati,longitude=longi,bus=q)
        b.save()
        return HttpResponse("<script> alert('Your have inserted bus details');window.location='/stationmaster_buses'</script>")
    return render(request,'stationmaster_buses.html',{'name':q.first_name +" "+ q.last_name,'buses':bus})

def updt_stationmaster_buses(request,id):
    q=stationmaster.objects.get(login=request.session['station_id'])
    obj=buses.objects.get(id=id)
    if request.method=="POST":
        obj.bus_name=request.POST['bus_name']
        obj.registration_number=request.POST['registration_number']
        obj.default_seat_count=request.POST['seating_capacity']
        obj.seat_count=request.POST['seating_capacity']
        obj.fare_rate=request.POST['fare_rate']
        obj.save()
        return HttpResponse("<script> alert('Your have updated bus details');window.location='/stationmaster_buses'</script>")
    return render(request,'stationmaster_buses.html',{'name':q.first_name +" "+ q.last_name,'obj':obj})
    
def delete_stationsmaster_buses(request,id):
    obj=buses.objects.get(id=id)
    obj.delete()
    return HttpResponse("<script> alert('Your have deleted bus details');window.location='/stationmaster_buses'</script>")







#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

    #                                    ANDROID                #
    
#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#


def andro_login(request):
    data = []
    androusername = request.GET.get('androusername')
    andropassword = request.GET.get('andropassword')
    logi = request.GET.get('latti', None)
    longi = request.GET.get('longi', None)

    try:
        
        queryset = login.objects.filter(username=androusername, password=andropassword)
        for login_obj in queryset:
            conductor = None
            try:
                conductor = tbl_conductor.objects.get(login=login_obj)
                bus = conductor.bus
                bus.latitude = logi
                bus.longitude = longi
                bus.save()
                # data['message'] = "Location updated successfully."
            except tbl_conductor.DoesNotExist:
                pass
            
            data.append({
                'id': login_obj.id,
                'username': login_obj.username,
                'password': login_obj.password,
                'usertype': login_obj.usertype,
                'conductor_id': conductor.conductor_id if conductor else None,
                'bus_id': conductor.bus_id if conductor else None,
                # Add other fields you want to include in the response
            })
           
            

        if data:
            status = "success"
        else:
            status = "error"
            message = "Invalid credentials"
    except login.DoesNotExist:
        status = "error"
        message = "Invalid credentials"

    response = {
        'status': status,
        'data': data
    }
    print(data)

    if status == "error":
        response['message'] = message

    return JsonResponse(response)





def updatepass_location(request):
    data = {}
    logi = request.GET.get('latti')
    longi = request.GET.get('longi')
    log_id = request.GET.get('logid')
    print("helooooooo")
    # print("helooooooo",logi)
        
    try:
        conductor = tbl_conductor.objects.get(login_id=log_id)
        buss= conductor.bus
        bus = conductor.bus.tbl_bus_location_set.all()
        print("...................",buss.bus_name)
        for j in bus:
            j.latitude = logi
            j.longitude = longi
            j.save()
        data['message'] = "Location updated successfully."
    except tbl_conductor.DoesNotExist:
        data['error'] = "Conductor with login_id '{}' does not exist.".format(log_id)
    return JsonResponse(data)

def Conductor_update_location(request):
    data = {}
    bus_id = request.GET.get('bus_id')
    seat = request.GET.get('seat')
    data['method'] = 'Conductor_update_location'
    
    if bus_id and seat:
        try:
            bus = buses.objects.get(id=bus_id)
            bus.seat_count = int(bus.seat_count) + int(seat)
            bus.save()
            
            data['status'] = 'success'
        except buses.DoesNotExist:
            data['status'] = 'error'
    else:
        data['status'] = 'error'
    return JsonResponse(data)




def viewtrips(request):
    data = {}
    logid = request.GET.get('logid')
    
    try:
        conductor = tbl_conductor.objects.get(login__id=logid)
    except tbl_conductor.DoesNotExist:
        data['status'] = 'failed'
        data['message'] = 'Conductor with the given login id does not exist.'
        return JsonResponse(data)

    trips_data = trips.objects.select_related('bus', 'route').filter(bus__id=conductor.bus.id)

    if trips_data:
        data['status'] = "success"
        data['data'] = []
        for trip in trips_data:
            trip_data = {
                'trip_id': trip.id,
                'bus_id': trip.bus.id,
                'route_id': trip.route.id,
                'bus_name': trip.bus.bus_name,
                'route_name': trip.route.route_name,
                'starting_time': trip.starting_time,
                'ending_time': trip.ending_time,
            }
            data['data'].append(trip_data)
    else:
        data['status'] = "failed"

    data['method'] = "viewtrips"
    return JsonResponse(data)












def viewseat(request):
    data = {}
    log_id = request.GET.get('log_id')
    bus_ids = request.GET.get('bus_ids')
    try:
        result = buses.objects.filter(id=bus_ids)
        print("result",result)
        
        if result:
            data['status'] = "success"
            data['method'] = "viewseat"
            data['data'] = []
            for bus in result:
                bus_data = {
                    'bus_id': bus.id,
                    # 'conductor_id': bus.tbl_conductor.conductor.id,
                    'seat_count': bus.seat_count,
                    'fare_rate': bus.fare_rate,
                    # Add more fields as needed
                }
                print("___________busdata",bus_data)
                data['data'].append(bus_data)
        else:
            data['status'] = "failed"
            data['message'] = "No buses found for the given bus_ids."
    except buses.DoesNotExist:
        data['status'] = "failed"
        data['message'] = "Invalid bus_ids provided."

    return JsonResponse(data)


def Bus_view_reservation(request):
    data = {}
    logid = request.GET.get('logid')
     
    try:
        conductor = tbl_conductor.objects.get(login__id=logid)
    except tbl_conductor.DoesNotExist:
        data['status'] = 'failed'
        data['message'] = 'Conductor with the given login id does not exist.'
        return JsonResponse(data)

    reservations_data = reservations.objects.select_related('trip', 'trip__bus', 'trip__route').filter(trip__bus__id=conductor.bus.id)
    
    data['method'] = "Bus_view_reservation"
    if reservations_data:
        data['status'] = "success"
        data['data'] = []
        for reservation in reservations_data:
            reservation_info = {
                'reservation_id': reservation.id,
                'fair_amount': reservation.reservation_amount,
                'no_of_seats': reservation.no_of_seats,
                'reservation_status': reservation.reservation_status,
                'fcustomer_name': reservation.user.first_name,
                'customer_name': reservation.user.last_name,
                # Add more fields as needed
            }
            data['data'].append(reservation_info)
        
    else:
        data['status'] = "failed"
    return JsonResponse(data)



def accept(request):
    data = {}
    req_id = request.GET.get('req_id')

    try:
        reservation = reservations.objects.get(id=req_id)
    except reservations.DoesNotExist:
        data['status'] = 'failed'
        data['message'] = 'Reservation with the given ID does not exist.'
        return JsonResponse(data)

    reservation.reservation_status = 'reservation confirmed'
    reservation.save()

    data['status'] = 'success'
    data['method'] = 'approve'
    return JsonResponse(data)






# def Bus_view_reservation(request):
#     data = {}
   
#     try:
       
#         reservations_data = reservations.objects.select_related('user').all()
#         print("reservations_data",reservations_data)
        
#         data['method'] = "Bus_view_reservation"
#         if reservations_data:
#             data['status'] = "success"
#             data['data'] = []
#             print("12345678") 
#             for reservation in reservations_data:
#                 print("vvvvvvvvvvvvvvvvvvvvvvvvv") 
#                 reservation_info = {
#                     'reservation_id': reservation.id,
#                     'fair_amount': reservation.reservation_amount,
#                     'no_of_seats': reservation.no_of_seats,
#                     'reservation_status': reservation.reservation_status,
#                     'fcustomer_name': reservation.user.first_name,
#                     'customer_name': reservation.user.last_name, 
#                 }
                
                
#                 print("reservation_info",reservation_info)
#                 data['data'].append(reservation_info)
            
#         else:
#             data['status'] = "failed"
        
#     except Exception as e:
#         data['status'] = "error"
#         data['message'] = str(e)

#     return JsonResponse(data)







# def viewtrips(request):
#     data = {}
#     logid = request.GET.get('logid')
    
#     # Perform the join operation using Django's ORM
#     res = trips.objects.select_related('bus', 'route').all()
    
#     if res:
#         data['status'] = "success"
#         data['data'] = []
#         for trip in res:
#             trip_data = {
#                 'trip_id': trip.id,
#                 'bus_id': trip.bus.id,
#                 'route_id': trip.route.id,
#                 'bus_name': trip.bus.bus_name,
#                 'route_name': trip.route.route_name,
#                 'starting_time': trip.starting_time,
#                 'ending_time': trip.ending_time
            
#                 # Add more fields as needed
#             }
#             data['data'].append(trip_data)
#     else:
#         data['status'] = "failed"
    
#     data['method'] = "viewtrips"
#     return JsonResponse(data)