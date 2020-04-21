export const setStore = (name, content) => {
    if(!name) return;
    if(typeof content !== 'string'){
        content = JSON.stringify(content);
    }
    window.localStorage.setItem(name,content)
}


/**
 * @description: 从本地LocalStorage获取存储信息，
 * @param {string} name 
 * @return: name不存在返回false。
 */
export const getStore = name => {
    if(!name) return ;
    return window.localStorage.getItem(name);
}


// 删除localStoreage
/**
 * @description: 删除本地存储数据
 * @param {string} name 
 * @return: 不存在数据返回false
 */
export const rmStore = name => {
    if (!name) return false;
	window.localStorage.removeItem(name);
}