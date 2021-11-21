{{/*
Expand the name of the chart.
*/}}
{{- define "distributed-calculator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "distributed-calculator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "distributed-calculator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "distributed-calculator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "distributed-calculator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "distributed-calculator.labels" -}}
helm.sh/chart: {{ include "distributed-calculator.chart" . }}
{{ include "distributed-calculator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "distributed-calculator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "distributed-calculator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the metadata name of deployment (argument: app info)
*/}}
{{- define "distributed-calculator.deploymentName" -}}
{{- printf "%sapp" .name }}
{{- end }}

{{/*
Create the image name:tag of deployment (argument: app info)
*/}}
{{- define "distributed-calculator.deploymentImage" -}}
{{- printf "%s:%s" .image .tag }}
{{- end }}
