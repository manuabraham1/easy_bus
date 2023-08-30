package com.example.easy_bus;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class Bus_home extends AppCompatActivity {
    ImageButton b1,b2,b3,b4,b5,b6,b7,b8;
    TextView t2;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bus_home);
        b1=(ImageButton) findViewById(R.id.product);
        b2=(ImageButton) findViewById(R.id.logout);
        b3=(ImageButton) findViewById(R.id.btcom);
//        b4=(ImageButton) findViewById(R.id.seat);
        b5=(ImageButton) findViewById(R.id.file);
        b3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(), Bus_view_reservation.class));

            }
        });
        b5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(), Conductor_update_location.class));

            }
        });
        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(), Login.class));

            }
        });
        b1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getApplicationContext(),Bus_view_bus_root.class));
            }
        });

//        TextView t1 = findViewById(R.id.mainhead);
//        t1.setText("Welcome, "+Login.zname+".");
    }

    public void onBackPressed()
    {
        // TODO Auto-generated method stub
        super.onBackPressed();
        Intent b=new Intent(getApplicationContext(),Bus_home.class);
        startActivity(b);
    }
}