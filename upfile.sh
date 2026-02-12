#!/bin/bash
# restart
kubectl delete namespaces spring-microservice-ns > /dev/null

# global things
kubectl apply -f namespace/global-ns.yaml
kubectl apply -f config-map/global-cm.yaml

# infrastructure
kubectl apply -f secrets/infrastructure-mongo-users-secrets.yaml
kubectl apply -f infrastructure/infrastructure-mongo-users.yaml
kubectl apply -f secrets/infrastructure-rabbit-secrets.yaml
kubectl apply -f infrastructure/infrastructure-rabbit.yaml
kubectl apply -f secrets/infrastructure-mongo-auth-secrets.yaml
kubectl apply -f infrastructure/infrastructure-mongo-auth.yaml

# extra functional for testing
kubectl apply -f test/pod.yaml

# config-server
kubectl apply -f config-map/config-server-cm.yaml
kubectl apply -f secrets/config-server-secrets.yaml
kubectl apply -f servers/config-server.yaml

sleep 3

# user-server
kubectl apply -f config-map/user-server-cm.yaml
kubectl apply -f servers/user-server.yaml

# auth-server
kubectl apply -f config-map/auth-server-cm.yaml
kubectl apply -f servers/auth-server.yaml

sleep 3

# gateway-server
kubectl apply -f config-map/gateway-server-cm.yaml
kubectl apply -f servers/gateway-server.yaml

