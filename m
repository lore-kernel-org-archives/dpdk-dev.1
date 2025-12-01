Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CADD116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:05:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD27340663;
	Mon,  1 Dec 2025 23:04:38 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0169440658
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:37 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8b2627269d5so406752185a.2
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626677;
 x=1765231477; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=e5l2VG9ijXzeHcJ4i1xCmOy2m30ivCJ4ZsR+we1PEQikLljIyHtn1GzhaTdYhOuG1k
 HeguIN5+Kd/MSUpMahr5prcS2E601Qg/7eNnA7psYvdoQDebGdhbdf0HzH9rGLF3g4Hx
 7tta5XLpMTOdbJ7s536ys8cxmkFBS5bBifjgDp8dmq3WgjO2RmFwjX8EfaOCpMuHaUsP
 Zlxe9D1qJPKsseITdyCwG335t72uLC22PAnoZ62xGW+2dhaqVXKhKFpOh5dBUypvFs4D
 Zr/ffTwSJk4JFARACiKKD4v49dmynWxoiZSFaD75bqVdtJiuZH22HFBOwxq98AUhHtz1
 q0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626677; x=1765231477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCMP9CwmkGTvpL2x7J2B/y0Rk6+GArDIs8Bn9++G6XI=;
 b=LcDIKV/uHvH54jIUU8vl++9UCRRTyxLpDIM6Zk2bIhMtPTTwxZ2jrTGT9Y4CfPWqDL
 lxPUoanBn3gKwIXFInKO/cdtWg2nz39J3mGqj75D8823NxCTC5zmuXT8afguu82QBWNF
 2fLVUqwmdPZeTRZCA2RoSXbeJ6FYyUQSGUu/J8UgKmU54d7p65cC3SmV3ieE1if2+u/r
 6vtjmELlHncAyuwQYrTYnZdqwQATYNeoMMRp+82vxtOZDxdpO3uazNOSUqU7sO4v8ASj
 duALujxHy4Mi5jOoQ2Xkl5nL23b9fB/43zJCC5ae8j1AiO/FmRblkbaGhvNRI27hcogA
 Mjpw==
X-Gm-Message-State: AOJu0Yx6WraDSEUFYbj0Hm7eqUzFYq/EMgzros9NKGaVDRWdovE5DPKX
 xfjZC7yGbF0uYzekd6Oe3atBU+MOTFIH0BosF3F2uL/3dPdGfU8jvzwgaVIuBmDnR/kDjnBnF43
 whye5
X-Gm-Gg: ASbGncsvPzABLV4bwqBYc9s7TjUClAjgTuQL/HGGB2ZhjT586qHHXfeopgJHJMVtxEb
 NK/0setB7HYT3mBMLykSQesdO2T7Oov5WAUOrElLtqHAh16WJzSWPWS1zy06av8gp3rZM0/Xss5
 53Px8rzKAjHnmjBHIoQhHEqlgVpGUwv4Y0sCNqgmzVaXTYp6iHE1ohmqKyILVoZXhhLbGmYKHDx
 2rMZk8OxiV7n8v04sfSRrm8XJMhj515WtAbFxqJIzpMgGdZW0MC+JSh3px3VU3YAqJQKuqgbIds
 a1zvDThzgL8F3LwBCXcc9TbYLUSaLyDN+iK7MPquSEkp18T7CAyqI41nCwN5CtjuPQmgHsFYjTi
 JnsqLG2Qslfyxixr9cLu4jLZa5o3Wz/qLaJRltmzil9LxrFihAWqlHKe4aHk31ZuGH+GKG6V4Lv
 AH3NQaasctGRIEiacp99P0SeKoeIpoK5EoEwjtmtMGkrDNwZJkOQ==
X-Google-Smtp-Source: AGHT+IERlRj0a3G2bz8Z3Cenfb+0FsihISTqCBgevONwZQ8MvjnhxNeQQBDvmoWs/aQlFeO9WobzPQ==
X-Received: by 2002:a05:620a:3943:b0:8ad:4126:4e19 with SMTP id
 af79cd13be357-8b33d1f00a9mr5214563585a.26.1764626677221; 
 Mon, 01 Dec 2025 14:04:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v9 8/9] test: fix overflow warnings in several places by using
 common code
Date: Mon,  1 Dec 2025 14:02:06 -0800
Message-ID: <20251201220421.207285-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201220421.207285-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251201220421.207285-1-stephen@networkplumber.org>
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

