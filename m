Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA1D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C82B740615;
	Fri, 23 Jan 2026 05:30:09 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 1972140613
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:08 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so20393195e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142608;
 x=1769747408; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQEnkwKLprX5Xvwi8GM18V0Mvd2A5VlceomuKmGaAtA=;
 b=gfSknO3mWG7Yg7l2bmNLlRRlzeYDUDZFy3HbCW5JnbkX4pqyzwoRXzO0ZXlj/m7tet
 vStefshP9mRFwtxl0PCXH7tMB1ATbhgGLGRcj2ytFE+bxs/mG6d/AQJMQdSoEntqUY14
 HUHyQe8w6hEm5+PGvzIBdoBWqej9QLCOGPxKTCdSn05Rc6nd88b4K5ZCyiYZv5v/iXIQ
 u9HkcBnJN7VGJ/oK8bJVjbHW9oX303Wo8kcSoq4PV8kRNpzr0/PNpdnCcHwvqRCq6iG5
 4HabtSA/RpjXwmksgXGV3hc3U3ANSYhuUicUvSjywSU4OaxTWXxK6ZXoEfZf08q0OAAg
 IySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142608; x=1769747408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eQEnkwKLprX5Xvwi8GM18V0Mvd2A5VlceomuKmGaAtA=;
 b=odBi7h6JJ8uh6fm5j3Jn5EdCgn6U6IqVjLrsZzNirKMJspZvEgIogjfZrFKN+5BKuq
 OhT41Prf/TI3gv0ER0qmSlIcbwBCQWcfqQ3U/4w3gljk0tvD0XZKVeg6f2FA5thnURnk
 G02gLhCbJ18UAgeYgFQYT1CYuvqhr02Ru/bVQV0iUr/yJQywwyYe1qTrBxYhwCHnTtfX
 gbafpCUfiim0Dj6owg6hU3gatsCz+2+b+Zwm2gtsSRzCGMXRizsa2AaI7mUf3BETB7NL
 0dixYO0jhLdIk3o54oG+GKiUfunK1UePwbkK485wsCDiKuqJxBLTffNm6kbKmglhE3dM
 DDDQ==
X-Gm-Message-State: AOJu0Yz71qBF2vpzRHS7Q+DWxR0aHwMKdz79rTlOt7eLGtMVV3UQxEsD
 jKmzuvq3LLjGS0Gk0XMo0Rv+qaZsIZBlzkilAlQKjOG4sjtB354073Mz39bEcZ7XQCuGWsbVuSH
 JOojG
X-Gm-Gg: AZuq6aJLiBF2uYU9jDJMLryyEYBwBSDR/4jabuF2GkDgrSyniAfrmn1gd1uirJ15hMO
 BtX7GpjbjJh1yggs0/6Fn7NAEARTxZ6LYCc48vx5DApz0aML9yvvuzhYAx82vyQheKhw+bh0Ws5
 CkRjZ82ONwb/TCaMD2UtsP32OnxjF8QXt1Du+yT0n1vjTe91bvXwY5IAB1XrUgcnBVxeVspJ8U/
 rMM3knGDoBe7baXfQ6DDGF9dzCoQP+FPhYe0QCoLzjKUgiRTgAESY3YfapSx14+EUHF0RZfbPod
 it9uvE5ju7gqTbAHDDeW3Us8bohy/+fZI9jVR3WrPE900pIz0SKFTtzSfqQZ5+FLWmDibDZ1yoT
 5WAsd7sT49vFSOYn2kmgrUUB22hbRydQijdcvQnHRuQyyF7CKvb0vMqD2U0b8Y3peB1qErD3kAa
 kwzXz6PPCWLCf3O/5O2nyAAmnnzAMP9p1pXLqDGLixdyuqrPpr4uVbEFoKVcb/
X-Received: by 2002:a05:600c:37c7:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-4804c9bc5d3mr30113075e9.17.1769142607651; 
 Thu, 22 Jan 2026 20:30:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v11 07/18] eal: use C library to parse filesystem table
Date: Thu, 22 Jan 2026 20:28:05 -0800
Message-ID: <20260123042945.159075-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

