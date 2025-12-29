Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F78E92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F3EE40654;
	Mon, 29 Dec 2025 21:48:41 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 136AC40657
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:39 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4327555464cso1947511f8f.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041319;
 x=1767646119; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=Ep2nRLs90BQLp1L4LuT6P0jKbFUQpOgmLGYd5Om9Q3ZZ9+S+2x1Ewa473MCiIOJxc8
 hIsiHrUinsTZrJlNKQsL1GBDI1f5wT3LclnC2xYdcP62ocETPow2B07ugzPmhZ+Z/QSD
 a4O13TclA2ztjfmzCXtJZA+/zXQz6yLX1ZKw/Z/wx4FMcwJ6PHJ8zLEIta8KoSiXyxSF
 Sis4RRw62pAenexw4fLrHRfHS5t6MCJFo1cOWWluROoTiTzkCSYMEzv9lQmrs/mIoyla
 sNqKTQlf9XfgwvAosYMqunncVNemaHAK/JBNpeBS5GOIxpj7NB3YdFZ2+b0KIceYAr9V
 ZVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041319; x=1767646119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=UQHkP11pkFrF2/8Mx1aNd+ErTtMrLEBW1jtWronypokjB+m8s7GmKcdEV/+MghW6/o
 fCXf4ckCmfoZfWN/E4ElHd4Tfa/oTKXTr/LNZJQ3BpNNU+G32aHLguj6Cm41A0L+WKJE
 DYAXGvijxbM8XL+or/ysuG6G+gZmSQsqHVq13IBxkDXgkAEz3433ThGCL8kRNzDu+kuc
 4AxzEV3P53qMYJtxs07OPsERk9X4RuvUfqaHhKCOeflvE36CTZ4gIRE5IWdoAZ4iOy9x
 167y0pRdA/8EwEGc/Sw4LPxHlTCc5tmOCPJHhlGFWdU2lrIIFKWFaafLmHfzNO+YVqIX
 T+Lw==
X-Gm-Message-State: AOJu0YwX+j2GskmRjQ89RtBHpaerncuaVqbBIhte9SGWYiItJU5tKQ6X
 JJVgT61BE1if6v5yaDJmkrpDMmOgRrQPTKkgs/V1fU9G2yhHuQaCNNkTfoED8zaMzA8D8Da8IZG
 Ei+lCL7Q=
X-Gm-Gg: AY/fxX5L8/x3BgrUhPuKJn/o+5MPbggcHM6X9M4/CjqeZS0olIilBnN5ZfEQ0kst1yv
 iqOxlhyxz6Qpbfb0TqINTmoPw5Q7OGzsScpzhndBI8CRrovbioJp7YlGEFOnvOu6Buej63dscqP
 52ELQLAG7tj0ru+wSYfF7ZD7CxWMZfYFY33w4OEOXjB115x0LKd/zje0DrQ/fPrI3p88NONCj2/
 ml1S2wkV9SxCDaQOJ/7sUnBv8b1aQ6OuFYD+TvB05+mAmApHJhLzX7/cYGlBqlTXBKkLpDp4Qye
 neYVe+UzZ1OCGcHWx6mUhsibCOpOd0e1H6K2KX4LEsa251XxAS6DK/o8aKi6saXZ8hLnxgr+FhF
 IH77kg2DY9qZ0HONQg/5rGMcwCAWaSR4cAB10DSTmzEjAbuXclBCrWZjWkTMw7qsmHIaFjKL8fF
 apxztp6TeGzDLt5HY3bB7bNme6UkBGlTN2qrQaQXPztdPWDYn9Og==
X-Google-Smtp-Source: AGHT+IEGpXlSydD+YsbvH8+vcDIGN3tqK/UB9IqSfHA+IL5LZdvejwmiv0fZM/o3wNkHCvGQf29OOQ==
X-Received: by 2002:a05:6000:1865:b0:42f:b9f6:f118 with SMTP id
 ffacd0b85a97d-4324e4cc03bmr43297078f8f.15.1767041318655; 
 Mon, 29 Dec 2025 12:48:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 07/18] eal: use C library to parse filesystem table
Date: Mon, 29 Dec 2025 11:38:05 -0800
Message-ID: <20251229204818.61231-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

