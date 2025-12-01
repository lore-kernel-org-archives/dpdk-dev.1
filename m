Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF8D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E2544021F;
	Mon,  1 Dec 2025 23:04:31 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 32D534064C
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:30 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8b2f0f9e4cbso374914185a.0
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626669;
 x=1765231469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsF6HxyMIoXJ7iymOvl8/WTESH0rCTv8yC+yvTXQgEE=;
 b=Ma8J9UrwoxOKG/GdVqrtEagPZe51yFuh1Fgiwzp0/69/rKmiKTbuTxlNd5wxNLj92L
 Owvvly/eFr5sAJsrYo7ktrxmZPfIATwqiaKcJGpTaQlsbR8/fXyDXn+6lDVF1WOGl7qq
 KAwGugElkSOQI0hYvYBVA941mC21ZEZG0uhrNNwLUAmZ0hF5/kv4ZUyWOJ8l+3PeUKK0
 d6gQhYr5dtmuYcQT8uVxKsNYlb9PbCgoWCo+7VWamaoAHmxRxcNTSHJUWAQHXgXuT8c1
 bemp5DEh+g90sNUPlHjPNbS0sFDRV/65FaSZgUMbbDSjhLAr1kI7KawFatGCLPI0685x
 PEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626669; x=1765231469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XsF6HxyMIoXJ7iymOvl8/WTESH0rCTv8yC+yvTXQgEE=;
 b=Z6viC9p8y0LSv0aEugmib7NLjMrQkRFUB38VrbNGjPLbSS7JZ3s1utxFnDcMVHWyzc
 gY40sjgpLBsq+k0C9jULpZABnns5t3lHgoCIPaHElLH0qFK7DJxg0hjb9UUiZuV38vS/
 eFMp6glirSmQGAuuhiTG51rJ+EMwkJCxxpC4TyOsOwJjxspqQbGj1paNun0twxW0LTGW
 5Q/ZOjt5abM2+c6TwJrPGXk/d2z8OhKdMhLohdVNdvp0ZJuXbPrU40S0ldWNZPD0Nj5w
 XsVcw84U7btIzUFwAuyeBzR0wkCdr4YPYxTuXY7czEp7eCsYfzN9hSAnEG/yez6+vooL
 SUhA==
X-Gm-Message-State: AOJu0Ywug6J72HO3Ya8oH/4y6z9f7LmcHfoi0YDE8zTGP3rl50hUvCSF
 JbNvskphR8dHU6VXk7nNjdHoP/h6jdhUghJCqa3r0bWusl8gMBq5kDf4WpiJGmdy2XbyD38vUXf
 k29Fj
X-Gm-Gg: ASbGncuxr7S1Awkv9Q6/diWfxjCOVo6gx2fcGmADBpS1mU6ge4dj3klPFJGPsqwRKFA
 MxSEBCBtmz18R3DyFfcc9Qdc0h9BeER0yjYCTcdUGl5SFB7mDIO/iToBguUPQTlyjLeQ0fFA5LI
 kjRZtYuWmW3lBSzmHj+4VOW+40dTsEUWkZ0bohqVpjk0n+8rkdt2C7O61Mz6LLBRekMi89QcGBx
 xGpWOPiUs0D8a9ZiW11kDBHSaOBBK+MYloFB6+ulIpTLnwCIbr5nZyxUVSdKKAfXxrwJ9ULSS6a
 ZHMiu+L9WSXyeC5rACojYO9nKp2ru/5khBcIp7Nc6T+rbPN3rqsqqMMuTQ7327gpvdTfWwEzeEp
 dU2NoK6KmK29GGezQp5bkbcW/AI9rLSe0Dkh85v+fbGIlGSMTyzLctN6v2GU3mvr46VmXA9oXlT
 PJ/X5f8nrzzM+5pTMQZlHYk3E3HTNq3ObDZxEk41lEk27EK3P9gA==
X-Google-Smtp-Source: AGHT+IGLZyv00mYg9vm4PkmPLK2s0J/1VhwgwoN/J/zJJJoZW3rtZo3r/pU4qqwPG46YH3XrN4cqHw==
X-Received: by 2002:a05:620a:8112:b0:891:e10a:9d3f with SMTP id
 af79cd13be357-8b5ac08359cmr22378285a.10.1764626669289; 
 Mon, 01 Dec 2025 14:04:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 3/9] test: refactor file prefix arg handling
