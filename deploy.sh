docker build -t pushock/multi-client:latest -t pushcok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pushock/multi-server:latest -t pushock/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pushcok/multi-worker:latest -t pushock/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pushock/multi-client:latest
docker push pushock/multi-server:latest
docker push pushock/multi-worker:latest
docker push pushock/multi-client:$SHA
docker push pushock/multi-server:$SHA
docker push pushock/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pushock/multi-server:$SHA
kubectl set image deployments/client-deployment client=pushock/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pushock/multi-worker:$SHA
