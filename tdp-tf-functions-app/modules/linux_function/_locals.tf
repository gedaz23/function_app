locals {
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE  = "true"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE      = "true"
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES  = "5"
    AzureWebJobsDashboard__accountName   = var.storage_account_name,
    AzureWebJobsStorage__queueServiceUri = "https://${var.storage_account_name}.queue.core.windows.net",
    AzureWebJobsStorage__blobServiceUri  = "https://${var.storage_account_name}.blob.core.windows.net",
    AzureWebJobsFeatureFlags             = "EnableWorkerIndexing",
  }
}
