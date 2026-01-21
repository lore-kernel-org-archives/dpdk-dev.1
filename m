Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E218C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:08:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EEBC42E76;
	Wed, 21 Jan 2026 22:08:20 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 5436842E74
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:19 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so2993805e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029699;
 x=1769634499; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCnXj4ZdgD4tbfAjnjYFqKHayQGSU3ZecUnn05aWfJE=;
 b=hwxSsv912doiRcuWZxvtBE59SmDMTWGFEb7lq+RJIHc2CryIfXwTdf1lRHFrvkGf9b
 SKTl49gQvKS73TGs3M9KfXhgzIlhZhrK5PfwZGSTeTw2EWxGL8j3WyOTo6bGMVdyJ5yu
 onHqr+mH6zShQwEhpaG+PfU7VQo8MSFPHIMTfTu5otM3J1Uj5PTjYq42xQ9bAxfbxM5d
 QWmN3cQRz7CeCTYj7C6qs7iGRWsKtWQxb8q2LcqpbzNtuBbIi2125cAwdUSos0FFBhbg
 xOslqTIU5sC5AzmAP/z8oypiTS6KoWOdnSroO7dy7rzaJedQ9Wil1t3VoQXU/kcM/z+f
 gP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029699; x=1769634499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JCnXj4ZdgD4tbfAjnjYFqKHayQGSU3ZecUnn05aWfJE=;
 b=vIeJZNMkc/PhMVESW5pUAgVZhZPduS1hn80VDm2udznWyW91q7eT6rfCriTnFYm7mJ
 Nhi1zOaKKdvqW4KH4zoChN2qksopGPjrrWB313nRteotLhMJFb2JErl+32QInH24Np91
 npxBq46DU6WAfh8L8Rthdh7/aiNtUEN2MFpwnbCfsS2xcNC26Ji/epJ/3He+5C2nplDR
 NGQhgRUnhXX0etByKOMEEcTsyeyuJpQWjJaRCYTqJHJbc5MQJQFSqNQs0v7TopB7uLxK
 bMDQCRCPsAJjDtRjvenUK/Q/nXyJXGXcLN7K9tjpjDTXZy3SEZ/csc/rHrlV53pP3j0n
 SioQ==
X-Gm-Message-State: AOJu0Yy+h4yDh+94Jnwkm9k9aN6zA+k/oQk9n9fmsx+r5+z5+rx7m7di
 A8k5OZpeH6ZrKKgRAi8FowvnDtlTQBumGmCfqDxxrqBrZhRBcSvE8Mm+P7bDD+qM7mGmLqXnB77
 yIURv
X-Gm-Gg: AZuq6aJKCT/1FPHk4azwim6pvPfTp1idIEW4yIiVmR9VumxEq14pvxtox4zgl9oN6eD
 8CEMHqXyQrCifRGz/kyJMkmRSAsqg/Qw+ghlbFLvBjQqcrihDmm2AZQzVm9huVqKDsRCY0Du49n
 ejEPZ2D78fPd2r6adBAKvu2W/eV62hqbPh5qENTzJPdKosftiaIE+sEek6EdSxGf1kQgR8s37aS
 FuknkBUOV13AfJtJULvXzEShB6ny0y7PJYpNLDDZqNUloTGSU0C4EapjiiFLhb9DMLxIOO41lMr
 r3KkL2OF0DEn5b43j+DpM5okQ5XxslPB8lGRjso/Dq+x1albQwd8MsfjOJYL0eqjdFJTq1hAv9X
 UGmyiX0WzPlqTK1AN93IA6qTk0CFIBFnGw+srBNl5dwOs77qgCf8LiS/G6F6zlruAZrZUNH+Pc6
 vjmzldt0kspgzwO++Urm30mcxRzxsjOilWjw8i2NWxmckhrz5l+w==
X-Received: by 2002:a05:600c:8108:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-4803e7f0d8emr91886735e9.29.1769029698858; 
 Wed, 21 Jan 2026 13:08:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v12 2/8] test: add new function to get current file-prefix arg
Date: Wed, 21 Jan 2026 13:06:22 -0800
Message-ID: <20260121210810.1044276-3-stephen@networkplumber.org>
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

Refactor so that there is one function to get current argument
for "--file-prefix=XXX".

The code does not need to initialize all these 4K buffers since
they are directly used by functions that set them.
The maximum sizeof of the current DPDK prefix is NAME_MAX (128)
not PATH_MAX(4096) so save a significant amount of space.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/process.h        |  44 +++++++++----
 app/test/test_eal_flags.c | 133 +++++++++++---------------------------
 2 files changed, 71 insertions(+), 106 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index 0704616c38..402dc4f96f 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -225,27 +225,49 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	return status;
 }
 
