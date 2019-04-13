docker build -t skorov/multi-client:latest -t skorov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skorov/multi-server:latest -t skorov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skorov/multi-worker:latest -t skorov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skorov/multi-client:latest
docker push skorov/multi-server:latest
docker push skorov/multi-worker:latest

docker push skorov/multi-client:$SHA
docker push skorov/multi-server:$SHA
docker push skorov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=skorov/multi-client:$SHA
kubectl set image deployments/server-deployment server=skorov/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=skorov/multi-worker:$SHA
