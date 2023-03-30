{{/* env */}}
{{- define "custom.env" -}}
{{- range $.Values.envVars }}
  {{- if .name }}
    - name: {{ include "common.tplvalues.render" (dict "value" .name "context" $) | quote }}
      {{- if and .secret (ne .key nil) }}
      valueFrom:
        secretKeyRef:
          name: {{ include "common.tplvalues.render" (dict "value" .secret "context" $) | quote }}
          key: {{ include "common.tplvalues.render" (dict "value" .key "context" $) | quote }}
      {{- else if and .configmap (ne .key nil) }}
      valueFrom:
        configMapKeyRef:
          name: {{ include "common.tplvalues.render" (dict "value" .configmap "context" $) | quote }}
          key: {{ include "common.tplvalues.render" (dict "value" .key "context" $) | quote }}
      {{- else }}
      value: {{ include "common.tplvalues.render" (dict "value" .value "context" $) | quote }}
      {{- end }}
    {{- end }}
{{- end }}
{{- end }}

{{/* envFrom */}}
{{- define "custom.envFrom" -}}
{{- range $.Values.envVars }}
  {{- if and (eq .name nil) (eq .key nil) }}
    {{- if .secret }}
    - secretRef:
        name: {{ include "common.tplvalues.render" (dict "value" .secret "context" $) | quote }}
    {{- else if .configmap }}
    - configMapRef:
        name: {{ include "common.tplvalues.render" (dict "value" .configmap "context" $) | quote }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
