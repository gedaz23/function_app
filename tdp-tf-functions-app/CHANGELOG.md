# Changelog

## [1.1.0] - 2025-05-12

### Added
- Configurable private DNS record creation via `private_dns_record_type` variable ("CNAME" or "A").
- Support for creating private A records using the `tdp-tf-pdns-a-record` module when `private_dns_record_type` is "A".
- Added create_before_destroy true to lifecycle block

## [1.0.2] - 2025-02-25

### Changed
- Add appsettings "AzureWebJobsDashboard__accountName" and "WEBSITE_HEALTHCHECK_MAXPINGFAILURES" into ignore_changes attribute

## [1.0.1] - 2025-01-21

### Changed
- Remove appsettings from ignore_changes attribute

## [1.0.0] - 2024-11-06

### Changed
- Updated provider version constraint

## [0.1.3] - 2024-06-10

### Changed
- Made custom domain variable nullable and removed enable option


## [0.1.2] - 2024-06-10

### Changed
- Added multiple private endpoints support

## [0.1.1] - 2024-05-17

### Changed
- Added custom domain and private endpoint support
-
## [0.1.0] - 2024-05-08

### Changed
- Added initial version of the Azure Functions App module
