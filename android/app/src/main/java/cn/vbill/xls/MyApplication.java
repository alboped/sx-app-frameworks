package cn.vbill.xls;

import android.app.Application;
import android.text.TextUtils;

import com.facebook.react.BuildConfig;
import com.facebook.react.ReactApplication;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cn.vbill.xls.entity.AdvertisInfo;
import cn.vbill.xls.react_modules.AnExampleReactPackage;

public class MyApplication extends Application implements ReactApplication {

  /** 轮播图结合 **/
  public static ArrayList<AdvertisInfo> infos = new ArrayList<AdvertisInfo>();

  public ArrayList<AdvertisInfo> getImages() {
    return infos;
  }

  public void setImages(ArrayList<AdvertisInfo> infos){
    this.infos = infos;
  }

  /** 轮播时间间隔 **/
  private String cycleTime;

  public void setCycleTime(String cycleTime){
    if(TextUtils.isEmpty(cycleTime)){
      this.cycleTime = "4000";
    }else{
      this.cycleTime = cycleTime;
    }
  }

  public String getCycleTime(){
    return this.cycleTime;
  }

  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
    @Override
    public boolean getUseDeveloperSupport() {
      return BuildConfig.DEBUG;
    }

    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
        new MainReactPackage(),new AnExampleReactPackage());
    }
  };


  @Override
  public ReactNativeHost getReactNativeHost() {
    return mReactNativeHost;
  }

  @Override
  public void onCreate() {
    super.onCreate();
    SoLoader.init(this, /* native exopackage */ false);
  }
}
