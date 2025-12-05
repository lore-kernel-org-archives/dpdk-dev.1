Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE22D2CDFE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDBFF40678;
	Fri,  5 Dec 2025 03:29:55 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id E1CC440156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:29:53 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4ee14ba3d9cso15031101cf.1
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901793;
 x=1765506593; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=Zvj8N24AOO7pOIiDDGZsMu1CuGUbCO5XNwCgy6cfQ0+6f/YFIYd+sN/7AH3pJpl2is
 WIt/y1EfqnxX6/5wSMXOp9xzfkOdmWgTMPUg//xAWlokLx/ozYwIplqFxofSP3VcY/pb
 EdmmOCrSiPmYSoDvsqNO9BcI/45vuueVAvbnRP4aEN3z4rwarE894IuuJZRcaQcI/jiT
 Jn6PZB2SwT/iwNXDWOte//mopasT+hKLNvkN/W2vhfUrRbQ4Aa9HnA3Aqp9yEXv4Cif5
 ZuDQkfRBOV7zM5ThO1sIZSKy7vqWLNwVWHOagqRWrU/leJfssSYVqN6Wwta/9C4gy3wQ
 j+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901793; x=1765506593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=TBSeyHlGpmvr41jq1sgeGn+LVS8462J4rIvS3foHOLPmc5Hm1AMMRi2P5/3JiLlF4Z
 MYw2WVCHD6s/7Kt5Ib3ejr+KrlTlcZVf6DVokM2Qs+8D0axrAtenouvRKp6ohXddFeQc
 xHBzYcsJaHXZY8yS0eUavybM0OfI1RHjTiml99ziQ4R+QI6b/cL7KLbO0MFGviv8ro20
 ZT5wU9nOmiZxqgLm0aRR9FLv2ipmzI+aI37I3MzGPaTH6qZd2gzIT1ojBIJc6tpVVsN/
 7Z55vy/vrL5oUNfeiEWcPcCWxQezK0ys7jN/ENJw6UMfOrVkMpVo+dvAYQmQ3qUQvm4a
 zgDw==
X-Gm-Message-State: AOJu0Yy/jseTjDhtEUmfjMwMtqQu0SIsJR1LUVB3dRjc6xcLBFI1R3/h
 Xt52rO0WbxVFUubcd8OLW/yn7+TgD4QlM8HnE59MSK339izNfkiSjAEc6TNgWmkKm1TmkjQc5jH
 T+VXt
X-Gm-Gg: ASbGncs1m46xkc/1XrHbOzGNGd6KRFnDQhUZ6/Zw099RsPGdsdnIM0WL52iONRWHwKm
 0XP+LmCaYZ7pcc4uArWkG1EYxLUYoJwklvI2DSuEjdSOzgTxXgWHtRhCQhg/2FMw4x5fqggSAhC
 WQP+sXv33AO3syHVdiS5DM1cGP/tSquCSMBlFOdBlcM4iJjH0gYRaOgov7VFx6v4OLttnOjle7t
 ecahMK+DIH33eQYWHTO4ijkxj291XGjJnZsGsoeTrx8CTNoujIO6RdG+n29NyakTYc/oS5YYwAn
 5qVIxTlhUa4VzSbfaUB8MQeVZaDrYNQDx8J84UwxZ+LkobpeiB7sYEPo/gjnGWKbzoM1n2Gz/5U
 stlSBQCbaRL0OilTtOd2MfzNrAuxlJKti0E0h/2LkAVtglb1kBsBRDgtrRaYtbcweKBZMNmdnVP
 FekbkM4qzNFpDL8xC3TdyClsOMpnsJ9vG8y6nDSlLYPmbl++srFIm2HwUxRI7X
X-Google-Smtp-Source: AGHT+IHYUzmUTAX4kjD0UmBrNUQpbCGJb7kGF6O7hm2gvsYyts9Avj9YfSUXdcjQfj4CeSpgGeW3yA==
X-Received: by 2002:ac8:5ac8:0:b0:4ee:433c:efbc with SMTP id
 d75a77b69052e-4f0175fd5d8mr104656001cf.40.1764901793145; 
 Thu, 04 Dec 2025 18:29:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC v2 01/14] eal: use C library to parse filesystem table
Date: Thu,  4 Dec 2025 18:28:10 -0800
Message-ID: <20251205022948.327743-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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

