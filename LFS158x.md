https://courses.edx.org/courses/course-v1:LinuxFoundationX+LFS158x+2T2019

CNCF:
Graduated projects:

            Kubernetes for container orchestration
            Prometheus for monitoring
            Envoy for service mesh
            CoreDNS for service discovery
            containerd for container runtime
            Fluentd for logging

Incubating projects:

            rkt and CRI-O for container runtime
            Linkerd for service mesh
            etcd for key/value store
            gRPC for remote procedure call (RPC)
            CNI for networking API
            Harbor for registry
            Helm for package management
            Rook and Vitess for cloud-native storage
            Notary for security
            TUF for software updates
            NATS for messaging
            Jaeger and OpenTracing for distributed tracing
            Open Policy Agent for policy.

### Architecture

Main components of k8s:
  - master node(s) (scheduler + controller as a part of api-server)
  - worker node(s) (kubelet, kubeproxy, pods, container runtime, "Addons for DNS, Dashboard, cluster-level monitoring and logging")
  - key-value storage (etcd) (resp: keeps configuration about cluster)

The role of the **kube-scheduler** is to assign new objects, such as pods, to nodes.

The **controller managers** are control plane components on the master node running controllers to regulate the state of the Kubernetes cluster.

**etcd** is a distributed key-value data store used to persist a Kubernetes cluster's state.
In Kubernetes, besides storing the cluster state, etcd is also used to store configuration details such as subnets, ConfigMaps, Secrets, etc.

[Raft Consensus Algorithm article](https://web.stanford.edu/~ouster/cgi-bin/papers/raft-atc14)

