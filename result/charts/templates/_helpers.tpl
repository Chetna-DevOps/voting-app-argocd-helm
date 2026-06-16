{{- define "result.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "result.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "result.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
