Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19303E78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C38F240693;
	Wed, 24 Dec 2025 23:13:44 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id AF4DD40693
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:43 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so40163835e9.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614423;
 x=1767219223; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riBaW5deNyN2mFHzkT3osuBjwXs7dH/r89MilBRT6go=;
 b=EIBfcZVRvZC5NOf5IpCJh0WjJUlvS2xbhbC1glF3//jxFc0MiILU3kzvP4mpqSJNbL
 4yAVs2Z7qoDkD7g2nCYLZ5zR2MCjoQgL3AV/S4vf2k39q3fqA6h9uj8KdtcG29ljwkpA
 ohII62034HBIq6QwzW9o386z/gLAhoQOaMmI0eDB9JG9cFwWQ4e0H+hQioBEBN3wVzfV
 h8lQqJxhOkm2QQJnAaIACFVqM3PM/rMCpdXqCVXKS0G3FvTVnlgz620ULt8RVLgakWP9
 vj3l523HiQr5BYb0o8+6efACPk11NjA2+lIxBLWwanEkueMe+0kyxikcZc2zN6XdjDon
 zPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614423; x=1767219223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=riBaW5deNyN2mFHzkT3osuBjwXs7dH/r89MilBRT6go=;
 b=KEP0Fz3YZSGrPlTXFvz2rSdD9MVkKyALEzuYAV2NtQt5f62gwWBYOTOU/YO2O/qTxC
 AGmYCZr84GaPD78BI0esjp5IuDLDIAOv+Uu3QrfRCouzqaeWwsJlS1+0ZcprGAVqtrdF
 +hteMjzmrp8jYA1ALEENMfuisPIKibw17asxdY4NJD3l70Rv6LcVWn4JaOpB5JtgVQou
 QuBQDb/A+jfHpWLgIOtOT2SbARCC3JuucS+9JbeJsT/GGFgDoUu3+E4i5544kPAOIXED
 8/0oRcvKXdbZgfVsvgfFCx8OwD2pBHQI8eQfv/Zp2hH6EjiJWm794OceVWiGWoLIpO6N
 3Lqw==
X-Gm-Message-State: AOJu0YwDnRn5tTXdVKaBYy9M/65dN9U71e0H9nUq9nKht7LOhEBnXx1o
 M4q93wk6iu/UfY9nkUIABAtavdlu0eze2NjnBAz6wI9Oa3GyPGXsFp0Ae4gzWaDNZiWPM/8vFU1
 YSD/zPE4=
X-Gm-Gg: AY/fxX5HdiCuftyXC02kNrM2QEtgxHihQPdKi0+Ub7C034RBWMYAlAgxWeghNg/Kt7Q
 W5yEFYAPK+yuZ3Ng+A1wKiCafUz+ZCUGXDXsi7pB0cx9/NYZq3LRy/4FL2J3ymZQVt1mDFtB7DC
 VULKA9cLxgoLFWjdkQXRkV19DHZTA7XbaN8BLMzFdo97OwrQ/2NngpNnjoxwZvb1lPD/a/yTRcR
 raWuP9tATQyV2kNOI4NNtXiKn79HbmzxxM96de2yPSAUoQQlCIm8KsWWLQ82Oz/Wnr3M/5qN302
 cw1pOaq4jQ++NoD64oUAW1nV2q+kfe9XzQZF9Sa4lmhSvSIHIY2eA63qxc6bDSBEIxzNxAPlY8r
 VsUXQrI5gJhSIShsfsoKRIZSbzgLwH+cR9l1T9l+Amjf5MA9cSUU6Kuanie1M1FOLvWY5QOJGaO
 mhWRCzDtQciuXFpNVMUBHectZZEfVlpPOSPjFCuqKalree2js9fQ==
X-Google-Smtp-Source: AGHT+IEl7gKxMEfeV9zEYvd8OvimpKD/2tD2vFQNXqO5F/VEIX8IuPAwO5fmXUEb0OyAccDHVaOTdg==
X-Received: by 2002:a05:600c:3509:b0:46e:49fb:4776 with SMTP id
 5b1f17b1804b1-47d3b0953cemr54343845e9.11.1766614423216; 
 Wed, 24 Dec 2025 14:13:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 12/18] eal: check for hugefile path overflow
Date: Wed, 24 Dec 2025 14:11:53 -0800
Message-ID: <20251224221301.52714-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

When constructing huge filename path, check for possible
overflow of PATH_MAX.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_filesystem.h   | 10 ++++---
 lib/eal/linux/eal_hugepage_info.c | 44 ++++++++++++++++++-------------
 lib/eal/linux/eal_memalloc.c      | 11 ++++++--
 lib/eal/linux/eal_memory.c        |  9 +++++--
 4 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/lib/eal/common/eal_filesystem.h b/lib/eal/common/eal_filesystem.h
index 2de88d7cc2..90b1cbb484 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -100,12 +100,14 @@ eal_hugepage_data_path(void)
 
 /** String format for hugepage map files. */
 #define HUGEFILE_FMT "%s/%smap_%d"
