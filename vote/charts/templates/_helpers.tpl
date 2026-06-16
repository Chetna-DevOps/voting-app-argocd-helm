{{- define "vote.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "vote.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "vote.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
