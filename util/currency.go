package util

const (
	USD = "USD"
	EUR = "EUR"
	CAD = "CAD"
)

func IsSupportedCurrency(currency string) bool {
	if currency == USD || currency == EUR || currency == CAD {
		return true
	}
	return false
}
