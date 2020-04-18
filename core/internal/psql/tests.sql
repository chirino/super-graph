?   	github.com/dosco/super-graph	[no test files]
testing: warning: no tests to run
PASS
ok  	github.com/dosco/super-graph/core	0.025s [no tests to run]
=== RUN   TestGQLName1
--- PASS: TestGQLName1 (0.00s)
=== RUN   TestGQLName2
--- PASS: TestGQLName2 (0.00s)
=== RUN   TestGQLName3
--- PASS: TestGQLName3 (0.00s)
=== RUN   TestGQLName4
--- PASS: TestGQLName4 (0.00s)
=== RUN   TestGQLName5
--- PASS: TestGQLName5 (0.00s)
=== RUN   TestFuzzCrashers
--- PASS: TestFuzzCrashers (0.00s)
PASS
ok  	github.com/dosco/super-graph/core/internal/allow	0.010s
?   	github.com/dosco/super-graph/core/internal/crypto	[no test files]
?   	github.com/dosco/super-graph/core/internal/integration_tests	[no test files]
=== RUN   TestCockroachDB
started temporary cockroach db
=== RUN   TestCockroachDB/seed_fixtures
=== RUN   TestCockroachDB/get_line_items
=== RUN   TestCockroachDB/update_line_item
=== RUN   TestCockroachDB/delete_line_item
=== RUN   TestCockroachDB/nested_insert
stopping temporary cockroach db
--- PASS: TestCockroachDB (0.85s)
    --- PASS: TestCockroachDB/seed_fixtures (0.01s)
    --- PASS: TestCockroachDB/get_line_items (0.00s)
    --- PASS: TestCockroachDB/update_line_item (0.00s)
    --- PASS: TestCockroachDB/delete_line_item (0.00s)
    --- SKIP: TestCockroachDB/nested_insert (0.00s)
        cockroachdb_test.go:61: nested inserts currently not working yet on cockroach db
PASS
ok  	github.com/dosco/super-graph/core/internal/integration_tests/cockroachdb	0.872s
=== RUN   TestCockroachDB
--- SKIP: TestCockroachDB (0.00s)
    postgresql_test.go:17: set the SG_POSTGRESQL_TEST_URL env variable if you want to run integration tests against a PostgreSQL database
