Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA1D0E6FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F55D40E12;
	Tue, 25 Nov 2025 16:22:55 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7FF1440DCB
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:44 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-29812589890so66389485ad.3
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084164;
 x=1764688964; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=P3i0g2Yzu7ws5EWcXdmSQ05FGiJV/BzL5/jX5QV0iAD8K4gVGzgzrnMNUfM9/OTyKt
 RWQSJZaDQRYnjNDxjvNgE5aAtBf+RX7dSDOEDyF6MS5tyPcjsUUkGUnFqQCz6nMgL1pG
 KDtFR1GEyBXObTTA/C5/qARoxmTd137jKlebKcdqWEFyZWyCkCof7myEIoOnlG9yZ7jg
 uAn8sW+dJohdBz6xKQWq0lrzE8rctRd4U3HDumCMEiWquA+rUECQrkv/CIzWHFrxum+J
 iDoioetvJ7uf5b1ZnKsMRCsZUZPF9Ti7WZG+CIBJpAONri9XXkE2xGreQyPbYOstzjpC
 FFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084164; x=1764688964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=IZMjOm1X0j4zc3fyufJ98MuOJTRq6HiImdUp4sg5luAH5vIqUBWmMhMiN7HLiABAPy
 3Gt2BLNoFSodMD+QHMrTePgOz0Epv5oIjxbxhcE+Mv1mK1Br/ZkIWSFWZxeg+w+dwPYt
 OVVUTPLoKB3s6nRbCy+jY29hwsd4zv5DZVneCvQUjdFgFNoGuZqqsunC5+QnhORCyATb
 PbKz3g76Kulztj3mZfHEgKpFDECqLeanoPm0dNxg0f+qsfxNm+m9rNTg67dj4UHwyOAv
 o90ex6e9089/OG613hAOcsLkORqgfphW5wpb3giYCJvAz6Gci38wHuc6U+yNhgyNJkg1
 k32g==
X-Gm-Message-State: AOJu0Yx/fKYf9PL4/k5TfAacKzmL1yQkMllVcUF7H1xtIVZWP7mH8eKj
 YD6onyGvWpPuC9Tj7FKTJrDqSKlIRwdXAmS4RjDglDqQRO7AtyDyNJLwMYbijiGuLX/KlhKtW4Q
 BPz0l
X-Gm-Gg: ASbGnctVvQaSFg4iAcDfsD3tgz37AhdG0zUwkMr0dpDOj1ng3LPO8cBE47n0d6eofJS
 cUcCV4da7fI86jhHYWQXFdnrjRFT8o/xLR+aVN9ZYkJAgqgZVNcawpec7RvXxsdFbP4VrkMTxlH
 e+Oi6oRN4yl5/6MPtbuMS56QVfLTpSvmlK+DMb9tmZllfdzw6rxZNv0BO5QQOi52xdv4IG4IaUC
 JH2QqeoWK8X8RaKQOKzgfILGd3gd13qhsaCQSeSxXQMfuQhoSC1WwOlNGNA5hcjHOBDSpaw2nqa
 HISgGH91yoBNyGkiKwtXnZ0kMAulyzUuT4GC+rxl2QLO+zAfnfcAJmIBp360NwfXyukS5ElPiyV
 TdpWEunNSj1joCylcSuM1XFBqqPSdqQQmoeHOW9PjjiwD2BYN4AuaAl0fcUPG9jw+xmZpyxCuhr
 DwmgGy6I6ylgcjpDjDFbb6BBze7IUACBLyQT/yDl++UwZD+Q==
X-Google-Smtp-Source: AGHT+IEaZG925hRJXElPi0p1Mq3Yo2UxYNlJK0Jh3Ohbhio2rfYGpKlV3Wh1SxX/5JO47rUfAZmAEQ==
X-Received: by 2002:a17:903:2f8d:b0:298:29e0:5f32 with SMTP id
 d9443c01a7336-29b6bead4e2mr172922775ad.15.1764084163619; 
 Tue, 25 Nov 2025 07:22:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v7 08/10] test: fix overflow warnings in several places by
 using common code
Date: Tue, 25 Nov 2025 07:20:58 -0800
Message-ID: <20251125152232.73528-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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
overflows by allowing for bigger string.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mp_secondary.c    | 14 ++++----------
 app/test/test_pdump.c           | 13 ++++---------
 app/test/test_timer_secondary.c | 12 ++++--------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..fc295323f2 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -67,17 +67,11 @@ run_secondary_instances(void)
 {
 	int ret = 0;
 	char coremask[10];
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
index 9f7769707e..cd044f0f69 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -174,16 +174,11 @@ run_pdump_server_tests(void)
 {
 	int ret = 0;
 	char coremask[10];
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
index 4e220559b4..bd618b3cfc 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -51,16 +51,12 @@ static int
 timer_secondary_spawn_wait(unsigned int lcore)
 {
 	char coremask[10];
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
 		"-c", coremask,
-- 
2.51.0

