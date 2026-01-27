Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0FED340A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D5C940EE6;
	Tue, 27 Jan 2026 17:33:21 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 7FDCD40EDF
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:19 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5975801f8f.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531599;
 x=1770136399; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLM5Szddv2V3DColfb/qRh5YB3IfmD9dWlgK3HMtaJs=;
 b=kIc7+/EnBI4MlKPUvsqbuTvyHVqMlVZ/i2I8zUXzdw405lrn6suGP6rCBEb43aneck
 k9gDCM6cG48BG7MrZEqDbRc6cJQv26vtonUq8VEztbZGEQw3vg3qjIVXT3EkMyVuKkmp
 VS2BOetD0dxkBiUFik2P4pJVdbK7Ti9hUbyxzIzl2WVjxp5q9uKrPU+wpzSoS45c+U/H
 zgUIsUr38sxV1R8G0Vsrqm3w1CsJMqKXLMmLQyalI5j482auA+1C9izd5BKhrpOhuup/
 E6dGJPUsBoyMkcfB0m4s8899I/Sa7cZGWekrcJQa7G45ezEWEy61YMDcU13xZp4wJuCR
 hGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531599; x=1770136399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KLM5Szddv2V3DColfb/qRh5YB3IfmD9dWlgK3HMtaJs=;
 b=AR74pXmyWE2WccJzOn3S8ONRoIaVCBkGjX5Ex1lomAlIEOVK34hK1W4GkcskAA9yCS
 R3Em4gyYcs1vYAtBgrbqyVoAyePDeORrEJy9IlvEP/c8Yfixdkf2+GwxA4glO6PBP9Gv
 SwfSgH9/MNW2IclYvDopeE9sXYwinkJeKOit/PQX+H5PX0yC+qTqy+dKPRhvhCmFz4YJ
 0l1pvKmKINFaSEP6s3vqhk7dbT6+mnl2r+C2H79EHZXtPNLuDZnWXDokuuJm2DNpvsmP
 WmqsSxrFGNEFcRsS1EGcQmvkOvYkU+4qSIgOENQJ41WQLaVRD8eMCK9o9e4vWfUODYbK
 YIOg==
X-Gm-Message-State: AOJu0YyhVn89cVAcfMk20s3vxSwybWpI8tao0fNq7OphOdydx5GWkCE6
 eabOg6w8E8JK8lFkH6dUIOhXo51qOMMzp0o/ZinB65qZjwCX1oF/UbW6gOze0zqSElZd7yA/NCh
 3SrcM
X-Gm-Gg: AZuq6aI+Yf44PkHPCnBRKOufow5+tfnE5iob7iTi4u5b7HEpi8hYPiIqvyVi46DCJsP
 oPkOkBRItaaAr0USST/IQs5Z9bTDtRqaeIITFmmcGJKFOnUrAz1hvYYJymWhbNp3x7C0Y7MYAO/
 hh9uR6LElldYvQSPCVeCvtMpsYP9byIEj7B9JUNCp/GudkJ3ivbzcUE+BKHoRduvMyWPDLCQa/L
 t6uNzqNnDqls3zfPIPpbP5r8XrEKZ115mKz4XsfGeXzQsdyRehz91qQ9nEP1ulC5hgB6zpDO5S9
 by5+GI89/5BoEG1gi7PG8G7xM9iNJC9hfiTkke/TVugIYI5ePZzcvdi+2CMamMrScsmy/hoAwkr
 5y2WK/yQD11IIOFCNGF7U4gJ48AH33CgB9LUXxnqdzLSiNx/41IAmqFkDEXuSfNZKDvhUnM0I4n
 OE5WcBakZ0NVBC8dFkrs+N+2JewnikKZTLqnso8kvYwn+IOk55JRgwpWY/mrac
X-Received: by 2002:a05:6000:402b:b0:435:9ee1:f91a with SMTP id
 ffacd0b85a97d-435dd1d61c4mr3677271f8f.53.1769531599034; 
 Tue, 27 Jan 2026 08:33:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v13 07/17] eal: use C library to parse filesystem table
Date: Tue, 27 Jan 2026 08:30:21 -0800
Message-ID: <20260127163258.75566-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

Replace open-coded string parsing of /proc/mounts with the
standard getmntent(3) routines available on Linux and BSD.

When hugepage_dir is explicitly specified, use statfs() to
validate the mount directly rather than scanning /proc/mounts.

