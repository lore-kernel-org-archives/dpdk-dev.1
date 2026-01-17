Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C80C9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:38:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C9F842EF7;
	Sat, 17 Jan 2026 03:38:30 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id 3D17542EBF
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:38:28 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b8719aeebc8so495028366b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617508;
 x=1769222308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yg0r246SfZ/dqxRHeCBoWas1QlKxNA4ezCDhfs+dKRk=;
 b=F1aSPGReF0qS6ZtTUsnSQTTq8sBLDmga8IET0J+CGhHiRM1ZsS2vTtCThDK2R56Wob
 gCON0YUu8LTymVxcxY9Ktd+67RRHLx3u8KaAQd91a87PVp0etqFwszPqcvv7MlRhQkoK
 sXs4AMbD7kRcMgbHIWewQCOO+X3zAlh02Zj4sciBpmYz/yOrUIT3TaEwKjss29x3awle
 7fA+9h++bsxkDCZu/p4OT+AmAHnbP+DHRLRfxXa4NcfkrMcstbLmk0fRV/zZuma04oG2
 2GMLaeQor5te6++66SAqrm/hSQU0k4WKmGLyRXVX6w8b7l5GLEPMpmk/zRslvyjPTIvx
 HSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617508; x=1769222308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yg0r246SfZ/dqxRHeCBoWas1QlKxNA4ezCDhfs+dKRk=;
 b=bXMXY406tVO1QE4mr9kT1LmZOoUbjnnyeBHmzZmp9uhocDBcGY0eQeb+RsYHtNkvPZ
 KTzRA+4MUDY/ezCazq6XAG1d6h40vFx3eY16YVsDExRWpsS9DUuNiL/OOYNMEhbjHBRx
 qgnAMCgmLuVpkjyifFO7SD1bCIi+Qe1qfpKZMUxlgi/HfdKpgmCbemcMnGBUWYoSMhGf
 LJctJA8E5+wsWWZxUaCGBG7MabPmuEQiWA3K6c9q6Y7L5nL0weKZLilHIjQZvm86Ph5M
 +rwUkn7kK2VI8hfBmYfaTiC56pgv9wNHWfhhd1aXxQsP4dns04hnrjrrDsm9gifHKiMR
 4KDA==
X-Gm-Message-State: AOJu0YzB/+ojaaCrwAI9+rBWP3lQboDXaTYlFwpxtA304+SI2wSNoQlj
 LGCVx8pWr0gsKAMjFWNBuir69Q8qgkY/FSoVrd1u+M1NfgBluSGA2UBY09XBvxKNZ4JJvdKKagv
 Iriq5
X-Gm-Gg: AY/fxX4M0dD0Z2ft/xhfRc8ijCi/QOMwDCCHvxjaGdmiVhSvxqUTnWh1a3UEaSKFZxD
 kDhH/MZR/R0QJoa0Dvsx0nqNERFwaiqUZXmq3HPma/ra1UuonfciuxDELmDQyBqLEIt+u2nLP3a
 bsdkX+9J040vJv0d3XyBfIPePt9/826XA+llJfI2uCUkgb7NqLZCf7YzFweB+6MmD4IlSga2zhk
 tubSn7j68yGauZu1VdBf2ah76OZOWqRVs5+hcvfgIhJyiS8nCrgrI11PrzKTuHc5fswEgQbGlse
 1POSkkV8bBgH6q8XWZdoVo4i+h7F7eePkCtqmlsfPXVIhIVG/ZayjgLYZ81ioXv5tjzoH6ZNjiq
 IAUNC/6TCfQmEKpo2nHiNRfnLEHK8AJ5azmT7QwT2sOaXGSnDMz27s4k86A6z/ZzJyOVeWwTk//
 0E83MM3Iao6qZDNv9txfb/43cXQ9xuY+UuKANDSxbGxmD3ufYsRA==
X-Received: by 2002:a17:906:9fc9:b0:b87:91cb:7412 with SMTP id
 a640c23a62f3a-b8792fea1f1mr438926466b.53.1768617507801; 
 Fri, 16 Jan 2026 18:38:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm439960166b.49.2026.01.16.18.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:38:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v11 3/6] test: avoid overflowing huge directory path
Date: Fri, 16 Jan 2026 18:36:58 -0800
Message-ID: <20260117023817.196694-4-stephen@networkplumber.org>
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

Modify the part of the test that is scanning for hugepages
mount point to use existing getmntent library calls.

As a result, the maximum mount path is smaller which is ok
since this is all handled by the standard library.
And the resulting huge path arguments don't overflow.

Hugepages aren't used on Window or FreeBSD so this is
skipped there.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_eal_flags.c | 142 ++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 83 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 10a5ceb579..9c522d1838 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -121,7 +121,8 @@ test_misc_flags(void)
 #define no_shconf "--no-shconf"
 #define allow "--allow"
 #define vdev "--vdev"
