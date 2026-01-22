const express = require("express");
const app = express();

app.use(express.json());

app.use(express.urlencoded({
    extended : true
}));

const products = []

const port = 4000;
app.listen(port,()=>{
    console.log("connected to server")
})

//api 

app.post('/api/add_product',(req,res)=>{
    console.log("result",req.body);
    const data = {
        'id' : products.length +1,
        'name' : req.body.name,
        'prize' : req.body.prize,
    }

    products.push(data);
    console.log('added', data)

    res.status(200).send({
        'status_code' : 200,
        "messege": 'sadded sucess',
        'prodect': data
    })
})

app.get('/api/get_product',(req,res)=>{

    if(products.length > 0){
        res.status(200).send({
        'status_code' : 200,
        'product' : products
    })
    }
    else(
        res.status(200).send({
            "status_code" : 200,
            'product' : []
        })
    );
})