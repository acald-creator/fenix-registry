### Fenix Self-Hosted Container Registry

***Experimental***

Steps to build Dockerfile which contains `cosign` for testing purposes.

```bash
docker buildx build \
  --platform linux/amd64 \
  --pull \
  --push \
  -f Dockerfile \
  -t pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit}) .
```

Sign with OIDC which is an experimental feature of `cosign`.
```bash
COSIGN_EXPERIMENTAL=1 cosign sign pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit})
Generating ephemeral keys...
Retrieving signed certificate...

        Note that there may be personally identifiable information associated with this signed artifact.
        This may include the email address associated with the account with which you authenticate.
        This information will be used for signing this artifact and will be stored in public transparency logs and cannot be removed later.
        By typing 'y', you attest that you grant (or have permission to grant) and agree to have this information stored permanently in transparency logs.

Are you sure you want to continue? (y/[N]): y
Your browser will now be opened to:
https://oauth2.sigstore.dev/auth/auth?access_type=online&client_id=sigstore&code_challenge=caIyLBgBcyD6Az2L7_jl9689M1C-LtmCQqI9p6qTfgU&code_challenge_method=S256&nonce=2BBEyfVQSDZtG8gfLu8a5Xm1xoF&redirect_uri=http%3A%2F%2Flocalhost%3A37825%2Fauth%2Fcallback&response_type=code&scope=openid+email&state=2BBEyiDjT9nGvgbOCshzmYSKXQC
Successfully verified SCT...
tlog entry created with index: 2783176
Pushing signature to: index.docker.io/pyrrhus/cosign
```