PASS
ok  	github.com/dosco/super-graph/core/internal/integration_tests/postgresql	0.015s
=== RUN   TestCompileInsert
=== RUN   TestCompileInsert/simpleInsert
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "users" AS (INSERT INTO "users" ("full_name", "email") SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying) FROM "_sg_input" i RETURNING *) SELECT jsonb_build_object('user', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."id" AS "id" FROM (SELECT "users"."id" FROM "users" LIMIT ('1') :: integer) AS "users_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/singleInsert
WITH "_sg_input" AS (SELECT '{{insert}}' :: json AS j), "products" AS (INSERT INTO "products" ("name", "description", "price", "user_id") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'description' AS text), CAST( i.j ->>'price' AS numeric(7,2)), CAST( i.j ->>'user_id' AS bigint) FROM "_sg_input" i RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/bulkInsert
WITH "_sg_input" AS (SELECT '{{insert}}' :: json AS j), "products" AS (INSERT INTO "products" ("name", "description") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'description' AS text) FROM "_sg_input" i RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/simpleInsertWithPresets
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "products" AS (INSERT INTO "products" ("name", "price", "created_at", "updated_at", "user_id") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), 'now' :: timestamp without time zone, 'now' :: timestamp without time zone, '{{user_id}}' :: bigint FROM "_sg_input" i RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id" FROM (SELECT "products"."id" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/nestedInsertManyToMany
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "products" AS (INSERT INTO "products" ("name", "price") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)) FROM "_sg_input" i RETURNING *), "customers" AS (INSERT INTO "customers" ("full_name", "email") SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying) FROM "_sg_input" i RETURNING *), "purchases" AS (INSERT INTO "purchases" ("sale_type", "quantity", "due_date", "customer_id", "product_id") SELECT CAST( i.j ->>'sale_type' AS character varying), CAST( i.j ->>'quantity' AS integer), CAST( i.j ->>'due_date' AS timestamp without time zone), "customers"."id", "products"."id" FROM "_sg_input" i, "customers", "products" RETURNING *) SELECT jsonb_build_object('purchase', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "purchases_0"."sale_type" AS "sale_type", "purchases_0"."quantity" AS "quantity", "purchases_0"."due_date" AS "due_date", "__sj_1"."json" AS "product", "__sj_2"."json" AS "customer" FROM (SELECT "purchases"."sale_type", "purchases"."quantity", "purchases"."due_date", "purchases"."product_id", "purchases"."customer_id" FROM "purchases" LIMIT ('1') :: integer) AS "purchases_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "customers_2"."id" AS "id", "customers_2"."full_name" AS "full_name", "customers_2"."email" AS "email" FROM (SELECT "customers"."id", "customers"."full_name", "customers"."email" FROM "customers" WHERE ((("customers"."id") = ("purchases_0"."customer_id"))) LIMIT ('1') :: integer) AS "customers_2") AS "__sr_2") AS "__sj_2" ON ('true') LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."id") = ("purchases_0"."product_id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "customers" AS (INSERT INTO "customers" ("full_name", "email") SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying) FROM "_sg_input" i RETURNING *), "products" AS (INSERT INTO "products" ("name", "price") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)) FROM "_sg_input" i RETURNING *), "purchases" AS (INSERT INTO "purchases" ("sale_type", "quantity", "due_date", "product_id", "customer_id") SELECT CAST( i.j ->>'sale_type' AS character varying), CAST( i.j ->>'quantity' AS integer), CAST( i.j ->>'due_date' AS timestamp without time zone), "products"."id", "customers"."id" FROM "_sg_input" i, "products", "customers" RETURNING *) SELECT jsonb_build_object('purchase', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "purchases_0"."sale_type" AS "sale_type", "purchases_0"."quantity" AS "quantity", "purchases_0"."due_date" AS "due_date", "__sj_1"."json" AS "product", "__sj_2"."json" AS "customer" FROM (SELECT "purchases"."sale_type", "purchases"."quantity", "purchases"."due_date", "purchases"."product_id", "purchases"."customer_id" FROM "purchases" LIMIT ('1') :: integer) AS "purchases_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "customers_2"."id" AS "id", "customers_2"."full_name" AS "full_name", "customers_2"."email" AS "email" FROM (SELECT "customers"."id", "customers"."full_name", "customers"."email" FROM "customers" WHERE ((("customers"."id") = ("purchases_0"."customer_id"))) LIMIT ('1') :: integer) AS "customers_2") AS "__sr_2") AS "__sj_2" ON ('true') LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."id") = ("purchases_0"."product_id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/nestedInsertOneToMany
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "users" AS (INSERT INTO "users" ("full_name", "email", "created_at", "updated_at") SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone) FROM "_sg_input" i RETURNING *), "products" AS (INSERT INTO "products" ("name", "price", "created_at", "updated_at", "user_id") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone), "users"."id" FROM "_sg_input" i, "users" RETURNING *) SELECT jsonb_build_object('user', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."id" AS "id", "users_0"."full_name" AS "full_name", "users_0"."email" AS "email", "__sj_1"."json" AS "product" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" LIMIT ('1') :: integer) AS "users_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."user_id") = ("users_0"."id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/nestedInsertOneToOne
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "users" AS (INSERT INTO "users" ("full_name", "email", "created_at", "updated_at") SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone) FROM "_sg_input" i RETURNING *), "products" AS (INSERT INTO "products" ("name", "price", "created_at", "updated_at", "user_id") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone), "users"."id" FROM "_sg_input" i, "users" RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "__sj_1"."json" AS "user" FROM (SELECT "products"."id", "products"."name", "products"."user_id" FROM "products" LIMIT ('1') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."id" AS "id", "users_1"."full_name" AS "full_name", "users_1"."email" AS "email" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" WHERE ((("users"."id") = ("products_0"."user_id"))) LIMIT ('1') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/nestedInsertOneToManyWithConnect
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "users" AS (INSERT INTO "users" ("full_name", "email", "created_at", "updated_at") SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone) FROM "_sg_input" i RETURNING *), "products" AS ( UPDATE "products" SET "user_id" = "users"."id" FROM "users" WHERE ("products"."id"= ((i.j->'product'->'connect'->>'id'))::bigint) RETURNING "products".*) SELECT jsonb_build_object('user', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."id" AS "id", "users_0"."full_name" AS "full_name", "users_0"."email" AS "email", "__sj_1"."json" AS "product" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" LIMIT ('1') :: integer) AS "users_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."user_id") = ("users_0"."id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/nestedInsertOneToOneWithConnect
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "_x_users" AS (SELECT "id" FROM "_sg_input" i,"users" WHERE "users"."id"= ((i.j->'user'->'connect'->>'id'))::bigint LIMIT 1), "products" AS (INSERT INTO "products" ("name", "price", "created_at", "updated_at", "user_id") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone), "_x_users"."id" FROM "_sg_input" i, "_x_users" RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "__sj_1"."json" AS "user", "__sj_2"."json" AS "tags" FROM (SELECT "products"."id", "products"."name", "products"."user_id", "products"."tags" FROM "products" LIMIT ('1') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_2"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "tags_2"."id" AS "id", "tags_2"."name" AS "name" FROM (SELECT "tags"."id", "tags"."name" FROM "tags" WHERE ((("tags"."slug") = any ("products_0"."tags"))) LIMIT ('20') :: integer) AS "tags_2") AS "__sr_2") AS "__sj_2") AS "__sj_2" ON ('true') LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."id" AS "id", "users_1"."full_name" AS "full_name", "users_1"."email" AS "email" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" WHERE ((("users"."id") = ("products_0"."user_id"))) LIMIT ('1') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileInsert/nestedInsertOneToOneWithConnectArray
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "_x_users" AS (SELECT "id" FROM "_sg_input" i,"users" WHERE "users"."id" = ANY((select a::bigint AS list from json_array_elements_text((i.j->'user'->'connect'->>'id')::json) AS a)) LIMIT 1), "products" AS (INSERT INTO "products" ("name", "price", "created_at", "updated_at", "user_id") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone), "_x_users"."id" FROM "_sg_input" i, "_x_users" RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "__sj_1"."json" AS "user" FROM (SELECT "products"."id", "products"."name", "products"."user_id" FROM "products" LIMIT ('1') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."id" AS "id", "users_1"."full_name" AS "full_name", "users_1"."email" AS "email" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" WHERE ((("users"."id") = ("products_0"."user_id"))) LIMIT ('1') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
--- PASS: TestCompileInsert (0.04s)
    --- PASS: TestCompileInsert/simpleInsert (0.00s)
    --- PASS: TestCompileInsert/singleInsert (0.00s)
    --- PASS: TestCompileInsert/bulkInsert (0.00s)
    --- PASS: TestCompileInsert/simpleInsertWithPresets (0.00s)
    --- PASS: TestCompileInsert/nestedInsertManyToMany (0.01s)
    --- PASS: TestCompileInsert/nestedInsertOneToMany (0.01s)
    --- PASS: TestCompileInsert/nestedInsertOneToOne (0.00s)
    --- PASS: TestCompileInsert/nestedInsertOneToManyWithConnect (0.00s)
    --- PASS: TestCompileInsert/nestedInsertOneToOneWithConnect (0.01s)
    --- PASS: TestCompileInsert/nestedInsertOneToOneWithConnectArray (0.01s)
=== RUN   TestCompileMutate
=== RUN   TestCompileMutate/singleUpsert
WITH "_sg_input" AS (SELECT '{{upsert}}' :: json AS j), "products" AS (INSERT INTO "products" ("name", "description") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'description' AS text) FROM "_sg_input" i RETURNING *)  ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileMutate/singleUpsertWhere
WITH "_sg_input" AS (SELECT '{{upsert}}' :: json AS j), "products" AS (INSERT INTO "products" ("name", "description") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'description' AS text) FROM "_sg_input" i RETURNING *)  ON CONFLICT (id) WHERE (("products"."price") > '3' :: numeric(7,2)) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileMutate/bulkUpsert
WITH "_sg_input" AS (SELECT '{{upsert}}' :: json AS j), "products" AS (INSERT INTO "products" ("name", "description") SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'description' AS text) FROM "_sg_input" i RETURNING *)  ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, description = EXCLUDED.description RETURNING *) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileMutate/delete
WITH "products" AS (DELETE FROM "products" WHERE (((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))) AND (("products"."id") = '1' :: bigint)) RETURNING "products".*) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
--- PASS: TestCompileMutate (0.01s)
    --- PASS: TestCompileMutate/singleUpsert (0.00s)
    --- PASS: TestCompileMutate/singleUpsertWhere (0.00s)
    --- PASS: TestCompileMutate/bulkUpsert (0.00s)
    --- PASS: TestCompileMutate/delete (0.00s)
