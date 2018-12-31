package main

import (
	"flag"
	"os"
	"log"
	"path/filepath"
)

func main() {
	signatureCommand := flag.NewFlagSet("signature", flag.ExitOnError)
	checksumCommand := flag.NewFlagSet("checksum", flag.ExitOnError)

	sig_keyPathPtr := signatureCommand.String("key", "", "The path to the public key")
	sig_sigPathPtr := signatureCommand.String("sig", "", "The path to the signature file")
	sig_targetPathPtr := signatureCommand.String("target", "", "The path to the file to check")
	
	checksum_checksumPathPtr := checksumCommand.String("shasum", "", "The path to the shasum file")
	checksum_targetPathPtr := checksumCommand.String("target", "", "The path to the file to check")

	// If the subcommand isn't provided, we exit
	if len(os.Args) < 2 {
        log.Fatal("signature or checksum subcommand is required")
    }

	switch os.Args[1] {
    case "signature":
        signatureCommand.Parse(os.Args[2:])
    case "checksum":
        checksumCommand.Parse(os.Args[2:])
    default:
        flag.PrintDefaults()
        os.Exit(1)
    }

	if signatureCommand.Parsed() {
        // Required Flags
        if *sig_keyPathPtr == "" || *sig_sigPathPtr == "" || *sig_targetPathPtr == "" {
            signatureCommand.PrintDefaults()
            os.Exit(1)
        }

		verify_signature(sig_keyPathPtr, sig_sigPathPtr, sig_targetPathPtr)
	}

	if checksumCommand.Parsed() {
        // Required Flags
        if *checksum_checksumPathPtr == "" || *checksum_targetPathPtr == "" {
            checksumCommand.PrintDefaults()
            os.Exit(1)
        }
	
		filename := filepath.Base(*checksum_targetPathPtr)
		verify_checksum(checksum_checksumPathPtr, checksum_targetPathPtr, &filename)
	}
}
