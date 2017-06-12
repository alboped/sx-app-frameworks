package cn.vbill.xls.fragment;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import cn.vbill.xls.MyReactActivity;
import cn.vbill.xls.MyReactNativeActivity;
import cn.vbill.xls.R;
import cn.vbill.xls.tool.XlsApiTools;

/**
 * Created by fenglonghui on 2017/6/5.
 * 我的
 */

public class MyInfoFragment extends BaseFragment implements View.OnClickListener{

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        this.con = (Context)activity;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.myinfo, null);
        init(view);
        view.findViewById(R.id.button).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MyInfoFragment.this.con,MyReactActivity.class));
            }
        });

        view.findViewById(R.id.button2).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(MyInfoFragment.this.con,MyReactNativeActivity.class));
            }
        });
        return view;
    }

    @Override
    public void init(View view){
        super.init(view);
    }

    @Override
    public void onClick(View v) {

    }

    @Override
    public void isVisibilityTitleArea() {
        initTitle(XlsApiTools.getResString(getActivity(),R.string.title_myinfo), true, false);
    }
}
