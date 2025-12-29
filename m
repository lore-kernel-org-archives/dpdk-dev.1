Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73463E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04F9640654;
	Mon, 29 Dec 2025 23:01:07 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id 54A0D40652
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:05 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b7ffa5d1b80so1201687666b.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045665;
 x=1767650465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqfey++oQ3n/mM/Iuq7awdzieES2FSFcHoFO0urM+T8=;
 b=W3Crj32kWbhrfE3u/wum786RHIO221kP1KER34c5jsPf31hbroowhneJQFEK8PlrKk
 v4EhLt/G16gZjjSuiiosJho0Y4LW3h9zHZ5wc6cj7IIpBjI/5rykNrlvqFszwhb0/iNm
 WYMdmegqWf3vYgJe2qchnSDSeSGOoUzn1w42hXyPe0o7DieVe3ECpZvTV+e2CIBWbcdb
 D11N24gqG/axSH2Y7XyEab+WWhrvcX82ZMAruZuIC9SWEBh3t307w0t0YbBtiuUl4seU
 6mUG5pz2OnUgWuz5HyKTz74fXTyfU6iX+8rbYZCfXza4IlPL+MuLcu4PXSTslgqPqwbc
 vnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045665; x=1767650465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aqfey++oQ3n/mM/Iuq7awdzieES2FSFcHoFO0urM+T8=;
 b=rimAx6QfA0aPq1WFSFWkA8U2k4q3aPOvldBu0Vg3yaCaV7+p3rzLa1HZzjxZgG7v/g
 2Nymk0zBVUy+jv7q/hAXuf4O9T1tlvDgU4eCAROOFkAMWVx9Uibh5c+FzKA3XP2QY1iD
 qduSfvyxMt0SiPuSGt9hxneaMuOyZqh8D22z4fMa9pfl3TLLXGGUHcQdr2rc6qXWMKSJ
 GE+r2fjPxGYyFvzlJNtaFqWnQFpyFCmSEFZsVSggrV74/oBoEk904LVuSmEUcs0EElN8
 cpmmxnVXshM83+3QsJlXtKAwlebQOVetcXDppE5EoLMl53By1EDszYNZaXPhMCL37KNq
 o8iQ==
X-Gm-Message-State: AOJu0Yygy7rkTNtEBJiUO0CV7K3unP6DhNbEvdvfoGBlgsoDBJKTXgXl
 hPmc0NejbWii5MDuW5PE9MHiS4RHun5MaJ1vwiPz/5v86GgjTHQQubP4o57pndO5zAvXi7laych
 oMP8rCew=
X-Gm-Gg: AY/fxX6wlzkk1M4/N14HdssdgQvjauUPozXyr2YvZUQvoPPc/qIOIwCLPeDZYXMRCDd
 b9SFC+PmDifJXhlkFiWqTYWhqpZX4BnvUy5Zz2XQ7Or4z0rzLZ6WzuvDt/Xntsn4ORATvDFl2Sc
 tV7xjyP9eUPwdl0UxdaHQ+NStyo7p7Jo0H+r2D5XDRVxyP4RHok+7gQx9JP1bvlrCTKuJ4DME7y
 3IS+dem4sF4W41jJSRnwN9vpO5VEBDB+Nu0GxQi0CSZi1Mquxq9w3AvW0W/4Cl70cmkmix2R6kV
 3k/ooVRKOqut51ONM49WqcLqTTYx4KtLzgWddhcOse/FaeKFVDx+IN3S14F8qhHhTy85YeDMjuj
 YUoPYBcVz7IvdPf1u3PZHlNCYIXbxD8/bhLvPUOC4raVuIXruK8dDPUvry5gwGSSReepsR1i/r3
 sNB1ESQ9WD8Xp6e+qTEclXUB0Rmqq34ecH36KQN7waNnO12OXtZg==
X-Google-Smtp-Source: AGHT+IEKt5R1gUOf/cQRZRwJ4SuQ631ZPPn2UAoJkRz0K3oPZTm/U33XHrsASfMfhTpn1lnNiNxpXg==
X-Received: by 2002:a17:907:d87:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b80371d69e5mr3446670166b.52.1767045664837; 
 Mon, 29 Dec 2025 14:01:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 4/9] test: avoid overflowing huge directory path
Date: Mon, 29 Dec 2025 13:59:04 -0800
Message-ID: <20251229220053.21981-5-stephen@networkplumber.org>
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

Modify the part of the test that is scanning for hugepages
mount point to use existing getmntent library calls.

As a result, the maximum mount path is smaller which is ok
since this is all handled by the standard library.
And the resulting huge path arguments don't overflow.

Hugepages aren't used on Window or FreeBSD so this is
skipped there.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_eal_flags.c | 136 ++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 78 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 12cf123e81..97cc21980a 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -123,12 +123,17 @@ test_misc_flags(void)
 #define vdev "--vdev"
 #define file_prefix "--file-prefix"
 
+#define FS_HUGETLB "hugetlbfs"
+
 #define memtest "memtest"
 #define memtest1 "memtest1"
 #define memtest2 "memtest2"
 #define SOCKET_MEM_STRLEN (RTE_MAX_NUMA_NODES * 20)
 #define launch_proc(ARGV) process_dup(ARGV, RTE_DIM(ARGV), __func__)
 
+#ifdef RTE_EXEC_ENV_LINUX
+#include <mntent.h>
+
 enum hugepage_action {
 	HUGEPAGE_CHECK_EXISTS = 0,
 	HUGEPAGE_CHECK_LOCKED,
@@ -136,24 +141,6 @@ enum hugepage_action {
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
@@ -165,45 +152,39 @@ get_hugepage_path(char * src, int src_len, char * dst, int dst_len)
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
 
@@ -222,10 +203,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
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
@@ -240,6 +221,8 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 				break;
 			case HUGEPAGE_CHECK_LOCKED:
 				{
+					int fd;
+
 					/* try and lock the file */
 					fd = openat(dirfd(hugepage_dir), dirent->d_name, O_RDONLY);
 
@@ -253,10 +236,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 					}
 
 					/* non-blocking lock */
-					lck_result = flock(fd, LOCK_EX | LOCK_NB);
-
-					/* if lock succeeds, there's something wrong */
-					if (lck_result != -1) {
+					if (flock(fd, LOCK_EX | LOCK_NB) != -1) {
 						result = 0;
 
 						/* unlock the resulting lock */
@@ -278,11 +258,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
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
@@ -853,10 +832,10 @@ test_no_huge_flag(void)
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
@@ -864,9 +843,7 @@ test_misc_flags(void)
 #else
 	const char *prefix = file_prefix_arg();
 	const char * nosh_prefix = "--file-prefix=noshconf";
-	FILE * hugedir_handle = NULL;
-	char line[PATH_MAX] = {0};
-	unsigned i, isempty = 1;
+	struct mntent *entry;
 
 	if (prefix == NULL)
 		return -1;
@@ -876,29 +853,24 @@ test_misc_flags(void)
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
@@ -1167,6 +1139,17 @@ test_misc_flags(void)
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
@@ -1185,16 +1168,12 @@ test_file_prefix(void)
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
@@ -1430,6 +1409,7 @@ test_file_prefix(void)
 
 	return 0;
 }
+#endif
 
 /* This function writes in passed buf pointer a valid --socket-mem= option
  * for num_sockets then concatenates the provided suffix string.
-- 
2.51.0

