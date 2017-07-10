import React from 'react';
import {NavBar} from 'antd-mobile';
import {browserHistory} from 'react-router';

/**
 * header 组件
 */
export default props => {
    const hVisible = sessionStorage.query_session_hVisible;

    document.title = props.title;
    const iframe = document.createElement('iframe');
    iframe.style.visibility = 'hidden';
    iframe.style.width = '1px';
    iframe.style.height = '1px';
    iframe.onload = () => {
        setTimeout(() => {
            document.body.removeChild(iframe);
        }, 1);
    };
    document.body.appendChild(iframe);

    // 判断是否添加返回事件
    const onLeftClick = (props.iconName !== null || props.iconName !== false) ? {onLeftClick: browserHistory.goBack} : {};

    return (
        hVisible === '0' ? null : <NavBar {...props} {...onLeftClick} />
    );
};
