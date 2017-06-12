'use strict';

import React, { Component } from 'react';
import {
  AppRegistry,
  View,
  Text,
  StyleSheet,
  Button,
  NativeModules
} from 'react-native'

const ta = NativeModules.ShowAndroid;


export default class Root extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>React Native组件:我成功啦……!</Text>
        <Button title="测试" onPress={() => ta.showToast('nihao',1)} />

        <Button title="关闭" onPress={() => ta.closeActivity()} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#65A35F',
  },
  welcome: {
    fontSize: 40,
    textAlign: 'center',
    margin: 10,
  }
});

AppRegistry.registerComponent('FirstView', () => Root);