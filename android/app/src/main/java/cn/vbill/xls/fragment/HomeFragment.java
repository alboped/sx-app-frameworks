package cn.vbill.xls.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.vbill.xls.MainActivity;
import cn.vbill.xls.MyReactNativeActivity;
import cn.vbill.xls.R;
import cn.vbill.xls.WebViewAty;
import cn.vbill.xls.entity.GrideInfo;
import cn.vbill.xls.framwork.DragBaseAdapter;
import cn.vbill.xls.tool.CycleViewPagerHandler;
import cn.vbill.xls.tool.XlsApiTools;
import cn.vbill.xls.view.ActiveGrideView;
import cn.vbill.xls.view.BaseViewPager;

/**
 * Created by fenglonghui on 2017/6/5.
 */

public class HomeFragment extends BaseFragment implements View.OnClickListener,ViewPager.OnPageChangeListener{
    private List<ImageView> imageViews = new ArrayList<ImageView>();
    private ImageView[] indicators;
    private FrameLayout viewPagerFragmentLayout;
    /** 指示器 **/
    private LinearLayout indicatorLayout;
    private BaseViewPager viewPager;
    private BaseViewPager parentViewPager;
    private ViewPagerAdapter cycleAdapter;
    private CycleViewPagerHandler handler;
    /** 默认轮播时间 4s **/
    private int time = Integer.parseInt("4000");
    /** 轮播当前位置 **/
    private int currentPosition = 0;
    /** 滚动框是否滚动着 **/
    private boolean isScrolling = false;
    /** 是否循环 **/
    private boolean isCycle = false;
    /** 是否轮播 **/
    private boolean isWheel = false;
    /** 手指松开、页面不滚动时间，防止手机松开后短时间进行切换 **/
    private long releaseTime = 0;
    /** 转动标志 **/
    private int WHEEL = 100;
    /** 等待标志 **/
    protected int WHEEL_WAIT;

    private ActiveGrideView aGridview;
    private List<HashMap<String, Integer>> list;
    private DragBaseAdapter adapter;

    {
        WHEEL_WAIT = 101;
    }
    private List<ImageView> temViews;


    public void setViews(List<ImageView> temViews){
        this.temViews=temViews;
    }

    public List<ImageView> getTemViews() {
        return temViews;
    }