=== RUN   TestCompileQuery
=== RUN   TestCompileQuery/withComplexArgs
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "products_0"."price" AS "price" FROM (SELECT DISTINCT ON ("products"."price") "products"."id", "products"."name", "products"."price" FROM "products" WHERE (((("products"."id") < '28' :: bigint) AND (("products"."id") >= '20' :: bigint) AND ((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))))) ORDER BY "products"."price" DESC LIMIT ('30') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/withWhereAndList
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "products_0"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE (((("products"."price") > '10' :: numeric(7,2)) AND NOT (("products"."id") IS NULL) AND ((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))))) LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/withWhereIsNull
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "products_0"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE (((("products"."price") > '10' :: numeric(7,2)) AND NOT (("products"."id") IS NULL) AND ((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))))) LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/withWhereMultiOr
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "products_0"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))) AND ((("products"."price") < '20' :: numeric(7,2)) OR (("products"."price") > '10' :: numeric(7,2)) OR NOT (("products"."id") IS NULL)))) LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/fetchByID
SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" WHERE ((((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))) AND (("products"."id") =  '{{id}}' :: bigint))) LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileQuery/searchQuery
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "products_0"."search_rank" AS "search_rank", "products_0"."search_headline_description" AS "search_headline_description" FROM (SELECT "products"."id", "products"."name", ts_rank("products"."tsv", websearch_to_tsquery('{{query}}')) AS "search_rank", ts_headline("products"."description", websearch_to_tsquery('{{query}}')) AS "search_headline_description" FROM "products" WHERE ((("products"."tsv") @@ websearch_to_tsquery('{{query}}'))) LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/oneToMany
SELECT jsonb_build_object('users', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."email" AS "email", "__sj_1"."json" AS "products" FROM (SELECT "users"."email", "users"."id" FROM "users" LIMIT ('20') :: integer) AS "users_0" LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_1"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."name", "products"."price" FROM "products" WHERE ((("products"."user_id") = ("users_0"."id")) AND ((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2)))) LIMIT ('20') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/oneToManyReverse
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."name" AS "name", "products_0"."price" AS "price", "__sj_1"."json" AS "users" FROM (SELECT "products"."name", "products"."price", "products"."user_id" FROM "products" WHERE (((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2)))) LIMIT ('20') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_1"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."email" AS "email" FROM (SELECT "users"."email" FROM "users" WHERE ((("users"."id") = ("products_0"."user_id"))) LIMIT ('20') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/oneToManyArray
SELECT jsonb_build_object('tags', "__sj_0"."json", 'product', "__sj_2"."json") as "__root" FROM (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "products_2"."name" AS "name", "products_2"."price" AS "price", "__sj_3"."json" AS "tags" FROM (SELECT "products"."name", "products"."price", "products"."tags" FROM "products" LIMIT ('1') :: integer) AS "products_2" LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_3"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_3".*) AS "json"FROM (SELECT "tags_3"."id" AS "id", "tags_3"."name" AS "name" FROM (SELECT "tags"."id", "tags"."name" FROM "tags" WHERE ((("tags"."slug") = any ("products_2"."tags"))) LIMIT ('20') :: integer) AS "tags_3") AS "__sr_3") AS "__sj_3") AS "__sj_3" ON ('true')) AS "__sr_2") AS "__sj_2", (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "tags_0"."name" AS "name", "__sj_1"."json" AS "product" FROM (SELECT "tags"."name", "tags"."slug" FROM "tags" LIMIT ('20') :: integer) AS "tags_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."name" AS "name" FROM (SELECT "products"."name" FROM "products" WHERE ((("tags_0"."slug") = any ("products"."tags"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/manyToMany
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."name" AS "name", "__sj_1"."json" AS "customers" FROM (SELECT "products"."name", "products"."id" FROM "products" WHERE (((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2)))) LIMIT ('20') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_1"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "customers_1"."email" AS "email", "customers_1"."full_name" AS "full_name" FROM (SELECT "customers"."email", "customers"."full_name" FROM "customers" LEFT OUTER JOIN "purchases" ON (("purchases"."product_id") = ("products_0"."id")) WHERE ((("customers"."id") = ("purchases"."customer_id"))) LIMIT ('20') :: integer) AS "customers_1") AS "__sr_1") AS "__sj_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/manyToManyReverse
SELECT jsonb_build_object('customers', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "customers_0"."email" AS "email", "customers_0"."full_name" AS "full_name", "__sj_1"."json" AS "products" FROM (SELECT "customers"."email", "customers"."full_name", "customers"."id" FROM "customers" LIMIT ('20') :: integer) AS "customers_0" LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_1"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."name" AS "name" FROM (SELECT "products"."name" FROM "products" LEFT OUTER JOIN "purchases" ON (("purchases"."customer_id") = ("customers_0"."id")) WHERE ((("products"."id") = ("purchases"."product_id")) AND ((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2)))) LIMIT ('20') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/aggFunction
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."name" AS "name", "products_0"."count_price" AS "count_price" FROM (SELECT "products"."name", count("products"."price") AS "count_price" FROM "products" WHERE (((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2)))) GROUP BY "products"."name" LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/aggFunctionBlockedByCol
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."name" AS "name" FROM (SELECT "products"."name" FROM "products" GROUP BY "products"."name" LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/aggFunctionDisabled
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."name" AS "name" FROM (SELECT "products"."name" FROM "products" GROUP BY "products"."name" LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/aggFunctionWithFilter
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."max_price" AS "max_price" FROM (SELECT "products"."id", max("products"."price") AS "max_price" FROM "products" WHERE ((((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))) AND (("products"."id") > '10' :: bigint))) GROUP BY "products"."id" LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/syntheticTables
SELECT jsonb_build_object('me', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT  FROM (SELECT "users"."email" FROM "users" WHERE ((("users"."id") =  '{{user_id}}' :: bigint)) LIMIT ('1') :: integer) AS "users_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileQuery/queryWithVariables
SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" WHERE (((("products"."price") =  '{{product_price}}' :: numeric(7,2)) AND (("products"."id") =  '{{product_id}}' :: bigint) AND ((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2))))) LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileQuery/withWhereOnRelations
SELECT jsonb_build_object('users', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."id" AS "id", "users_0"."email" AS "email" FROM (SELECT "users"."id", "users"."email" FROM "users" WHERE (NOT EXISTS (SELECT 1 FROM products WHERE (("products"."user_id") = ("users"."id")) AND ((("products"."price") > '3' :: numeric(7,2))))) LIMIT ('20') :: integer) AS "users_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/multiRoot
SELECT jsonb_build_object('customer', "__sj_0"."json", 'user', "__sj_1"."json", 'product', "__sj_2"."json") as "__root" FROM (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "products_2"."id" AS "id", "products_2"."name" AS "name", "__sj_3"."json" AS "customers", "__sj_4"."json" AS "customer" FROM (SELECT "products"."id", "products"."name" FROM "products" WHERE (((("products"."price") > '0' :: numeric(7,2)) AND (("products"."price") < '8' :: numeric(7,2)))) LIMIT ('1') :: integer) AS "products_2" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_4".*) AS "json"FROM (SELECT "customers_4"."email" AS "email" FROM (SELECT "customers"."email" FROM "customers" LEFT OUTER JOIN "purchases" ON (("purchases"."product_id") = ("products_2"."id")) WHERE ((("customers"."id") = ("purchases"."customer_id"))) LIMIT ('1') :: integer) AS "customers_4") AS "__sr_4") AS "__sj_4" ON ('true') LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_3"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_3".*) AS "json"FROM (SELECT "customers_3"."email" AS "email" FROM (SELECT "customers"."email" FROM "customers" LEFT OUTER JOIN "purchases" ON (("purchases"."product_id") = ("products_2"."id")) WHERE ((("customers"."id") = ("purchases"."customer_id"))) LIMIT ('20') :: integer) AS "customers_3") AS "__sr_3") AS "__sj_3") AS "__sj_3" ON ('true')) AS "__sr_2") AS "__sj_2", (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."id" AS "id", "users_1"."email" AS "email" FROM (SELECT "users"."id", "users"."email" FROM "users" LIMIT ('1') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1", (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "customers_0"."id" AS "id" FROM (SELECT "customers"."id" FROM "customers" LIMIT ('1') :: integer) AS "customers_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileQuery/jsonColumnAsTable
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "__sj_1"."json" AS "tag_count" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('20') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "tag_count_1"."count" AS "count", "__sj_2"."json" AS "tags" FROM (SELECT "tag_count"."count", "tag_count"."tag_id" FROM "products", json_to_recordset("products"."tag_count") AS "tag_count"(tag_id bigint, count int) WHERE ((("products"."id") = ("products_0"."id"))) LIMIT ('1') :: integer) AS "tag_count_1" LEFT OUTER JOIN LATERAL (SELECT coalesce(jsonb_agg("__sj_2"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "tags_2"."name" AS "name" FROM (SELECT "tags"."name" FROM "tags" WHERE ((("tags"."id") = ("tag_count_1"."tag_id"))) LIMIT ('20') :: integer) AS "tags_2") AS "__sr_2") AS "__sj_2") AS "__sj_2" ON ('true')) AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/withCursor
SELECT jsonb_build_object('products', "__sj_0"."json", 'products_cursor', "__sj_0"."cursor") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json", CONCAT_WS(',', max("__cur_0"), max("__cur_1")) as "cursor" FROM (SELECT to_jsonb("__sr_0".*) - '__cur_0' - '__cur_1' AS "json", "__cur_0", "__cur_1"FROM (SELECT "products_0"."name" AS "name", LAST_VALUE("products_0"."price") OVER() AS "__cur_0", LAST_VALUE("products_0"."id") OVER() AS "__cur_1" FROM (WITH "__cur" AS (SELECT a[1] as "price", a[2] as "id" FROM string_to_array('{{cursor}}', ',') as a) SELECT "products"."name", "products"."id", "products"."price" FROM "products", "__cur" WHERE (((("products"."price") < "__cur"."price" :: numeric(7,2)) OR ((("products"."price") = "__cur"."price" :: numeric(7,2)) AND (("products"."id") > "__cur"."id" :: bigint)))) ORDER BY "products"."price" DESC, "products"."id" ASC LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/nullForAuthRequiredInAnon
SELECT jsonb_build_object('products', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", NULL AS "user" FROM (SELECT "products"."id", "products"."name", "products"."user_id" FROM "products" LIMIT ('20') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
=== RUN   TestCompileQuery/blockedQuery
SELECT jsonb_build_object('user', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."id" AS "id", "users_0"."full_name" AS "full_name", "users_0"."email" AS "email" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" WHERE (false) LIMIT ('1') :: integer) AS "users_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileQuery/blockedFunctions
SELECT jsonb_build_object('users', "__sj_0"."json") as "__root" FROM (SELECT coalesce(jsonb_agg("__sj_0"."json"), '[]') as "json" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."email" AS "email" FROM (SELECT , "users"."email" FROM "users" WHERE (false) GROUP BY "users"."email" LIMIT ('20') :: integer) AS "users_0") AS "__sr_0") AS "__sj_0") AS "__sj_0"
--- PASS: TestCompileQuery (0.05s)
    --- PASS: TestCompileQuery/withComplexArgs (0.00s)
    --- PASS: TestCompileQuery/withWhereAndList (0.00s)
    --- PASS: TestCompileQuery/withWhereIsNull (0.00s)
    --- PASS: TestCompileQuery/withWhereMultiOr (0.00s)
    --- PASS: TestCompileQuery/fetchByID (0.00s)
    --- PASS: TestCompileQuery/searchQuery (0.00s)
    --- PASS: TestCompileQuery/oneToMany (0.00s)
    --- PASS: TestCompileQuery/oneToManyReverse (0.00s)
    --- PASS: TestCompileQuery/oneToManyArray (0.00s)
    --- PASS: TestCompileQuery/manyToMany (0.00s)
    --- PASS: TestCompileQuery/manyToManyReverse (0.00s)
    --- PASS: TestCompileQuery/aggFunction (0.00s)
    --- PASS: TestCompileQuery/aggFunctionBlockedByCol (0.00s)
    --- PASS: TestCompileQuery/aggFunctionDisabled (0.00s)
    --- PASS: TestCompileQuery/aggFunctionWithFilter (0.00s)
    --- PASS: TestCompileQuery/syntheticTables (0.00s)
    --- PASS: TestCompileQuery/queryWithVariables (0.00s)
    --- PASS: TestCompileQuery/withWhereOnRelations (0.00s)
    --- PASS: TestCompileQuery/multiRoot (0.01s)
    --- PASS: TestCompileQuery/jsonColumnAsTable (0.00s)
    --- PASS: TestCompileQuery/withCursor (0.00s)
    --- PASS: TestCompileQuery/nullForAuthRequiredInAnon (0.00s)
    --- PASS: TestCompileQuery/blockedQuery (0.00s)
    --- PASS: TestCompileQuery/blockedFunctions (0.00s)
=== RUN   TestCompileUpdate
=== RUN   TestCompileUpdate/singleUpdate
WITH "_sg_input" AS (SELECT '{{update}}' :: json AS j), "products" AS (UPDATE "products" SET ("name", "description") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'description' AS text) FROM "_sg_input" i)  WHERE ((("products"."id") = '1' :: bigint) AND (("products"."id") =  '{{id}}' :: bigint)) RETURNING "products".*) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name" FROM (SELECT "products"."id", "products"."name" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileUpdate/simpleUpdateWithPresets
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "products" AS (UPDATE "products" SET ("name", "price", "updated_at") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), 'now' :: timestamp without time zone FROM "_sg_input" i)  WHERE (("products"."user_id") =  '{{user_id}}' :: bigint) RETURNING "products".*) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id" FROM (SELECT "products"."id" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileUpdate/nestedUpdateManyToMany
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "purchases" AS (UPDATE "purchases" SET ("sale_type", "quantity", "due_date") = (SELECT CAST( i.j ->>'sale_type' AS character varying), CAST( i.j ->>'quantity' AS integer), CAST( i.j ->>'due_date' AS timestamp without time zone) FROM "_sg_input" i)  WHERE (("purchases"."id") =  '{{id}}' :: bigint) RETURNING "purchases".*), "products" AS (UPDATE "products" SET ("name", "price") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)) FROM "_sg_input" i) FROM "purchases" WHERE (("products"."id") = ("purchases"."product_id")) RETURNING "products".*), "customers" AS (UPDATE "customers" SET ("full_name", "email") = (SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying) FROM "_sg_input" i) FROM "purchases" WHERE (("customers"."id") = ("purchases"."customer_id")) RETURNING "customers".*) SELECT jsonb_build_object('purchase', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "purchases_0"."sale_type" AS "sale_type", "purchases_0"."quantity" AS "quantity", "purchases_0"."due_date" AS "due_date", "__sj_1"."json" AS "product", "__sj_2"."json" AS "customer" FROM (SELECT "purchases"."sale_type", "purchases"."quantity", "purchases"."due_date", "purchases"."product_id", "purchases"."customer_id" FROM "purchases" LIMIT ('1') :: integer) AS "purchases_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "customers_2"."id" AS "id", "customers_2"."full_name" AS "full_name", "customers_2"."email" AS "email" FROM (SELECT "customers"."id", "customers"."full_name", "customers"."email" FROM "customers" WHERE ((("customers"."id") = ("purchases_0"."customer_id"))) LIMIT ('1') :: integer) AS "customers_2") AS "__sr_2") AS "__sj_2" ON ('true') LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."id") = ("purchases_0"."product_id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "purchases" AS (UPDATE "purchases" SET ("sale_type", "quantity", "due_date") = (SELECT CAST( i.j ->>'sale_type' AS character varying), CAST( i.j ->>'quantity' AS integer), CAST( i.j ->>'due_date' AS timestamp without time zone) FROM "_sg_input" i)  WHERE (("purchases"."id") =  '{{id}}' :: bigint) RETURNING "purchases".*), "customers" AS (UPDATE "customers" SET ("full_name", "email") = (SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying) FROM "_sg_input" i) FROM "purchases" WHERE (("customers"."id") = ("purchases"."customer_id")) RETURNING "customers".*), "products" AS (UPDATE "products" SET ("name", "price") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)) FROM "_sg_input" i) FROM "purchases" WHERE (("products"."id") = ("purchases"."product_id")) RETURNING "products".*) SELECT jsonb_build_object('purchase', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "purchases_0"."sale_type" AS "sale_type", "purchases_0"."quantity" AS "quantity", "purchases_0"."due_date" AS "due_date", "__sj_1"."json" AS "product", "__sj_2"."json" AS "customer" FROM (SELECT "purchases"."sale_type", "purchases"."quantity", "purchases"."due_date", "purchases"."product_id", "purchases"."customer_id" FROM "purchases" LIMIT ('1') :: integer) AS "purchases_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_2".*) AS "json"FROM (SELECT "customers_2"."id" AS "id", "customers_2"."full_name" AS "full_name", "customers_2"."email" AS "email" FROM (SELECT "customers"."id", "customers"."full_name", "customers"."email" FROM "customers" WHERE ((("customers"."id") = ("purchases_0"."customer_id"))) LIMIT ('1') :: integer) AS "customers_2") AS "__sr_2") AS "__sj_2" ON ('true') LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."id") = ("purchases_0"."product_id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileUpdate/nestedUpdateOneToMany
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "users" AS (UPDATE "users" SET ("full_name", "email", "created_at", "updated_at") = (SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone) FROM "_sg_input" i)  WHERE (("users"."id") = '8' :: bigint) RETURNING "users".*), "products" AS (UPDATE "products" SET ("name", "price", "created_at", "updated_at") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone) FROM "_sg_input" i) FROM "users" WHERE (("products"."user_id") = ("users"."id") AND "products"."id"= ((i.j->'product'->'where'->>'id'))::bigint) RETURNING "products".*) SELECT jsonb_build_object('user', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."id" AS "id", "users_0"."full_name" AS "full_name", "users_0"."email" AS "email", "__sj_1"."json" AS "product" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" LIMIT ('1') :: integer) AS "users_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."user_id") = ("users_0"."id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileUpdate/nestedUpdateOneToOne
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "products" AS (UPDATE "products" SET ("name", "price", "created_at", "updated_at") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone) FROM "_sg_input" i)  WHERE (("products"."id") =  '{{id}}' :: bigint) RETURNING "products".*), "users" AS (UPDATE "users" SET ("email") = (SELECT CAST( i.j ->>'email' AS character varying) FROM "_sg_input" i) FROM "products" WHERE (("users"."id") = ("products"."user_id")) RETURNING "users".*) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "__sj_1"."json" AS "user" FROM (SELECT "products"."id", "products"."name", "products"."user_id" FROM "products" LIMIT ('1') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."id" AS "id", "users_1"."full_name" AS "full_name", "users_1"."email" AS "email" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" WHERE ((("users"."id") = ("products_0"."user_id"))) LIMIT ('1') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileUpdate/nestedUpdateOneToManyWithConnect
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "users" AS (UPDATE "users" SET ("full_name", "email", "created_at", "updated_at") = (SELECT CAST( i.j ->>'full_name' AS character varying), CAST( i.j ->>'email' AS character varying), CAST( i.j ->>'created_at' AS timestamp without time zone), CAST( i.j ->>'updated_at' AS timestamp without time zone) FROM "_sg_input" i)  WHERE (("users"."id") =  '{{id}}' :: bigint) RETURNING "users".*), "products_c" AS ( UPDATE "products" SET "user_id" = "users"."id" FROM "users" WHERE ("products"."id"= ((i.j->'product'->'connect'->>'id'))::bigint) RETURNING "products".*), "products_d" AS ( UPDATE "products" SET "user_id" =  NULL FROM "users" WHERE ("products"."id"= ((i.j->'product'->'disconnect'->>'id'))::bigint) RETURNING "products".*), "products" AS (SELECT * FROM "products_c" UNION ALL SELECT * FROM "products_d") SELECT jsonb_build_object('user', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "users_0"."id" AS "id", "users_0"."full_name" AS "full_name", "users_0"."email" AS "email", "__sj_1"."json" AS "product" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" LIMIT ('1') :: integer) AS "users_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "products_1"."id" AS "id", "products_1"."name" AS "name", "products_1"."price" AS "price" FROM (SELECT "products"."id", "products"."name", "products"."price" FROM "products" WHERE ((("products"."user_id") = ("users_0"."id"))) LIMIT ('1') :: integer) AS "products_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileUpdate/nestedUpdateOneToOneWithConnect
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "_x_users" AS (SELECT "id" FROM "_sg_input" i,"users" WHERE "users"."id"= ((i.j->'user'->'connect'->>'id'))::bigint AND "users"."email"= ((i.j->'user'->'connect'->>'email'))::character varying LIMIT 1), "products" AS (UPDATE "products" SET ("name", "price", "user_id") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), "_x_users"."id" FROM "_sg_input" i", "_x_users)  WHERE (("products"."id") =  '{{product_id}}' :: bigint) RETURNING "products".*) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "__sj_1"."json" AS "user" FROM (SELECT "products"."id", "products"."name", "products"."user_id" FROM "products" LIMIT ('1') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."id" AS "id", "users_1"."full_name" AS "full_name", "users_1"."email" AS "email" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" WHERE ((("users"."id") = ("products_0"."user_id"))) LIMIT ('1') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "_x_users" AS (SELECT "id" FROM "_sg_input" i,"users" WHERE "users"."email"= ((i.j->'user'->'connect'->>'email'))::character varying AND "users"."id"= ((i.j->'user'->'connect'->>'id'))::bigint LIMIT 1), "products" AS (UPDATE "products" SET ("name", "price", "user_id") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), "_x_users"."id" FROM "_sg_input" i", "_x_users)  WHERE (("products"."id") =  '{{product_id}}' :: bigint) RETURNING "products".*) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "__sj_1"."json" AS "user" FROM (SELECT "products"."id", "products"."name", "products"."user_id" FROM "products" LIMIT ('1') :: integer) AS "products_0" LEFT OUTER JOIN LATERAL (SELECT to_jsonb("__sr_1".*) AS "json"FROM (SELECT "users_1"."id" AS "id", "users_1"."full_name" AS "full_name", "users_1"."email" AS "email" FROM (SELECT "users"."id", "users"."full_name", "users"."email" FROM "users" WHERE ((("users"."id") = ("products_0"."user_id"))) LIMIT ('1') :: integer) AS "users_1") AS "__sr_1") AS "__sj_1" ON ('true')) AS "__sr_0") AS "__sj_0"
=== RUN   TestCompileUpdate/nestedUpdateOneToOneWithDisconnect
WITH "_sg_input" AS (SELECT '{{data}}' :: json AS j), "_x_users" AS (SELECT * FROM (VALUES(NULL::bigint)) AS LOOKUP("id")), "products" AS (UPDATE "products" SET ("name", "price", "user_id") = (SELECT CAST( i.j ->>'name' AS character varying), CAST( i.j ->>'price' AS numeric(7,2)), "_x_users"."id" FROM "_sg_input" i", "_x_users)  WHERE (("products"."id") =  '{{id}}' :: bigint) RETURNING "products".*) SELECT jsonb_build_object('product', "__sj_0"."json") as "__root" FROM (SELECT to_jsonb("__sr_0".*) AS "json"FROM (SELECT "products_0"."id" AS "id", "products_0"."name" AS "name", "products_0"."user_id" AS "user_id" FROM (SELECT "products"."id", "products"."name", "products"."user_id" FROM "products" LIMIT ('1') :: integer) AS "products_0") AS "__sr_0") AS "__sj_0"
--- PASS: TestCompileUpdate (0.04s)
    --- PASS: TestCompileUpdate/singleUpdate (0.00s)
    --- PASS: TestCompileUpdate/simpleUpdateWithPresets (0.00s)
    --- PASS: TestCompileUpdate/nestedUpdateManyToMany (0.01s)
    --- PASS: TestCompileUpdate/nestedUpdateOneToMany (0.01s)
    --- PASS: TestCompileUpdate/nestedUpdateOneToOne (0.00s)
    --- PASS: TestCompileUpdate/nestedUpdateOneToManyWithConnect (0.00s)
    --- PASS: TestCompileUpdate/nestedUpdateOneToOneWithConnect (0.01s)
    --- PASS: TestCompileUpdate/nestedUpdateOneToOneWithDisconnect (0.00s)
PASS
ok  	github.com/dosco/super-graph/core/internal/psql	0.154s
=== RUN   TestCompile1
--- PASS: TestCompile1 (0.00s)
=== RUN   TestCompile2
--- PASS: TestCompile2 (0.00s)
=== RUN   TestCompile3
--- PASS: TestCompile3 (0.00s)
=== RUN   TestInvalidCompile1
--- PASS: TestInvalidCompile1 (0.00s)
=== RUN   TestInvalidCompile2
--- PASS: TestInvalidCompile2 (0.00s)
=== RUN   TestEmptyCompile
--- PASS: TestEmptyCompile (0.00s)
=== RUN   TestInvalidPostfixCompile
--- PASS: TestInvalidPostfixCompile (0.00s)
=== RUN   TestGetQType
=== RUN   TestGetQType/query
=== RUN   TestGetQType/mutation
=== RUN   TestGetQType/default_query
=== RUN   TestGetQType/default_query_with_comment
=== RUN   TestGetQType/failed_query_with_comment
--- PASS: TestGetQType (0.00s)
    --- PASS: TestGetQType/query (0.00s)
    --- PASS: TestGetQType/mutation (0.00s)
    --- PASS: TestGetQType/default_query (0.00s)
    --- PASS: TestGetQType/default_query_with_comment (0.00s)
    --- PASS: TestGetQType/failed_query_with_comment (0.00s)
PASS
ok  	github.com/dosco/super-graph/core/internal/qcode	0.012s
?   	github.com/dosco/super-graph/core/internal/util	[no test files]
=== RUN   TestFuzzCrashers
--- PASS: TestFuzzCrashers (0.00s)
=== RUN   TestGQLHash1
--- PASS: TestGQLHash1 (0.00s)
=== RUN   TestGQLHash2
--- PASS: TestGQLHash2 (0.00s)
=== RUN   TestGQLHash3
--- PASS: TestGQLHash3 (0.00s)
=== RUN   TestGQLHash4
--- PASS: TestGQLHash4 (0.00s)
=== RUN   TestGQLHashWithVars1
--- PASS: TestGQLHashWithVars1 (0.00s)
=== RUN   TestGQLHashWithVars2
--- PASS: TestGQLHashWithVars2 (0.00s)
PASS
ok  	github.com/dosco/super-graph/internal/serv	0.033s
?   	github.com/dosco/super-graph/internal/serv/internal/auth	[no test files]
testing: warning: no tests to run
PASS
ok  	github.com/dosco/super-graph/internal/serv/internal/migrate	0.011s [no tests to run]
=== RUN   TestRailsEncryptedSession1
--- PASS: TestRailsEncryptedSession1 (0.01s)
=== RUN   TestRailsEncryptedSession52
--- PASS: TestRailsEncryptedSession52 (0.00s)
=== RUN   TestRailsJsonSession
--- PASS: TestRailsJsonSession (0.00s)
=== RUN   TestRailsMarshaledSession
--- PASS: TestRailsMarshaledSession (0.00s)
PASS
ok  	github.com/dosco/super-graph/internal/serv/internal/rails	0.023s
=== RUN   TestFuzzCrashers
--- PASS: TestFuzzCrashers (0.00s)
=== RUN   TestGet
--- PASS: TestGet (0.00s)
=== RUN   TestGet1
--- PASS: TestGet1 (0.00s)
=== RUN   TestGet2
--- PASS: TestGet2 (0.00s)
=== RUN   TestGet3
--- PASS: TestGet3 (0.00s)
=== RUN   TestGet4
--- PASS: TestGet4 (0.00s)
=== RUN   TestValue
--- PASS: TestValue (0.00s)
=== RUN   TestFilter1
--- PASS: TestFilter1 (0.00s)
=== RUN   TestFilter2
--- PASS: TestFilter2 (0.00s)
=== RUN   TestStrip
--- PASS: TestStrip (0.00s)
=== RUN   TestValidateTrue
--- PASS: TestValidateTrue (0.00s)
=== RUN   TestValidateFalse
--- PASS: TestValidateFalse (0.00s)
=== RUN   TestReplace
--- PASS: TestReplace (0.00s)
=== RUN   TestReplaceEmpty
--- PASS: TestReplaceEmpty (0.00s)
=== RUN   TestKeys1
--- PASS: TestKeys1 (0.00s)
=== RUN   TestKeys2
--- PASS: TestKeys2 (0.00s)
=== RUN   TestKeys3
--- PASS: TestKeys3 (0.00s)
PASS
ok  	github.com/dosco/super-graph/jsn	0.014s
