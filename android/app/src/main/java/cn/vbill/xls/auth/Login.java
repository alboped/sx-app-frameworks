package cn.vbill.xls.auth;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import cn.vbill.xls.MainActivity;
import cn.vbill.xls.R;
import cn.vbill.xls.tool.DialogueTools;


/**
 * Created by fenglonghui on 2017/6/6.
 */

public class Login extends Activity implements View.OnClickListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);
        findViewById(R.id.btn_login).setOnClickListener(this);
        findViewById(R.id.tv_register).setOnClickListener(this);
    }




    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.btn_login:
                startActivity(new Intent(this, MainActivity.class));
                break;
            case R.id.tv_register:

                break;
        }

    }
}