-static inline const char *
+static inline __rte_warn_unused_result const char *
 eal_get_hugefile_path(char *buffer, size_t buflen, const char *hugedir, int f_id)
 {
-	snprintf(buffer, buflen, HUGEFILE_FMT, hugedir,
-			eal_get_hugefile_prefix(), f_id);
-	return buffer;
+	if (snprintf(buffer, buflen, HUGEFILE_FMT, hugedir,
+		     eal_get_hugefile_prefix(), f_id) >= (int)buflen)
+		return NULL;
+	else
+		return buffer;
 }
 
 /** define the default filename prefix for the %s values above */
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index fe3351259e..cddffb9efb 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -68,11 +68,14 @@ create_shared_memory(const char *filename, const size_t mem_size)
 
 static int get_hp_sysfs_value(const char *subdir, const char *file, unsigned long *val)
 {
-	char path[PATH_MAX];
+	char *path = NULL;
+	int ret;
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
-			sys_dir_path, subdir, file);
-	return eal_parse_sysfs_value(path, val);
+	if (asprintf(&path, "%s/%s/%s", sys_dir_path, subdir, file) < 0)
+		return -1;
+	ret = eal_parse_sysfs_value(path, val);
+	free(path);
+	return ret;
 }
 
 /* this function is only called from eal_hugepage_info_init which itself
@@ -133,13 +136,15 @@ get_num_hugepages(const char *subdir, size_t sz, unsigned int reusable_pages)
 static uint32_t
 get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 {
-	char path[PATH_MAX], socketpath[PATH_MAX];
+	char *path = NULL, *socketpath = NULL;
 	DIR *socketdir;
 	unsigned long num_pages = 0;
 	const char *nr_hp_file = "free_hugepages";
 
-	snprintf(socketpath, sizeof(socketpath), "%s/node%u/hugepages",
-		sys_pages_numa_dir_path, socket);
+	if (asprintf(&socketpath, "%s/node%u/hugepages", sys_pages_numa_dir_path, socket) < 0) {
+		EAL_LOG(ERR, "Can not format node huge page path");
+		goto nopages;
+	}
 
 	socketdir = opendir(socketpath);
 	if (socketdir) {
@@ -147,17 +152,16 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		closedir(socketdir);
 	} else {
 		/* Can't find socket dir, so ignore it */
-		return 0;
+		goto nopages;
 	}
 
-	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
-		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
-			socketpath, subdir, nr_hp_file);
-		return 0;
+	if (asprintf(&path, "%s/%s/%s", socketpath, subdir, nr_hp_file) < 0) {
+		EAL_LOG(ERR, "Can not format free hugepages path");
+		goto nopages;
 	}
 
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
-		return 0;
+		goto nopages;
 
 	if (num_pages == 0)
 		EAL_LOG(WARNING, "No free %zu kB hugepages reported on node %u",
@@ -170,6 +174,10 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 	if (num_pages > UINT32_MAX)
 		num_pages = UINT32_MAX;
 
+nopages:
+	free(path);
+	free(socketpath);
+
 	return num_pages;
 }
 
@@ -204,7 +212,7 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 	const char proc_mounts[] = "/proc/mounts";
 	const char pagesize_opt[] = "pagesize=";
 	const size_t pagesize_opt_len = sizeof(pagesize_opt) - 1;
-	char found[PATH_MAX] = "";
+	const char *found = NULL;
 	char buf[BUFSIZ];
 	struct mntent entry;
 	const struct internal_config *internal_conf =
@@ -247,7 +255,7 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 		 * If no --huge-dir option has been given, we're done.
 		 */
 		if (internal_conf->hugepage_dir == NULL) {
-			strlcpy(found, entry.mnt_dir, len);
+			found = entry.mnt_dir;
 			break;
 		}
 
@@ -267,13 +275,13 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 		 * We found a match, but only prefer it if it's a longer match
 		 * (so /mnt/1 is preferred over /mnt for matching /mnt/1/2)).
 		 */
-		if (mountpt_len > strlen(found))
-			strlcpy(found, entry.mnt_dir, len);
+		if (found == NULL || mountpt_len > strlen(found))
+			found = strdupa(entry.mnt_dir);
 	} /* end while fgets */
 
 	endmntent(mounts);
 
-	if (found[0] != '\0') {
+	if (found != NULL) {
 		/* If needed, return the requested dir, not the mount point. */
 		strlcpy(hugedir, internal_conf->hugepage_dir != NULL ?
 			internal_conf->hugepage_dir : found, len);
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 1e60e21620..d9e8ea76b9 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -260,6 +260,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 {
 	int fd;
 	int *out_fd;
+	const char *huge_path;
 	struct stat st;
 	int ret;
 	const struct internal_config *internal_conf =
@@ -276,12 +277,18 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 
 	if (internal_conf->single_file_segments) {
 		out_fd = &fd_list[list_idx].memseg_list_fd;
-		eal_get_hugefile_path(path, buflen, hi->hugedir, list_idx);
+		huge_path = eal_get_hugefile_path(path, buflen, hi->hugedir, list_idx);
 	} else {
 		out_fd = &fd_list[list_idx].fds[seg_idx];
-		eal_get_hugefile_path(path, buflen, hi->hugedir,
+		huge_path = eal_get_hugefile_path(path, buflen, hi->hugedir,
 				list_idx * RTE_MAX_MEMSEG_PER_LIST + seg_idx);
 	}
+	if (huge_path == NULL) {
+		EAL_LOG(DEBUG, "%s(): hugefile path truncated: '%s'",
+			__func__, path);
+		return -1;
+	}
+
 	fd = *out_fd;
 	if (fd >= 0)
 		return fd;
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 8e1763e890..2a0a441398 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -337,8 +337,13 @@ map_all_hugepages(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi,
 
 		hf->file_id = i;
 		hf->size = hugepage_sz;
-		eal_get_hugefile_path(hf->filepath, sizeof(hf->filepath),
-				hpi->hugedir, hf->file_id);
+		if (eal_get_hugefile_path(hf->filepath, sizeof(hf->filepath),
+					  hpi->hugedir, hf->file_id) == NULL) {
+			EAL_LOG(DEBUG, "%s(): huge file path '%s' truncated",
+				__func__, hf->filepath);
+			goto out;
+		}
+
 		hf->filepath[sizeof(hf->filepath) - 1] = '\0';
 
 		/* try to create hugepage file */
-- 
2.51.0

