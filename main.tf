resource "google_service_account" "storage_sa" {
  account_id   = "storage-service-account"
  display_name = "Storage Service Account"
}

resource "google_project_iam_member" "storage_admin" {
  project = "platform-services-sandbox"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.storage_sa.email}"
}

resource "google_compute_instance" "instance_1" {
  name         = "jenkins-backup"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      
    }
  }


  service_account {
    email  = google_service_account.storage_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance" "instance_2" {
  name         = "jenkins-restore"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      
    }
  }


  service_account {
    email  = google_service_account.storage_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_storage_bucket" "bucket" {
  name          = "jenkins_server_backup"
  location      = "US"
  

  public_access_prevention = "enforced"
}


