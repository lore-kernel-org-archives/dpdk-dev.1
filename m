Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69EFD1171E
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 790884042E;
	Tue,  2 Dec 2025 18:26:33 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id BE863402DE
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:32 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8b21fc25ae1so544719885a.1
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696392;
 x=1765301192; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=GWGF9rccfCXntzA+qV5s6RpD1CwmWb4YNbUxOxM1MwsKyxjbDeC/zTyj38uzS4ZIJh
 loBNeTLvogoMoeD+KCRUewoLub14JKFlY5gQaJZGwAqLI74YELAGMDSa07djlcBvp5WY
 cOw0kePvOLeum9iERkRFGmfJcJKb6uWnfG/sLBpeRt9tFR37DJCgVTcswFehtcrIMDW2
 BWibtuHKnPHoprVHaYdqRZAuM0aRNCgEgubHZwWCnZRmiUjsyFZjTlfAWCPv8V8qlwjF
 C21TW6lN7m/Jbgwvmmv4eSWXNGLE3e7UzmCpDKmxT0oNkixsF2/oJiKKGdCl6qWV7eGE
 85tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696392; x=1765301192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=dnsNyuiPewfD/tcKuyJjGqD06ER+7S2w0L0q/8S+hLLWy50OCPyaZNwz+iaGsuareg
 YHBW4dm9Jx7FDcBMa5gx3r7dOlcuE7IO8e4g4YFAE83iq0jKuLXSzzEjEcs1JvWMjYx2
 q0ehh5DQepDJZR4d87Puiqax91dSq2RIYZqcPFxHgFTYhXOBYquqW53RZ9/jTrJ5e5l/
 L6+1MIn8s8R/OTMU61vi3+LE9khiZvXj4410TcixzmRALMq1kr6rY6BeVzOhTyCbmX95
 Z+Sily9YuEeoKDN4ZqwJiZ8RaMGDJXXTEWfNkn2wmwAkRasDmoQEIyWxWvCJ4axKZ1GM
 SdGQ==
X-Gm-Message-State: AOJu0YzVyTXWpowfnXexXw/IhgRGk3tlWIO6gu5isL4afCSZqZrClERH
 Kv+Eb0Nv9VE5IBvRqjhFp3WN4shpkSLkVe8zzMgqIg5ecU24MKXCD8z6mHx1h2IfaThZhwTt5/y
 riK5W
X-Gm-Gg: ASbGncsuZqA+Qj5+bf6jJD5upMqJfq+GB2eKKbkC4szRLaIasB8VEnRDx3Z6iPjDPeg
 p8yG0zof+kfV0OtI3W+lcSbFwjYsAqmAzrtOF2jQjzqjm2rpvYbtLNe59iHCtGperqZJbmZ944e
 oDePu8Y0GWQVSGFIdvmHSnTTZw6tAF6Ukg8LIrws3pRyetAySc1v4qDPUis24Irkt+VXrqC7dUy
 SpazFi2Yk/O5gghHPQqQvlaxs9EqvWAF5G4Q7z2ZbIDKt0P8ks2YhK26fxtLnTIVHKkbVqh0waW
 O89EMzYUxAM8c0YrCMGrvi1YqdGxXZX5crRtL8K9CO2mMZdW5tvgQqMki+MvGOmsz5Uv4f+BnUD
 WuExDUtcJX4nM9tVMKLKlIPpSqFkwdc1W2UFYhvIw6IobUVXkHIbgUl4Wru04iMs9b2Slvumt/F
 XtNkbkQqFlewcNTp9Jw+ysW1UDOoTCf/rLgVIsZe97rEom4N2SrA==
X-Google-Smtp-Source: AGHT+IEMEbmtcCJmlagttcLOVBKJbr+DSEgX8VjU4COu/OKJmBhzc7MTHYPiRXLLji1aqJUMVVoABg==
X-Received: by 2002:a05:620a:4090:b0:8b2:213a:e2e4 with SMTP id
 af79cd13be357-8b4ebdce632mr4697055685a.84.1764696391916; 
 Tue, 02 Dec 2025 09:26:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 1/8] eal: use C library to parse filesystem table
Date: Tue,  2 Dec 2025 09:24:27 -0800
Message-ID: <20251202172626.283094-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

