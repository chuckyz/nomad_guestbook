# nomad_guestbook
Kubernetes example guestbook app modified for Nomad example

## Runbook

```
consul agent -dev
nomad agent -config nomad_configs/server.hcl
nomad agent -config nomad_configs/client.hcl
terraform apply -auto-approve
```

This will bring up a Redis master, Redis replica, and the guestbook-go frontend application.

## Notes
`nomad agent -dev` runs nomad in a way that the containers only listen on 127.0.0.1.

This allows containers to talk to each other in the same task, but not cross-job, which is why the server/client is needed.  The configs should be viewed though just so it's visible how simple it is to configure these services. :)

Unsure how a template is going to be output?  Try out the example template!

`consul-template -dry -once -template template.tmpl`

Taking off `-once` will even let this persist, so any changes to "template.tmpl" in another area will immediately be rendered in the area running consul-template.
