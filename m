Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA333E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B75B40650;
	Mon, 29 Dec 2025 23:01:05 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id DBC104025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:03 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b728a43e410so1787894566b.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045663;
 x=1767650463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8H9qvBXDj7hWyPBelWPgigyfjM7mPo1x6qowGFbj0M=;
 b=qg57TbjXEWi5596Hc7H21D5eaK6DYcEoFY87wtGj5Pq0JBiDPvbF1197wciOyeuM00
 1IecbfScIUCuyZ+ye8s68DC5NJD949TkA3IIHv5yhTctCrCKD7KZa/lTENsjw1UNlaIS
 8CDohWFd+I4ytU41Bpx2iFvsG8vJ9dvv3D6BllH5s3kDDBw8v0mglWFDRGA2WJafl9Vd
 w6bDZ879kjqvepYe5r2XA/6Vv6jmCV1/A09W5sKWZlq4HddPLWzDaqJv3Gxqv7krPfsa
 A4gBM1jE63mYzMAMI4XfJJ+ByrR7KFzYC44eIykgUXAs3r8VyftE+e/ymKLCrk9NjT9N
 vp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045663; x=1767650463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g8H9qvBXDj7hWyPBelWPgigyfjM7mPo1x6qowGFbj0M=;
 b=MWR8JEheB5KU3VJumOr3T5q0x6bk9EP5Z1P97K/8ClsOHc14jcxc+uHhdIU+23g0tI
 +ZLA21uYNISyYNNJYnvXPhz3WBtv/lnpJnRZmc41Dw93di/3nVhdrkGAMTyvX6qPYqIJ
 W8NwhlKcmfO3BS18q/bxQraXS9072k2nCOSh+0sj3pVNPheyoQ53moMtSv9/rjq943L5
 fMyAKesh3Z6TiF32aKJKuNTzG+fVVDw8ydSB2XAThDOLq5cQ/eV783Vdg1ILtj41OcbI
 ZhMtWK+rcVSWQdMHEOkLJ+oyiL3whydin4leyTqM6Fd96DJDqXO9+fdFYTzcMILRTGWz
 0o0Q==
X-Gm-Message-State: AOJu0YzIsTgfTYvuyf2hzs7a6PhJGc4nFJUBlcc1QO4Wx+J3v5wmOIGm
 +r8WJ/7JWfHow4tiu2CZ9Q1qoS8Bt5Vh6I9oT17SUhvRCehFyj/kEGPQabn80Q4vsAc2lfX+xEj
 0s5uiCS8=
X-Gm-Gg: AY/fxX4fUjQYjRaALwC2Wb/MR2v/3ApXQS7UxROMpV6Xr6VqmdWzF/IelytRV7k6eqm
 w/1X7brVnFilfkWg5b2z7Lt1uNhekRWip4iq1f1e/TqGGA5Q1rT0gV15WqUttN811jxa4ZGFN/3
 6zToXYbClEZbn1MXVJo104Mbc13602f5ruAKnUFnf4irr3SZnHJHqKJHeTH3bPLTUapAS/wrWAy
 pPXkpPqQ+FVtOXevv4BOO9xAl7UN/WET21JNxAqQXbqoCk2LHNN7v7QzzX+MGIBbF6emT310PQJ
 pWER/3OLXpeGNpD8+jVZm0Kzzdh8pVPK58OiiSBSaUI7/0jvBhOyjol2Azo9uE6lq9c9rxBWqNA
 lcytO0e2jJYjzWDswIAoBZkSNiPmfyLgvsgCMSpbLYj84ldPUxejJb/G3wwgzRG8U31yPe/mVM+
 L0BzdsfPbmYSXxdi6c2CZtrgDoyDzFVyK2KsfXFiMrnFu0ZtEI2Fbh9b3SYziH
X-Google-Smtp-Source: AGHT+IFet0k/pJvCoi3XQGv4uJBlypc+SKB4pq+vgBD4dq/72TTxGBmS3pD//RPkGDLucdxlYr/P2Q==
X-Received: by 2002:a17:907:d2a:b0:b73:3e15:a370 with SMTP id
 a640c23a62f3a-b80371d6c20mr3791352066b.57.1767045663251; 
 Mon, 29 Dec 2025 14:01:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 3/9] test: refactor file prefix arg handling
Date: Mon, 29 Dec 2025 13:59:03 -0800
Message-ID: <20251229220053.21981-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 132 ++++++++++----------------------------
 2 files changed, 37 insertions(+), 103 deletions(-)

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
index e32f83d3c8..12cf123e81 100644
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
@@ -830,6 +778,7 @@ test_no_hpet_flag(void)
 		return -1;
 	}
 	return 0;
+#endif
 }
 
 /*
@@ -853,6 +802,18 @@ test_no_huge_flag(void)
 	const char *argv2[] = {prgname, prefix, no_huge,
 			"-m", DEFAULT_MEM_SIZE};
 
+	if (launch_proc(argv1) != 0) {
+		printf("Error - process did not run ok with --no-huge flag\n");
+		return -1;
+	}
+	if (launch_proc(argv2) != 0) {
+		printf("Error - process did not run ok with --no-huge and -m flags\n");
+		return -1;
+	}
+#ifdef RTE_EXEC_ENV_FREEBSD
+	/* no other tests are applicable to FreeBSD */
+	return 0;
+#else
 	/* With --no-huge and --socket-mem */
 	const char *argv3[] = {prgname, prefix, no_huge,
 			"--socket-mem=" DEFAULT_MEM_SIZE};
@@ -867,19 +828,6 @@ test_no_huge_flag(void)
 	const char * const argv6[] = {prgname, prefix, no_huge,
 			"--huge-worker-stack=512"};
 
-	if (launch_proc(argv1) != 0) {
-		printf("Error - process did not run ok with --no-huge flag\n");
-		return -1;
-	}
-	if (launch_proc(argv2) != 0) {
-		printf("Error - process did not run ok with --no-huge and -m flags\n");
-		return -1;
-	}
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* no other tests are applicable to FreeBSD */
-	return 0;
-#endif
-
 	if (launch_proc(argv3) == 0) {
 		printf("Error - process run ok with --no-huge and --socket-mem "
 				"flags\n");
@@ -898,6 +846,7 @@ test_no_huge_flag(void)
 		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
 		return -1;
 	}
+#endif
 	return 0;
 }
 
@@ -913,17 +862,14 @@ test_misc_flags(void)
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
@@ -1525,17 +1471,9 @@ populate_socket_mem_param(int num_sockets, const char *mem,
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