Date: Mon,  1 Dec 2025 14:02:01 -0800
Message-ID: <20251201220421.207285-4-stephen@networkplumber.org>
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

Make setting up --file-prefix arg logic into a function,
and avoid impossible case of file prefix path causing overflow
of string.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/process.h        |   8 +--
 app/test/test_eal_flags.c | 107 ++++++++------------------------------
 2 files changed, 25 insertions(+), 90 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index 251262d948..775fb9e881 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -213,14 +213,10 @@ file_prefix_arg(void)
 static inline char *
 get_current_prefix(char *prefix, int size)
 {
-	char path[64];
 	char buf[PATH_MAX];
 
-	/* get file for config (fd is always 3) */
-	snprintf(path, sizeof(path), "/proc/self/fd/%d", 3);
-
-	/* return NULL on error */
-	if (readlink(path, buf, sizeof(buf)) == -1)
+	/* get file for config (fd is always 3) return NULL on error */
+	if (readlink("/proc/self/fd/3", buf, sizeof(buf)) == -1)
 		return NULL;
 
 	/*
diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..c3723ee0b8 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -121,6 +121,8 @@ test_misc_flags(void)
 #define no_shconf "--no-shconf"
 #define allow "--allow"
 #define vdev "--vdev"
+#define file_prefix "--file-prefix"
+
 #define memtest "memtest"
 #define memtest1 "memtest1"
 #define memtest2 "memtest2"
@@ -320,18 +322,10 @@ get_number_of_sockets(void)
 static int
 test_allow_flag(void)
 {
-	unsigned i;
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	unsigned int i;
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *wlinval[][7] = {
 		{prgname, prefix, mp_flag,
@@ -387,17 +381,9 @@ test_allow_flag(void)
 static int
 test_invalid_b_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *blinval[][5] = {
 		{prgname, prefix, mp_flag, "-b", "error"},
@@ -491,17 +477,9 @@ test_invalid_vdev_flag(void)
 static int
 test_invalid_r_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *rinval[][5] = {
 			{prgname, prefix, mp_flag, "-r", "error"},
@@ -535,17 +513,9 @@ test_invalid_r_flag(void)
 static int
 test_missing_c_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -c flag but no coremask value */
 	const char *argv1[] = { prgname, prefix, mp_flag, "-c"};
@@ -694,17 +664,9 @@ test_missing_c_flag(void)
 static int
 test_main_lcore_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char *prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	if (!rte_lcore_is_enabled(0) || !rte_lcore_is_enabled(1))
 		return TEST_SKIPPED;
@@ -751,17 +713,9 @@ test_main_lcore_flag(void)
 static int
 test_invalid_n_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -n flag but no value */
 	const char *argv1[] = { prgname, prefix, no_huge, no_shconf,
@@ -803,18 +757,12 @@ test_invalid_n_flag(void)
 static int
 test_no_hpet_flag(void)
 {
-	char prefix[PATH_MAX] = "";
-
 #ifdef RTE_EXEC_ENV_FREEBSD
 	return 0;
 #else
-	char tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* With --no-hpet */
 	const char *argv1[] = {prgname, prefix, mp_flag, no_hpet};
@@ -829,6 +777,7 @@ test_no_hpet_flag(void)
 		printf("Error - process did not run ok without --no-hpet flag\n");
 		return -1;
 	}
+#
 	return 0;
 }
 
@@ -898,6 +847,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
+#endif
 	return 0;
 }
 
@@ -913,17 +863,14 @@ test_misc_flags(void)
 	const char * prefix = "";
 	const char * nosh_prefix = "";
 #else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
+	const char *prefix = file_prefix_arg();
 	const char * nosh_prefix = "--file-prefix=noshconf";
 	FILE * hugedir_handle = NULL;
 	char line[PATH_MAX] = {0};
 	unsigned i, isempty = 1;
 
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 
 	/*
 	 * get first valid hugepage path
@@ -1525,17 +1472,9 @@ populate_socket_mem_param(int num_sockets, const char *mem,
 static int
 test_memory_flags(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* valid -m flag and mp flag */
 	const char *argv0[] = {prgname, prefix, mp_flag,
-- 
2.51.0

