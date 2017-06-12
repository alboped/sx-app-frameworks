package cn.vbill.xls;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import cn.vbill.xls.tool.DevOs;

/**
 * Created by fenglonghui on 2017/6/4.
 *
 */

public abstract class BaseActivity extends AppCompatActivity {
    public WebView adverWebView;
    public TextView title;
    public LinearLayout backup;
    public LinearLayout scan;
    public ImageView titleRightImage;
    public TextView titleRightTv;
    public Context con;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.con = this;
        DevOs.setOverlayPermission(this);

    }


    /**
     * 初始化标题栏
     */
    public void init(){
        title = getViewTag(R.id.disp);
        backup = getViewTag(R.id.backup);
        scan = getViewTag(R.id.scan);
        titleRightImage = getViewTag(R.id.titleRightImage);
        titleRightTv = getViewTag(R.id.titleRightTv);
        isVisibilityTitleArea();
    }

    public abstract void isVisibilityTitleArea();


    public void isUp(View view){
        if(adverWebView !=null){
            boolean canGoBack = adverWebView.canGoBack();
            if(canGoBack){
                adverWebView.goBack();
            }else{
                finish();
            }

        }else{
            finish();
        }
    }


    public void isScan(View view){
//		showInforWindow("扫描");
        finish();
    }


    protected void initTitle(String con,boolean up,boolean next){
        title.setText(con);
        if(up){
            if(backup.getVisibility() == View.INVISIBLE){
                backup.setVisibility(View.VISIBLE);
            }
        }else{
            if(backup.getVisibility() == View.VISIBLE){
                backup.setVisibility(View.INVISIBLE);
            }
        }

        if(next){
            if(scan.getVisibility() == View.INVISIBLE){
                scan.setVisibility(View.VISIBLE);
            }
        }else{
            if(scan.getVisibility() == View.VISIBLE){
                scan.setVisibility(View.INVISIBLE);
            }
        }
    }

    @SuppressWarnings("unchecked")
    public <T extends View> T getViewTag(int id) {
        return (T) super.findViewById(id);
    }



    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == DevOs.SDK_INT_GRANTED_REQUEST_CODE) {
            if (Build.VERSION.SDK_INT >= DevOs.BUILD_VERSION_INT_M) {
                if (!Settings.canDrawOverlays(this)) {
                    // SYSTEM_ALERT_WINDOW permission not granted...
                    Toast.makeText(this,"overlay permission not granted", Toast.LENGTH_SHORT).show();
                    DevOs.setOverlayPermission(this);
                }
            }
        }
        super.onActivityResult(requestCode, resultCode, data);
    }
}
