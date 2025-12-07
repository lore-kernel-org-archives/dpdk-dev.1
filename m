Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A1D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:12:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7140402D9;
	Sun,  7 Dec 2025 20:12:52 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 0DEED40156
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:12:50 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so48474775e9.2
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134770;
 x=1765739570; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=jJVM6qizgShcRzyh2+FNTVbizkOBDILI/bfPDeKM/dInFU9nPFmVYsis/ZbdEbR8OV
 3+zXNuzKZqWzMGJdMqSOT7PBdPGCm7ENJaVQ808IGMJttu7RILvmwvqN5FFPLOrwca0G
 ZXmLN8rYo43WoqaZU240XFbUB2/UZVIT8xS2coZSLi1ALaZlqFRUBd07eBfXnuvTWdJS
 Ygj3ntALDvM1k2bkXQk31x4heIKv1/IC5leO+h/5NW65hEQLJtVaWWUcuEZt5YbuoK42
 J8aqhYyTAaLwMqt8e2y4BKsF7Yer7zUopRITL71S61z6cofGchRtqE2WHvvZPx1CWl71
 4pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134770; x=1765739570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=C9+L209gnVHVlmUHv3rcojibz9U3/E6d7nSNuieLPS0Kkpbxsdo2pHoa2TaLfKsEMt
 tR3FKwzYBCjKHtpHgHAaN3tHz+QgnD9BH/kdjRL+Ne1Bh/jWtBGUp4iSwyuK2i0yRI7+
 sWzRFQEIaNWno2lyCK+JMiJymlTESXZRqKVqZPzzm0Ys69uyt+YuZfjgg56YD74VYy26
 DZKsQ8/ALS022YDZUdEg3ntdckdQqji3GuozhViRwwKBjMhauCwF0olkknJWpIL0DFhk
 REjRtglx7Yn3UBu1Y5UlZ6cVmVZXquVAcSkP97x+HJo3t69iQaVXoFnXytXsZwlVUTnm
 +YXw==
X-Gm-Message-State: AOJu0YxcIBK58Y1Ph1GwBqSTIi4my9qPZDuSib9j4dbftUijFxM5oZHG
 EnLEyik3lK9lz54qxByu/ErE+hgSnAzI3D70eRfFzW6SM/8xzgsrAOspbNcB1iiXrND1IgvwF1h
 ztVuH
X-Gm-Gg: ASbGncuRKhhYQv9KtUDqVa+DatbRo6EhIXSdl17B7YWD8kNM8/f1Dn0c0SxYPSrM28e
 5ovv66pRHTXseCDFPLNUpE99OCmsHpQlp4Uo6r9nVTDs3YoU8kaxSCkPRJTQSRPvZbJSe1xv8kN
 JNq9a7Nk3cKVf6yYvMLIb3y0XWvrtIvAxiqReAktc3V/S+5g/gEzJGPsyeS1aoCDaHU+06HedQJ
 McTG4xEXh7+Rn60ocYQA4cdArWxMEhsG+CqXx2dCe7N8ivNhJjgFoxp6DtB0t7DGjBX16UjvQwU
 U10jIrfpmkq2esdiKZJ5z6vDWwPx1I6AOhKXj/w3LIWsUPgfmIINw+6MTzKbKIkkjciPGegoFHA
 GDOKgXzEvR0uySXETufQHupoRQruG0uJLhC+cNf5IBjPkHcAqA3zQ6ww1swZanxeiyyRXKQtHHI
 ZxPI4Jl7WXmjBiys1mCYBtzWmwGBAQH/6Je/B9KN6uSErFLSGaHQ==
X-Google-Smtp-Source: AGHT+IEPpcGsxdjnh2Gnm1ofT54DiQ7c4530om6Zi2nFrOrJYw+LoAUuPS4nNd3+Ifbdg65dXIhjsA==
X-Received: by 2002:a05:600c:4743:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-47939e200cbmr56027325e9.22.1765134769482; 
 Sun, 07 Dec 2025 11:12:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:12:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 01/17] eal: use C library to parse filesystem table
Date: Sun,  7 Dec 2025 11:11:52 -0800
Message-ID: <20251207191242.165619-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

