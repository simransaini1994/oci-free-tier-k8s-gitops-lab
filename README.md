# oci-free-tier-k8s-gitops-lab
Self-managed Kubernetes and GitOps Lab on Oracle Cloud Free Tier: Automating cluster deployment, GitOps workflows, and observability using Terraform, Ansible, and open-source tools. 
# OCI Free Tier Kubernetes GitOps Lab

A hands-on DevOps laboratory for deploying, automating, and managing a self-hosted Kubernetes cluster on Oracle Cloud Infrastructure (OCI) Free Tier. This project leverages Infrastructure as Code (Terraform), Configuration Management (Ansible), modern GitOps workflows (Argo CD/Flux), and full observability (Prometheus, Grafana). Extendable with AI-based monitoring and anomaly detection.

---

## 🚀 Project Goals

- **Use Oracle Cloud Free Tier** resources for cost-effective experimentation.
- **Automate infrastructure** provisioning with Terraform.
- **Configure and bootstrap Kubernetes** (k3s, kubeadm, or microk8s) with Ansible. (need to decide)
- **Implement GitOps deployment pipelines** using Argo CD or Flux. (need to decide)
- **Deploy sample applications** and manage configs through Git.
- **Monitor cluster health and workloads** with Prometheus and Grafana.
- **Experiment with AI-powered monitoring** (simple anomaly detection as a stretch goal).
- **Document and share** the process for knowledge building and careers.

---

## 🛠️ Tech Stack

- **Cloud:** Oracle Cloud Infrastructure (Free Tier resources)
- **Infrastructure as Code:** Terraform
- **Configuration Management:** Ansible
- **Kubernetes Distribution:** (e.g., k3s, kubeadm, or microk8s)
- **GitOps:** Argo CD (or Flux)
- **Monitoring & Observability:** Prometheus, Grafana
- **AI/ML (Optional):** OCI Data Science Notebooks or local Jupyter notebooks

---

## 🗂️ Repository Structure
- /terraform # Infrastructure as Code scripts
- /ansible # OS and Kubernetes configuration playbooks
- /k8s-gitops # App & infra manifests, Helm charts, Argo CD configs
- /monitoring # Prometheus, Grafana dashboards, alert rules, AI scripts
- /diagrams # Architecture diagrams
- README.md # Project documentation and usage guide



---

## 🏗️ Getting Started

1. **Clone this repo and review Day 1 architecture diagram.**
2. **Provision OCI Free Tier compute & networking using Terraform.**
3. **Bootstrap Kubernetes node(s) with Ansible.**
4. **Install and configure GitOps tool (Argo CD/Flux) for automated app deployments.**
5. **Set up monitoring and create custom dashboards.**
6. **Experiment or extend with AI/ML-based monitoring.**

*(Detailed step-by-step instructions and prerequisites are found in [docs/SETUP.md](docs/SETUP.md) - to be created as you progress.)*

---

## 💡 Why This Project?

- **Demonstrates end-to-end DevOps skills** at a senior level.
- Enables learning and experimentation with modern cloud infrastructure, automation, and observability.
- Showcases cost-awareness and hands-on proficiency in building robust DevOps workflows.

---

## 📝 License

This project is open-source and intended for educational and demonstration purposes.

---

## 🙋‍♂️ Contributions & Feedback

Open to feedback, suggestions, and improvements! Please open an issue 
---

