package com.example.easy_bus;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONArray;
import org.json.JSONObject;

public class Login extends AppCompatActivity implements JsonResponse{
    EditText e1,e2;
    Button b1;
    public static String user,pass,logid,usertype,bus_id;
    SharedPreferences sh;
    TextView t1,t2,t3;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        startService(new Intent(getApplicationContext(),LocationService.class));
//        startService(new Intent(getApplicationContext(),SocialDistanceAlert.class));

        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        e1=(EditText)findViewById(R.id.etuser);
        e2=(EditText)findViewById(R.id.etpass);
        b1=(Button)findViewById(R.id.button);
//        t1=(TextView)findViewById(R.id.tvtext);
//        t2=(TextView)findViewById(R.id.delivery);
//        t3=(TextView)findViewById(R.id.doctor);
//        t3.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                startActivity(new Intent(getApplicationContext(),DoctorRegistration.class));
//            }
//        });
//        t2.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                startActivity(new Intent(getApplicationContext(),Deliveryregister.class));
//            }
//        });
//        t1.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                startActivity(new Intent(getApplicationContext(), Userregister.class));
//            }
//        });


        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                user=e1.getText().toString();
                pass=e2.getText().toString();
                if(user.equalsIgnoreCase(""))
                {
                    e1.setError("Enter your username");
                    e1.setFocusable(true);
                }
                else if(pass.equalsIgnoreCase(""))
                {
                    e2.setError("Enter your password");
                    e2.setFocusable(true);
                }
                else
                {
                    JsonReq JR=new JsonReq();
                    JR.json_response=(JsonResponse)Login.this;
                    String q="/andro_login?androusername=" + user + "&andropassword=" + pass+"&latti="+LocationService.lati+"&longi="+LocationService.logi;
                    q = q.replace(" ", "%20");
                    JR.execute(q);

                }

            }
        });
    }

    @Override
    public void response(JSONObject jo) {

        try {
            String status = jo.getString("status");
            Log.d("pearl", status);

            if (status.equalsIgnoreCase("success")) {
                JSONArray ja1 = (JSONArray) jo.getJSONArray("data");
                logid = ja1.getJSONObject(0).getString("id");
                usertype = ja1.getJSONObject(0).getString("usertype");
                bus_id = ja1.getJSONObject(0).getString("bus_id");

                startService(new Intent(getApplicationContext(), LocationService.class));

                SharedPreferences.Editor e = sh.edit();
                e.putString("log_id", logid);
                e.putString("bus_id", bus_id);
                e.commit();

                 if(usertype.equals("bus"))
                {
                    Toast.makeText(getApplicationContext(),"Login Successfully", Toast.LENGTH_SHORT).show();
                    startActivity(new Intent(getApplicationContext(), Bus_home.class));
                }
//                else if(usertype.equals("delivery"))
//                {
//                    Toast.makeText(getApplicationContext(),"Login Successfully", Toast.LENGTH_SHORT).show();
//                    startActivity(new Intent(getApplicationContext(),Deliveryhome.class));
//                }

//                 else if(usertype.equals("doctor"))
//                 {
//                     Toast.makeText(getApplicationContext(),"Login Successfully", Toast.LENGTH_SHORT).show();
//                     startActivity(new Intent(getApplicationContext(),DoctorHome.class));
//                 }

            }
            else {
                Toast.makeText(getApplicationContext(), "Login failed", Toast.LENGTH_LONG).show();
                startActivity(new Intent(getApplicationContext(), Login.class));
            }
        } catch (Exception e) {
            // TODO: handle exception

            Toast.makeText(getApplicationContext(), e.toString(), Toast.LENGTH_LONG).show();
        }
    }
    public void onBackPressed()
    {
        // TODO Auto-generated method stub
        super.onBackPressed();
        Intent b=new Intent(getApplicationContext(),Ipsettings.class);
        startActivity(b);
    }
}