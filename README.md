#kl apply -n myservice3 -f - <<EOF
#apiVersion: v1
#kind: Service
#...
#EOF

# PGAdmin
username: admin@pg.com
password admin1234

# dblabs
https://github.com/danvergara/dblab

# Integration Test
go test ./app/services/sales-api/tests/ -run TestUsers/getToken200 -v