Verify with `cosign`
```bash
COSIGN_EXPERIMENTAL=1 cosign verify pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit}) | jq .

Verification for index.docker.io/pyrrhus/cosign:57c405b --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - Any certificates were verified against the Fulcio roots.
[
  {
    "critical": {
      "identity": {
        "docker-reference": "index.docker.io/pyrrhus/cosign"
      },
      "image": {
        "docker-manifest-digest": "sha256:a73f461665535618c190ec04d969629541d2f880ecbf17b499c91fb630f434ee"
      },
      "type": "cosign container image signature"
    },
    "optional": {
      "Bundle": {
        "SignedEntryTimestamp": "MEQCIEK373lbv2jMZ9xvUdv/leTivIaZbSb+VdvP9PBGqwpbAiBy6I1YEhJqb0CDaMpQMTaY0bk85RiG+w+5D5Yiz6RXoQ==",
        "Payload": {
          "body": "eyJhcGlWZXJzaW9uIjoiMC4wLjEiLCJraW5kIjoiaGFzaGVkcmVrb3JkIiwic3BlYyI6eyJkYXRhIjp7Imhhc2giOnsiYWxnb3JpdGhtIjoic2hhMjU2IiwidmFsdWUiOiI3ZmE3YWYxOTgwNmVjM2JjMjdkMDUwZDNiOTEzMzViOTU1ZTg0ZDc1YWYxYTY4NGIxMjU2Mjg2OTgxYmVmNzA3In19LCJzaWduYXR1cmUiOnsiY29udGVudCI6Ik1FWUNJUUR4L3gzK0Z3bXRsVGlhaXQ2L0tVSkFXdlVtdFd0dUNKeGM4a2oyY2l4WmN3SWhBSlF3bGgxbmgwZzRxWS83WExVS3Mwb09ZWkY0b3BINmI0enpaYjdBek5hdCIsInB1YmxpY0tleSI6eyJjb250ZW50IjoiTFMwdExTMUNSVWRKVGlCRFJWSlVTVVpKUTBGVVJTMHRMUzB0Q2sxSlNVTnZla05EUVdsdFowRjNTVUpCWjBsVlRuQmFRbmc1YzB4R1pETXJSelExTVV4bFF6Qk9VemhUU21aemQwTm5XVWxMYjFwSmVtb3dSVUYzVFhjS1RucEZWazFDVFVkQk1WVkZRMmhOVFdNeWJHNWpNMUoyWTIxVmRWcEhWakpOVWpSM1NFRlpSRlpSVVVSRmVGWjZZVmRrZW1SSE9YbGFVekZ3WW01U2JBcGpiVEZzV2tkc2FHUkhWWGRJYUdOT1RXcEpkMDVxU1ROTmFrMTNUMFJWTWxkb1kwNU5ha2wzVG1wSk0wMXFUWGhQUkZVeVYycEJRVTFHYTNkRmQxbElDa3R2V2tsNmFqQkRRVkZaU1V0dldrbDZhakJFUVZGalJGRm5RVVYxYjAxWk4ybDJRekJRV0dVd1dTdHpOMVl6VGsxYU5reElaMjlqT1V4WVJIbE5jVGtLTm0xdmIwNW5Za0ZpT0dwRFZuRkxkR0pMUTJoS0swRkhMMDF4ZGtGaGFHOXdjbWhGTUZCNlpVcDVWWEUyYmsxd2VFdFBRMEZWWjNkblowWkZUVUUwUndwQk1WVmtSSGRGUWk5M1VVVkJkMGxJWjBSQlZFSm5UbFpJVTFWRlJFUkJTMEpuWjNKQ1owVkdRbEZqUkVGNlFXUkNaMDVXU0ZFMFJVWm5VVlV4Vm13eENqRjBWbkpWWW1SaGVERlpNWHBNYmpCS2NuaGhkelU0ZDBoM1dVUldVakJxUWtKbmQwWnZRVlV6T1ZCd2VqRlphMFZhWWpWeFRtcHdTMFpYYVhocE5Ga0tXa1E0ZDBsUldVUldVakJTUVZGSUwwSkNZM2RHV1VWVVkwaFdjMkpITVdoaWJVVTBVVWRrZEZsWGJITk1iVTUyWWxSQmMwSm5iM0pDWjBWRlFWbFBMd3BOUVVWQ1FrSTFiMlJJVW5kamVtOTJUREprY0dSSGFERlphVFZxWWpJd2RtSkhPVzVoVnpSMllqSkdNV1JIWjNkbldYTkhRMmx6UjBGUlVVSXhibXREQ2tKQlNVVm1VVkkzUVVoclFXUjNRVWxaU2t4M1MwWk1MMkZGV0ZJd1YzTnVhRXA0UmxwNGFYTkdhak5FVDA1S2REVnlkMmxDYWxwMlkyZEJRVUZaUjI0S1lrNWlha0ZCUVVWQmQwSkpUVVZaUTBsUlJITktjRE13T0RKUFpHUnNZVWMwYTFCTmVGSnpUalIzWWt0T2JFZGFlSEZ4TVZWUU1tdDBVRVpoYWxGSmFBcEJUbFoxU2twSk1FNXhjVzFIUkc0NFRrd3hVR1YyZWtaek0zUkZTSFJKVTBOclZtdHNXR2N3YW5OTk1rMUJiMGREUTNGSFUwMDBPVUpCVFVSQk1tZEJDazFIVlVOTlNGZFhLMjUzVWtSQ1IwWnpLMGx6WkZwQ1FYSm9WWFkxVEZCNVpqUmlhekpxYzBwelQyZFVlVVZHTm1odlFtZDRWRmg0WVhSNFluUm1kV1lLYzFOdGRqVlJTWGhCVEhCeU5EZENVMmRpZDNsNFRqaEViRTVEVTJkNmQyNU1jMDB2UWt0UWVHSmFOSE4wVEcxa1JHWjZTVzVuUjNwSlZ6ZHBVVmRuVkFweVRFTlpSMlJyTkhCM1BUMEtMUzB0TFMxRlRrUWdRMFZTVkVsR1NVTkJWRVV0TFMwdExRbz0ifX19fQ==",
          "integratedTime": 1656371338,
          "logIndex": 2783176,
          "logID": "c0d23d6ad406973f9559f3ba2d1ca01f84147d8ffc5b8445c224f98b9591801d"
        }
      },
      "Issuer": "https://github.com/login/oauth",
      "Subject": "pullmana8@gmail.com"
    }
  }
]
```

Attach example file `foo` as attestation with `cosign`
```bash
COSIGN_EXPERIMENTAL=1 cosign attest --predicate foo pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit})
Generating ephemeral keys...
Retrieving signed certificate...

        Note that there may be personally identifiable information associated with this signed artifact.
        This may include the email address associated with the account with which you authenticate.
        This information will be used for signing this artifact and will be stored in public transparency logs and cannot be removed later.
        By typing 'y', you attest that you grant (or have permission to grant) and agree to have this information stored permanently in transparency logs.

Are you sure you want to continue? (y/[N]): y
Your browser will now be opened to:
https://oauth2.sigstore.dev/auth/auth?access_type=online&client_id=sigstore&code_challenge=vVzc66UIdoShqrfywX6f3lH2dCFamB5VmTLO9n0kKIM&code_challenge_method=S256&nonce=2BBHdGjOFFAn1ZTIgcuaZAFpFvP&redirect_uri=http%3A%2F%2Flocalhost%3A37071%2Fauth%2Fcallback&response_type=code&scope=openid+email&state=2BBHdIsOd9mXeGOI4R5OexJZPfw
Successfully verified SCT...
Using payload from: foo
tlog entry created with index: 2783192
```

