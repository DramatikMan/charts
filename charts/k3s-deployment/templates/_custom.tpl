{{/* envFrom */}}
{{- define "custom.envFrom" -}}
{{- range $.Values.secrets }}
    - secretRef:
        name: {{ include "common.tplvalues.render" (dict "value" .name "context" $) | quote }}
{{- end }}
{{- range $.Values.configmaps }}
    - configMapRef:
        name: {{ include "common.tplvalues.render" (dict "value" .name "context" $) | quote }}
{{- end }}
{{- end }}
