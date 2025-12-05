Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75493D3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:15:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F14D402BD;
	Fri,  5 Dec 2025 21:15:47 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id AE27140156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:44 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so20846755e9.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965744;
 x=1765570544; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=gYKuh/PzG41BvuA9LXRGcMqn0VG0fWNMU5fe3S/NSSCn5vjhDv91Fycxnc2I+BEMw6
 Iao0bk0HQiS93vVPeu2DfGF08w5dGhCIM050xnhDGsoxKxM7m5CLCCOCIr75u/7f/Sq/
 NatD2lw6C87SsovqZjTpTcBTjGd1Xg7zsvJEvF5FTMwE3aMGqBXu4o+PeYc+IgZXRTUw
 KVlT+5R/iqfw73kGqnbuur4skyi+JrSQXrj9Rdb1I9VjRaymTNaRf4L5W1UwJBeJ/b7Q
 AuMw2OHU1N6g6F54GGIIMFMuofFMeZ94oxOi7otpy0pMG5EZS6pS68KBKn1j3KOhnz1K
 a1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965744; x=1765570544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=b0o0IBp3QoZNxNvHi3AtPjJFcVFapmb+5/5Z8zibFkCu9t7J52w/VssKpESUaAc6yI
 oH/Rb9uvuuDc3xEj6AGtm2r/gy/m9geMmKA7Vv1ADCnnJ0Se3QlMh7z9pTmC5/NY2dLG
 mZpZGNTff49ZU/c81//yse2KVxEHeVamlsdQ2EmhOR//bJ3VYOWWTvrFLWPQhHX1NU2q
 fveNXklM9JsSBXUMgADd1Kub7MvnX6/qHhjTWulU13+3hYJ+sCpQ5ytadxdgHoL7qmIW
 3jx4DZmIiWU2vcsTj/0qmRPEkpdUsNtnkQ4gfc7BFFQEOWAm74umkz76Yg1zUonm0P4u
 sItw==
X-Gm-Message-State: AOJu0YxrCPOx2gxDjszO9NuScnAFcx0bSHMWvbcBgHvHP1aUPq5GdCDA
 UCf5Rb4UeeqKSquNShZeGPPRk9CiRDnZslLqYdFILtmSRw9wdeXfBalCWg3+a2WKHGGLezzblbW
 PN+J0
X-Gm-Gg: ASbGncuV/z9cXTX6VaYLlUfBUecxKRSiBpn8htBhd3ztBRzmIMgpcZOK3NJxIG1icNH
 9qpZrcmbcVYcVEelAm+K5oPUNzrZQALT2TB1BUVOHYmBgssOpiCNg0V5XqJsDUxCkFRwtI5c/3P
 F98/Pnpozlc0kBneQATiv2rxD99BkwSXjkvP7gi8DyNpfkoZz5YIq5aOsTgsZhpdG/2/FLnQq4N
 Jd8Nmin9KrL+1WHtPRy0PqctVVIjvv0pq8nSC3Xp5s4zp1Odn6D2XTInpPPtExAs52tAIPJQRnp
 LXxpA83BV3PIU2Gu4lLjE+RQw8Dtb2SsfpZz5WQOrXmdLSFRV1DTb8+WZuMNwghpgstpv08nMBq
 Ut0z8LtwoXT57uP5I8Qs59LQI9u+a2QeMPs0ZVWR509HlVPhNIxd5BJzzBkK7AY86Sr8o+jT3x6
 Q28Nk9gKNm3gFxhy0LKGLtvA5cseS6mJSAKWW3Ok3eM8xFzGu2HQ==
X-Google-Smtp-Source: AGHT+IFh1M3N28ywxqjKFQ4HhW91QA7Gncljkm5Y57EvAqYwuLOkmfG4qhaH4r6hONELpK813hMzCQ==
X-Received: by 2002:a05:600c:6097:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47939df44c9mr5737275e9.12.1764965744003; 
 Fri, 05 Dec 2025 12:15:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 01/16] eal: use C library to parse filesystem table
Date: Fri,  5 Dec 2025 12:11:30 -0800
Message-ID: <20251205201537.251131-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

