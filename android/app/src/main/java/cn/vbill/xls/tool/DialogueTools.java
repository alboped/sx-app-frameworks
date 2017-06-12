package cn.vbill.xls.tool;

import android.app.Activity;
import android.widget.Toast;

import cn.vbill.xls.R;

/**
 * Created by fenglonghui on 2017/6/6.
 * dialogue 工具类
 */

public class DialogueTools {


    /**
     * Toast 长提示框
     * @param con
     * @param id
     * @return
     */
    public static void ToastLongDialogue(Activity con,int id){
        Toast.makeText(con, XlsApiTools.getResString(con,id), Toast.LENGTH_LONG).show();
    }


    /**
     * Toast 短提示框
     * @param con
     * @param id
     */
    public static void ToastShortDialogue(Activity con,int id){
        Toast.makeText(con, XlsApiTools.getResString(con,id), Toast.LENGTH_SHORT).show();
    }
}
