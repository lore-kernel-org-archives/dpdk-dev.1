Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10833E78497
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E22CF4066D;
	Wed, 24 Dec 2025 23:13:29 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 16BAE40262
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:29 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so2702538f8f.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614409;
 x=1767219209; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=L4CEn+AD4eWbAFUOw4vvXSPfLLpD3DYJbhH0RIMW14mbW5NWZSOYCFid1g/YMsSEy3
 cf73UI8mDcn2HCaxIwgDlmS1RIgzfIqbOlE8ZhV7Idx/jd4Y+qdLB3CW1ZWBjXi40bla
 iTW51Gom14GVpCeHKcqwu0o5HnJA5av/rbFn+4QMICqoqArWHcRY0nQrMxMrXBJsluo6
 0J3RMpPGdkVomCh6gBLw+09W7yUDbwJGMsY+XwExVA/ox3cCDUaWtxPtuDvHky7nSMmB
 ouRbewmvj+5GbemalrcQtgBJutyho3R/Uu3QutAMESTmWiA78e+naAcwe5jUCrqob9Wd
 UjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614409; x=1767219209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=Lo8JYl7F6PoOZkL7TvzN0cf8xjA444pzrMIXzqCMS5TvimjUXeguasM6Vegjba4XHh
 5BlQZGk3uJff+/28LRZGHSpXg0/okANsmUps99qYl8HxmDnwVrYqxTK80X6FCRFpAMmM
 /ebWnxhzN+3IvCkQpcGblpU7WUrXLSpA6DoWhDOMfZ0H+tgVAab49eNkIS4qzmNTNuSP
 3nm0l3gW3xuwnwyhDSsy2q8XXn0WeArj/F1D2GVkp9ZRivIbo1Iff9R8np6DDdfGNJ+u
 +Q0yb+skYXeuFg1kq9m8DPDmZWySQbtNJQlXpjMIxyXoBXjTtUm9IssRJ9JKXj6Kj+ni
 oOfQ==
X-Gm-Message-State: AOJu0YxuO2f7eWWzmJaXfOaB6cps2U5l0z26T4aEeK9IS5aZUUVXtjsX
 M1Cmq0WP9MB2O0lCye01r/NDzF6IvF4qA2GamlZxUSiTHUq5nJO1u3DDtKi4Bvdqtdg/NIvigA5
 CDl+blmk=
X-Gm-Gg: AY/fxX41uBHooFkgxrVr4KolaE8QmmyitBYqQZYwyFCgRLQml5846ktYwqfFGDVm54b
 Zl+0rgZ7ltPK1FTQhEGPNFpty2yZRA/MkDSWP96avh86spVjrQucyEl7yiekpBT6Tggg1qYbkeq
 tv97V/Gqyce6HM54s7jyg/EsFyoau5mq5bloCsH/o2oHk+ixmPC8iFqEMipbUb9j46ifV3jJzeZ
 LqQr14J/S5GNF0KDwTq/+AdknLkQY8IDuSIf61s8HKMhUtDJoY4hmf3Xjm1oWin7/6A85X9msni
 7wuF8htucwVM+4Gx6YDWbsIDZhXiERlaDybmaFnhuCLtCGFSTRFFSrVHzBWY1i4LO4PUNxo//1M
 6gukl9OWcMbW6iCAXeILS9E2+0Ne0T8PvruS0NKKE9EJHGDCFCl+hcv7i16lYyOR/voSCi/Co+H
 iV/pJ/oZejYdjvFBeq32fjaoc8TYHA/LDwBVSHKykJkxCbPKgI4A==
X-Google-Smtp-Source: AGHT+IGEo7WrDDNl+X2KWyqvZWhTbUiU5rwLIuYNpGAmmCHRaTDmSWAC8p/AuJqIV4mUC3EJIxmeag==
X-Received: by 2002:a05:6000:400b:b0:431:4bd:4edf with SMTP id
 ffacd0b85a97d-4324e4fb0bemr19532885f8f.36.1766614408685; 
 Wed, 24 Dec 2025 14:13:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 07/18] eal: use C library to parse filesystem table
Date: Wed, 24 Dec 2025 14:11:48 -0800
Message-ID: <20251224221301.52714-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

Rather than doing parsing of /proc/mounts with open coded string
handling, use the standard C library routines.
These exist in BSD and Linux.

