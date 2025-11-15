Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C19CEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0515140E21;
	Sat, 15 Nov 2025 20:34:19 +0100 (CET)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id F0FB5410E6
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:34:16 +0100 (CET)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7ba49f92362so1916955b3a.1
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235256;
 x=1763840056; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geNB80bwPZKwod0ZvzJJiEPWjrC8Gr8Jh0d9jHdGOsY=;
 b=P3jSyUXQWibrJLd5u0k7H+GcGLMUSyU1fmeMHbSih/GGcZGMRyRXxCAn5H8R48CeHG
 ICidY8XVJcFmB13HiFGVHPwanPZeIIGQ4EFpRw4Gr2yLZFmLSEZUrygHqdgKlkZNSX+x
 KyDqMPhkpkOWZEc5OUX071TrqonH94nJc+yRx6zwfg7FAJZxnlBskzs4crYD3v1h9ZMk
 N1wOzrjcp2PeSzF+L1JdwGq7FfWFnE5oJhcgUYWVFzclEqNdXgh23JV6dg59CGD1Wdww
 2IupBcOokDUcDUsd4JNoW36txul/lJ8pTO5mQ24VYbRGX+/R5sr4L9FmbpGrgGH+5xD6
 kJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235256; x=1763840056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=geNB80bwPZKwod0ZvzJJiEPWjrC8Gr8Jh0d9jHdGOsY=;
 b=xDTKmO6tK8vHqEOwMnuw6RywYqOUTFl8P8DKx3NjrajWZlM+nyfen9gv1j+aDIFG1C
 5Rz3zExRtRkX5xAvJfitpW1ko4r6dCIXp5hITAnXMRrBoO+RITJhj9sgGopqRZdUKzMz
 T/s738BQMrgsR0/TDU6fIkw7fvHOEHJ8ZwJ/Zu8cK4ViYIKgPKB5azn5xlzlpx8haLuS
 xVOWVF1MMFwE8kuquqUtEEF1rsq66ygOSkJ1ucaJlaYmDCaAMp7OYkLXUZbZi2f8uFwu
 rofv47l2tFFHy/MeNP8z0EjnPb/e86eT5b+W8bSvrF1xzxULjJpviRkKWkl0NfUwRSMf
 SAQA==
X-Gm-Message-State: AOJu0YyitucvGhICbkewuBJZ3dEY4yE+xXJfp49I5JE/+lh+Ukf75VN2
 gHIIwFBAJa86oeTw3BzDBFFt8pPnINi02csbBSMHQpBXpYNi94ajGcF8E7wHw/YRQN7zGNQUTEt
 /ivKm
X-Gm-Gg: ASbGncvEb20UxlCzVVeAM8k6FnNGe2+m8Zx2C/9dFAJqrU5Z6er2+/0Nassyv7+T3sV
 q4QpMCgLnTjQB0UHQn9TmKYdhRxSQCTMHmWlV2y4OBT+CgZSiHu/pGBqv6tqfwfBz4dGZ0Krdjy
 Tg99Wod5zteq+1rK4hKT0jZ0Rdqlm+2zMOoWYicPyYWC2dRhICpwmp/wdptQNpXWVOcU9SfzZsG
 4LkLTURBZWdDCGYi4nfx/XmTGIu+35sX39ObsF2wdY2t3Px0cST73zpx5ntY652mTBB1bOMSnEX
 Rj7pZ7ajyjj+bcZwBejNgppkPjkTg8oUp5eqRW10lrivvbnKNyHLUxkQim2M0izw3XBO8wgIi0y
 7wppMoGZVydpevXYvJ6lBJnwM7fa0ISpboq8hEjKmGIlCAs4jpUd/o5iuuBV0PzSQxxjjw7Eocs
 X6izCOzKN1QaFqhcf185qmbpNPYZQy/RZHzcP72Rlb1yqELrz2AQ==
X-Google-Smtp-Source: AGHT+IEUjiEqOgk44kyWSWnKCY659zVk7NrXr+irwc/NjEJ853Tzw5asSUmh1TlhOMhiSKgXZHU6bQ==
X-Received: by 2002:a05:7022:6b85:b0:11a:515c:e891 with SMTP id
 a92af1059eb24-11b02b653eemr2995684c88.0.1763235255887; 
 Sat, 15 Nov 2025 11:34:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088604sm26588644c88.7.2025.11.15.11.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:34:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH 3/4] test: refactor file prefix arg handling
Date: Sat, 15 Nov 2025 11:33:09 -0800
Message-ID: <20251115193409.99740-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193409.99740-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 123 +++++++++++++-------------------------
 1 file changed, 40 insertions(+), 83 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..0eead2a422 100644
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
@@ -803,17 +776,12 @@ test_invalid_n_flag(void)
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
 #endif
 
 	/* With --no-hpet */
@@ -913,17 +881,14 @@ test_misc_flags(void)
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
@@ -1525,17 +1490,9 @@ populate_socket_mem_param(int num_sockets, const char *mem,
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

