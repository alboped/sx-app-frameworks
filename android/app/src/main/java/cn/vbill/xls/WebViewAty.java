package cn.vbill.xls;

import android.graphics.Bitmap;
import android.net.http.SslError;
import android.os.Bundle;
import android.text.TextUtils;
import android.webkit.SslErrorHandler;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import cn.vbill.xls.tool.XlsApiTools;

/**
 * Created by fenglonghui on 2017/6/7.
 */

public class WebViewAty extends BaseActivity {

    public String actionUrl = "https://www.baidu.com/";
    public String title="";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.adver_activity);
        init();
    }

    @Override
    public void init(){
        super.init();
        adverWebView = getViewTag(R.id.adver_webView);
        WebSettings setting = adverWebView.getSettings();
        setting.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
        setting.setDefaultTextEncodingName("utf-8");
        setting.setJavaScriptEnabled(true);
        setting.setBuiltInZoomControls(true);
        setting.setDisplayZoomControls(false);
        setting.setSupportZoom(true);

        setting.setDomStorageEnabled(true);
        setting.setDatabaseEnabled(true);
        setting.setCacheMode(WebSettings.LOAD_NO_CACHE);
        adverWebView.setLongClickable(false);
        adverWebView.getSettings().setLayoutAlgorithm(WebSettings.LayoutAlgorithm.NORMAL);
        adverWebView.setWebViewClient(new WebViewClient() {

            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);

            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                return true;
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                title = view.getTitle();
                if(!TextUtils.isEmpty(title)){
                    initTitle(title, true, true);
                }

            }

            @Override
            public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
                super.onReceivedError(view, errorCode, description, failingUrl);

            }

            @Override
            public void onReceivedSslError(WebView view, SslErrorHandler handler, SslError error) {
                handler.proceed();
            }
        });

        adverWebView.loadUrl(actionUrl);
    }


    @Override
    public void isVisibilityTitleArea() {
        initTitle(title, true, true);

    }
}
