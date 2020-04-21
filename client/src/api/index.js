import Axios from './../extend/axios'

export const login = ({username,captcha,password}) => Axios.post(
        'login/',{
            username,
            captcha,
            password
        }
    )


export const getCaptcha = ()=>Axios.get(
        'captcha'
    )

export const getflower = (kind) => Axios.get(
    kind
)


export const getflowerDetail = (id) => Axios.get(
    'Detail',{params:{
        flower_id:id

    }    }
)

export const getflowerComments = (id) => Axios.get(
    'comments', {
        params: {
            flower_id:id
        }
    }
)

export const inserComments = (star,comment_desc,flower_id) => Axios.post(
    'insertComments/',{
        star,
        comment_desc,
        flower_id
    }
)

export const updateUser = (formData) => Axios.post(
    'updateUser/',formData
)

export const collectflower = (flower_id) => Axios.post(
    'flowerCollect/',{
        flower_id
    }
)

export const getUser = () => Axios.get(
    'user'
)

export const getCollectedflowers = ()=>Axios.get(
    'flowerCollected'
)

export const deletCollectedflower = (collect_id) => Axios.post(
    'collectDelete/',{
        collect_id
    }
)

export const resUser = (username,password) => Axios.post('registerLogin/',{
    username,
    password
})

export const flowerBuy = (flower_id) => Axios.post('flowerBuy/',{
    flower_id
})


export const findOrder = (statu) => Axios.get(`myOrder?status=${statu}`)

export const flowerSell = (status,buy_id)=>Axios.post(
    'flowerSell/',{
        status,
        buy_id
    }
)

export const logOut = () =>Axios.get('logout') 

export const addflowerType = (name)=> Axios.post(
    'insertType/',{
        name
    }
)

export const findflowerType = ()=>Axios.get('flowerType')

export const deleteType = (flower_type_id)=>Axios.post('deleteType/',{
    flower_type_id
})

export const addflower = (formData)=>Axios.post(
    'insertFlower/',formData
)
    

export const delflower = (flower_id)=>Axios.post(
    'deleteFlower/',{
        flower_id
    }
)

export const findAllflower = ()=>Axios.get('flower')

export const flowerSold = (status) =>Axios.get(`flowerSold?status=${status}`)

export const updataflower = (form) => Axios.post('updateFlower/',form)