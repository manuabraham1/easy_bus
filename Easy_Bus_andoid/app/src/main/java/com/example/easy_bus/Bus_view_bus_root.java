package com.example.easy_bus;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

public class Bus_view_bus_root extends AppCompatActivity implements JsonResponse {
    ListView l1;
    SharedPreferences sh;
    String[] trip,bus,route,stime,etime,val;
    public static String logid;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bus_view_bus_root);
        sh= PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
        logid=sh.getString("log_id","");
        l1=(ListView) findViewById(R.id.lv1);

        JsonReq JR = new JsonReq();
        JR.json_response = (JsonResponse) Bus_view_bus_root.this;
        String q = "/viewtrips?logid="+logid;
        q = q.replace(" ", "%20");
        JR.execute(q);

    }

    @Override
    public void response(JSONObject jo) {
        try {

            String method = jo.getString("method");

            if (method.equalsIgnoreCase("viewtrips")) {

                String status = jo.getString("status");
                Log.d("pearl", status);


                if (status.equalsIgnoreCase("success")) {
                    JSONArray ja1 = (JSONArray) jo.getJSONArray("data");

                    route = new String[ja1.length()];
                    stime = new String[ja1.length()];

                    etime = new String[ja1.length()];
                    val = new String[ja1.length()];

                    for (int i = 0; i < ja1.length(); i++) {

                        route[i] = ja1.getJSONObject(i).getString("route_name");
                        stime[i] = ja1.getJSONObject(i).getString("starting_time");
                        etime[i] = ja1.getJSONObject(i).getString("ending_time");
                        val[i] = "\nRoute Name:" + route[i] + "\n Starting Time:" + stime[i] + "\n Ending Time:" + etime[i];


                    }
                    ArrayAdapter<String> ar = new ArrayAdapter<String>(getApplicationContext(), R.layout.cust_list_view, val);
                    l1.setAdapter(ar);
                }
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
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