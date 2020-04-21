
let imageUrl = "";
switch (process.env.NODE_ENV) {
    case 'development':
        imageUrl = "./../assets/"  //开发环境url
        break
    case 'production':
        imageUrl = "http://localhost:8081/images/"   //生产环境url
        break
}
export const  getImageUrl= (url) =>{
   return  `${imageUrl}${url}`
 }
export {imageUrl};
