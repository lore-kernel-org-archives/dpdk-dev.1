Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D25ED3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BDE14066C;
	Sun, 28 Dec 2025 21:19:50 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 4C4424066C
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:44 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so55388595e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953184;
 x=1767557984; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=Qwp33ouTr/RQO45EZIYc0pgzqVD5mfhwA5/GR5pk2Sur+NUJN+PLUt3UgTqdTJ6QFC
 KM6RRSVyJGMmOs3cfV80TyMYX0pQtz7tUuSk7hJpEaNxMJ2GpNMCPRFsEdWbv8cYOUHh
 XrX6DJG2g9IeANHLpPy4r9UdM1ngMwl8WEinqw6bNd47k9BLBuoDePMKbWp0jzJGDPOH
 70R+rDJPMbIqwyG1dpwkteJ4QEOauLfz8ogw9pTKDCQ5wvLosm2O0kg9kpy5sz6J94rM
 ugriPhNKd2iERTNspn8C/PlAccXPV97cVqYjAnmcmpfnkk0gMXkkCW/k/BIq9dYNeWR/
 DaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953184; x=1767557984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=lxr8qBRNJIVwNw2MShtRoBUYUTP0ZBnbCzJdp8xmTjc2MoH1kplsJkXeeWojw4Pt15
 F2T73cViAk7KfIbFKRQUZUetFbEL3SIecU9nacCD/ZZFCNQbnqC1uyJcCEZHOsy/iUwn
 kHf0ghUmCXoLfDQlBbIu1KmW+AMCXctmsM4rWcbUdm730HzFM/iG1l43Y2wJ27EALelI
 7AWRv0m2jqdspVBht+gAL7p02s1ODJM2jTzlb85wGk1/nXbSTvDChGTnXF6XJ4aL7dy5
 gVWMcCfQouDthVQe84J8Khgci0B20MoxLxt3Q19cOpbC+srl55Ki4UiDP7Xhd2qd8TrP
 shwA==
X-Gm-Message-State: AOJu0YzdlMgp8xXQGSVyQTu26ZBsyuh/YCuf6gCVrqjqLXJzrKRxJbYs
 15vnQ1KJ1WBUDnlOlyddY7RdajsOSyVKtdv9fBCVgFsD+35Ho3uN5b3fhz3XWzymHNQmZAF3Jsl
 wFqYNUHw=
X-Gm-Gg: AY/fxX5BYf7yb4Ewm9JFlfGwJFehZ3acZ0JKK1XtVyc5OeTnre6e1/kLSEmrjz/345R
 NUBpv8qMCDOojp/jqRXExHYaxD+CrtN1tIvxTdglGp0JlO5U/qydTtSQQYZ7DMBWk4z//xHfo6F
 kxPsc6SXgFRogWv5InvIHRgUjSCWOGXp4s3UmVAX5tawd5eW4ObUyGmLhrnOD9REB749bbDlXaQ
 GfN4N4FjE7+K5TUffm1Wft6xKcjlwB72+zxb4vFVIFxqDXS/5dIqO3Qlk3yOmcD5ZPfx2K6XMUd
 PwvWP+bHQntSk+s94XpMNa716uFZeZkTzjV7vytNnPLPNsMEELbysfrUymWlGql+yrS/91tbWwk
 8UQgvxGkz6BMJ42SKqlsvn9XP0pnQY3bheMmrEy92Fk6+DxNZoQLjpn8hwTEN7zoGMXjZDYSK+S
 PQZoYe+RY+01CDOUafd8ku4kPzyBjfyGy87mGj3hFdl3TStXkSvg==
X-Google-Smtp-Source: AGHT+IGQ8YDp8jCtdDXPWtm45veOUIvGktAQQ2v8gFNw9PkOkHjr4EVwKNuuKKLVC0BKgpHmFvBWhg==
X-Received: by 2002:a05:600c:1d1d:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47d1958f9c5mr307204865e9.26.1766953183848; 
 Sun, 28 Dec 2025 12:19:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 07/18] eal: use C library to parse filesystem table
Date: Sun, 28 Dec 2025 10:56:10 -0800
Message-ID: <20251228201236.547268-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

