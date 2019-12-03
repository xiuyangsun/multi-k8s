docker build -t bobbysun8910/complex-client:latest bobbysun8910:complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t bobbysun8910/complex-server:latest bobbysun8910:complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t bobbysun8910/complex-worker:latest bobbysun8910:complex-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bobbysun8910/complex-client:latest
docker push bobbysun8910/complex-server:latest
docker push bobbysun8910/complex-worker:latest

docker push bobbysun8910/complex-client:$SHA
docker push bobbysun8910/complex-server:$SHA
docker push bobbysun8910/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bobbysun8910/complex-server:$SHA
kubectl set image deployments/client-deployment client=bobbysun8910/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=bobbysun8910/complex-worker:$SHA
