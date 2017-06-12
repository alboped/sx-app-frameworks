package cn.vbill.xls.tool;

import android.app.Activity;

/**
 * Created by fenglonghui on 2017/6/6.
 * 工具类
 */

public class XlsApiTools {


    /**
     * 获取应用字符串
     * @param act
     * @param id
     * @return
     */
    public static String getResString(Activity act,int id){
        return act.getResources().getString(id);
    }
}
