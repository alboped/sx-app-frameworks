/**
 * 公用校验方法。
 */

// 校验数字
export const validatorNumber = ({rules, message}) => {
    return {
        validator: (_rules, value, callback) => {
            if(value === '' || value === undefined) {
                callback();
                return;
            }
            if (isNaN(value)) {
                callback([message]);
            } else {
                const _value = Number(value);
                for (const i in rules) {
                    const v = rules[i];
                    if(v.min && _value < v.min) {
                        callback([v.message]);
                        return;
                    } else if(v.max && _value > v.max) {
                        callback([v.message]);
                        return;
                    } else if(v.accuracy) {
                        const jd = String(value).split('.');
                        if(jd.length > 1 && jd[1].length > v.accuracy) {
                            callback([v.message]);
                            return;
                        }
                    }
                };
                callback();
            }
        }
    };
};

/**
 * 校验字符串长度
 * @param  {String}   value    字符串
 * @param  {Number}   min      最小值
 * @param  {Number}   max      最大长度
 * @param  {String}   message  提示信息
 * @param  {Function} callback 校验的回调函数
 * @return {void}
 */
export const validatorByteLen = (min, max, message) => {
    return {
        validator: (rules, value, callback) => {
            const length = getByteLen(value);
            if(length < min || length > max) {
                callback([message]);
            } else {
                callback();
            }
        }
    }
}

/**
 * 获取字符串长度（汉字2个字符，字幕数字1个字符）；
 * @param  {String} value 字符串
 * @return {Number} 字符串长度
 */
const getByteLen = value => {
    let len = 0;
    for (const i in value) {
        const a = value.charAt(i);
        if (a.match(/[^\x00-\xff]/ig) !== null) {
            len += 2;
        } else {
            len += 1;
        }
    }
    return len;
};

/**
 * 校验是否含有空格
 * @param  {[type]} message [description]
 * @return {[type]}         [description]
 */
export const validatorSpace = message => {
    return {
        pattern: /^[^ ]+$/,
        message
    };
};

/**
 * 银行卡号校验
 * @param  {String} bankno 银行卡号
 * @return {void}
 */
export const validatorBankCard = (bankno) => {
    const lastNum = bankno.substr(bankno.length - 1, 1);// 取出最后一位（与luhm进行比较）

    const first15Num = bankno.substr(0, bankno.length - 1);// 前15或18位
    const newArr = [];
    for (let i = first15Num.length - 1; i > -1; i--) {    // 前15或18位倒序存进数组
        newArr.push(first15Num.substr(i, 1));
    }
    const arrJiShu = [];  // 奇数位*2的积 <9
    const arrJiShu2 = []; // 奇数位*2的积 >9

    const arrOuShu = [];  // 偶数位数组
    for (let j = 0; j < newArr.length; j++) {
        if ((j + 1) % 2 === 1) { // 奇数位
            if (parseInt(newArr[j], 10) * 2 < 9) {
                arrJiShu.push(parseInt(newArr[j], 10) * 2);
            } else {
                arrJiShu2.push(parseInt(newArr[j], 10) * 2);
            }
        } else { // 偶数位
            arrOuShu.push(newArr[j]);
        }
    }

    const jishuChild1 = [];// 奇数位*2 >9 的分割之后的数组个位数
    const jishuChild2 = [];// 奇数位*2 >9 的分割之后的数组十位数
    for (let h = 0; h < arrJiShu2.length; h++) {
        jishuChild1.push(parseInt(arrJiShu2[h], 10) % 10);
        jishuChild2.push(parseInt(arrJiShu2[h], 10) / 10);
    }

    let sumJiShu = 0; // 奇数位*2 < 9 的数组之和
    let sumOuShu = 0; // 偶数位数组之和
    let sumJiShuChild1 = 0; // 奇数位*2 >9 的分割之后的数组个位数之和
    let sumJiShuChild2 = 0; // 奇数位*2 >9 的分割之后的数组十位数之和
    let sumTotal = 0;
    for (let m = 0; m < arrJiShu.length; m++) {
        sumJiShu += parseInt(arrJiShu[m], 10);
    }

    for (let n = 0; n < arrOuShu.length; n++) {
        sumOuShu += parseInt(arrOuShu[n], 10);
    }

    for (let p = 0; p < jishuChild1.length; p++) {
        sumJiShuChild1 += parseInt(jishuChild1[p], 10);
        sumJiShuChild2 += parseInt(jishuChild2[p], 10);
    }
    // 计算总和
    sumTotal = parseInt(sumJiShu, 10) + parseInt(sumOuShu, 10) + parseInt(sumJiShuChild1, 10) + parseInt(sumJiShuChild2, 10);

    // 计算Luhm值
    const k = parseInt(sumTotal, 10) % 10 === 0 ? 10 : parseInt(sumTotal, 10) % 10;
    const luhm = 10 - k;
    if (lastNum !== luhm) {
        return false;
    }
    return true;
};
