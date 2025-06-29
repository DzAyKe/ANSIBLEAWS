# ANSIBLEAWS

Utilisez Terraform pour construire les trois instances EC2, dont nous aurons

besoin pour l’atelier. Elles doivent se nommer respectivement FCS-Frontend,

FCS-Backend et FCS-Database.

 - SSH

- Pour vous connecter aux machines que vous venez de créer, vous aurez besoin
de SSH
- Utilisez une paire de clé SSH pour vous connecter aux instances EC2, elles
doivent être intégrées au VMs en utilisant Terraform. En cas de doutes vous
pouvez supprimer et recommencer la création de vos machines virtuelles
indéfiniment.

``
ssh-keygen -f terraform_ec2_key
``

Ajouter les regles entrantes sur AWS dans le groupe de sécurité :

TCP personalisé / port 22 / 0.0.0.0/0

pour ce connecter :

```
Frontend :
ssh -i terraform_ec2_key ec2-user@ec2-XX-XX-XX-XX.eu-X-X.compute.amazonaws.com

Backend :
ssh -i terraform_ec2_key ec2-user@ec2-XX-XX-XX-XX.eu-X-X.compute.amazonaws.com
```

commande pour détruire les instances:

```
terraform destroy
```

Créez un dossier “Playbook” dans le dossier “Atelier Ansible”. Importez un fichier “inventory.yml”

Ping les machines:

```
ansible fcs -m ping -i "C:\Users\eloig\Desktop\Atelier Ansible\Playbook\inventory.yml" --private-key "C:\Users\user\Desktop\Atelier Ansible\terraform_ec2_key"
```

main.tf

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "fcs_packer" {
  ami           = "ami-08ed5885443d7a7a6"
  instance_type = "t3.micro"
  key_name = "terraform_ec2_key"

  tags = {
    Name = "FCS-PACKER"
  }
}

#resource "aws_instance" "fcs_backend" {
#  ami           = "ami-0dd574ef87b79ac6c"
#  instance_type = "t3.micro"
#  key_name = "terraform_ec2_key"
#
#  tags = {
#    Name = "FCS-Backend"
#  }
#}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = "${file("terraform_ec2_key.pub")}"
}
```

Lancement instance avec Terraform:

terraform init

terraform plan

terraform apply
