Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C177C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DC9442E82;
	Wed, 21 Jan 2026 22:08:22 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 2676B42E7F
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:21 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so2423175e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029701;
 x=1769634501; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbOodkItnZ9ME9dwbzmbTtpmm+JRL0mSKjsi2Y4aIXg=;
 b=SAY0V/2NtrC681ia9R9vHkYODBa0Bx6LbFZgf6S2oGESip8tBPwjMmf7EDAOxm0V8E
 UzyJh7BoceRdvGwgqSFWL7YDeT/Ft4IqOe7c9XLlOPwpwnmFt0TVFkgPaKVimjWsEqNZ
 +Xjvy4yTdoswsrFb2DLCvtmx8vZLtRamBov9bqDZ5fFWlr4c9/a3bXKhUs55zb7/ejk2
 SvYaWeli+7Xna0d8/9VHd7YPcp1waISp/rcTz8xnuKCcicxo60N0QlIy/0AeIErWwquK
 6+Zo0F7W4HsRYygyIn93TH/ENsY5VQyh8iRQ0XzjArPIOkt5DZp6TekJrgbucOaXa0T9
 GAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029701; x=1769634501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QbOodkItnZ9ME9dwbzmbTtpmm+JRL0mSKjsi2Y4aIXg=;
 b=WZx6IG8r0KXdNj/1u2FwDrXGBX6Jqjn9ZApp+F0DYBnmXOmOn/zAHKHpqtpz7UmUeX
 kPnBrE1ZW8PeKDBNaBCpvmlErGfHePCFLnnXCezW2TEpt3GU7T292iw0KwqM+Vj33qME
 KHHDBL/8DPV1ecCKKxRss2w3FOY2Gdzt+ITE7I7Nvj2E2nvQ3u7PJkTcXwOoTd6NUdsz
 t1zC73yrr0WS1j+awtkAyYq1VW5F73LcrZsA4OE/H9nEVpc7nBBgGczCcCR1ogGvpGUG
 k0KX8JF0b2msOH2SFR7PEyKkNXGAwhl9H5nL3/x/43RclA4iVmIIwtrm84z+T2Y92hEA
 QqTA==
X-Gm-Message-State: AOJu0YzWg3F5xDPEIOXLz7Wfs+z2fzHC8J5qOq8c+IIxT8yF6+FJPo1I
 zcgouvuW3TkkkN0OsKIp/lqcKFrSZ0XfVPrspoDuA3ZLNsr0wKi7X8LTM7od+FgShHuCAEb7eTN
 wwUof
X-Gm-Gg: AZuq6aJhlCJdE3bwiw4zya9mAoZuDihZEuF+T//KAxSMurYvLgFwMoV3GzA37GonGHi
 xf41meluUi5GxBJthEAINJvTy4q0gp6RoPP/dR6LdH6/RuVHPUqd5Dm2K9YhOVzD7m9QXXl98Cr
 0t7It2IRiq/q4ZpwnuCNojH5M1/lQn5CMbgBil8slTneAIvu8U9jd2Z/FrQz7rV9ljQPWes0EVR
 EqPbu5jOmkEFYiH6pI3y7SQpJf272Qm/2R3zm5kNBccm5R81uK+VCmZmmEh8eTynundUhceeFsd
 CdFV4L+eSD9HAPYTZz+w5hwLicY9wc5mt90hsV5m/TMKJaWsEkIsNr02wm7NSZjJdr8U0fE5zSr
 sfgjxcb77AIUnKJzaEzbM2PVScWxyvweT/Jjte4XpGbBOZ5S0Mzhd/Rw2WV+msS66XCAUrEXEJP
 zonByJQV1RoK05LN81TzhoDQ/WzTCTtD6ptMzi+muc2GCq1ar7Yw==
X-Received: by 2002:a05:600c:3d8b:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-4801e30b49emr222735785e9.9.1769029700664; 
 Wed, 21 Jan 2026 13:08:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v12 3/8] test: avoid overflowing huge directory path
