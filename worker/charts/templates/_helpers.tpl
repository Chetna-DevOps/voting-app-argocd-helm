{{- define "worker.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "worker.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "worker.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
