Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F5DC44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:09:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C23942EA0;
	Wed, 21 Jan 2026 22:08:31 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 0C1B542E87
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:31 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so3080645e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029711;
 x=1769634511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1t2QfQVXvG8orz8h4uSEgvkkR1cjZS6h4cNiVTVkEg=;
 b=iE1K31BH/GTlieX3MjiYUClsnnb+4yVF9F2AsqZj7RMI4zjXNndBQeQ0btf8z0mDwQ
 zjip4QrWVcsyBuEx6dM2bhawdXw64gbtWz0cjPOC/L6x8WafuqHLKsH4sApA4vQAzac2
 HJo7X4WqXrmt1rV1h/LYYvGrcd9gN801I6WJueLk0bRtUyzN6cXaGCwxXvplBGRWOt2N
 eRZ87BK4jbE3Lme9nAOKXwLP9GOQSTCsr4ivPD+5lJw7d++xjeROofwbgyn/iRZWV2IG
 ofH//AJwxInVzLWYYjLRzn/64JeXWJ+fltrgsjNTGaSO1p2hdyln3S0/+mlRNzZAA9vi
 QG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029711; x=1769634511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y1t2QfQVXvG8orz8h4uSEgvkkR1cjZS6h4cNiVTVkEg=;
 b=Y+fe3eqWBuQwLsB9W3DHhb1Zpv5gf2eKeCpaEPKeZpStrszlGZ0RCa5zuegEXD4582
 BYoanUbVGOMoCk7kkOq4vXwCrVhhLr1a+T/IyTdwi/GqpwV5xTJIQe1i5ys3i/qOQ6XS
 mTyB2anOO9Zm2X46lQ9TUtpYpNLfrowBHh2VgHUnAvnX5Zan2HRXHdha31IifG71GFfk
 m7AcvfvUgCSYQE73NzDAGIE/JWUXheR+4M15KHpVECioJ0wUnp6zUrDVeOGM7L3QPdVi
 tHb2gLQvHl2VlUiSzTcsnUO5KdQpLF0gscKgOGpa4nQjvPsSzC+hoa8QcdM5T1agBOki
 P7EA==
X-Gm-Message-State: AOJu0YySEr0rwRYc59Rlybu4xzCWUCVZqrcVR/oQkL8aTYb0JhPt8F5a
 0Y1wHiEmhcSlxezDVpsuMty81JrqmssznFCU1mr/USNN3rLLdE7OxqyzX0YKYKI7lhsDHhEALDw
 2jaLj
X-Gm-Gg: AZuq6aJ5kgZMzAQ6/6y/UcKvF862j97RR839Fdh3kqSzWEfFE0YD7VAGolqRpp0mmpm
 ARjO1ZZXAsiC53LHCNijZUMvAmEiqGH8ca118S6pj8/64pbEDArXBbxFw5nQq87QUr64pML8wU8
 Lm7cGw8uDgvw0phUmzdpsmO+8LviPTPcJXtoyCq7zbni00EtOKu23MlAzrXC+dmDe8uz8CqPz08
 oHGxsfWKMlkd4ZPQW19jAetq5BKqI8QJ1HqckNMhMx71AygUXEAQGsPSVmyXuDzHVYWqrk3b1y4
 VDzgKyH2Zo9QSMy5MS9TLyL2t38gYFRNplOCX+1GDIPwrv3Yhxa2UH+6ycALFpZgq9YV4hXe7k+
 hDojeOut0uwonCm8HvYyi+mLoQrY4D/jljdUlNdNzkCnlpQJSRhewdQaTSkwyT1ly6cbw5uKItY
 BIoLIWjkh652pzFPAeYMbs0a3X/37Vb/UM/W1JwplYV9+wl9ASvA==
X-Received: by 2002:a05:600c:3150:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-4803e7e818fmr98105615e9.19.1769029710612; 
 Wed, 21 Jan 2026 13:08:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v12 7/8] test: fix overflow warnings in common code
Date: Wed, 21 Jan 2026 13:06:27 -0800
Message-ID: <20260121210810.1044276-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121210810.1044276-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260121210810.1044276-1-stephen@networkplumber.org>
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

Several tests lookup the current file prefix and
format up a filename argument. Avoid any possible format
overflows by using new file prefix function.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_mp_secondary.c    | 14 ++++----------
 app/test/test_pdump.c           | 13 ++++---------
 app/test/test_timer_secondary.c | 12 ++++--------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index 9b4b9812c3..218eacb3bf 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -67,17 +67,11 @@ run_secondary_instances(void)
 {
 	int ret = 0;
 	char core_str[10];
+	const char *prefix;
 
-#ifdef RTE_EXEC_ENV_LINUX
-	char tmp[PATH_MAX] = {0};
-	char prefix[PATH_MAX] = {0};
-
-	get_current_prefix(tmp, sizeof(tmp));
-
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#else
-	const char *prefix = "";
-#endif
+	prefix = file_prefix_arg();
+	if (prefix == NULL)
+		return -1;
 
 	/* good case, using secondary */
 	const char *argv1[] = {
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index c084e20742..824caef2d4 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -174,16 +174,11 @@ run_pdump_server_tests(void)
 {
 	int ret = 0;
 	char core_str[10];
+	const char *prefix;
 
-#ifdef RTE_EXEC_ENV_LINUX
-	char tmp[PATH_MAX] = { 0 };
-	char prefix[PATH_MAX] = { 0 };
-
-	get_current_prefix(tmp, sizeof(tmp));
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#else
-	const char *prefix = "";
-#endif
+	prefix = file_prefix_arg();
+	if (prefix == NULL)
+		return -1;
 
 	/* good case, using secondary */
 	const char *const argv1[] = {
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 8bff904ed4..0fc07dcbad 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -51,16 +51,12 @@ static int
 timer_secondary_spawn_wait(unsigned int lcore)
 {
 	char core_str[10];
-#ifdef RTE_EXEC_ENV_LINUXAPP
-	char tmp[PATH_MAX] = {0};
-	char prefix[PATH_MAX] = {0};
+	const char *prefix;
 
-	get_current_prefix(tmp, sizeof(tmp));
+	prefix = file_prefix_arg();
+	if (prefix == NULL)
+		return -1;
 
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#else
-	const char *prefix = "";
-#endif
 	char const *argv[] = {
 		prgname,
 		"-l", core_str,
-- 
2.51.0

