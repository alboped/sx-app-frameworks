package cn.vbill.xls;


import android.os.Bundle;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;

import com.nostra13.universalimageloader.cache.disc.naming.Md5FileNameGenerator;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.QueueProcessingType;

import java.util.ArrayList;
import java.util.List;

import cn.vbill.xls.entity.AdvertisInfo;
import cn.vbill.xls.fragment.ClassifyFragment;
import cn.vbill.xls.fragment.HomeFragment;
import cn.vbill.xls.fragment.MyInfoFragment;
import cn.vbill.xls.fragment.RankingFragment;
import cn.vbill.xls.tool.DialogueTools;
import cn.vbill.xls.view.ViewFactory;


/**
 * 主页
 */
public class MainActivity extends BaseActivity implements android.view.View.OnClickListener{

    public static final String TAG = "MainActivity";
    private RadioGroup container;
    private RadioButton rb;
    private FragmentManager manager;
    private FragmentTransaction transaction;


    /** 首页 **/
    private HomeFragment homeFragment;
    /** 商户 **/
    private RankingFragment rankFragment;
    /** 盟主 **/
    private ClassifyFragment classFragment;
    /** 我的 **/
    private MyInfoFragment infoFragment;

    private long mExitTime;

    // viewpager轮番图所定义的参数
    private List<ImageView> views = new ArrayList<ImageView>();
    ArrayList<AdvertisInfo> infos = new ArrayList<AdvertisInfo>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        initView();
    }


    public void initView(){
        container = getViewTag(R.id.main_radiogroup);
        rb = getViewTag(R.id.main_radio0);
        manager = getSupportFragmentManager();
        container.setOnCheckedChangeListener(new OnCheckedChangeListener() {

            @Override
            public void onCheckedChanged(RadioGroup arg0, int arg1) {
                transaction = manager.beginTransaction();
                if (homeFragment != null) {
                    transaction.detach(homeFragment);
                }
                if (rankFragment != null) {
                    transaction.detach(rankFragment);
                }
                if (classFragment != null) {
                    transaction.detach(classFragment);
                }
                if (infoFragment != null) {
                    transaction.detach(infoFragment);
                }


                switch (arg1) {
                    case R.id.main_radio0:
                        homeFragment = new HomeFragment();
                        transaction.replace(R.id.main_container, homeFragment);
                        transaction.commitAllowingStateLoss();
                        break;
                    case R.id.main_radio1:
                        rankFragment = new RankingFragment();
                        transaction.replace(R.id.main_container, rankFragment);
                        transaction.commit();
                        break;
                    case R.id.main_radio2:
                        classFragment = new ClassifyFragment();
                        transaction.replace(R.id.main_container, classFragment);
                        transaction.commit();
                        break;
                    case R.id.main_radio3:
                        infoFragment = new MyInfoFragment();
                        transaction.replace(R.id.main_container, infoFragment);
                        transaction.commit();
                        break;
                }
            }
        });
        rb.setChecked(true);
        testAdervalData();
        initCycleImageView();
    }

    /**
     * 测试数据
     */
    public void testAdervalData(){
        AdvertisInfo a1 = new AdvertisInfo();
        a1.setUrl("https://www.baidu.com/img/bd_logo1.png");
        infos.add(a1);
        AdvertisInfo a2 = new AdvertisInfo();
        a2.setUrl("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496755714479&di=c9f112ccdfc75348405e4202cb1db7b1&imgtype=0&src=http%3A%2F%2Fwww.icosky.com%2Ficon%2Fpng%2FAvatar%2FElite%2520Captains%2FElite%2520Captain%2520Blue.png");
        infos.add(a2);
        AdvertisInfo a3 = new AdvertisInfo();
        a3.setUrl("http://img.sj33.cn/uploads/allimg/201412/7_122G02R5Ab.png");
        infos.add(a3);
        AdvertisInfo a4 = new AdvertisInfo();
        a4.setUrl("http://img.sj33.cn/uploads/allimg/201412/7_121ZT6493956.png");
        infos.add(a4);
    }


    @Override
    public void onClick(View v) {

    }


    @Override
    public void isVisibilityTitleArea() {

    }

    public void checkDataIsNull(HomeFragment homeFragment){
        if(homeFragment.getTemViews() == null){
            bindCycleImageView(homeFragment);
        }
    }


    /**
     * 初始化轮播图
     */
    private void initCycleImageView(){
        configImageLoader();
    }

    /**
     * 配置ImageLoder
     */
    private void configImageLoader() {
        // 初始化ImageLoader
        @SuppressWarnings("deprecation")
        DisplayImageOptions options = new DisplayImageOptions.Builder().showStubImage(R.mipmap.icon_stub) // 设置图片下载期间显示的图片
                .showImageForEmptyUri(R.mipmap.icon_empty)
                .showImageOnFail(R.mipmap.icon_error)
                .cacheInMemory(true) // 是否缓存
                .cacheOnDisc(true) // 是否缓存在SD卡中
                .build();

        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(con).defaultDisplayImageOptions(options)
                .threadPriority(Thread.NORM_PRIORITY - 2).denyCacheImageMultipleSizesInMemory()
                .discCacheFileNameGenerator(new Md5FileNameGenerator()).tasksProcessingOrder(QueueProcessingType.LIFO).build();
        ImageLoader.getInstance().init(config);
    }


    private void bindCycleImageView(HomeFragment homeFragment){
        if(views.size() > 0)
            views.clear();
        if(infos.size() != 0){
            // add last image into CycleImage
            views.add(ViewFactory.getImageView(this, infos.get(infos.size() - 1).getUrl()));
            for (int i = 0; i < infos.size(); i++) {
                views.add(ViewFactory.getImageView(this, infos.get(i).getUrl()));
            }
            // add first image into CycleImage
            views.add(ViewFactory.getImageView(this, infos.get(0).getUrl()));
        }
        homeFragment.configViewPager(views);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            if ((System.currentTimeMillis() - mExitTime) > 2000) {
                DialogueTools.ToastLongDialogue(this,R.string.exit_message);
                mExitTime = System.currentTimeMillis();

            } else {
                finish();
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

}
