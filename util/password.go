package util

import (
	"fmt"
	"golang.org/x/crypto/bcrypt"
)

//HashPassword returns bcrypt hash of the password
func HashPassword(password string) (string, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", fmt.Errorf("failed to has password: %w", err)
	}

	return string(hashedPassword), nil
}

//CheckPassword checks if the provided password is correc tor not
func CheckPassword(password string, hashedPassword string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
}