Using the C library handles edge cases like escaped strings
in mount paths automatically.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/eal/linux/eal_hugepage_info.c | 104 +++++++++---------------------
 1 file changed, 29 insertions(+), 75 deletions(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..f6d7098a07 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -13,10 +13,13 @@
 #include <inttypes.h>
 #include <unistd.h>
 #include <errno.h>
+#include <mntent.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
+#include <sys/statfs.h>
 
 #include <linux/mman.h> /* for hugetlb-related flags */
+#include <linux/magic.h> /* for HUGETLBFS_MAGIC */
 
 #include <rte_lcore.h>
 #include <rte_debug.h>
@@ -195,109 +198,60 @@ get_default_hp_size(void)
 static int
 get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 {
-	enum proc_mount_fieldnames {
-		DEVICE = 0,
-		MOUNTPT,
-		FSTYPE,
-		OPTIONS,
-		_FIELDNAME_MAX
-	};
 	static uint64_t default_size = 0;
-	const char proc_mounts[] = "/proc/mounts";
-	const char hugetlbfs_str[] = "hugetlbfs";
-	const size_t htlbfs_str_len = sizeof(hugetlbfs_str) - 1;
 	const char pagesize_opt[] = "pagesize=";
 	const size_t pagesize_opt_len = sizeof(pagesize_opt) - 1;
-	const char split_tok = ' ';
-	char *splitstr[_FIELDNAME_MAX];
-	char found[PATH_MAX] = "";
-	char buf[BUFSIZ];
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	const size_t hugepage_dir_len = (internal_conf->hugepage_dir != NULL) ?
-		strlen(internal_conf->hugepage_dir) : 0;
-	struct stat st;
+	struct mntent *mnt;
+	FILE *fp;
 
-	/*
-	 * If the specified dir doesn't exist, we can't match it.
-	 */
-	if (internal_conf->hugepage_dir != NULL &&
-		stat(internal_conf->hugepage_dir, &st) != 0) {
-		return -1;
+	/* Fast path: hugepage_dir explicitly specified */
+	if (internal_conf->hugepage_dir != NULL) {
+		struct statfs sfs;
+
+		/* Query info about mounted filesystem */
+		if (statfs(internal_conf->hugepage_dir, &sfs) != 0 ||
+		    sfs.f_type != HUGETLBFS_MAGIC ||
+		    (uint64_t)sfs.f_bsize != hugepage_sz)
+			return -1;
+
+		strlcpy(hugedir, internal_conf->hugepage_dir, len);
+		return 0;
 	}
 
-	FILE *fd = fopen(proc_mounts, "r");
-	if (fd == NULL)
-		rte_panic("Cannot open %s\n", proc_mounts);
+	/* Discover mount point from /proc/mounts */
+	fp = setmntent("/proc/mounts", "r");
+	if (fp == NULL)
+		rte_panic("Cannot open /proc/mounts\n");
 
 	if (default_size == 0)
 		default_size = get_default_hp_size();
 
-	while (fgets(buf, sizeof(buf), fd)){
+	while ((mnt = getmntent(fp)) != NULL) {
 		const char *pagesz_str;
-		size_t mountpt_len = 0;
-
-		if (rte_strsplit(buf, sizeof(buf), splitstr, _FIELDNAME_MAX,
-				split_tok) != _FIELDNAME_MAX) {
-			EAL_LOG(ERR, "Error parsing %s", proc_mounts);
-			break; /* return NULL */
-		}
 
-		if (strncmp(splitstr[FSTYPE], hugetlbfs_str, htlbfs_str_len) != 0)
+		if (strcmp(mnt->mnt_type, "hugetlbfs") != 0)
 			continue;
 
-		pagesz_str = strstr(splitstr[OPTIONS], pagesize_opt);
+		pagesz_str = hasmntopt(mnt, "pagesize");
 
-		/* if no explicit page size, the default page size is compared */
 		if (pagesz_str == NULL) {
 			if (hugepage_sz != default_size)
 				continue;
-		}
-		/* there is an explicit page size, so check it */
-		else {
+		} else {
 			uint64_t pagesz = rte_str_to_size(&pagesz_str[pagesize_opt_len]);
 			if (pagesz != hugepage_sz)
 				continue;
 		}
 
-		/*
-		 * If no --huge-dir option has been given, we're done.
-		 */
-		if (internal_conf->hugepage_dir == NULL) {
-			strlcpy(found, splitstr[MOUNTPT], len);
-			break;
-		}
-
-		mountpt_len = strlen(splitstr[MOUNTPT]);
-
-		/*
-		 * Ignore any mount that doesn't contain the --huge-dir directory
-		 * or where mount point is not a parent path of --huge-dir
-		 */
-		if (strncmp(internal_conf->hugepage_dir, splitstr[MOUNTPT],
-				mountpt_len) != 0 ||
-			(hugepage_dir_len > mountpt_len &&
-				internal_conf->hugepage_dir[mountpt_len] != '/')) {
-			continue;
-		}
-
-		/*
-		 * We found a match, but only prefer it if it's a longer match
-		 * (so /mnt/1 is preferred over /mnt for matching /mnt/1/2)).
-		 */
-		if (mountpt_len > strlen(found))
-			strlcpy(found, splitstr[MOUNTPT], len);
-	} /* end while fgets */
-
-	fclose(fd);
-
-	if (found[0] != '\0') {
-		/* If needed, return the requested dir, not the mount point. */
-		strlcpy(hugedir, internal_conf->hugepage_dir != NULL ?
-			internal_conf->hugepage_dir : found, len);
+		/* Found a match */
+		strlcpy(hugedir, mnt->mnt_dir, len);
+		endmntent(fp);
 		return 0;
 	}
 
+	endmntent(fp);
 	return -1;
 }
 
-- 
2.51.0