    @SuppressWarnings("deprecation")
    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ((MainActivity)con).checkDataIsNull(this);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.home, null);
        init(view);
        return view;
    }

    @Override
    public void init(View view){
        super.init(view);
        viewPagerFragmentLayout = (FrameLayout) view.findViewById(R.id.layout_viewager_content);
        viewPager = (BaseViewPager) view.findViewById(R.id.viewPager);
        indicatorLayout = (LinearLayout) view.findViewById(R.id.layout_viewpager_indicator);

        aGridview = getViewTag(view, R.id.gridview);
        aGridview.setOnItemClickListener(new AdapterView.OnItemClickListener() {

            @Override
            public void onItemClick(AdapterView<?> parent, View item, int arg2,
                                    long position) {
//                DragBaseAdapter dba = (DragBaseAdapter)parent.getAdapter();
//                Map.Entry<?, ?> entry = dba.loopItem(dba.get(),(int)position);
//                String key = (String)entry.getKey();
                if(position == 1){
                    startActivity(new Intent(con,WebViewAty.class));
                }else if(position == 2){
                    startActivity(new Intent(HomeFragment.this.con,MyReactNativeActivity.class));
                }

            }
        });
        initdata();
        notifyCollection();
        initViewPager();
    }


    /**
     * 初始化数据
     */
    public void initdata() {
        if (list != null) {
            if (list.size() > 0)
                list.clear();
        } else {
            list = new ArrayList<HashMap<String, Integer>>();
        }
        for (int i = 0; i < gis.length; i++) {
            HashMap<String, Integer> map = new HashMap<String, Integer>();
            int pos = i;
            map.put(gis[pos].getName(), R.mipmap.app_phonecharge);
            list.add(map);
        }
    }


    private void notifyCollection() {
        adapter = new DragBaseAdapter(con, list);
        aGridview.setAdapter(adapter);
    }

    /**
     * 初始化主页广告轮番图
     */
    private void initViewPager() {

        handler = new CycleViewPagerHandler(con) {
            @Override
            public void handleMessage(Message msg) {
                super.handleMessage(msg);
                if (msg.what == WHEEL && imageViews.size() != 0) {
                    if (!isScrolling) {
                        int max = imageViews.size() + 1;
                        int position = (currentPosition + 1) % imageViews.size();
                        viewPager.setCurrentItem(position, true);
                        if (position == max) {
                            // looper end to first adver
                            viewPager.setCurrentItem(1, false);
                        }
                    }
                    releaseTime = System.currentTimeMillis();
                    handler.removeCallbacks(runnable);
                    handler.postDelayed(runnable, time);
                    return;
                }
                if (msg.what == WHEEL_WAIT && imageViews.size() != 0) {
                    handler.removeCallbacks(runnable);
                    handler.postDelayed(runnable, time);
                }
            }
        };
        // set image islooper before call method setData
        setCycle(true);
        //set loop
        setWheel(true);
        // set loop duration，defalut 4000ms
        setTime(this.time);
        //set guide icon show position defalut right
        setIndicatorCenter();
        setData(0);
    }


    @Override
    public void onClick(View v) {

    }



    @Override
    public void onPageScrollStateChanged(int arg0) {
        if (arg0 == 1) { // viewPager在滚动
            isScrolling = true;
            return;
        } else if (arg0 == 0) { // viewPager滚动结束
            if (parentViewPager != null)
                parentViewPager.setScrollable(true);

            releaseTime = System.currentTimeMillis();

            viewPager.setCurrentItem(currentPosition, false);

        }
        isScrolling = false;
    }



    @Override
    public void onPageScrolled(int arg0, float arg1, int arg2) {
    }


    @Override
    public void onPageSelected(int arg0) {
        int max = imageViews.size() - 1;
        int position = arg0;
        currentPosition = arg0;
        if (isCycle) {
            if (arg0 == 0) {
                currentPosition = max - 1;
            } else if (arg0 == max) {
                currentPosition = 1;
            }
            position = currentPosition - 1;
        }
        setIndicator(position);
    }


    @Override
    public void isVisibilityTitleArea() {
        initTitle(XlsApiTools.getResString(getActivity(),R.string.title_home), false, false);
    }


    /**
     * init viewpager
     *
     * @param showPosition
     *            默认显示位置
     */
    public void setData(int showPosition) {
        this.imageViews.clear();

        if (temViews.size() == 0) {
//			viewPagerFragmentLayout.setVisibility(View.GONE);
            return;
        }

        for (ImageView item : temViews) {
            this.imageViews.add(item);
        }

        int ivSize = temViews.size();

        // 设置指示器
        indicators = new ImageView[ivSize];
        if (isCycle)
            indicators = new ImageView[ivSize - 2];
        indicatorLayout.removeAllViews();
        for (int i = 0; i < indicators.length; i++) {
            View view = LayoutInflater.from(getActivity()).inflate(
                    R.layout.view_cycle_viewpager_indicator, null);
            indicators[i] = (ImageView) view.findViewById(R.id.image_indicator);
            indicatorLayout.addView(view);
        }

        cycleAdapter = new ViewPagerAdapter();

        // 默认指向第一项，下方viewPager.setCurrentItem将触发重新计算指示器指向
        setIndicator(0);

        viewPager.setOffscreenPageLimit(3);
        viewPager.addOnPageChangeListener(HomeFragment.this);
        viewPager.setAdapter(cycleAdapter);
        if (showPosition < 0 || showPosition >= temViews.size())
            showPosition = 0;
        if (isCycle) {
            showPosition = showPosition + 1;
        }
        viewPager.setCurrentItem(showPosition);

    }

    /**
     * 设置指示器居中，默认在右方
     */
    public void setIndicatorCenter() {
        RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT);
        params.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        params.addRule(RelativeLayout.CENTER_HORIZONTAL);
        indicatorLayout.setLayoutParams(params);
    }

    /**
     * 是否循环，默认不开启，开启前，请将views的最前面与最后面各加入一个视图，用于循环
     *
     * @param isCycle
     *            是否循环
     */
    public void setCycle(boolean isCycle) {
        this.isCycle = isCycle;
    }

    /**
     * 是否处于循环状态
     *
     * @return
     */
    public boolean isCycle() {
        return isCycle;
    }

    /**
     * 设置是否轮播，默认不轮播,轮播一定是循环的
     *
     * @param isWheel
     */
    public void setWheel(boolean isWheel) {
        this.isWheel = isWheel;
        isCycle = true;
        if (isWheel) {
            handler.postDelayed(runnable, time);
        }
    }

    /**
     * 是否处于轮播状态
     *
     * @return
     */
    public boolean isWheel() {
        return isWheel;
    }

    final Runnable runnable = new Runnable() {

        @Override
        public void run() {
            if (getActivity() != null && !getActivity().isFinishing()
                    && isWheel) {
                long now = System.currentTimeMillis();
                // 检测上一次滑动时间与本次之间是否有触击(手滑动)操作，有的话等待下次轮播
                if (now - releaseTime > time - 500) {
                    handler.sendEmptyMessage(WHEEL);
                } else {
                    handler.sendEmptyMessage(WHEEL_WAIT);
                }
            }
        }
    };

    /**
     * release guider height（可能由于之前指示器被限制了高度，此处释放）
     */
    public void releaseHeight() {
        getView().getLayoutParams().height = RelativeLayout.LayoutParams.MATCH_PARENT;
//        refreshData();
    }

    /**
     * set looper duration time. 默认4000ms
     *
     * @param time
     *            毫秒为单位
     */
    public void setTime(int time) {
        this.time = time;
    }



    /**
     * hide CycleViewPager
     */
    public void hide() {
        viewPagerFragmentLayout.setVisibility(View.GONE);
    }

    /**
     * get viewpager
     *
     * @return viewPager
     */
    public BaseViewPager getViewPager() {
        return viewPager;
    }

    /**
     * set the guider
     *
     * @param selectedPosition
     *            默认指示器位置
     */
    private void setIndicator(int selectedPosition) {
        for (int i = 0; i < indicators.length; i++) {
            indicators[i]
                    .setBackgroundResource(R.drawable.dot_sel);
        }
        if (indicators.length > selectedPosition)
            indicators[selectedPosition]
                    .setBackgroundResource(R.drawable.dot);
    }


    public void configViewPager(List<ImageView> views){
        setViews(views);
    }