-#define file_prefix "--file-prefix"
+
+#define FS_HUGETLB "hugetlbfs"
 
 #define memtest "memtest"
 #define memtest1 "memtest1"
@@ -129,6 +130,9 @@ test_misc_flags(void)
 #define SOCKET_MEM_STRLEN (RTE_MAX_NUMA_NODES * 20)
 #define launch_proc(ARGV) process_dup(ARGV, RTE_DIM(ARGV), __func__)
 
+#ifdef RTE_EXEC_ENV_LINUX
+#include <mntent.h>
+
 enum hugepage_action {
 	HUGEPAGE_CHECK_EXISTS = 0,
 	HUGEPAGE_CHECK_LOCKED,
@@ -136,24 +140,6 @@ enum hugepage_action {
 	HUGEPAGE_INVALID
 };
 
-/* if string contains a hugepage path */
-static int
-get_hugepage_path(char * src, int src_len, char * dst, int dst_len)
-{
-#define NUM_TOKENS 4
-	char *tokens[NUM_TOKENS];
-
-	/* if we couldn't properly split the string */
-	if (rte_strsplit(src, src_len, tokens, NUM_TOKENS, ' ') < NUM_TOKENS)
-		return 0;
-
-	if (strncmp(tokens[2], "hugetlbfs", sizeof("hugetlbfs")) == 0) {
-		strlcpy(dst, tokens[1], dst_len);
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Cycles through hugepage directories and looks for hugepage
  * files associated with a given prefix. Depending on value of
@@ -165,45 +151,39 @@ get_hugepage_path(char * src, int src_len, char * dst, int dst_len)
  * Returns -1 if it encounters an error
  */
 static int
-process_hugefiles(const char * prefix, enum hugepage_action action)
+process_hugefiles(const char *prefix, enum hugepage_action action)
 {
-	FILE * hugedir_handle = NULL;
-	DIR * hugepage_dir = NULL;
-	struct dirent *dirent = NULL;
-
-	char hugefile_prefix[PATH_MAX] = {0};
-	char hugedir[PATH_MAX] = {0};
-	char line[PATH_MAX] = {0};
-
-	int fd, lck_result, result = 0;
+	const struct mntent *entry;
+	char hugefile_prefix[PATH_MAX];
+	int result = 0;
 
-	const int prefix_len = snprintf(hugefile_prefix,
-			sizeof(hugefile_prefix), "%smap_", prefix);
-	if (prefix_len <= 0 || prefix_len >= (int)sizeof(hugefile_prefix)
-			|| prefix_len >= (int)sizeof(dirent->d_name)) {
+	const int prefix_len = snprintf(hugefile_prefix, sizeof(hugefile_prefix), "%smap_", prefix);
+	if (prefix_len <= 0 || prefix_len >= NAME_MAX) {
 		printf("Error creating hugefile filename prefix\n");
 		return -1;
 	}
 
 	/* get hugetlbfs mountpoints from /proc/mounts */
-	hugedir_handle = fopen("/proc/mounts", "r");
-
-	if (hugedir_handle == NULL) {
+	FILE *mounts = setmntent("/proc/mounts", "r");
+	if (mounts == NULL) {
 		printf("Error parsing /proc/mounts!\n");
 		return -1;
 	}
 
-	/* read and parse script output */
-	while (fgets(line, sizeof(line), hugedir_handle) != NULL) {
+	/* foreach mountpoint */
+	while ((entry = getmntent(mounts)) != NULL) {
+		DIR *hugepage_dir;
+		struct dirent *dirent;
 
-		/* check if we have a hugepage filesystem path */
-		if (!get_hugepage_path(line, sizeof(line), hugedir, sizeof(hugedir)))
+		/* only want hugetlbfs filesystems */
+		if (strcmp(entry->mnt_type, FS_HUGETLB) != 0)
 			continue;
 
 		/* check if directory exists */
-		if ((hugepage_dir = opendir(hugedir)) == NULL) {
-			fclose(hugedir_handle);
-			printf("Error reading %s: %s\n", hugedir, strerror(errno));
+		hugepage_dir = opendir(entry->mnt_dir);
+		if (hugepage_dir == NULL) {
+			endmntent(mounts);
+			printf("Error reading %s: %s\n", entry->mnt_dir, strerror(errno));
 			return -1;
 		}
 
@@ -222,10 +202,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 				break;
 			case HUGEPAGE_DELETE:
 				{
-					char file_path[PATH_MAX] = {0};
+					char file_path[PATH_MAX];
 
 					snprintf(file_path, sizeof(file_path),
-						"%s/%s", hugedir, dirent->d_name);
+						"%s/%s", entry->mnt_dir, dirent->d_name);
 
 					/* remove file */
 					if (remove(file_path) < 0) {
@@ -240,6 +220,8 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 				break;
 			case HUGEPAGE_CHECK_LOCKED:
 				{
+					int fd;
+
 					/* try and lock the file */
 					fd = openat(dirfd(hugepage_dir), dirent->d_name, O_RDONLY);
 
@@ -253,10 +235,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 					}
 
 					/* non-blocking lock */
-					lck_result = flock(fd, LOCK_EX | LOCK_NB);
-
-					/* if lock succeeds, there's something wrong */
-					if (lck_result != -1) {
+					if (flock(fd, LOCK_EX | LOCK_NB) != -1) {
 						result = 0;
 
 						/* unlock the resulting lock */
@@ -278,11 +257,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 		closedir(hugepage_dir);
 	} /* read /proc/mounts */
 end:
-	fclose(hugedir_handle);
+	endmntent(mounts);
 	return result;
 }
 
-#ifdef RTE_EXEC_ENV_LINUX
 /*
  * count the number of "node*" files in /sys/devices/system/node/
  */
@@ -810,10 +788,7 @@ test_no_huge_flag(void)
 		printf("Error - process did not run ok with --no-huge and -m flags\n");
 		return -1;
 	}
-#ifdef RTE_EXEC_ENV_FREEBSD
-	/* no other tests are applicable to FreeBSD */
-	return 0;
-#else
+#ifndef RTE_EXEC_ENV_FREEBSD
 	/* With --no-huge and --socket-mem */
 	const char *argv3[] = {prgname, prefix, no_huge,
 			"--socket-mem=" DEFAULT_MEM_SIZE};
@@ -853,10 +828,10 @@ test_no_huge_flag(void)
 static int
 test_misc_flags(void)
 {
-	char hugepath[PATH_MAX] = {0};
-	char hugepath_dir[PATH_MAX] = {0};
-	char hugepath_dir2[PATH_MAX] = {0};
-	char hugepath_dir3[PATH_MAX] = {0};
+	const char *hugepath = "";
+	char hugepath_dir[PATH_MAX];
+	char hugepath_dir2[PATH_MAX];
+	char hugepath_dir3[PATH_MAX];
 #ifdef RTE_EXEC_ENV_FREEBSD
 	/* BSD target doesn't support prefixes at this point */
 	const char * prefix = "";
@@ -864,9 +839,7 @@ test_misc_flags(void)
 #else
 	const char *prefix = file_prefix_arg();
 	const char * nosh_prefix = "--file-prefix=noshconf";
-	FILE * hugedir_handle = NULL;
-	char line[PATH_MAX] = {0};
-	unsigned i, isempty = 1;
+	struct mntent *entry;
 
 	if (prefix == NULL)
 		return -1;
@@ -876,29 +849,24 @@ test_misc_flags(void)
 	 */
 
 	/* get hugetlbfs mountpoints from /proc/mounts */
-	hugedir_handle = fopen("/proc/mounts", "r");
-
-	if (hugedir_handle == NULL) {
+	FILE *mounts = setmntent("/proc/mounts", "r");
+	if (mounts == NULL) {
 		printf("Error opening /proc/mounts!\n");
 		return -1;
 	}
 
-	/* read /proc/mounts */
-	while (fgets(line, sizeof(line), hugedir_handle) != NULL) {
-
-		/* find first valid hugepath */
-		if (get_hugepage_path(line, sizeof(line), hugepath, sizeof(hugepath)))
+	/* foreach mount point */
+	hugepath = NULL;
+	while ((entry = getmntent(mounts)) != NULL) {
+		/* only want hugetlbfs filesystems */
+		if (strcmp(entry->mnt_type, FS_HUGETLB) == 0) {
+			hugepath = strdupa(entry->mnt_dir);
 			break;
+		}
 	}
+	endmntent(mounts);
 
-	fclose(hugedir_handle);
-
-	/* check if path is not empty */
-	for (i = 0; i < sizeof(hugepath); i++)
-		if (hugepath[i] != '\0')
-			isempty = 0;
-
-	if (isempty) {
+	if (hugepath == NULL) {
 		printf("No mounted hugepage dir found!\n");
 		return -1;
 	}
@@ -1167,6 +1135,17 @@ test_misc_flags(void)
 	return -1;
 }
 
+#ifdef RTE_EXEC_ENV_FREEBSD
+
+static int
+test_file_prefix(void)
+{
+	printf("file_prefix not supported on FreeBSD, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+#else
+
 static int
 test_file_prefix(void)
 {
@@ -1185,16 +1164,12 @@ test_file_prefix(void)
 	 *    run in legacy mode, and not present at all after run in default
 	 *    mem mode
 	 */
-	char prefix[PATH_MAX] = "";
+	char prefix[PATH_MAX];
 
-#ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
-#else
 	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
 		printf("Error - unable to get current prefix!\n");
 		return -1;
 	}
-#endif
 
 	/* this should fail unless the test itself is run with "memtest" prefix */
 	const char *argv0[] = {prgname, mp_flag, "-m",
@@ -1430,6 +1405,7 @@ test_file_prefix(void)
 
 	return 0;
 }
+#endif
 
 /* This function writes in passed buf pointer a valid --socket-mem= option
  * for num_sockets then concatenates the provided suffix string.
-- 
2.51.0

