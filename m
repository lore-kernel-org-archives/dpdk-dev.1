Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B7C021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93A0340A7F;
	Sat, 15 Feb 2025 20:05:59 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id BDA1F402A0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:05:57 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22114b800f7so4547855ad.2
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646357;
 x=1740251157; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHYdq434PJealTXPJqVJdnEDtH8hAF0XExmSu/YBuaY=;
 b=2vkQ8mGH6s378sVnOp/ll6hC0ENKjvf5zQCf9mRlhc5KiuqDGlt9tfW2pa7QHCHIbQ
 KoOOxM8Qg952N5ZcoHkSNxfJFaBAnWq1IiNkQWG94JCnbG+HYW6zp7+84WccFOUjGtoy
 WaWN6Dx6XWZADfPTWTnWqVQ8k041GFQ9YN3n8PUdAxk5Fyc5D6IL0tUnTlszSINk1MO+
 cnrNvH6Z6XTr7stcazyOIOXoXkaDQ16xzGxwROSe3MSiV6WC9KIPEhnLwPtukWZaP1J7
 cCjuZnJf40pV4y5m5B2i5BhopLeTAZ6/p0vMEGtqd/wAyz7e+diCq18CzDXqjdn2mqHW
 EisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646357; x=1740251157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHYdq434PJealTXPJqVJdnEDtH8hAF0XExmSu/YBuaY=;
 b=YAOlh3r+V2zzR0MzUeJLPJZ9bPcNo+c9ngsoYDVmDStWYSG6HWuUh69QKx0Fwo9LQH
 NiibGmyB1FbYtxHQZhNeolLbsFkJxj3A6DAYXLouJ5PPsGyAlYXcTKPgpADKvAswcvcO
 OdMyc9+5U34pI4Eh4nYlsQq5TlBGg8E78I8wH6RBqPmtNUWQ5wnOO2rh37SN4k5umTqX
 To+lXextvzfEpxtUSzhLMn33DXcDdcyI1YrRE+V92syGq+O4ljL4KgFl+gq/RvgtsxJo
 27Xh6QHONULZYFhcwDHbN1yzuEf0c/AM83p4yKI2jedhZmF6/mEyftvuTLG3MCbBOSQ4
 YUAg==
X-Gm-Message-State: AOJu0YyNU0EGBrkweSEKLl3RcrgB75Ychk6TIgYZ6EbneqN7P2ANWy/n
 edZJosEaUn1HtO7DMUIgq3JjCzqAeoyuLlcwZv8EnJa5eaI8wz9l2RWEeNiE0apdETwB+y1nHXu
 l
X-Gm-Gg: ASbGncvj8CmflaA8UEldtaqWGcRp9Wq1vB82tmdXJ8jCdV1dQRuZAMnYKYmtEP6C+24
 uebGC7sbecURkHTwo1s6spEIiBQd0dclGN4HUPiC560RmFTrvxNamH1asJCCvjgP4eVPwgQm0zP
 Hk/6Ly9MZQjW8XVgcq4YDOqzbXgYnMivssjzuBGIjzma4NMq3DzV9FQpFm9AThyaHtYrHFYWJh4
 XRbO8BHa0vy99reNUfoMFd8iX4Z0MbZXP8xEh3bFS5T8hOoUUeGdl5SlvlQx31QEhyfNjAgPnAF
 zmzsnvlo1teM2834eI3fNJvYQ59U1NhzOofsM+NSZaO+Fdhhtlyoq86x6CB9PoesMSts
X-Google-Smtp-Source: AGHT+IGIJeSbEW8jMlKolFzTLaY8PQV8izEdMDqHRu9qnfK0uhlK8RnXB+PgrDAN8hdqWyHBG18a/w==
X-Received: by 2002:a05:6a21:6b05:b0:1e1:ab8b:dda1 with SMTP id
 adf61e73a8af0-1ee8cbc41fbmr9030820637.35.1739646356918; 
 Sat, 15 Feb 2025 11:05:56 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:05:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 02/16] app/test: use unit test runner for string tests
Date: Sat, 15 Feb 2025 11:04:30 -0800
Message-ID: <20250215190544.988310-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Switching to unit test table makes it easier to add new tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_string_fns.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index 3b311325dc..ce07c17228 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -205,16 +205,20 @@ test_rte_str_skip_leading_spaces(void)
 	return 0;
 }
 
+static struct unit_test_suite test_suite = {
+	.suite_name = "String functions tests",
+	.unit_test_cases = {
+		TEST_CASE(test_rte_strsplit),
+		TEST_CASE(test_rte_strlcat),
+		TEST_CASE(test_rte_str_skip_leading_spaces),
+		TEST_CASES_END()
+	}
+};
+
 static int
 test_string_fns(void)
 {
-	if (test_rte_strsplit() < 0)
-		return -1;
-	if (test_rte_strlcat() < 0)
-		return -1;
-	if (test_rte_str_skip_leading_spaces() < 0)
-		return -1;
-	return 0;
+	return unit_test_suite_runner(&test_suite);
 }
 
 REGISTER_FAST_TEST(string_autotest, true, true, test_string_fns);
-- 
2.47.2

