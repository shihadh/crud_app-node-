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
// get api
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

// update api (also we can do with post)
app.put('/api/update_product/:id',(req,res)=>{

    const id = req.params.id * 1;
    const findProduct = products.find(p=> p.id === id);
    const index = products.indexOf(findProduct);
    products[index] = req.body;
    res.status(200).send({
        'status_code' : 200,
        'messege' : 'update is sucess'
    })
})

// delete
app.delete("/api/delete_product/:id",(req,res)=>{

    const id = req.params.id *1;
    const findProduct = products.find(p=>p.id === id)
    const index = products.indexOf(findProduct);

    products.splice(index,1)
    
    res.status(200).send({
        'status_code' : 200,
        'messege' : 'delete sucess'
    })
})