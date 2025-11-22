Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C302CFD2EF
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Nov 2025 19:49:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5B73400EF;
	Sat, 22 Nov 2025 20:49:25 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id CC4F3400D7
 for <dev@dpdk.org>; Sat, 22 Nov 2025 20:49:24 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-298039e00c2so42181475ad.3
 for <dev@dpdk.org>; Sat, 22 Nov 2025 11:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763840964;
 x=1764445764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KWTr7Tg0Sqo2yYldLiQGMhX3ICqdVIjGCnxD1bBlbNM=;
 b=XUFzCQwOTNXGYT3lmNZa93HHDDX0qUyKC9OMPQvYqbINma+P4n56WvKSf0ooy0wBSr
 2e5f21734VSlV7gbSpOkmf0WyZoIimKw0DJQC1Y4iy0IEXVd3gfCZFJwluSk6xkQQ1xQ
 4lwqbQKSc5GkovFjicKx1jAMG5hxkfn8DDC0DqOhq8SMcY9ukAUJLG6vH4Xb9Z/h6zJT
 CH8ckJwvpoECv5Ubn0WpsxADIIKAazoi4dBzSZ94kf87VcJz5Ffc9pAvZu8Ey3tutOZ/
 Fmzksyr9+wxB93a1davyL1ngA7OK+7XJOZywyNxz/KqgnRvVorZ8soqqhYWxSUxZiJMV
 t8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763840964; x=1764445764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWTr7Tg0Sqo2yYldLiQGMhX3ICqdVIjGCnxD1bBlbNM=;
 b=E/YiIEbWfXNtKGE3uOZGlYbt7UpeOWnzTMa077qXDYqnuHG0l258SR1GpV6T2BeZFY
 7ouytfg39ScoOmTvQ+qL1fstPX6hXDyUlUH+L3OQDn/+oLrg2IRxmuOJGbugsIXeO6X4
 pZpJqFdWvG++Sh3XKXfKTKIz/ovFxUE/leX/LLkEE+1CDauwF2gBrpvObOoulbSwwDzl
 /9Plo6nZ/CZLL2laVEgvzYw2C5+ZJsSqHPBr7C3c5fsTyjNzSLb/Mk0m1dNPOoVkgzA2
 gFDmFmBuZewHX8apRaS11fay2aaFKmSnwrG456QghNQbECO1hVpspMdsO8OmFZJaMgSP
 9eog==
X-Gm-Message-State: AOJu0Ywxwxg2dzX4RJu/G3oa5P33aa//43peS/1LtzTRvkhUdtJToCIY
 GQOvzjO5Rd0hLqlC4l2149O3HfvbkxB2+8TqgTdOwkCSn6ERq7JyTzpbnLA5NWdKWopANVOBlSv
 42AgU
X-Gm-Gg: ASbGnculUA4ls8KMS+Rdu44ckNMMgg21pd8zQTJUwYqGGXFLD9GStF0Q06f/kzf7szT
 bm9C+ezo/w4S+yjPMoNgjCXBuYNYyafi80oiIuVnWosrp3Oids5hW21XZvfqTO4PJpRNjZBLxTY
 XPs0fa3pkpjOW/mKS5PsJthTgleVJB4+kLBdaI+1Dv14JLETPO29eQCn6+QGRNHMwqv2huPAtBO
 gNiC7NgtVCfyOSPgUpMIaqRc+Rf+WadF+2Cy4o5C5Y8nPmNNPbC92+7gCTeRsNeBNcprO6dfCYv
 oB5Jvbtwe9MhraNQx6Ar3Jmuu1I7UQuP16vTgTpFa/XdMMQYNg81hjiAicm2wbGqk2bqUIGTbm9
 ud36hGe60SzjbDmLzrQKW4uyG5/i9J+YDbkhPsLVjbHaJdc0HlvmiNnvCjqH6GFj2yfLMd9l/fv
 pZPabxh1jeOCGrbtoGfNxs1dCC8dEpQ4Iy7F+Szyz1+7kVS8oS1+BtN466xRzU
X-Google-Smtp-Source: AGHT+IH5HX/AHsXAFprtYa8zvQwonxoDc7O9tFJ6JHESgTKxwfMxHWhm5JtJmmGpGzcgB793aJRFOA==
X-Received: by 2002:a17:903:2f0d:b0:282:eea8:764d with SMTP id
 d9443c01a7336-29b6bf37397mr83628995ad.35.1763840963691; 
 Sat, 22 Nov 2025 11:49:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b107cc2sm92098125ad.16.2025.11.22.11.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Nov 2025 11:49:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] eal: use C library to parse filesystem table
Date: Sat, 22 Nov 2025 11:49:21 -0800
Message-ID: <20251122194921.158921-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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
---
 lib/eal/linux/eal_hugepage_info.c | 45 ++++++++++---------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index d47a19c56a..ecc0374204 100644
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
@@ -226,35 +217,28 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
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
 		size_t mountpt_len = 0;
 
-		if (rte_strsplit(buf, sizeof(buf), splitstr, _FIELDNAME_MAX,
-				split_tok) != _FIELDNAME_MAX) {
-			EAL_LOG(ERR, "Error parsing %s", proc_mounts);
-			break; /* return NULL */
-		}
-
-		if (strncmp(splitstr[FSTYPE], hugetlbfs_str, htlbfs_str_len) != 0)
+		if (strcmp(entry.mnt_type, "hugetlbfs") != 0)
 			continue;
 
-		pagesz_str = strstr(splitstr[OPTIONS], pagesize_opt);
+		pagesz_str = strstr(entry.mnt_opts, pagesize_opt);
 
 		/* if no explicit page size, the default page size is compared */
 		if (pagesz_str == NULL) {
 			if (hugepage_sz != default_size)
 				continue;
-		}
-		/* there is an explicit page size, so check it */
-		else {
+		} else {
+			/* there is an explicit page size, so check it */
 			uint64_t pagesz = rte_str_to_size(&pagesz_str[pagesize_opt_len]);
 			if (pagesz != hugepage_sz)
 				continue;
@@ -264,18 +248,17 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
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
@@ -286,10 +269,10 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
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

