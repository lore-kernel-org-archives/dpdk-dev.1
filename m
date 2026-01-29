Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD820D46BF0
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E57AE406BA;
	Thu, 29 Jan 2026 02:43:34 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 6DBEA4069D
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:33 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4806b43beb6so3261285e9.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651013;
 x=1770255813; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzuI2IRwk1XWqNBUVDXztQtH4fhpciuoOakomBdfKDY=;
 b=Xe7ldvpy9EeABKWakzvG1rnYRQVKqc5S/sUEBhBO+rodslZPNTo5tGvlDAmA2tfLww
 wD2l+Kiya9kLv8FItwZ0hlpy+ZQZ5DpweZehwrDDTzNakpJfzx9gKKRUAWlXnN077AEG
 OnFKqCSGBLKtdzjsoCK6DbNFFigktbFDf1MdNbyDVEHf889xsDTjBpgU8azVyvQlY3v4
 acoPgx1hUbP8NCK/iLF0nkVU7xslejE9M6pdyagQwmcAvtaOArq8zQIwJT/HkAyPGxjl
 tbAjBtGvkEOHcFLlF/Cu76I23vxN14qfd2o/c7+a78koS974WnXtELmtIdqy0bc5FTIs
 m3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651013; x=1770255813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vzuI2IRwk1XWqNBUVDXztQtH4fhpciuoOakomBdfKDY=;
 b=HVwj4PQewf03r8AedGie2uAusdSLN0YKokG7mU4JuDdqst1NucEdbeDKkPvSPRSmjq
 KURpasL878KkpswzIed4zZ7oeQ+ms3KURLfoTEttkOo15ysakdARtWieLRQ+RCAV98gK
 2vVIC2pT5hbdBRWrOwduO8FJKZ6d2FWuMGYTUo1WWid9Ev0LEvffsW4Bvv+zOqVA9Qqf
 /uD4XGbkNyrB2tr0kCnBq/Q6JD5U3hpzENiqmj91+GVLwtxDXHowQ4RQJqXVFiBXXj+w
 JW6G6hS2Q5iKIcUQ+S6nHbHtGRip2eGDkC7gNLrqYk1yTXMy1VVmlqay8gy3FnQ5JvTl
 sroA==
X-Gm-Message-State: AOJu0Yze8iVdUV61RTpODuYK4J3DFXwhhpqGyquTlNfbQ/pymeGQ+iXm
 i7+P+uTXxtyM0uSwI8EEVk4MKJaOm+Bu78pDPy6xdMwRtdnkFOaQTlB0/7eVFLEZqWbO3OXBOJ9
 7uq7n
X-Gm-Gg: AZuq6aKUOQ5RGeGV0+nXxm3KV3wzNrl9m3HmBB9FWw909x2XPda+wXrW297r8BcX5Et
 YjdhSPEL4UPzQLeCuWqUPWRxJ/dlaUiPCwqpmXfa0Iqi18cAzmxQO6j4ql5Wcsua8fzZ+9nc9u3
 5NYqNLK52jeEjiMNBgVeMMlo8MDpoErUhJwhO0gym1LZd/q57O13X0q5aQ7wXNxXGFcqOMKHw+a
 sutNxWfz6I9JH81LSpK1Yw32AEr1xT/ySEHG0pWUJ/CeKb0BwUsnRwMmLbOX7WJUUt4gPMa7cN9
 mnH8mQ2/OhpogsikDt2kgFTN+kGrdC73MmwnatgW3YfGMEg5asd6NN09Zn+2wQzHuxWqYHXw5oG
 oMS8OLKhxoYPKbvx60qC+/0Q2ZA+wcJ/ATLIiaCeY/aolXH7mLxB3T0TMPSvaeF8IxCU3LR3wMO
 3CUTJ0Ml1NbTRBjUBsd/nAEblZfmXtmsnlG5hPOBiZvQRlO7Hqkw==
X-Received: by 2002:a05:600c:3b19:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-48069c5fd06mr74015905e9.26.1769651012977; 
 Wed, 28 Jan 2026 17:43:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v14 07/17] eal: use C library to parse filesystem table
Date: Wed, 28 Jan 2026 17:41:10 -0800
Message-ID: <20260129014313.939831-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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
index d47a19c56a..f3ee474735 100644
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
+		    (uint32_t)sfs.f_type != HUGETLBFS_MAGIC ||
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

