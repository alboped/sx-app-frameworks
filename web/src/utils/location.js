export const getQuery = key => {
    const {search} = window.location;
    const params = {};
    const paramStr = search.substr(1, search.length);

    paramStr.split('&').forEach(par => {
        const parArr = par.split('=');

        params[parArr[0]] = parArr[1];
    });

    return params[key];
};
