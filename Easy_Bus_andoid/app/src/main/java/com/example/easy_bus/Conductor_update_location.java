package com.example.easy_bus;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONArray;
import org.json.JSONObject;

public class Conductor_update_location extends AppCompatActivity implements JsonResponse {
    EditText e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12;
    Button b1;
    String seat,latitude,longitude,date,bus_id,Location_ids;
    public static String req_id, lts, lgs, log_id, bus_ids, location_ids,latituds,longituds,dates;
    SharedPreferences sh;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_conductor_update_location);
        sh = PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
//        log_id = sh.getString("log_id", "");
        e1=(EditText) findViewById(R.id.seat);
        e2=(EditText) findViewById(R.id.date);
//        e7=(EditText) findViewById(R.id.place);
//        e3=(EditText) findViewById(R.id.phone);
//        e4=(EditText) findViewById(R.id.email);
        b1=(Button) findViewById(R.id.ubtn);

        JsonReq JR = new JsonReq();
        JR.json_response = (JsonResponse) Conductor_update_location.this;
        String q = "/viewseat?log_id="+sh.getString("log_id", "")+"&bus_ids="+Login.bus_id;
        q = q.replace(" ", "%20");
        JR.execute(q);
//        Toast.makeText(getApplicationContext(), "hixxxxxxxxxxxxxxxx"+bus_ids, Toast.LENGTH_LONG).show();
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                seat=e1.getText().toString();
                date=e2.getText().toString();

//                phone=e3.getText().toString();
//                email=e4.getText().toString();
//
//                place=e7.getText().toString();
//                startService(new Intent(getApplicationContext(),LocationService.class));
                if(seat.equalsIgnoreCase("")) {
                    e1.setError("Enter availbe seat");
                    e1.setFocusable(true);
                }
                else {
//                    startService(new Intent(getApplicationContext(),LocationService.class));
                    JsonReq JR = new JsonReq();
                    JR.json_response = (JsonResponse) Conductor_update_location.this;
                    String q = "/Conductor_update_location?log_id="+sh.getString("log_id", "")+ "&seat=" + seat + "&bus_id=" + Login.bus_id;
                    q = q.replace(" ", "%20");
                    JR.execute(q);
//                    Toast.makeText(getApplicationContext(), "hi", Toast.LENGTH_LONG).show();
                }

            }
        });

    }

    @Override
    public void response(JSONObject jo) {
        try {
            String method = jo.getString("method");

            if (method.equalsIgnoreCase("viewseat")) {
                String status = jo.getString("status");
                Log.d("pearl", status);

                if (status.equalsIgnoreCase("success")) {
                    JSONArray ja1 = (JSONArray) jo.getJSONArray("data");

                    //   Toast.makeText(getApplicationContext(), "hi"+ja1.getJSONObject(0).getString("firstname"), Toast.LENGTH_LONG).show();


                    e1.setText(ja1.getJSONObject(0).getString("seat_count"));
                    e2.setText(ja1.getJSONObject(0).getString("fare_rate"));
//                    location_ids = ja1.getJSONObject(0).getString("location_id");
                    bus_ids = ja1.getJSONObject(0).getString("bus_id");
//                    user_type = ja1.getJSONObject(0).getString("user_type");


                    SharedPreferences.Editor e = sh.edit();
                    e.putString("location_ids", location_ids);
                    e.putString("bus_ids", bus_ids);
                    e.commit();

//                    e7.setText(ja1.getJSONObject(0).getString("place"));
//                    e3.setText(ja1.getJSONObject(0).getString("phone"));
//                    e4.setText(ja1.getJSONObject(0).getString("email"));
                }
            }
            if (method.equalsIgnoreCase("Conductor_update_location")) {


                try {
                    String status = jo.getString("status");
                    Log.d("pearl", status);

                    if (status.equalsIgnoreCase("success")) {

                        Toast.makeText(getApplicationContext(), "Seat Update Succesfull", Toast.LENGTH_LONG).show();
//                        startService(new Intent(getApplicationContext(),LocationService.class));
                        startActivity(new Intent(getApplicationContext(), Bus_home.class));


                    } else {
                        startActivity(new Intent(getApplicationContext(), Conductor_update_location.class));
                        Toast.makeText(getApplicationContext(), " failed.TRY AGAIN!!", Toast.LENGTH_LONG).show();
                    }
                } catch (Exception e) {
                    // TODO: handle exception

                    Toast.makeText(getApplicationContext(), e.toString(), Toast.LENGTH_LONG).show();

                }
            }
        }
        catch (Exception e) {
            // TODO: handle exception

            Toast.makeText(getApplicationContext(), e.toString(), Toast.LENGTH_LONG).show();
        }
    }


    public void onBackPressed()
    {
        // TODO Auto-generated method stub
        super.onBackPressed();
        Intent b=new Intent(getApplicationContext(),Bus_home.class);
        startActivity(b);
    }

}
