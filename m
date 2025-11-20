Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB0CF9C4D
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4461402E8;
	Thu, 20 Nov 2025 17:57:20 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4A8D940262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:18 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7aa9be9f03aso915039b3a.2
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657837;
 x=1764262637; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CefcNYnobekhEYOU6KHsh/TgSBsiP33nUIdjH1rdj7E=;
 b=XEUQxlVjhxeh72gmAjf97zaQVtQCcRUz1okfHk2shbzX5hnhB9lTgMbVvGfAdIwbQU
 8w/p0EmY11BifKVsbkwcyTgPIN+fMEvpC0gQ4nFx8D/VoIEqq3Si9Q/TW01DXQfbn9Gz
 /PTBVPev7hI2FS9EkbFineHaYDw5CRfYE9KSyqx5zG+PYQOeh4PWqDV6N/V74xZI02Xq
 UNDmTJfqKm+HjsEuKKl8Xpk80KYY0cqQDFDebDw91LfetfFZAQn2WkCq/J8nOpKfm7N9
 R02ZgXudsBupmGLlzG3IVI2zBopY3kgjkwjUh0WAEMiP2wpMqYGrB8gy53NTT4Yp7Nk9
 /y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657837; x=1764262637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CefcNYnobekhEYOU6KHsh/TgSBsiP33nUIdjH1rdj7E=;
 b=QqN0YBlYUnuBSLGohSS2YNvrr50w50RtUdZDpZqd5kZd55C/jvjrzj0J8R54QqQ6Ne
 pbCKPQq0Nkrmz0dkPfNRN5FXF0lxw/b6g7+XxRchZkDF3ChxNyDEeRl0URoNqZTAozvA
 W+yTb8UEkUl/Ic2NifvMBcCsRpFWJEzkVj+GL+qMkfEsxHwQgk0X6HEUpfCqbcfd6ifR
 WamZr7Bi6lXVJdvf7+GtD/rNTtbI7X4ZEEpS34cnwUJtcMRjZE9fhS7WNyytb1q8PEtU
 ooWCJhR2KluTAJa/Vj1WekPhNrn2UREEG2tCdrLBlLxXGfsi1r3okX4A0bNZux5yRuLj
 i4qg==
X-Gm-Message-State: AOJu0YznMfBGO9Q/WZH6Q4cKF1epcuqiINlWr9S9aGs4KtItOEh+/HHa
 +A/YZAi8UQfFul1T3/jkk5rS0D/CcdEua3PBhK4AxJrfekZyIADTEFnYMemePczOXyJgUPAinNn
 OC4m9
X-Gm-Gg: ASbGncsSpXq74UjycD038hF8uQ6TRDLc9ng6M/kR3Me6nhNTHG/w5zrjjBEX+f9TxAN
 8ZYN2l/VZylHig6f6BmvgeX4wMJTTRfBMArwntjke2xbv7nySWj3pZ1fGini6pV+stgqUyOBFdS
 LPrnYPp0m8ONQB0W3cfjXWvU8B2EzZTOrTBBprFf+IxjVPbR4IeA+1J6YzD7xPzqGDCgtkXqonr
 UPIvRtGQ/NYoyA/YWjW0tZPt4Yj0PRw0Y9zI+jLLteTECZ5EsLluWmuNeLCcyNkwzLY0y4WSeRI
 XJnuLCOxGr31U9EJmaa+fs6sQF/JTyqO0/X7q0K41bxSXNru2m7lpw96sk8ZmDPWhEEGhUmZdIi
 9PuWJP5g8mcu4efQAG+Jv7ZH45+hp5gwW3oeJYQ+V3zfFl9fLvw8ShCBKcuegbmSvJYY5Objtv+
 KZWh3nTeE9IOHXWnCBzdGwBHFxTECXMdXfvb1waYsJBABR7dopkQ==
X-Google-Smtp-Source: AGHT+IH4nRyNDy4lcvJHVA+HO0Xqe9fhteH/I64Bf3FgFwPNjCooITgfd4tG8tcQU/n03WsUd8lu8A==
X-Received: by 2002:a05:7022:a8b:b0:11b:e21e:5653 with SMTP id
 a92af1059eb24-11c9383093cmr1309651c88.19.1763657837227; 
 Thu, 20 Nov 2025 08:57:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 2/8] test: refactor file prefix arg handling
Date: Thu, 20 Nov 2025 08:55:30 -0800
Message-ID: <20251120165713.120238-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120165713.120238-1-stephen@networkplumber.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 126 +++++++++++++-------------------------
 1 file changed, 42 insertions(+), 84 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..c2e6c00edb 100644
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
@@ -312,6 +314,25 @@ get_number_of_sockets(void)
 }
 #endif
 
+static const char *
+get_file_prefix(void)
+{
+#ifdef RTE_EXEC_ENV_FREEBSD
+	/* BSD target doesn't support prefixes at this point */
+	return "";
+#else
+	static char prefix[PATH_MAX + sizeof(file_prefix)];
+	char tmp[PATH_MAX];
+
+	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
+		printf("Error - unable to get current prefix!\n");
+		return NULL;
+	}
+	snprintf(prefix, sizeof(prefix), file_prefix "=%s", tmp);
+	return prefix;
+#endif
+}
+
 /*
  * Test that the app doesn't run with invalid allow option.
  * Final tests ensures it does run with valid options as sanity check (one
@@ -320,18 +341,10 @@ get_number_of_sockets(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *wlinval[][7] = {
 		{prgname, prefix, mp_flag,
@@ -387,17 +400,9 @@ test_allow_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *blinval[][5] = {
 		{prgname, prefix, mp_flag, "-b", "error"},
@@ -491,17 +496,9 @@ test_invalid_vdev_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *rinval[][5] = {
 			{prgname, prefix, mp_flag, "-r", "error"},
@@ -535,17 +532,9 @@ test_invalid_r_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -c flag but no coremask value */
 	const char *argv1[] = { prgname, prefix, mp_flag, "-c"};
@@ -694,17 +683,9 @@ test_missing_c_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	if (!rte_lcore_is_enabled(0) || !rte_lcore_is_enabled(1))
 		return TEST_SKIPPED;
@@ -751,17 +732,9 @@ test_main_lcore_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -n flag but no value */
 	const char *argv1[] = { prgname, prefix, no_huge, no_shconf,
@@ -803,18 +776,12 @@ test_invalid_n_flag(void)
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* With --no-hpet */
 	const char *argv1[] = {prgname, prefix, mp_flag, no_hpet};
@@ -829,6 +796,7 @@ test_no_hpet_flag(void)
 		printf("Error - process did not run ok without --no-hpet flag\n");
 		return -1;
 	}
+#
 	return 0;
 }
 
@@ -898,6 +866,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
+#endif
 	return 0;
 }
 
@@ -913,17 +882,14 @@ test_misc_flags(void)
 	const char * prefix = "";
 	const char * nosh_prefix = "";
 #else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
+	const char *prefix = get_file_prefix();
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
@@ -1525,17 +1491,9 @@ populate_socket_mem_param(int num_sockets, const char *mem,
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
+	const char *prefix = get_file_prefix();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* valid -m flag and mp flag */
 	const char *argv0[] = {prgname, prefix, mp_flag,
-- 
2.51.0

