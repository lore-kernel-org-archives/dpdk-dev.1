Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2708AD0E6F8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FBAC40DD5;
	Tue, 25 Nov 2025 16:22:46 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id E3DEB40BA4
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:40 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-29558061c68so75989795ad.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084160;
 x=1764688960; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVG7JyknlAwdkehjmY8DMmPkYIXmQfn3iQVo+lFWKD4=;
 b=yDNszdi9AMnn/3bPuq7Dtqiw5J0DKoxkhEOdHPjKFRgRJgkync20lySbvaWKe3lfUX
 MgRBPMGw4qg9ajTy08v5jhTMFV/cxx6+0u8/hZa5C/nuTWxZJ4JXmtH5x/nr9p5Hufuw
 zPDTC5d0zKbEx4K0vBu1QxaG8IZDX9rLtmNZEScot5xyytRzZy8EW7tBrp75dV1/EJn/
 bfsegiaHacptuj0QPfmUEWgeRCNeH6vYB7kjrniXyHujlcdr0cKjjZHbCYmFxohpinOQ
 L9akd9JSqojKK2shXGuhJ59xDgk/H/WY68+EpYlbkYuZDkcthOdBAeWIo/px6941sl5h
 Cd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084160; x=1764688960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KVG7JyknlAwdkehjmY8DMmPkYIXmQfn3iQVo+lFWKD4=;
 b=qYVSDmgcJDTScq4+hrwSYJw7awt0CntOvuzjUDjWVMy5gX514egHOJYZlnW9sMfoF7
 E+siyhhWvziVMpxSGN+rgNTbmvQ4yPfWaTvyrZcuNcXiouhjVxHbWVbkZO7+O1OAJp2v
 GCQkw/8kUXU39Fcumz5DVAsNlkBqR9Y+iFxmGFBfe7/38Hfkdj66VULV1p6HUHClngd0
 3xeHD6NX8+eUTkoIS4iJc5UlbYB8e96dBK4+Tb6weyAQ+0i55uXWhq6GfPPIXbSQU62e
 Q8fKt6JrL43X+H4luTYybc5JUDD9CwwQ+3+WAANFjpPmRGIhagJ01/kMCPLwYce1sJFU
 eH/Q==
X-Gm-Message-State: AOJu0YxCmeCtVFzT4ECiqB5LSTOaFcu1vF4PxxtKEb+cas27drrF8yO3
 r8QHIO9BM71DhHhz6y13MGVeJimZd0liOS6q0qTznVzBRBsuXDAZl7Dg7rx0FTHaZY1RMq4nTYy
 91w1q
X-Gm-Gg: ASbGncvLTmkW83ue9Gl5xfBYOfEt0Ee2BJ7sAe4l02doFBeJHlYAwpZAkQggtb2dQLT
 OZzDd8VKVW7u20TaPBGK2zZmZahgj6FsCWYQE/J3y//657Guiz/fxYqq5kkcRcYCzjxmI1x8PZA
 ECjKyfB/2dtR1jg09YC9wEhhyN/IvP1AMMcncjj4yPBYUSvrh7iHb0NAJkhPvwUmdoHyspSdifW
 UgKNc7zPkLP9bT06h+6YSlLDNUV9RNJQ31TNZrALlA3PgswxeYGYEL94iK8Le4QVhRrlogsRnky
 aQ/cCvKJFH8uV6Wfqz6O7SwPLRrQ7OXSZMfSSb6eEWvRKoATawLFKqGnFoiaXnU1kaQvU09j8Uw
 fbfRPp+zDVh4ttzb7vDJ810a7cAousABnYvUtb3db5wamivU/Cigl+hwE//XZXzMbKgu7DHaXn5
 xyayD0DAViowxvI96er1DQUCVq7oJAsWOMOfsVdNRtsVLdTg==
X-Google-Smtp-Source: AGHT+IEyEDQrJeXCJXrngEozoSReKMvMTXiR7avFyw+rvFajRJ4EXrMjakhJ2dXxFlyraMD7yFpDSg==
X-Received: by 2002:a17:903:2f8d:b0:298:29e0:5f32 with SMTP id
 d9443c01a7336-29b6bead4e2mr172921035ad.15.1764084159937; 
 Tue, 25 Nov 2025 07:22:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 04/10] test: avoid overflowing huge directory path
Date: Tue, 25 Nov 2025 07:20:54 -0800
Message-ID: <20251125152232.73528-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_eal_flags.c | 115 ++++++++++++++------------------------
 1 file changed, 43 insertions(+), 72 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index c3723ee0b8..6cf061864d 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -107,6 +107,7 @@ test_misc_flags(void)
 #include <sys/wait.h>
 #include <limits.h>
 #include <fcntl.h>
+#include <mntent.h>
 
 #include <rte_lcore.h>
 #include <rte_debug.h>
@@ -123,6 +124,8 @@ test_misc_flags(void)
 #define vdev "--vdev"
 #define file_prefix "--file-prefix"
 
+#define FS_HUGETLB "hugetlbfs"
+
 #define memtest "memtest"
 #define memtest1 "memtest1"
 #define memtest2 "memtest2"
@@ -136,24 +139,6 @@ enum hugepage_action {
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
@@ -165,45 +150,39 @@ get_hugepage_path(char * src, int src_len, char * dst, int dst_len)
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
 
@@ -222,10 +201,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
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
@@ -240,6 +219,8 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 				break;
 			case HUGEPAGE_CHECK_LOCKED:
 				{
+					int fd;
+
 					/* try and lock the file */
 					fd = openat(dirfd(hugepage_dir), dirent->d_name, O_RDONLY);
 
@@ -253,10 +234,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 					}
 
 					/* non-blocking lock */
-					lck_result = flock(fd, LOCK_EX | LOCK_NB);
-
-					/* if lock succeeds, there's something wrong */
-					if (lck_result != -1) {
+					if (flock(fd, LOCK_EX | LOCK_NB) != -1) {
 						result = 0;
 
 						/* unlock the resulting lock */
@@ -278,7 +256,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 		closedir(hugepage_dir);
 	} /* read /proc/mounts */
 end:
-	fclose(hugedir_handle);
+	endmntent(mounts);
 	return result;
 }
 
@@ -854,10 +832,10 @@ test_no_huge_flag(void)
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
@@ -865,9 +843,7 @@ test_misc_flags(void)
 #else
 	const char *prefix = file_prefix_arg();
 	const char * nosh_prefix = "--file-prefix=noshconf";
-	FILE * hugedir_handle = NULL;
-	char line[PATH_MAX] = {0};
-	unsigned i, isempty = 1;
+	struct mntent *entry;
 
 	if (prefix == NULL)
 		return -1;
@@ -877,29 +853,24 @@ test_misc_flags(void)
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
-- 
2.51.0