Verify attestation with `cosign`
```bash
COSIGN_EXPERIMENTAL=1 cosign verify-attestation pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit}) | jq -r .payload | base64 -D | jq .

Verification for pyrrhus/cosign:57c405b --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - Any certificates were verified against the Fulcio roots.
Certificate subject:  pullmana8@gmail.com
Certificate issuer URL:  https://github.com/login/oauth
{
  "payloadType": "application/vnd.in-toto+json",
  "payload": "eyJfdHlwZSI6Imh0dHBzOi8vaW4tdG90by5pby9TdGF0ZW1lbnQvdjAuMSIsInByZWRpY2F0ZVR5cGUiOiJjb3NpZ24uc2lnc3RvcmUuZGV2L2F0dGVzdGF0aW9uL3YxIiwic3ViamVjdCI6W3sibmFtZSI6ImluZGV4LmRvY2tlci5pby9weXJyaHVzL2Nvc2lnbiIsImRpZ2VzdCI6eyJzaGEyNTYiOiJhNzNmNDYxNjY1NTM1NjE4YzE5MGVjMDRkOTY5NjI5NTQxZDJmODgwZWNiZjE3YjQ5OWM5MWZiNjMwZjQzNGVlIn19XSwicHJlZGljYXRlIjp7IkRhdGEiOiIiLCJUaW1lc3RhbXAiOiIyMDIyLTA2LTI3VDIzOjMwOjQ3WiJ9fQ==",
  "signatures": [
    {
      "keyid": "",
      "sig": "MEYCIQC6/ngLMr584AdflFdCHlLkVlM0QKfaH5MGndi3VFYYsAIhAJu5jcEU7xxDBqwTcPNLpRTQw0QSxEXla3a/vqBJ0oVQ"
    }
  ]
}
```

Decode with `base64`
```bash
COSIGN_EXPERIMENTAL=1 cosign verify-attestation pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit}) | jq -r .payload | base64 -d | jq .

Verification for pyrrhus/cosign:57c405b --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - Any certificates were verified against the Fulcio roots.
Certificate subject:  pullmana8@gmail.com
Certificate issuer URL:  https://github.com/login/oauth
{
  "_type": "https://in-toto.io/Statement/v0.1",
  "predicateType": "cosign.sigstore.dev/attestation/v1",
  "subject": [
    {
      "name": "index.docker.io/pyrrhus/cosign",
      "digest": {
        "sha256": "a73f461665535618c190ec04d969629541d2f880ecbf17b499c91fb630f434ee"
      }
    }
  ],
  "predicate": {
    "Data": "",
    "Timestamp": "2022-06-27T23:30:47Z"
  }
}
```

Experimental feature to verify attestations based on REGO policy and CUE policy.
```bash
COSIGN_EXPERIMENTAL=1 cosign verify-attestation --policy policies/policy.cue pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit})

COSIGN_EXPERIMENTAL=1 cosign verify-attestation --policy policies/policy.rego pyrrhus/cosign:$(git rev-parse --short v0.0.2^{commit})
```

Use `slsa-verifier` check provenance after you setup the `.slsa-goreleaser.yml` as the GitHub Actions workflow.
```bash
slsa-verifier -artifact-path fenix-binary-linux-amd64 -provenance fenix-binary-linux-amd64.intoto.jsonl -source github.com/acald-creator/fenix-registry
Verified signature against tlog entry index 2783247 at URL: https://rekor.sigstore.dev/api/v1/log/entries/5ac8dffa6999324d6c4e70abd29052f0217494fc4dc7c92e095d3fb9701c7b1a
Signing certificate information:
 {
        "caller": "acald-creator/fenix-registry",
        "commit": "7d6d187b3b761c64246e925524501716c9b4f356",
        "job_workflow_ref": "/slsa-framework/slsa-github-generator/.github/workflows/builder_go_slsa3.yml@refs/tags/v1.1.1",
        "trigger": "workflow_dispatch",
        "issuer": "https://token.actions.githubusercontent.com"
}
PASSED: Verified SLSA provenance
```