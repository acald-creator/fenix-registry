package signature

allow[msg] {
    input.Data != "foo\n"
    msg := sprintf("unexpected data: %v", [input.Data])
}

allow[msg] {
 before = time.parse_rfc3339_ns("2022-06-27T23:30:47Z")
 actual = time.parse_rfc3339_ns(input.Timestamp)
 actual != before
 msg := sprintf("unexpected time: %v", [input.Timestamp])
}