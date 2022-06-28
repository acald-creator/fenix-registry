import "time"

before: time.Parse(time.RFC3339, "2022-06-27T23:30:47Z")

predicateType: "cosign.sigstore.dev/attestation/v1"

predicate: {
	Timestamp: <before
}
