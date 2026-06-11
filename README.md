# MarkdownViewer
A simple Markdown Viewer that displays uploaded .MD files in friendly HTML format. Created with a purpose of hosting in AWS via Terraform IAC.

## Technology Stack
### Front-End:
- HTML
- CSS
- JavaScript
### Infrastructure As Code (IAC)
- HashiCorp Terraform
### CI/CD Pipelines
- GitHub Actions

## AWS Infrastructure Components
This project leverages the following AWS Infrastructure Components:
### S3 Buckets
- To hold source code files for the front-end.
### AWS CloudFront
- CDN for caching and serving front-end.