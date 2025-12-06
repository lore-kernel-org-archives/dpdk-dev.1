Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05654D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94BC40663;
	Sat,  6 Dec 2025 19:44:38 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 5DF044066F
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:37 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so1475389f8f.0
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046677;
 x=1765651477; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riBaW5deNyN2mFHzkT3osuBjwXs7dH/r89MilBRT6go=;
 b=T7UMFo1r5rLe3xpWHOpBZAP9aaf0fw+G6XvXdMgE9lQcrHNwo7EJFvgaO9qVz72M5x
 0NxHjNUNZ3FeowavhbY2LO5AsxwjMPnqaxORElOt2RG/nArnIxh1sYy11YofgTs50/nq
 i9R/dwKD4gJhyP4ScggrQMdl8pOzq/I/4TXY1jWzwx+S/3EjfThdtSb38utmPrbPcPy5
 jYa4hPC1i42fKeiTrAVS5iIYNISFW5o8Um2UahOgAFwuxxvDKvVD2x2m3Z0bzVWLmtAb
 bgFecGRb3PRB09qCwLld9JhJ4zdk50BQj8dJOyCOlFwfdziG2qeZpVwIVegjQn5VZgWN
 hfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046677; x=1765651477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=riBaW5deNyN2mFHzkT3osuBjwXs7dH/r89MilBRT6go=;
 b=VdOmfzXjysgzZxTx50hSBylI+gJynlobi4txewUCmiGEDeynSSqediCNEe1oFvrzHq
 DvUKgP2SlC+T86Hy4JTzRfvtg3exSu1caXrccqK1FcYW5cOun92nDJe5RGEfynzf/b9x
 38v7jl0KtJ93/lHYheAYm47Vl97X4QsZoM+UOV897Vrh2ibC3dG2S2A1NQ5rMnjC18tc
 Gr8DNMDfR2kOwbxQAZVp/P/SUI9+axcLA0PkbFaAqsvZXcJi3v9Pc3QBStyS+ow/YxtE
 I6xpysll703oGNy92ECw+zbjxUje5642JIM5PLYR/FcaJ7RTV/CeIC/zexRih9HquhwK
 NjtA==
X-Gm-Message-State: AOJu0YzKYq6M6k0qquRILy3q+lIQIL1LEyQoE7ccPsbVOEfeQ32SqJU1
 B6VK5ZX2EoTKlvwC6wR6cV/E5tVxdmEVX1PZyCUrXNyAoUEKcDVZ5H3FuvP/ZxSDNWXzOphlaTm
 +s6iu
X-Gm-Gg: ASbGncv81uKH01vide70C35djEUK21N7NdnhDWOZx7m4I/tCsh20D4zeyCvzioSnlKI
 HbQliYFXxKtrG/Frma8OzKZ920pcObs6yL20OsGkca1SblHWOCZTBcuAoOlL/Kmvl4CZJG7YGzF
 PbIbI0aDlsvVpntobvhhkE8X66W5icw3kvGarS+E3IzA0deVkcTdJ5zebHZsWI7EcXOf8cJGFKT
 Z5XJpu2tdG9FylEtf9ewfpWcrymQiQBZPeHItExQQb2PF3+iZKb+BybrTiTUYS+BvGhJy2BATgg
 HM1GlDKTZnjpSkjDqa06XXQXv6z0orpl7WMvxgSIPLn7FEqWL+3FDE+1Nutby18iS4+eeSEFUmu
 Gqj0AJaWhnTZXjiNBlZq+ncisf8SsIOpyAr0iBw6mOaXQ7eVo7KcricTADqVs+rD2A/eQusufFm
 XUkfQNznW6fkgVXD47AWiIYbhgwSL7arM8iYdzUTD8vm7B6zelhg==
X-Google-Smtp-Source: AGHT+IHjy0rCkO8+eUegVlI7HoMaVYhuR9zBfcZ4NgwodSGoCdH0fUC8B0n3NVnTy1BQhAxF2QvIMw==
X-Received: by 2002:a05:6000:2908:b0:42b:47ef:1d59 with SMTP id
 ffacd0b85a97d-42f7874f9aemr13540282f8f.4.1765046676931; 
 Sat, 06 Dec 2025 10:44:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 11/16] eal: check for hugefile path overflow
Date: Sat,  6 Dec 2025 10:43:12 -0800
Message-ID: <20251206184410.542725-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

