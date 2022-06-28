/*
Copyright © 2022 Antonette Caldwell antonette.caldwell@owasp.org

*/
package main

import "github.com/acald-creator/fenix-registry/cmd"

func main() {
	// Muting this line for testing purposes
	// cmd.PullDockerImage()

	// Will not work because there is plaintext credentials
	// cmd.PullDockerImageWithAuth()

	cmd.ListDockerContainers()

	// Future feature
	// cmd.Execute()
}
