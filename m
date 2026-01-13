Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF3DD30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC048406B6;
	Tue, 13 Jan 2026 21:23:49 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 1F73140695
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:48 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b83122f9d78so1263086166b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335828;
 x=1768940628; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQEnkwKLprX5Xvwi8GM18V0Mvd2A5VlceomuKmGaAtA=;
 b=EKxnMiwTABb9lE1WEC1Yk5/dKYq63ivU6zMYK5aq4gB3TQWWSv+LgVmOb/EcuRw2gC
 IKgEK/SCeE0ZqMX1uHbtqM3QHXafJbZ3oqzSSLnd2gGrmUcmjQJH47icXLiXy+z7hvE3
 Pk9kOm0JLfcQAdgN9kZbEfuGC9XasJYrI+eDp8QOC/9wsTO1dKGw94jig1CIQVOtCPEC
 EbrXULDqNQVO17ssAtVc9SsCbttpzs7aWwfT0rdvF4nU61Jekj2AdPWHo9ftHdT7U8As
 ixRxTAxIssypXGpX/Xt5LClru+0h9L1ANDhtNOIyhOnyMseW+LltZpM5iSDTqoG9rJLU
 /dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335828; x=1768940628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eQEnkwKLprX5Xvwi8GM18V0Mvd2A5VlceomuKmGaAtA=;
 b=HFV0XycjzG94P4nSRldyegkvPFtrsIlW4hYukEk+UwJrQqgDalh+IlwYlpu6LAU11O
 XG1BMe2hmmAmCXe2By6IZat8HbhoVQx0/Wyc09I9TDpkM6plMUPxl/dJpoiAgwGH1qEW
 K6Ki+u/RgH5bSd9GFmeg3aD0s/OjaaWzeu5vNadQbnpP2fVR6XciYmHW/FBMvb4P0FlQ
 /Cr45Q1XwSWaYbjwl3NM3BSOeOTGZZNxW0tvZI44ehDFbzBvyN1mNUIE182qlqn7HgSy
 YKFwnGYdD40fnD3J2vMQQuxCjc4bfgetlzyPhlnOGLJWdyNoQdIWVXBZlqMjRrqqGNNg
 t/tQ==
X-Gm-Message-State: AOJu0YxylDKmlEgIaC+VYI1VDXs6u8ZXXBvKURZtpLI13u7LKn4BhN2I
 L1Ljc5ztxmoJH0Lk9jkv9DwhoZicrFSh5v3kARLq1bCuI38ewiuXCBmwvv45QSNcGLkQpbE9Ezn
 Vw7Dj
X-Gm-Gg: AY/fxX4p8M2MME0CKom6wDmRyDIoIfls0eaumjLnIarqrCn05aHscxGWfHK+NpHN8tW
 J1i32YnKaQMhCi2xX0hY3BEPMwrZAodMKYbIfPxD6WWkl6wkrjQc2v3q1MOjQBqhFKLUeGCgDun
 XpclgrwIXGkXMUQ3wYfJffoQ9vyiPjQ2brRk0mOAK4kkdkZdQsLJ7xPgRxDOMR5IlDMys2ch0vk
 WQtXcOqD8RFlRi4la9KiUd+qFWVGKJHzilq50l3p+7pLauWkElE3Z9UfmRovQp8DbHpH1Oj/9nO
 rkF215x12aMjoeVC49vsWt1jtA1YYzuHT6GxYa5THOtIqE7p9jlK+y2/RROfGAKBV+TFhXs71a2
 ieWl1vMrYjxE9b2Xn81yxLHNRibCFlwOEDqpi26sgmeaqf9RtZJI0vnAOYFDiUyLaPtcEzfcBQk
 FGkNxo1Y5MDxw0Ov5u1HtYyVsUEgA8OX56UVi9DLXRpe67l7dF2g==
X-Received: by 2002:a17:906:dc95:b0:b73:4fbb:37a2 with SMTP id
 a640c23a62f3a-b8760fc1808mr32399666b.5.1768335827672; 
 Tue, 13 Jan 2026 12:23:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v10 07/18] eal: use C library to parse filesystem table
Date: Tue, 13 Jan 2026 12:21:46 -0800
Message-ID: <20260113202329.35190-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

