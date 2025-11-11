Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673CCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D71A240670;
	Tue, 11 Nov 2025 23:19:09 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id E10B640655
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:06 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-bb7799edea8so138271a12.3
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899546;
 x=1763504346; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPw2bQ3hNYz9p6I4jbY6EaFT9twwQAPSJaibV3CN74A=;
 b=bN1qkT203wDrXAkAKo/Hc7sFstAa7lnczKAJWMQjgagB/pAwtpOdEOtS4sxjdD0OQc
 hHyjmEohlrekLJS9HEhD1YUks1LeLpHczrALhX4tz+CD0/QsJ/wgrsGInl4DY25/MviA
 qisDNU3gRiIyaTeMRJ1M0wgrDb8JgXtrZHFyqkXtyeffta/ZrU5RSggQWHsWZDvIQTmM
 I5AKkE5xiGNUlGIHq1BCk7MK1BbGdVGnq9r6YTYhc1gnv7sKuWrcO8FVc4mhrB8pyP3o
 chA7Phv8vlWbjT/rU/4+1HooWEz0xPU6JiE5LgqLF8JKnGLFhDWJwKkKV3oUry4Zh0ZK
 G8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899546; x=1763504346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lPw2bQ3hNYz9p6I4jbY6EaFT9twwQAPSJaibV3CN74A=;
 b=ClQ0BQCPrlj9KJHI1ym0RErQ0ybNyJ7d/8MNKSoR664js4cFbV7KKYV9KCpczytzvq
 LN6fpnMs9yVCcUXUIOSJXUzkuPfhX15povWKhcWCl3X41covm1WIAdY8546mplMUoc1o
 C8j4xf8MZ6HKUPmVBqJxrhCrfsEYyM4tRDj3auUcV/TFcxwib7JS4BrSCUtsk7qBFEDF
 1uPb1NOrJl46ziBGNgr1HXVzI8Vla3ZMUMMAtl11RNlkryvIfoY9W4tLHjtQurW0iRWs
 UHooW+DxyS5piAe5QldlUjSUSEpM8c6jhoRi8giMZKgB6JikyAZqQgQn9cOwHIx5Thcq
 34tw==
X-Gm-Message-State: AOJu0YzYQdmyE1WMTrtZyzWty0m1g9E8mNmnzBdskjemT0AR+R+qlVjQ
 SaAnPyKKP5Qdzklb93ngGBw3Gn3QG/MT3O2OC5xhRYt8ic98bpY0Xnyhlqnj5Nu1kYgLCD+r5du
 qtTkw
X-Gm-Gg: ASbGncuSBn3ACfL0V37qZ1Wi+4tIqBCG/wo9lwYs0z0BJaoFaob6emgIJwjLZBIDtZe
 QHi1bnMSYCcYQaSzUzaw/gPnAjsHMfeQdYjgJQ0n+HR4EaoV1VX0qHcm9A2F2zynbptVuoROikx
 +qUow+e4iQRP2vL6+jiGhvr8lVAyENXjau9yQ/G4YPbTyml/E/74OrpbN8zCoHbXN7aQIeU+mFy
 kuq/lCrgc7DNeWIJFlhvkaSe4mcBTtquq/jCDPlrTRgISTfO7TboU+pCEjK3dN4wmyHlR6MRrH3
 1VQajPCj98fcnYA6hkwd9Pfj2N/25XJ97MUC8X9hOoq4bZw4yEFv2t+hSkVKZkX6aoiultMEIvD
 sdWd9it0vDCdwQQrv7Gfy/7RwrpoC5RHQ3A3k/C/DeE39yy/RuBXVxoZ0d3rs3sJSHfhFBL4ItN
 /hKraGAqLLYc/16eJuFEP38e7rDu57HC8P2EV6hpmckBqKtF7Itg==
X-Google-Smtp-Source: AGHT+IFy/h7cpbG6LKKrEYhsdinrYWQGB+vN8KzIjY/jX8eJVtoBogB+TRw7IhK4oUi24OfifPmM9Q==
X-Received: by 2002:a17:90b:4c50:b0:343:5f43:9359 with SMTP id
 98e67ed59e1d1-343ddeaf708mr901232a91.31.1762899546032; 
 Tue, 11 Nov 2025 14:19:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:19:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 5/7] test: refactor file prefix arg handling
Date: Tue, 11 Nov 2025 14:17:22 -0800
Message-ID: <20251111221857.443752-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111221857.443752-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 161 ++++++++++++++------------------------
 1 file changed, 59 insertions(+), 102 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..05b4135a51 100644
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
@@ -312,26 +314,40 @@ get_number_of_sockets(void)
 }
 #endif
 
