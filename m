Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE78CCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:53:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31AC7402A7;
	Mon, 17 Nov 2025 18:53:41 +0100 (CET)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id DBF14402AA
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:53:38 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-bb2447d11ceso2675073a12.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402018;
 x=1764006818; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CefcNYnobekhEYOU6KHsh/TgSBsiP33nUIdjH1rdj7E=;
 b=PNikKYT/90tGl2UaYlUpN6GLkJ0J/6YKDnvmFz+M/oKSyWj2K8zPWECx9qiamPEpcE
 qVza/ljqcejP3EwHLXS4/5b9W1+Dj7BjUgh/UuCUFfTsQmHQKYcob6Cnn6mc5P4kQfpu
 JAMO7sjN5ZtXwzD27n1ueXnGLEv/HJMcsU+xHKY1xkeEI39zfbT+KYrq+Xsum/Q4knb7
 3+EbJTEWVIBxx8VNjnItWBV5WBK1u1g06JfLLwQwIZhA1PjmzBJIZeSLD0gnvyufOuv0
 NrGSepcFDsKHV09Ee+7Faj+INW9ecfhzUWuEpeI+4nJckv3t6VkCODytvB+rSurAH1WC
 UBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402018; x=1764006818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CefcNYnobekhEYOU6KHsh/TgSBsiP33nUIdjH1rdj7E=;
 b=bKzOQEHR4jKNTBYMsduWpIBFCUuLc5PMqM1pXIssLz4SFbtzT9CBRZAPS/6+Vbsrp7
 llMV3hPRbgjmQvUkJ2w8/X61NwUPoNAUQfO2V/ZEHIN1uAY0Jj6XdIxynbZ4NRCJmZF7
 BfRhWfhk7jBDBeX5nilvs2t15thj7ZBTn5KuNN8xW2FXk512WUSuQuxmH1edE9z++j1V
 khyQcyOdIFAztdgHHZ7mDYYnJFFQHSGiPcZPu1xLAL5kFxNxx2MtxGeEpl1b7wFl5MT1
 kVPQgf/rUDa5i8iwMa29hTanUaIUMT7rSw5ytXxyylWF3cWc9mP2OHRFrEK0HTxf0MP4
 RfJA==
X-Gm-Message-State: AOJu0YzYHwJ/Ip0QB+qN81HZiM9WuahzZaQMhCMBmHcU8p+NwHRpsW7B
 MPuhVHWg8oAh8cciCqD7Ga8bbEaac4d8fIW96Hn75+SxcR3d07+19H2R4CHJBwG06I7Y4sSDP2V
 QiyLn
X-Gm-Gg: ASbGncs0f8/6JyCw4XCa1ZB5SlxI9RuNLeKstPyHjx5kiFVdFN7x/OrTGk7AiQQHfLx
 tn1xGzFzaCjFj3O05q0EDy/2V6tlqflqEw3FaJjBqxl/7tfWvL+/CI/tJSyuyz8zDixFe93oAZo
 AB6wLxSUKnIKadnD+qAbmyVC9db2BsxsKq1LeOIfNBzx9ZTNXOEHD9YRJNhbEClIDQkACvIQ+g7
 D4qJm66JW55oimsMZsiy6uGPtZOgeb8ucknPb6A3+5DYYW6itYANvn8O6K0a01LzPPIqWiPN5dt
 dRLaEANlMh9LgLzWPP6bODkEHZ2oKBqOFpwQTkHqFuF4cLQbLBImM4E7LQ3gkpLrfJMhRWpytgE
 d7eoqjzX9MMWZpO1kD61GGzVRAbk1GWoBOU/Ww+jCatax9L+tl5SvIMUNotMhuxc4nDLEPB2L9g
 P9VE032U5dv3kCSNRyFaHZ0siA6b7xFqTBFNhFfrcqkCfhiqQzZJmbm26TgNbm
X-Google-Smtp-Source: AGHT+IEgwzHHkq+sKAQlH7V0kbIAIW17uULJfBn1f1hwKRxUtTNNRjAspJUpJPq21n8/crKVi6lbZg==
X-Received: by 2002:a05:7300:51c2:b0:2a4:874c:ba92 with SMTP id
 5a478bee46e88-2a4abd77306mr4954790eec.36.1763402017878; 
 Mon, 17 Nov 2025 09:53:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d9ead79sm63457494eec.1.2025.11.17.09.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:53:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 2/6] test: refactor file prefix arg handling
Date: Mon, 17 Nov 2025 09:52:09 -0800
Message-ID: <20251117175332.14014-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117175332.14014-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
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

