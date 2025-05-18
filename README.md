## Description

## ERD Diagram

![alt text](https://github.com/dedihartono801/ecommerce/blob/master/erd.png)

Tech:
- Go (Fiber)
- MySQL
- Docker
- RabbitMQ
- Grafana, Loki, Promtail

List API:
- Registration User
- Login User
- List Product
- Order
- Login admin
- Stock Transfer
- Change Status Warehouse
- Create Stock
- Update Stock

List Implementation Concept:
- Gracefully Shutdown
    https://github.com/dedihartono801/ecommerce/blob/master/cmd/main.go#L124

- Stock Reversal using RabbitMQ DLX (Dead Letter Exchange) / DLQ (Dead Letter Queue) if payment is not made within a specified time 
    https://github.com/dedihartono801/ecommerce/blob/master/internal/app/worker/producer.go

- Concurrency when update stock
    https://github.com/dedihartono801/ecommerce/blob/master/internal/app/usecase/transaction/transaction.go#L73

- Locking Row (SELECT FOR UPDATE) with strategy to prevent deadlock
    https://github.com/dedihartono801/ecommerce/blob/master/internal/app/repository/transaction/transaction.go#L145

- Connection Pooling
    https://github.com/dedihartono801/ecommerce/blob/master/database/mysql.go#L17

- Unit Test
    https://github.com/dedihartono801/ecommerce/blob/master/internal/app/usecase/product/product_test.go

- Generate Mock Repository using Mockgen
    https://github.com/dedihartono801/ecommerce/blob/master/Makefile#L32

- Dockerize Logging (promtail, loki, grafana)
    https://github.com/dedihartono801/ecommerce/blob/master/docker-compose.yaml

- Write logs to file and terminal/console (stdout), so they can be scraped by promtail
    https://github.com/dedihartono801/ecommerce/blob/master/pkg/logger/logger.go#L13

- Migration
    https://github.com/dedihartono801/ecommerce/tree/master/migrations

- Dockerfile Multi Stage
    https://github.com/dedihartono801/ecommerce/blob/master/cmd/Dockerfile

- Sample Script CI/CD with Github Actions
    https://github.com/dedihartono801/ecommerce/blob/master/.github/workflows/github-action-deploy.yml

- Sample Script CI/CD with Jenkins
    https://github.com/dedihartono801/ecommerce/blob/master/Jenkinsfile

## Install Migration

go install -tags 'mysql' github.com/golang-migrate/migrate/v4/cmd/migrate@latest

## Install mock generator (mockgen)

go install github.com/golang/mock/mockgen@v1.6.0

## Create .env file

```bash
$ ./entrypoint.sh
```

## Run Service With Docker

```bash
$ docker-compose up -d
```

## Run Service Without Docker

```bash
$ go run cmd/main.go
```

## Run Migration UP

```bash
$ make migration-up
```

## Run Migration Down

```bash
$ make migration-down
```

## Create Migration

```bash
$ make migration
#type your migration name example: create_create_table_users
```

## Generate Mock repository

- Open Makefile
- Add this code section mock:

```
mockgen -source="YOUR_GO_INTERFACE" -destination="YOUR_MOCK_DESTINATION"
```

Example:

```
mockgen -source="./internal/app/repository/user/user.go" -destination="./internal/app/repository/user/mocks/user_mock.go"
```

```bash
$ make mock
```

## Run Unit Test and Test Coverage

```bash
$ make test-cov
```

## Check Code Smell

```bash
$ make lint
```

## Register User

```bash
curl --location 'http://localhost:5004/register' \
--header 'Content-Type: application/json' \
--data '{
    "warehouse_id":"5daf7427-fb6a-4ccb-8d54-2c496503f04c",
    "phone":"08982510077",
    "password":"123",
    "name":"andi",
    "gender":"male",
    "address":"jakarta selatan"
}'
```

## Login User

```bash
curl --location 'http://localhost:5004/login' \
--header 'Content-Type: application/json' \
--data '{
    "phone":"08982510066",
    "password":"123"
}'
```

## Get List Product

```bash
curl --location 'http://localhost:5004/product' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAxOTUwYjZhLTg4MmQtN2M2ZC1hNDhjLWE0YjA5ZmU1NWY4NyIsIndhcmVob3VzZV9pZCI6IjVkYWY3NDI3LWZiNmEtNGNjYi04ZDU0LTJjNDk2NTAzZjA0YyIsImV4cCI6MTczOTczOTc0MH0.i3Sc2d6GLKaxppalYOtkXjBwhZZ7-NDmanVup4ZeWrI' \
--data ''
```

## Order

```bash
curl --location 'http://localhost:5004/transaction' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAxOTRmZDY2LWRjYTQtNzQzMi05YzRiLTllYjM3NjYxZDJlMiIsIndhcmVob3VzZV9pZCI6IjNjNGQxY2ViLTkzZDQtNDIzMy1hZWE3LTcwMGJmNTFlNTA1MSIsImV4cCI6MTczOTc4NjMzM30.p9U3yW2atOiHxc7kMQ9w29nIYy3L9TQXNSIGktc9NgE' \
--header 'Content-Type: application/json' \
--data '{
    "payment_method":"VA",
    "address":"Jl. Cibaduyut Bandung",
    "sku":[
        {
            "id":"502a7a6a-ef9a-46ce-b9ff-cb33b21fdbec",
            "quantity":5
        },
        {
            "id":"b32b86b0-aa0a-4bea-806c-61f0250a8c28",
            "quantity":2
        }
    ]

}'
```

## Login Admin

```bash
curl --location 'http://localhost:5004/admin/login' \
--header 'Content-Type: application/json' \
--data '{
    "username":"dedih",
    "password":"123"
}'

```


## Change Status Warehouse

```bash
curl --location 'http://localhost:5004/warehouse/status' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1ZDQ0ZmQ3LTJmNzYtNGFiZi04ODgwLTgxOGM2M2M0ZTk0ZiIsIndhcmVob3VzZV9pZCI6IiIsImV4cCI6MTczOTUyMDM4Mn0.L1WhMmFEMxC0VxSiJhhmvsIT0HZ8-iP78SSQdfibkCI' \
--header 'Content-Type: application/json' \
--data '{
    "warehouse_id":"3c4d1ceb-93d4-4233-aea7-700bf51e5051"
}'
```

## Stock Transfer

```bash
curl --location 'http://localhost:5004/warehouse/stock-transfer' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1ZDQ0ZmQ3LTJmNzYtNGFiZi04ODgwLTgxOGM2M2M0ZTk0ZiIsIndhcmVob3VzZV9pZCI6IiIsImV4cCI6MTczOTcwOTE3MX0.wagS6HBgV_xuvpzD1uz74ryqLanV4Xd7udjnBVXphBs' \
--header 'Content-Type: application/json' \
--data '{
    "from":"3c4d1ceb-93d4-4233-aea7-700bf51e5051",
    "to":"5daf7427-fb6a-4ccb-8d54-2c496503f04c",
    "sku_id":"b32b86b0-aa0a-4bea-806c-61f0250a8c28",
    "quantity":10
}'
```

## Create Product

```bash
curl --location 'http://localhost:5004/product' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1ZDQ0ZmQ3LTJmNzYtNGFiZi04ODgwLTgxOGM2M2M0ZTk0ZiIsIndhcmVob3VzZV9pZCI6IiIsImV4cCI6MTczOTcwOTE3MX0.wagS6HBgV_xuvpzD1uz74ryqLanV4Xd7udjnBVXphBs' \
--header 'Content-Type: application/json' \
--data '{
    "shop_id":"01950a6a-4816-7e58-a15a-fbd229ed3e72",
    "name":"Sabun Colek",
    "sku":[
        {
            "variant":"wangi jeruk nipis",
            "price":10000,
            "uom":"renceng"
        }
    ]
}'
```

## Create Sku Stock

```bash
curl --location 'http://localhost:5004/warehouse/stock' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1ZDQ0ZmQ3LTJmNzYtNGFiZi04ODgwLTgxOGM2M2M0ZTk0ZiIsIndhcmVob3VzZV9pZCI6IiIsImV4cCI6MTczOTcwOTE3MX0.wagS6HBgV_xuvpzD1uz74ryqLanV4Xd7udjnBVXphBs' \
--header 'Content-Type: application/json' \
--data '{
    "warehouse_id":"5daf7427-fb6a-4ccb-8d54-2c496503f04c",
    "sku_id":"b32b86b0-aa0a-4bea-806c-61f0250a8c28",
    "stock":10
}'
```

## Create Shop

```bash
curl --location 'http://localhost:5004/shop' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1ZDQ0ZmQ3LTJmNzYtNGFiZi04ODgwLTgxOGM2M2M0ZTk0ZiIsIndhcmVob3VzZV9pZCI6IiIsImV4cCI6MTczOTcwOTE3MX0.wagS6HBgV_xuvpzD1uz74ryqLanV4Xd7udjnBVXphBs' \
--header 'Content-Type: application/json' \
--data '{
    "name":"shop 2"
}'
```

## Create Warehouse

```bash
curl --location 'http://localhost:5004/warehouse' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE1ZDQ0ZmQ3LTJmNzYtNGFiZi04ODgwLTgxOGM2M2M0ZTk0ZiIsIndhcmVob3VzZV9pZCI6IiIsImV4cCI6MTczOTcwOTE3MX0.wagS6HBgV_xuvpzD1uz74ryqLanV4Xd7udjnBVXphBs' \
--header 'Content-Type: application/json' \
--data '{
    "shop_id":"01950a6a-4816-7e58-a15a-fbd229ed3e72",
    "location":"Tangerang",
    "address":"Jl. Tangerang"
}'
```
