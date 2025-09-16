# ProtonMail AutoMail Sieve Filter

A Sieve filter script for ProtonMail that automatically organizes automated emails into a dedicated folder, helping keep your inbox clean and focused on human-sent messages.

## What This Does

This Sieve filter automatically moves automated emails (newsletters, notifications, marketing emails, system messages, etc.) into a folder named "📬 AutoMail", keeping your main inbox focused on personal correspondence.

## Features

- **Comprehensive Detection**: Identifies automated emails through multiple methods:
  - Mailing list headers (List-Id, List-Unsubscribe, etc.)
  - Standard automated email headers (Precedence, Auto-Submitted, etc.)
  - No-reply sender patterns
  - Common email service provider signatures (SendGrid, MailChimp, Amazon SES, etc.)
  - Campaign and marketing email identifiers

- **Spam-Safe**: Respects ProtonMail's spam filtering - spam emails are not moved to AutoMail
- **Extensible**: Easy to add new patterns and rules as needed

## Installation

### Prerequisites
- ProtonMail account with Sieve filter support (requires paid subscription)
- Access to ProtonMail's Sieve filter settings

### Steps

1. **Create the AutoMail folder** (if it doesn't exist):
   - In ProtonMail, go to Settings → Folders and labels
   - Create a new folder named: `📬 AutoMail`

2. **Install the Sieve filter**:
   - Go to Settings → Filters
   - Click "Add Sieve Filter"
   - Copy and paste the contents of `protonmail-automail-filter.sieve`
   - Save and enable the filter

3. **Test the filter**:
   - Send yourself a test email with `noreply` in the sender address
   - Verify it gets moved to the AutoMail folder

## How It Works

The filter uses multiple detection methods to identify automated emails:

### Mailing List Headers
Detects standard mailing list headers like `List-Id`, `List-Unsubscribe`, etc.

### No-Reply Patterns
Catches common no-reply email patterns in sender addresses:
- noreply, no_reply, no-reply, no reply, no.reply

### Email Service Providers
Identifies emails from common automated email services:
- SendGrid, MailChimp, Constant Contact
- Amazon SES, PayPal notifications
- Bounce handlers and other automated systems

### Campaign Identifiers
Detects marketing and campaign-related headers like `X-Campaign-Id`, `Feedback-ID`

## Customization

You can easily extend the filter by adding new patterns to the appropriate sections:

```sieve
# Add new no-reply patterns
header :matches "From" ["*noreply*","*your-new-pattern*"],

# Add new service providers
header :matches "Return-Path" ["*sparkpostmail*","*your-new-service*"],
```

## Common Issues

### Filter Not Working
- Ensure you have a paid ProtonMail subscription (required for Sieve filters)
- Check that the "📬 AutoMail" folder exists and is spelled correctly
- Verify the filter is enabled in your ProtonMail settings

### Emails Not Being Caught
- Check if the email headers contain any of the patterns in the filter
- Consider adding new patterns for specific senders you want to catch
- Remember that spam emails are intentionally not moved to AutoMail

### Too Many Emails Being Caught
- Review the patterns and remove any that are too broad for your needs
- Consider creating additional rules for emails you want to keep in your inbox

## Disclaimer

This filter is provided as-is. While it has been tested with ProtonMail, email filtering can be complex and results may vary based on your specific use case. Always test filters carefully and review moved emails periodically to ensure important messages aren't being misclassified.

---

**Note:** This filter requires a paid ProtonMail subscription as Sieve filtering is not available on free accounts.
