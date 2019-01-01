package main

import (
	"bufio"
	"log"
	"os"
	"strings"
	"fmt"
)

func extract_checksum(checksumPathPtr *string, filename *string) {
	checksums := make(map[string]string)

	checksumFile, err := os.Open(*checksumPathPtr)
	if err != nil {
		log.Fatalf("Error opening checksum file: %s", err)
	}
	defer checksumFile.Close()
	
	// parse out the checksum target
	scanner := bufio.NewScanner(checksumFile)
	for scanner.Scan() {
		kv := strings.Fields(scanner.Text())
		checksums[kv[1]] = kv[0]
	}
	
	var checksumFile_checksum string
	var key_exists bool
	if checksumFile_checksum, key_exists = checksums[*filename]; !key_exists {
		log.Fatalf("The Checksum file does not contain a checksum for %s", *filename)
	}

	fmt.Println(checksumFile_checksum)	
}