-/*
- * Test that the app doesn't run with invalid allow option.
- * Final tests ensures it does run with valid options as sanity check (one
- * test for with Domain+BDF, second for just with BDF)
- */
+/* Get the file_prefix xommand line argument */
 static int
-test_allow_flag(void)
+get_file_prefix(char *prefix, size_t size)
 {
-	unsigned i;
 #ifdef RTE_EXEC_ENV_FREEBSD
 	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
+	RTE_SET_USED(len);
+	*prefix = 0;
+	return 0;
 #else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
+	char tmp[PATH_MAX];
+
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
 		printf("Error - unable to get current prefix!\n");
 		return -1;
 	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
+	snprintf(prefix, size, "%s=%s", file_prefix, tmp);
+	return 0;
 #endif
+}
+
+/*
+ * Test that the app doesn't run with invalid allow option.
+ * Final tests ensures it does run with valid options as sanity check (one
+ * test for with Domain+BDF, second for just with BDF)
+ */
+static int
+test_allow_flag(void)
+{
+	unsigned i;
+	char prefix[PATH_MAX + sizeof(file_prefix)];
+
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	const char *wlinval[][7] = {
 		{prgname, prefix, mp_flag,
@@ -387,17 +403,10 @@ test_allow_flag(void)
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
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
+	char prefix[PATH_MAX + sizeof(file_prefix)];
+
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	const char *blinval[][5] = {
 		{prgname, prefix, mp_flag, "-b", "error"},
@@ -491,17 +500,10 @@ test_invalid_vdev_flag(void)
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
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
+	char prefix[PATH_MAX + sizeof(file_prefix)];
+
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	const char *rinval[][5] = {
 			{prgname, prefix, mp_flag, "-r", "error"},
@@ -535,17 +537,10 @@ test_invalid_r_flag(void)
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
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
+	char prefix[PATH_MAX + sizeof(file_prefix)];
+
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	/* -c flag but no coremask value */
 	const char *argv1[] = { prgname, prefix, mp_flag, "-c"};
@@ -694,17 +689,10 @@ test_missing_c_flag(void)
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
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
+	char prefix[PATH_MAX + sizeof(file_prefix)];
+
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	if (!rte_lcore_is_enabled(0) || !rte_lcore_is_enabled(1))
 		return TEST_SKIPPED;
@@ -751,17 +739,10 @@ test_main_lcore_flag(void)
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
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
+	char prefix[PATH_MAX + sizeof(file_prefix)];
+
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	/* -n flag but no value */
 	const char *argv1[] = { prgname, prefix, no_huge, no_shconf,
@@ -803,18 +784,10 @@ test_invalid_n_flag(void)
 static int
 test_no_hpet_flag(void)
 {
-	char prefix[PATH_MAX] = "";
+	char prefix[PATH_MAX + sizeof(file_prefix)];
 
-#ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
-#else
-	char tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	/* With --no-hpet */
 	const char *argv1[] = {prgname, prefix, mp_flag, no_hpet};
@@ -913,17 +886,14 @@ test_misc_flags(void)
 	const char * prefix = "";
 	const char * nosh_prefix = "";
 #else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
+	char prefix[PATH_MAX + sizeof(file_prefix)];
 	const char * nosh_prefix = "--file-prefix=noshconf";
 	FILE * hugedir_handle = NULL;
 	char line[PATH_MAX] = {0};
 	unsigned i, isempty = 1;
 
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	/*
 	 * get first valid hugepage path
@@ -1239,16 +1209,10 @@ test_file_prefix(void)
 	 *    run in legacy mode, and not present at all after run in default
 	 *    mem mode
 	 */
-	char prefix[PATH_MAX] = "";
+	char prefix[PATH_MAX + sizeof(file_prefix)];
 
-#ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
-#else
-	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
-		return -1;
-	}
-#endif
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	/* this should fail unless the test itself is run with "memtest" prefix */
 	const char *argv0[] = {prgname, mp_flag, "-m",
@@ -1525,17 +1489,10 @@ populate_socket_mem_param(int num_sockets, const char *mem,
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
-		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
+	char prefix[PATH_MAX + sizeof(file_prefix)];
+
+	if (get_file_prefix(prefix, sizeof(prefix)) != 0)
+		return TEST_FAILED;
 
 	/* valid -m flag and mp flag */
 	const char *argv0[] = {prgname, prefix, mp_flag,
-- 
2.51.0

