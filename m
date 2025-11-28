Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A00D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74A234060F;
	Fri, 28 Nov 2025 23:44:36 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 8A48F402C5
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:30 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-88246676008so24562206d6.3
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369870;
 x=1764974670; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYIPoS2jk5cVhYLvr+QH0OG/6ojstUDaect/34kp80U=;
 b=z/ZqAdWtSf24yrcxr6nB6wymLvgoqJkaAExA01ziyXnwykWi8IA1Ba55YAv0l9lanq
 +fz/G/tQ+3S6UPcavqAhxdsh1exgxXfsc6Oz/PMX4NsiQ6oDWV+H9NLfaA2Hbs+DPy0Y
 1Yv9Ug2Ee1bQ1qgyLHPC5ZOzFM0IwWQP7LhF1zBwc1kqcZgBFOPCazEYbQnon51MuPIv
 oUqfAuNQh3HUZfnPyg9SKdsuQDiqy6xjv5qwbRRGlU8ntQyaa1IIr3J+ZvQruTgdIyc3
 AM7C+n1iDnh2M4VTkGtv+8Yb0NsveTG4FkYEc0f4S/PgilyAk+lHyyj+v6j1N7lv/aSy
 VPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369870; x=1764974670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VYIPoS2jk5cVhYLvr+QH0OG/6ojstUDaect/34kp80U=;
 b=jyBleOT77tvKIe/Ew0Sdi72AtFZPx/DLAcmduVmuYzmQd0EfZiPxHL2N2js8D/2mIe
 AFJOqEDZZWWauuk/uQbmHH47lbBxxdv1xf5vA6jhVm17ipurfd8nTE2ud5PGt6ewogBM
 AlcWQZyYnxzFt+EgZhy9tRP1x15lR8mushwCs6vdijWDx9bdiYgWpE47EEM7LwgbESPM
 hvxwuNOIlOLB6Ptq23P6iPs7920QudZWKP2t0Sm4qiaH6sKIu8Lj8DCtULh2Lv4jrWIL
 4K19u2F3naCULkaqT5EzWPLwYll3W+ilO9xodu/JI1VgO0sA8A7dHCdKeyo3VQEwuCLZ
 uSmA==
X-Gm-Message-State: AOJu0YwlYM4J9OD8jyq4ApAydx0raUUWk4jgTXeU0vSzIHYEf9r8gpvF
 c1BjDv8XRjFpvUW+CvGm7itRr9gY2pJBOlIOMsjHPAqj/c5zdYvxue3Mjd8Et75BE6NF+/CkFg9
 eVfKK
X-Gm-Gg: ASbGncs983Gs7AXFSNQ6EgIXHTrHBnIr/NZOJqEFI/kEwW5YCVknsPdT8+Pw3XaNP7m
 oJ+myuhr8xhPXFZ73gMTVLyKySzohQmgHtWN+/RFTKbN6BiOFHsdlXXH0DqeT0lGUE2SlQbYSnA
 9vwZybfYAGlvI+wfa8ESwOWHbrBoc+X8B6jl7tCuuYutSwSPEZ91hF0ndEk/RiVSqMx+y5aziPA
 07ogHSQtdmeAGvf6hZZGgj3ZYSY0hzQOuBPUgdmdZqMBHmkmeX5vN9IKC7c0a0jTWokhe7QR7PO
 9jtQVEH2yo10KCrIGQDBtEPMajc8706BzfVQCOsEqzNtHzG9UXYJmFEHyTpU7c/2w/dPx32E8t4
 VlkaRuV4J4XK6zsZ5igSe+KPD9Mu4kHqu1l6fQGDt6OQOrwE2FV6zmfhbrxmbwqUI+5C4nqhWle
 LAGFVwY09vivalzNBZDUsza6bP9oJ0+06LgmSKV9CD9/eEyDcKgDXP1Qc3/Qqy
X-Google-Smtp-Source: AGHT+IGNSdbAf4EfUm/km7SCB5WuYICJ/fJ0ZvrTQabNBM5bxwmMAcy038Qewv3v6zyiKeI70IBPng==
X-Received: by 2002:a05:6214:4b01:b0:880:47c3:8b69 with SMTP id
 6a1803df08f44-8847c544802mr505125266d6.33.1764369869814; 
 Fri, 28 Nov 2025 14:44:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 04/10] test: avoid overflowing huge directory path
Date: Fri, 28 Nov 2025 14:42:07 -0800
Message-ID: <20251128224420.195013-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
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
index c3723ee0b8..fbdc972240 100644
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
@@ -854,10 +833,10 @@ test_no_huge_flag(void)
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
@@ -865,9 +844,7 @@ test_misc_flags(void)
 #else
 	const char *prefix = file_prefix_arg();
 	const char * nosh_prefix = "--file-prefix=noshconf";
-	FILE * hugedir_handle = NULL;
-	char line[PATH_MAX] = {0};
-	unsigned i, isempty = 1;
+	struct mntent *entry;
 
 	if (prefix == NULL)
 		return -1;
@@ -877,29 +854,24 @@ test_misc_flags(void)
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
@@ -1168,6 +1140,17 @@ test_misc_flags(void)
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
@@ -1186,16 +1169,12 @@ test_file_prefix(void)
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
@@ -1431,6 +1410,7 @@ test_file_prefix(void)
 
 	return 0;
 }
+#endif
 
 /* This function writes in passed buf pointer a valid --socket-mem= option
  * for num_sockets then concatenates the provided suffix string.
-- 
2.51.0

