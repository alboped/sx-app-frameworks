package cn.vbill.xls.view;

import android.support.v4.view.ViewPager;
import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;


/**
 * 自定义viewpapger(广告推荐)
 * Created by fenglonghui on 2017/6/6.
 */
public class BaseViewPager extends ViewPager {
    private boolean scrollable = true;

    public BaseViewPager(Context context) {
        super(context);
    }

    public BaseViewPager(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    /**
     * 设置viewpager是否可以滚动
     *
     * @param enable
     */
    public void setScrollable(boolean enable) {
        scrollable = enable;
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent event) {
        if (scrollable) {
            return super.onInterceptTouchEvent(event);
        } else {
            return false;
        }
    }
}