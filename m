Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A220D19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21D3140B92;
	Tue, 27 Jan 2026 00:24:51 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id A241640B97
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:49 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so4379358f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469889;
 x=1770074689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIloIverS70aBstGR7QJyCROQFZSsSB4E6JDeF0+MKM=;
 b=gCbbbbUzV4CnK/r/3rcT8yiqq2hYFpPpy7RSd4jL+br5nuuSrAvS26VFiEYnA7ukYM
 98Zr3ZX00Be3275aWiieaGBB9QVnYfBR3fDDHiAc2X3ZwtuXPreIfqrR/snc4uigWgII
 jb4TGJFdUOYD1onwpUu7YOpn8bC3z7Z7g9GsBNLwB3otqhi5kiHeGkhBNIEkNl9qaKCt
 gQErau67vrYRIICvhKkCAu8ecD8+SVF0MkILniMbQYY63MAt8EGFr1NDjy1HthQhkORk
 ue9fGTqnbv3sVliHDOUWae9ebLehVtqYdErD1Rsa48aBIqo3RxC1BOQ6/pqv7266suMH
 1jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469889; x=1770074689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HIloIverS70aBstGR7QJyCROQFZSsSB4E6JDeF0+MKM=;
 b=Sw3FIJulZdWIH+GZW253Ai4cYDkiprlC+/vs9OHd6VhWooom9L2cXZQFooqoUFLZ/v
 5Zo6/svf24tved1oeECrhyN4TjPGUbjhwvm2+wPNoHIRMhkhZkmy+sXHVFiKzJKUVbDK
 k+qNBYo+lgFbjUMDhKjX5ik9KND+ymG94Sgwovemyp+lWrT+HqoTv0p2m6LL9T8kd7QW
 MLdy5HVlAEqNN3Ap9Fa43g2BV9uKP8tf0YhhXmOsYNqL2Ut6BaFNtfcduCtzx9Mjd00b
 R8Zdi7j9UF0HP+NHESx3aVKylKnVJOkW3UCetsv741xgVRfArxP42noBEVK2HFuB65xq
 zYQA==
X-Gm-Message-State: AOJu0Yyl+wXyUrlhdHVSIWZsZCBSYJwULfrwq7FT0sKYnYvRj9p5Rsvn
 I7TvvgGLL4xBJNURHlE7YoNciqyyjk6RevQ4GJlR5IWA1hB4m5xRbQMvdx8+IsIRedW4nAeqklQ
 R2Y7K
X-Gm-Gg: AZuq6aJL4V18YzdEw3iB+vorG27mMySltf+1mHWUjY1K8pizrc1vDOKPw+DWC5dssOS
 tLYoalNoYiPcoQHoyXN3zoCtNlSYUhn/7P5NaytKYYI9W6l1fzFyFRNYoBRs0yoQJhOHU7YOYcK
 N9H6VKO7INsec8Z35aa7N4wnZQmMQfjyVaq0ug4ibY+El2ly/xd22i/hnM5o8K/N8XDDjb0Jwro
 Up0ribLNO4jdSH6atDj0VverruFKZvTQnPxXws6HMXDr+cdAacksKTGlwTfJ6fDYFB4ysEi1Hpu
 UbI2DlKeVrLGNFSRYBSyWcTU5iBXZJ8+CLd5mWpUbZqNSOF4FEmmi8a+fW4VcNVje+GGddGjUxT
 r2zITVz6zW6wS/fi5xmFzX5nMsGalZYwm7K3PbKqgjzSBa0fj6iuXHNfUyzvFj/gizBiIN/0z9n
 NpmHtYcoWah02IhlbRMQZ/CVjV3wZVTcp23bnQJscznRtnzLY6EQ==
X-Received: by 2002:a05:6000:2312:b0:431:9b2:61c4 with SMTP id
 ffacd0b85a97d-435ca39ad53mr9414904f8f.45.1769469889144; 
 Mon, 26 Jan 2026 15:24:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v12 07/17] eal: use C library to parse filesystem table
Date: Mon, 26 Jan 2026 15:22:15 -0800
Message-ID: <20260126232428.276534-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/eal/linux/eal_hugepage_info.c | 78 +++++++++++++------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..f4c03b7ce5 100644
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
-	char found[PATH_MAX] = "";
+	char *found = NULL;
 	char buf[BUFSIZ];
+	struct mntent entry;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 	const size_t hugepage_dir_len = (internal_conf->hugepage_dir != NULL) ?
@@ -226,56 +217,45 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
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
+			found = strdup(entry.mnt_dir);
+			if (found == NULL)
+				rte_panic("Cannot dup %s", entry.mnt_dir);
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
@@ -285,16 +265,24 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 		 * We found a match, but only prefer it if it's a longer match
 		 * (so /mnt/1 is preferred over /mnt for matching /mnt/1/2)).
 		 */
-		if (mountpt_len > strlen(found))
-			strlcpy(found, splitstr[MOUNTPT], len);
+		if (mountpt_len > strlen(found)) {
+			found = realloc(found, mountpt_len + 1);
+			if (found == NULL)
+				rte_panic("Cannot realloc for %s", entry.mnt_dir);
+			memcpy(found, entry.mnt_dir, mountpt_len + 1);
+		}
+
 	} /* end while fgets */
 
-	fclose(fd);
+	endmntent(mounts);
 
-	if (found[0] != '\0') {
+	if (found != NULL) {
 		/* If needed, return the requested dir, not the mount point. */
-		strlcpy(hugedir, internal_conf->hugepage_dir != NULL ?
-			internal_conf->hugepage_dir : found, len);
+		if (internal_conf->hugepage_dir != NULL)
+			strlcpy(hugedir, internal_conf->hugepage_dir, len);
+		else
+			strlcpy(hugedir, found, len);
+		free(found);
 		return 0;
 	}
 
-- 
2.51.0

