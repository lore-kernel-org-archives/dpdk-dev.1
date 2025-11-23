Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424B3CFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57A44402E9;
	Sun, 23 Nov 2025 18:45:21 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id F1929400D7
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:07 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-299d40b0845so59004785ad.3
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919907;
 x=1764524707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CefcNYnobekhEYOU6KHsh/TgSBsiP33nUIdjH1rdj7E=;
 b=Th2cLpxJphWZ6hwzXUfWrhw7N1Ax4R8gPEAAa2bGz9xQnGPRkf0bTdZwarCrOm9zZP
 G5JIw8uca29z9uuMOhViFt5jYBws3D5jLvznHwfdf2VM70eMScqYkCjq9oxuXHvlUDYO
 LN308RmaZlrvUkUoglxvmgoyieN0z2bw44TAX22ZR22deNGWJz6ierMm09s6Iy6iOYvB
 33qcxJdMkfPqImOECYrtPnEScrw1vcBI9JrfxofB+w3ySaBehC5oRCi4ZL41RIwSpgHq
 KvjXsK/4ZOFooWGehoA4KLSHDgWRpjY+VbCwksV3oTiLJ2sPhKJi19oY3Fi8i32NDj9R
 t7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919907; x=1764524707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CefcNYnobekhEYOU6KHsh/TgSBsiP33nUIdjH1rdj7E=;
 b=uFEZvG8od1OMzQ2RRMf0RuqAnpsk/O6oSYd3vGHRe178K5u4JTOzXJ6kI5AbNWOJLf
 O8G17KyPu1P1o8R7TmQRGWnh7bVsCpZJSDzjjn6VefEPDGfc3Tn8XZl+yXLVadITkSTd
 Sp87BOyhpR9QiNKaLEEE3c6Rz+gRzdk9ewWRcLnjyNDYXcR6nzuPv5xC6Ka4jLfFyKgv
 +HW3Ym3h3iXhmqK10FzJge5+a8fNMjWmMKA/kfwhWDzrumTWSX5oyCvCDLPyA2+/47wO
 /Kybf0hpyzihEGUDH81hmym417VdTji97R8z74h/zPafofK0lXjWQrFdqotq/HZlzz8f
 rr/w==
X-Gm-Message-State: AOJu0Ywsy60MGv7LOQWCjs/omxg/hfy1HGzgJfUXgutMGcL3hu/YYydF
 /I2VLEE4kI6UN+6CWRcEX0Khaop9HyvH55ZJFjbjSB3Ttxa0FF9WnqjL6DFlfz9LiNeynr6+WN7
 J0s83
X-Gm-Gg: ASbGnctbrdjGo/o7BjTDi/51QJyHbW9h7/lYjpLFoFPZPbv2zjTcR31GzSaNjEw9FSH
 6vhaArQVay8J122Rj6Q68gDFHp6smKjlmHwmEa/iKnCbdJyvhWYC8jCsDCdhWGZudEUAzV7aAyv
 rHu/aT/zo5iBFgVEqgzbi5w8QxBNuxvjLJahQQw1S6kxu+h8EKN+8WmAqt1Z1ZW0QEB3SBBJ4KH
 b/zWg/e2FFaqhhgXnuGLdqlsh6BK2Ji+1Xy8geAF/a+fNxP74CvgYCdfdibHtG8ntnGACFMcnLU
 FPhjdofMef1o658hv3QyE70M4iV0FKW9RxNf7BeWdFHnnbXQWLRhaw0tKrkpT9w6P2tDY7GyKwT
 1c9FYCtCGpN9p9c8PJyXLdXex5wdjT+GMW0na4kEzpBt3qmiMMSNOqbhTy2dBfx5BGi0FlTTsTI
 c7sMDZNwcElBRD2Xj/+Msjd1gcmKNuweDZgj5ZIZ56LuDuk3f+Ow==
X-Google-Smtp-Source: AGHT+IGNddoZVZC2f/NTEI7Ri5x7VYXx8wE+Kn8gJUJjFzyWbPievZ0VX1ISVr09aE1t+/nXmH3Nog==
X-Received: by 2002:a17:903:1a83:b0:295:888e:d204 with SMTP id
 d9443c01a7336-29b6bf73815mr98812445ad.57.1763919907140; 
 Sun, 23 Nov 2025 09:45:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 2/9] test: refactor file prefix arg handling
Date: Sun, 23 Nov 2025 09:43:25 -0800
Message-ID: <20251123174503.20880-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
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

