postgres:
	docker run -p 5432:5432 --name postgres12 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres12 dropdb simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1
sqlc:
	sqlc generate
test:
	export GO111MODULE=off
	go clean -testcache
	go test -v -cover ./...
mock:
	mockgen --package mockdb --destination db/mock/store.go simplebank/db/sqlc Store
server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock