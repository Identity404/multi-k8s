docker build -t identity404/multi-client:latest -t identity404/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t identity404/multi-server:latest -t identity404/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t identity404/multi-worker:latest -t identity404/multi-worker:$GIT_SHA -f ./woker/Dockerfile ./worker
docker push identity404/multi-client:latest
docker push identity404/multi-server:latest
docker push identity404/multi-worker:latest
docker push identity404/multi-client:$GIT_SHA
docker push identity404/multi-server:$GIT_SHA
docker push identity404/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=identity404/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=identity404/multi-server:$GIT_SHA 
kubectl set image deployments/worker-deployment server=identity404/multi-worker:$GIT_SHA 