docker build -t tintuntint/multi-client:latest -t tintuntint/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tintuntint/multi-server:latest -t tintuntint/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tintuntint/multi-worker:latest -t tintuntint/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tintuntint/multi-client:latest
docker push tintuntint/multi-server:latest
docker push tintuntint/multi-worker:latest

docker push tintuntint/multi-client:$SHA
docker push tintuntint/multi-server:$SHA
docker push tintuntint/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=tintuntint/multi-server:$SHA
kubectl set image deployments/client-deployment client=tintuntint/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tintuntint/multi-worker:$SHA

#kubectl set image deployments/server-deployment server=tintuntint/multi-server:latest
#kubectl set image deployments/client-deployment client=tintuntint/multi-client:latest
#kubectl set image deployments/worker-deployment worker=tintuntint/multi-worker:latest

#kubectl set image deployments/server-deployment server=stephengrider/multi-server:latest
#kubectl set image deployments/client-deployment client=stephengrider/multi-client:latest
#kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:latest