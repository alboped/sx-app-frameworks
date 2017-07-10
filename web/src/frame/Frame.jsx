import React, {Component} from 'react';
import {PubSubMsg} from 'zk-react';
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';
import './style.less';
import * as message from '../commons/message';
import handleErrorMessage from '../commons/handle-error-message';

NProgress.configure({showSpinner: false});

export class LayoutComponent extends Component {
    state = {}

    componentWillMount() {
        const {actions} = this.props;
        actions.getStateFromStorage();

        PubSubMsg.subscribe('message', ({type, message: msg, error = {}}) => {
            if (type === 'error') {
                handleErrorMessage(error);
            } else if (type === 'success') {
                message.success(msg, 3);
            } else {
                message.info(msg, 3);
            }
        });

        PubSubMsg.subscribe('history-change', (/* history */) => {
        });

        PubSubMsg.subscribe('start-fetching-component', () => {
            NProgress.start();
        });

        PubSubMsg.subscribe('end-fetching-component', () => {
            NProgress.done();
        });
    }

    render() {
        return (
            <div className="app-frame">
                {this.props.children}
            </div>
        );
    }
}

export function mapStateToProps(state) {
    return {
        ...state.frame,
    };
}
