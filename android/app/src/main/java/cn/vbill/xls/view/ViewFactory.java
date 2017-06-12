package cn.vbill.xls.view;

/**
 * Created by fenglonghui on 2017/6/6.
 */
import android.content.Context;
import android.view.LayoutInflater;
import android.widget.ImageView;

import com.nostra13.universalimageloader.core.ImageLoader;

import cn.vbill.xls.R;

/**
 * ImageView创建工厂
 * @author flh
 */
public class ViewFactory {

    /**
     * 获取ImageView视图的同时加载显示url
     *
     * @param context
     * @param url
     * @return
     */
    public static ImageView getImageView(Context context, String url) {
        ImageView imageView = (ImageView) LayoutInflater.from(context).inflate(
                R.layout.adver_unit, null);
        ImageLoader.getInstance().displayImage(url, imageView);
        return imageView;
    }
}