-/* FreeBSD doesn't support file prefixes, so force compile failures for any
- * tests attempting to use this function on FreeBSD.
- */
+/* FreeBSD doesn't support file prefixes, so no argument passed. */
+#ifdef RTE_EXEC_ENV_FREEBSD
+static inline const char *
+file_prefix_arg(void)
+{
+	/* BSD target doesn't support prefixes at this point */
+	return "";
+}
+#else
+
 #ifdef RTE_EXEC_ENV_LINUX
 static inline char *
 get_current_prefix(char *prefix, int size)
 {
-	char path[PATH_MAX] = {0};
-	char buf[PATH_MAX] = {0};
+	char buf[PATH_MAX];
 
-	/* get file for config (fd is always 3) */
-	snprintf(path, sizeof(path), "/proc/self/fd/%d", 3);
-
-	/* return NULL on error */
-	if (readlink(path, buf, sizeof(buf)) == -1)
+	/* get file for config (fd is always 3) return NULL on error */
+	if (readlink("/proc/self/fd/3", buf, sizeof(buf)) == -1)
 		return NULL;
 
-	/* get the prefix */
+	/*
+	 * path should be something like "/var/run/dpdk/config"
+	 * which results in prefix of "dpdk"
+	 */
 	rte_basename(dirname(buf), prefix, size);
+	return prefix;
+}
+
+/* Return a --file-prefix=XXXX argument or NULL */
+static inline const char *
+file_prefix_arg(void)
+{
+	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
+	char tmp[NAME_MAX];
 
+	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
+		fprintf(stderr, "Error - unable to get current prefix!\n");
+		return NULL;
+	}
+
+	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 	return prefix;
+#endif
 }
 #endif
 
diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 659a6745fd..b369326dbf 100644
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
@@ -317,7 +319,7 @@ get_number_of_sockets(void)
 	closedir(dir);
 	return result;
 }
-#endif
+#endif /* RTE_EXEC_ENV_LINUX */
 
 /*
  * Test that the app doesn't run with invalid allow option.
@@ -327,18 +329,10 @@ get_number_of_sockets(void)
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
-		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
+	unsigned int i;
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *wlinval[][7] = {
 		{prgname, prefix, mp_flag,
@@ -396,17 +390,9 @@ test_allow_flag(void)
 static int
 test_invalid_b_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *blinval[][5] = {
 		{prgname, prefix, mp_flag, "-b", "error"},
@@ -451,7 +437,7 @@ test_invalid_vdev_flag(void)
 	const char * prefix = no_shconf;
 #else
 	const char * prefix = "--file-prefix=vdev";
-#endif
+#endif /* !RTE_EXEC_ENV_FREEBSD */
 
 	/* Test with invalid vdev option */
 	const char *vdevinval[] = {prgname, prefix, no_huge,
@@ -493,7 +479,7 @@ test_invalid_vdev_flag(void)
 	return 0;
 #else
 	return TEST_SKIPPED;
-#endif
+#endif /* !RTE_NET_RING */
 }
 
 /*
@@ -502,17 +488,9 @@ test_invalid_vdev_flag(void)
 static int
 test_invalid_r_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	const char *rinval[][5] = {
 			{prgname, prefix, mp_flag, "-r", "error"},
@@ -547,17 +525,9 @@ test_invalid_r_flag(void)
 static int
 test_missing_c_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -c flag but no coremask value */
 	const char *argv1[] = { prgname, prefix, mp_flag, "-c"};
@@ -706,17 +676,9 @@ test_missing_c_flag(void)
 static int
 test_main_lcore_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char *prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	if (!rte_lcore_is_enabled(0) || !rte_lcore_is_enabled(1))
 		return TEST_SKIPPED;
@@ -765,17 +727,9 @@ test_main_lcore_flag(void)
 static int
 test_invalid_n_flag(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
 		return -1;
-	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* -n flag but no value */
 	const char *argv1[] = { prgname, prefix, no_huge, no_shconf,
@@ -818,18 +772,14 @@ test_invalid_n_flag(void)
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
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL) {
 		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* With --no-hpet */
 	const char *argv1[] = {prgname, prefix, mp_flag, no_hpet};
@@ -846,6 +796,7 @@ test_no_hpet_flag(void)
 		return -1;
 	}
 	return 0;
+#endif
 }
 
 /*
@@ -869,6 +820,18 @@ test_no_huge_flag(void)
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
@@ -883,20 +846,6 @@ test_no_huge_flag(void)
 	const char * const argv6[] = {prgname, prefix, no_huge,
 			"--huge-worker-stack=512"};
 
-	if (launch_proc(argv1) != 0) {
-		printf("Error (line %d) - process did not run ok with --no-huge flag\n", __LINE__);
-		return -1;
-	}
-	if (launch_proc(argv2) != 0) {
-		printf("Error (line %d) - process did not run ok with --no-huge and -m flags\n",
-			__LINE__);
-		return -1;
-	}
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* no other tests are applicable to FreeBSD */
-	return 0;
-#endif
-
 	if (launch_proc(argv3) == 0) {
 		printf("Error (line %d) - process run ok with --no-huge and --socket-mem flags\n",
 			__LINE__);
@@ -917,6 +866,7 @@ test_no_huge_flag(void)
 			__LINE__);
 		return -1;
 	}
+#endif /* !RTE_EXEC_ENV_FREEBSD */
 	return 0;
 }
 
@@ -932,17 +882,16 @@ test_misc_flags(void)
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
+	if (prefix == NULL) {
 		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 
 	/*
 	 * get first valid hugepage path
@@ -1568,17 +1517,11 @@ populate_socket_mem_param(int num_sockets, const char *mem,
 static int
 test_memory_flags(void)
 {
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* BSD target doesn't support prefixes at this point */
-	const char * prefix = "";
-#else
-	char prefix[PATH_MAX], tmp[PATH_MAX];
-	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL) {
 		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
-	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
-#endif
 
 	/* valid -m flag and mp flag */
 	const char *argv0[] = {prgname, prefix, mp_flag,
-- 
2.51.0

