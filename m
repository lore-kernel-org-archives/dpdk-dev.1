Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5965C9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11F8842ED6;
	Sat, 17 Jan 2026 03:38:29 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 29AF942E47
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:38:27 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b870732cce2so412579366b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617506;
 x=1769222306; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FU4A5HZB8ayyFDH0YQXc7ULXidMZ9NwYLDmsPK9Cfk=;
 b=SWqu7Y47F2GzulQK2WP1HhSIG5yF/klS/t+vcs6Mz0YylV7DHWFMFWh16mAkpBj6t5
 cXX2HjK5wAzGBBI7QoHui2JD6/0ykz5sYtVkgJ6V+2GOjPmTCjCNLCtIMV+JuRNRCDm1
 9WndWnZsqnJKyAo604kFjrgtgwq9RMLrjez2DLZI7juyCtOOFm8d/30lALPvTsVdftX2
 DpRzRm2RFy4xuN+ASfNF8Qhv7ja1EvKS/mVeA4Cqlou6n8HhV5p3ek72u0YHutgWcB0j
 YGlky2thpFHUxy372EiDTm/Uy0/1me0KB3BVx9PAm22e/i4j0VGeFTBuXIQKCy9W2MhP
 tLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617506; x=1769222306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7FU4A5HZB8ayyFDH0YQXc7ULXidMZ9NwYLDmsPK9Cfk=;
 b=EkiRtMYgZODsK6n8g2UNoehXu26rm8aZPvRiSuOT+PtkfIBjyNLMostMG9QC4rdBhH
 ZSz5x1SouX2Qu5B9LGWW4GayxRrAurugG3wg+lI+igCeIsYw2wP8IntCwrnf6k+AYXFd
 k8Rp/9ul0XkDAmJBl0Z5oA8izPsfZ/XgUJtccIjmwSTNRgB9TD4MwHAjubASBSL1s6Ys
 iZLp4Uy/x2DkbU7pAheGO7n5qZhjVOmSEZ9AChOod129dRjpLu4anHtvefkqmTZe1n+f
 HRoytttubiT3yboiSL1D/eImgjVgKpfcefWbllcLbBp78yixAVUgjrE4xoCviDeUFdsG
 Qfgw==
X-Gm-Message-State: AOJu0Yx9XKtDZtGsbIoYi0yS2bv/R2JMqAyomAMFbD0xDwZ2jBO0a14R
 67yJcw4TvHyTkd4PftYauDDSNjp3hA8mOL9uvAVyuiDPbzAL7SVWdn7euLXxIJ4QOqwpHnSJL57
 y4np5
X-Gm-Gg: AY/fxX7ULmVV6B/aKhJS1rrw067Htpjx+/CGBDXOCe2yte9HxQM0G25HGNXV1e6LAS/
 BUeROmJZagI/VdInxRIw5M6FJuN5mElIA6jH2glMU1FqE3u/InmGh/rH7GO3PgNXjVQf0m+GIkZ
 7p9OmRL80w3R+6Hovj0KsBRYYO8nmS/TVTd0xS7t6dqCcfba+ped0WKfsJuroJCXiq9N5ckeElR
 InIHUU8mh3bd2Xd57IKxGXMfUMHkvuvkj3Lih9hLlf59APWnISOQUCLbFXrSSf6PDZy5B5KAct7
 iYCPKPZgavn/hiW8YzG6xNlJ4oaHeR5z+qpnQKeXThIqSyBr/cDIiGi+UBjpykadLsSw6cTWHJr
 foabb+2g4XBe75cb9cSRqhZpb16dHYcTsLZCC7ilNhLFAYruqYhaq/7GplAu//gA6CEHSa66cHU
 v4A3fQscBXX7U6LZYxAKupmwZVklPuYydmojQTerc7VsP16B1WAg==
X-Received: by 2002:a17:907:86a8:b0:b87:6af7:c186 with SMTP id
 a640c23a62f3a-b8796b8fed2mr336895866b.54.1768617505987; 
 Fri, 16 Jan 2026 18:38:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm439960166b.49.2026.01.16.18.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:38:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v11 2/6] test: add new function to get current file-prefix arg
Date: Fri, 16 Jan 2026 18:36:57 -0800
Message-ID: <20260117023817.196694-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117023817.196694-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260117023817.196694-1-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 132 ++++++++++----------------------------
 2 files changed, 68 insertions(+), 108 deletions(-)

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
index 4ddcafdecb..10a5ceb579 100644
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