Date: Wed, 21 Jan 2026 13:06:23 -0800
Message-ID: <20260121210810.1044276-4-stephen@networkplumber.org>
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
 app/test/test_eal_flags.c | 146 ++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 85 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index b369326dbf..65c63befe2 100644
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
@@ -165,46 +151,40 @@ get_hugepage_path(char * src, int src_len, char * dst, int dst_len)
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
 		printf("Error (line %d) - cannot create hugefile filename prefix\n", __LINE__);
 		return -1;
 	}
 
 	/* get hugetlbfs mountpoints from /proc/mounts */
-	hugedir_handle = fopen("/proc/mounts", "r");
-
-	if (hugedir_handle == NULL) {
+	FILE *mounts = setmntent("/proc/mounts", "r");
+	if (mounts == NULL) {
 		printf("Error (line %d) - cannot parse /proc/mounts!\n", __LINE__);
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
+		hugepage_dir = opendir(entry->mnt_dir);
+		if (hugepage_dir == NULL) {
+			endmntent(mounts);
 			printf("Error (line %d) - cannot open %s: %s\n",
-				__LINE__, hugedir, strerror(errno));
+				__LINE__, entry->mnt_dir, strerror(errno));
 			return -1;
 		}
 
@@ -217,7 +197,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 				{
 					/* file exists, return */
 					printf("Hugepage file %s/%s exists, matching prefix %s\n",
-						hugedir, dirent->d_name, hugefile_prefix);
+						entry->mnt_dir, dirent->d_name, hugefile_prefix);
 					closedir(hugepage_dir);
 					result = 1;
 					goto end;
@@ -225,10 +205,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
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
@@ -244,6 +224,8 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 				break;
 			case HUGEPAGE_CHECK_LOCKED:
 				{
+					int fd;
+
 					/* try and lock the file */
 					fd = openat(dirfd(hugepage_dir), dirent->d_name, O_RDONLY);
 
@@ -257,10 +239,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 					}
 
 					/* non-blocking lock */
-					lck_result = flock(fd, LOCK_EX | LOCK_NB);
-
-					/* if lock succeeds, there's something wrong */
-					if (lck_result != -1) {
+					if (flock(fd, LOCK_EX | LOCK_NB) != -1) {
 						result = 0;
 
 						/* unlock the resulting lock */
@@ -271,7 +250,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 					}
 					result = 1;
 					printf("Hugepage file %s/%s is locked\n",
-						hugedir, dirent->d_name);
+					       entry->mnt_dir, dirent->d_name);
 					close(fd);
 				}
 				break;
@@ -284,11 +263,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
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
@@ -828,10 +806,7 @@ test_no_huge_flag(void)
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
@@ -873,10 +848,10 @@ test_no_huge_flag(void)
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
@@ -884,9 +859,7 @@ test_misc_flags(void)
 #else
 	const char *prefix = file_prefix_arg();
 	const char * nosh_prefix = "--file-prefix=noshconf";
-	FILE * hugedir_handle = NULL;
-	char line[PATH_MAX] = {0};
-	unsigned i, isempty = 1;
+	struct mntent *entry;
 
 	if (prefix == NULL) {
 		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
@@ -898,29 +871,24 @@ test_misc_flags(void)
 	 */
 
 	/* get hugetlbfs mountpoints from /proc/mounts */
-	hugedir_handle = fopen("/proc/mounts", "r");
-
-	if (hugedir_handle == NULL) {
+	FILE *mounts = setmntent("/proc/mounts", "r");
+	if (mounts == NULL) {
 		printf("Error (line %d) - cannot open /proc/mounts!\n", __LINE__);
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
@@ -1204,6 +1172,17 @@ test_misc_flags(void)
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
@@ -1222,16 +1201,12 @@ test_file_prefix(void)
 	 *    run in legacy mode, and not present at all after run in default
 	 *    mem mode
 	 */
-	char prefix[PATH_MAX] = "";
+	char prefix[PATH_MAX];
 
-#ifdef RTE_EXEC_ENV_FREEBSD
-	return 0;
-#else
 	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
 		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
-#endif
 
 	/* this should fail unless the test itself is run with "memtest" prefix */
 	const char *argv0[] = {prgname, mp_flag, "-m",
@@ -1476,6 +1451,7 @@ test_file_prefix(void)
 
 	return 0;
 }
+#endif
 
 /* This function writes in passed buf pointer a valid --socket-mem= option
  * for num_sockets then concatenates the provided suffix string.
-- 
2.51.0

