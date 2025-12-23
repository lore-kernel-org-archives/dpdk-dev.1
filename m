Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336C0E6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:15:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F210E4066B;
	Tue, 23 Dec 2025 19:14:37 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 14BA040654
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:35 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b735487129fso943833466b.0
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513674;
 x=1767118474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=ngOPkKGQbvTZ1Fkm8z1JqA2jL6g4qMW2ZJjH87Jn8ersjNuZn+Xtq+arNOG+CWf3+4
 0aIBFTpXLVlOL8jFnZ449jDQnzlWdlXGOMk/zoO/fgxDPFIHj6HE9TdNpLJ4joCf+7SR
 HpoBB1zDDFvjI0TVjfGYjXw8jj63Inkl+/Fve1qm0na3PIx8EjV9PHZ5k9o2eEymx6Lg
 VUlL/ZdjECine0ZEiuFPtX6MnlrNHUYe38ALXXxT24fhGZLpclaABzg8eqmX6xBc+MmP
 99esUF8GVsGfwU2pkkvZEp+v83VwYb7ZAbUYtQOo35rk5sULla2JKKTKe4N/lwnLdbzF
 mf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513674; x=1767118474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=n9TfEhvOElUoCkhQaPDomTt3dVBdSEE6VO41ZqyUglKgCI4odD45sCZ09ZE/xOqmvV
 ClY+gRSEZZOXavr9w5+6+/NGzOomFMSXlAPQGgwr3yUeJ/bxcGpeV2QzcWMaEFIKu+EI
 CBAHnN36t+jb0Gqx8A7p+z1nFzGs10oMt+FRt8OvJdOlSd0mskz6+sENdX+prOxQo2/9
 /2iOOcsJuuzGUaHIf9mN+Re6mqmSb34OfVXdvOK1umSd+RnOjqsj1IZca1lKZrXfndl7
 q3Xiyb49+9LT9y+QeyW+h9FLXZIzWhGG5HXHf1wVa59Rxpkaytw+0kYMvGi/JYbA4ebu
 b91Q==
X-Gm-Message-State: AOJu0YxzHO/maYOHddxE9xuxTh/6F3aB2HA8ZReeLhi1B3Qb9zdbVxHB
 IDwxYtPKhKcwWI8nGmtlLVIeDGEdDTS9FcANOTX0eUcE7G6FFUvSXCuRCEIchn0HhKQQyv/1OEN
 8CF4tVFw=
X-Gm-Gg: AY/fxX5M3ZNVza+rW30GKTtuuaYh3UBWp+MPVXBJ7XhrVNukb99CNvG2zD1DD9/tUHK
 quvFu+4hOJKSKYb4PxH3t/In9ZVO4i2bmI8RXbAdBxvS0BH/4BOp4xVSmI3ke9eVDUDPWMzguP3
 ShRZSVjtj0EjSYgA92f8+IBU1dxjT2I6Vv2DgSRUA7pSTrmij2iEVYZAJglmgNqTU4Ks7uvLvzn
 W7fbuxK6bkErTRGW5qDU1yYjWb1in8bh3f6svAsC5WKOUpfTY1bACz70hTdz3yBKE+GADlg9Ble
 PZDo/UIygAwCvK5RA3tivu+1bVsnaMSaow+mvhp3Dx6jYWiN3N6jrSgYoyfzf7F2xde0u2eXjPK
 B2tTCWFV6WoOd6EiAJ2G2GGwR5vgFAQ23mzIOnjDjx9Z2aOTeO+M0dXeNI6SUOwoAYMVmbYWjBf
 sjtqsdCBRxiBL6XxQW2NmDzcgouhotuk+3ya6aFa1zaM5uIAh2/Q==
X-Google-Smtp-Source: AGHT+IH6UBF5jn3Shtwkfa8kPXsvuJD5joaAi2VIgx+IByLz+odjakI4U0ERRjm8l5mF0LlDzDiC9A==
X-Received: by 2002:a17:907:7e84:b0:b79:fc57:b598 with SMTP id
 a640c23a62f3a-b8037153443mr1322541666b.36.1766513674608; 
 Tue, 23 Dec 2025 10:14:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 07/18] eal: use C library to parse filesystem table
Date: Tue, 23 Dec 2025 10:13:05 -0800
Message-ID: <20251223181418.40834-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