It also avoids any possible issues with escaped strings etc
which the library handles. See getmntent(3) man page.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/linux/eal_hugepage_info.c | 58 ++++++++++---------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..7161b1a2fb 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -13,6 +13,7 @@
 #include <inttypes.h>
 #include <unistd.h>
 #include <errno.h>
+#include <mntent.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 
@@ -195,23 +196,13 @@ get_default_hp_size(void)
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
 	const char proc_mounts[] = "/proc/mounts";
-	const char hugetlbfs_str[] = "hugetlbfs";
-	const size_t htlbfs_str_len = sizeof(hugetlbfs_str) - 1;
 	const char pagesize_opt[] = "pagesize=";
 	const size_t pagesize_opt_len = sizeof(pagesize_opt) - 1;
-	const char split_tok = ' ';
-	char *splitstr[_FIELDNAME_MAX];
 	char found[PATH_MAX] = "";
 	char buf[BUFSIZ];
+	struct mntent entry;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 	const size_t hugepage_dir_len = (internal_conf->hugepage_dir != NULL) ?
@@ -226,56 +217,43 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 		return -1;
 	}
 
-	FILE *fd = fopen(proc_mounts, "r");
-	if (fd == NULL)
+	FILE *mounts = setmntent(proc_mounts, "r");
+	if (mounts == NULL)
 		rte_panic("Cannot open %s\n", proc_mounts);
 
 	if (default_size == 0)
 		default_size = get_default_hp_size();
 
-	while (fgets(buf, sizeof(buf), fd)){
+	while (getmntent_r(mounts, &entry, buf, sizeof(buf))) {
 		const char *pagesz_str;
-		size_t mountpt_len = 0;
-
-		if (rte_strsplit(buf, sizeof(buf), splitstr, _FIELDNAME_MAX,
-				split_tok) != _FIELDNAME_MAX) {
-			EAL_LOG(ERR, "Error parsing %s", proc_mounts);
-			break; /* return NULL */
-		}
+		uint64_t pagesz = default_size;
+		size_t mountpt_len;
 
-		if (strncmp(splitstr[FSTYPE], hugetlbfs_str, htlbfs_str_len) != 0)
+		if (strcmp(entry.mnt_type, "hugetlbfs") != 0)
 			continue;
 
-		pagesz_str = strstr(splitstr[OPTIONS], pagesize_opt);
+		pagesz_str = strstr(entry.mnt_opts, pagesize_opt);
+		if (pagesz_str)
+			pagesz = rte_str_to_size(&pagesz_str[pagesize_opt_len]);
 
-		/* if no explicit page size, the default page size is compared */
-		if (pagesz_str == NULL) {
-			if (hugepage_sz != default_size)
-				continue;
-		}
-		/* there is an explicit page size, so check it */
-		else {
-			uint64_t pagesz = rte_str_to_size(&pagesz_str[pagesize_opt_len]);
-			if (pagesz != hugepage_sz)
-				continue;
-		}
+		if (pagesz != hugepage_sz)
+			continue;
 
 		/*
 		 * If no --huge-dir option has been given, we're done.
 		 */
 		if (internal_conf->hugepage_dir == NULL) {
-			strlcpy(found, splitstr[MOUNTPT], len);
+			strlcpy(found, entry.mnt_dir, len);
 			break;
 		}
 
-		mountpt_len = strlen(splitstr[MOUNTPT]);
+		mountpt_len = strlen(entry.mnt_dir);
 
 		/*
 		 * Ignore any mount that doesn't contain the --huge-dir directory
 		 * or where mount point is not a parent path of --huge-dir
 		 */
-		if (strncmp(internal_conf->hugepage_dir, splitstr[MOUNTPT],
-				mountpt_len) != 0 ||
+		if (strncmp(internal_conf->hugepage_dir, entry.mnt_dir, mountpt_len) != 0 ||
 			(hugepage_dir_len > mountpt_len &&
 				internal_conf->hugepage_dir[mountpt_len] != '/')) {
 			continue;
@@ -286,10 +264,10 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 		 * (so /mnt/1 is preferred over /mnt for matching /mnt/1/2)).
 		 */
 		if (mountpt_len > strlen(found))
-			strlcpy(found, splitstr[MOUNTPT], len);
+			strlcpy(found, entry.mnt_dir, len);
 	} /* end while fgets */
 
-	fclose(fd);
+	endmntent(mounts);
 
 	if (found[0] != '\0') {
 		/* If needed, return the requested dir, not the mount point. */
-- 
2.51.0

