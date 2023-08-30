package com.example.easy_bus;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONArray;
import org.json.JSONObject;

public class Bus_view_reservation extends AppCompatActivity implements JsonResponse, AdapterView.OnItemClickListener {
    ListView l1;
    SharedPreferences sh;
    String[] val,reservation_amount,reservation_status,seat_no,first_name,last_name,reservation_id;
    public static String logid,req_id,statusss;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bus_view_reservation);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        logid=sh.getString("log_id","");
        l1=(ListView) findViewById(R.id.lv2);
        l1.setOnItemClickListener(this);

        JsonReq JR = new JsonReq();
        JR.json_response = (JsonResponse) Bus_view_reservation.this;
        String q = "/Bus_view_reservation?logid="+logid;
        q = q.replace(" ", "%20");
        JR.execute(q);
    }

    @Override
    public void response(JSONObject jo) {
        try {

            String method = jo.getString("method");

            if (method.equalsIgnoreCase("Bus_view_reservation")) {

                String status = jo.getString("status");
                Log.d("pearl", status);



                if (status.equalsIgnoreCase("success")) {
                    JSONArray ja1 = (JSONArray) jo.getJSONArray("data");

                    reservation_amount = new String[ja1.length()];
                    reservation_status = new String[ja1.length()];
                    first_name = new String[ja1.length()];
                    last_name = new String[ja1.length()];
                    reservation_id = new String[ja1.length()];
//                    date = new String[ja1.length()];
                    seat_no = new String[ja1.length()];


                    val = new String[ja1.length()];

                    for (int i = 0; i < ja1.length(); i++) {

                        reservation_amount[i] = ja1.getJSONObject(i).getString("fair_amount");
                        reservation_status[i] = ja1.getJSONObject(i).getString("reservation_status");
                        first_name[i] = ja1.getJSONObject(i).getString("fcustomer_name");
                        last_name[i] = ja1.getJSONObject(i).getString("customer_name");
                        reservation_id[i] = ja1.getJSONObject(i).getString("reservation_id");
                        seat_no[i] = ja1.getJSONObject(i).getString("no_of_seats");


                        val[i] = "\nCustomer Name: " + first_name[i] + "  " + last_name[i] + "\n Amount:" + reservation_amount[i]+"\nNo Seat :" + seat_no[i]+ "\nStatus:" + reservation_status[i];


                    }
                    ArrayAdapter<String> ar = new ArrayAdapter<String>(getApplicationContext(), R.layout.cust_list_view, val);
                    l1.setAdapter(ar);
                }
            }
            if (method.equalsIgnoreCase("approve")) {
                String status = jo.getString("status");
                Toast.makeText(getApplicationContext(), status, Toast.LENGTH_LONG).show();
                if (status.equalsIgnoreCase("success")) {
                    Toast.makeText(getApplicationContext(), "aprove Successfully", Toast.LENGTH_LONG).show();
                    startActivity(new Intent(getApplicationContext(), Bus_view_reservation.class));
                }
//			else if(status.equalsIgnoreCase("duplicate"))
//			{
//				Toast.makeText(getApplicationContext(), "Duplicate", Toast.LENGTH_LONG).show();
//			}
                else {
                    Toast.makeText(getApplicationContext(), "..........", Toast.LENGTH_LONG).show();

                }
            }
            if (method.equalsIgnoreCase("reject")) {
                String status = jo.getString("status");
                Toast.makeText(getApplicationContext(), status, Toast.LENGTH_LONG).show();
                if (status.equalsIgnoreCase("success")) {
                    Toast.makeText(getApplicationContext(), "rejected Successfully", Toast.LENGTH_LONG).show();
                    startActivity(new Intent(getApplicationContext(), Bus_view_reservation.class));
                }
//			else if(status.equalsIgnoreCase("duplicate"))
//			{
//				Toast.makeText(getApplicationContext(), "Duplicate", Toast.LENGTH_LONG).show();
//			}
            }

        }

        catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            Toast.makeText(getApplicationContext(), e.toString(), Toast.LENGTH_LONG).show();
        }

    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        req_id=reservation_id[position];
        statusss = reservation_status[position];


        if (statusss.equals("Confirmed")) {
            final CharSequence[] items = {"Confirm Paymentxxxxx","Cancel"};

            AlertDialog.Builder builder = new AlertDialog.Builder(Bus_view_reservation.this);
            // builder.setTitle("Add Photo!");
            builder.setItems(items, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int item) {


//                if (items[item].equals("View Map")) {
//                    String url = "http://www.google.com/maps?saddr=" + LocationService.lati + "" + "," + LocationService.logi + "" + "&&daddr=" + User_view_request.lts + "," + User_view_request.lgs;
//                    Intent in = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
//                    startActivity(in);
//                }

                    if (items[item].equals("Accept")) {

                        JsonReq JR = new JsonReq();
                        JR.json_response = (JsonResponse) Bus_view_reservation.this;
                        String q = "/accept?req_id=" + req_id;
                        q = q.replace(" ", "%20");
                        JR.execute(q);
                    }
                    if (items[item].equals("Reject")) {
                        JsonReq JR = new JsonReq();
                        JR.json_response = (JsonResponse) Bus_view_reservation.this;
//					String q = "/user_add_interest?loginid="+Login.logid+"&type_id="+User_add_interests.type_ids;
                        String q = "/reject?req_id=" + req_id;
                        q = q.replace(" ", "%20");
                        JR.execute(q);

                    } else if (items[item].equals("Cancel")) {
                        dialog.dismiss();
                    }
                }

            });
            builder.show();
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