//    public static String[] img_text = { "新增商户", "装换撤管理", "商户查询", "进度查询", "机具订单", "信息修改", "积分商城", "业务员推荐"};

//    public static int[] imgs = { R.drawable.app_transfer, R.drawable.app_fund,
//            R.drawable.app_phonecharge, R.drawable.app_creditcard, R.drawable.order, R.drawable.intelligence, R.drawable.shop, R.drawable.sales_recomend };




    // "00" native，"01" rn, "02" webview
    public static GrideInfo gi1 = new GrideInfo("新增商户", "00", "url", "iconlink", "market", "android");
    public static GrideInfo gi2 = new GrideInfo("装换撤管理", "01", "url", "iconlink", "market", "android");
    public static GrideInfo gi3 = new GrideInfo("商户查询", "02", "url", "iconlink", "market", "android");
    public static GrideInfo gi4 = new GrideInfo("进度查询", "00", "url", "iconlink", "market", "android");
    public static GrideInfo gi5 = new GrideInfo("机具订单", "00", "url", "iconlink", "market", "android");
    public static GrideInfo gi6 = new GrideInfo("信息修改", "00", "url", "iconlink", "market", "android");
    public static GrideInfo gi7 = new GrideInfo("积分商城", "00", "url", "iconlink", "market", "android");
    public static GrideInfo gi8 = new GrideInfo("业务员推荐", "00", "url", "iconlink", "market", "android");

    public static GrideInfo[] gis = {gi1,gi2,gi3,gi4,gi5,gi6,gi7,gi8};


    /**
     * ViewPagerAdapter
     *
     * @author flh
     *
     */
    private class ViewPagerAdapter extends PagerAdapter {

        @Override
        public int getCount() {
            return imageViews.size();
        }

        @Override
        public boolean isViewFromObject(View arg0, Object arg1) {
            return arg0 == arg1;
        }

        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            container.removeView((View) object);
        }

        @Override
        public View instantiateItem(ViewGroup container, final int position) {
            ImageView v = imageViews.get(position);
            v.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (isCycle()) {
                        //jump2AdverUI();
                    }
                }
            });
            container.addView(v);
            return v;
        }

        @Override
        public int getItemPosition(Object object) {
            return POSITION_NONE;
        }
    }

}
