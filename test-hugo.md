+++
title = "Test"
+++
{{ $content := .Site.GetPage "page" "profile" }}
{{ $chunks := split $content.RawContent "\n### " }}
{{ $qas := after 1 $chunks }}
{{ range first 2 (shuffle $qas) }}
### {{ . }}
{{ end }}
