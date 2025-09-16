require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest", "fileinto"];

if allof (environment :matches "vnd.proton.spam-threshold" "*",
          spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

if anyof (
    # list / subscription headers
    header :contains "List-Id" "@",
    header :contains "List-Unsubscribe" "<",
    header :contains "List-Subscribe" "<",
    header :contains "List-Post" "<",
    header :contains "List-Owner" "<",
    header :contains "List-Help" "<",

    # standard auto-response / precedence / campaign headers
    header :matches "Precedence" "*",
    header :matches "X-Mailgun-Sid" "*",
    header :matches "X-Auto-Response-Suppress" "*",
    header :matches "Feedback-ID" "*",
    header :matches "X-Report-Abuse-To" "*",
    header :matches "X-Campaign-Id" "*",

    # obvious no-reply indicators (From or Return-Path)
    header :matches "From" ["*noreply*","*no_reply*","*no-reply*","*no reply*","*no.reply*"],
    header :matches "Return-Path" ["*noreply*","*no_reply*","*no-reply*","*no reply*","*no.reply*"],

    # common vendor / relay patterns
    header :matches "Return-Path" ["*sparkpostmail*","*@sendgrid*","*@mailchimp*","*@constantcontact*","*paypal*","*paylogic*","*whatbox*","*ses.*","*amazonses*","*amazon*","*bounce*"],

    # SES / Amazon specific traces
    header :matches "Message-Id" "*amazonses*",
    header :matches "Feedback-Id" "*AmazonSES*",
    header :matches "X-Ses-Outgoing" "*",

    # known mailer IDs
    header :matches "X-Mailer" ["*MailChimp*","*Constant Contact*","*PHPMailer*"],

    # auto-submitted header
    header :matches "Auto-Submitted" "auto-*"
) {
    fileinto "📬 AutoMail";
    stop;
}
