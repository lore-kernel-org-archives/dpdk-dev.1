Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AA1D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36FD2402E9;
	Fri, 23 Jan 2026 05:30:21 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 6CC5A4066D
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:19 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso13477925e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142619;
 x=1769747419; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QR518gAxrqo1bNDOHcPrbbKhUVaqwgMNV0ePc47R5oA=;
 b=ZQcofD/J/eIhmyTNoiq/eyGN0K47f4WM4VQa/fPT4E1cDA++MpSl4iWUHldzuYIaZd
 DJQJ1dRKj0O94zCgPk/tmDYMUpsX0ufDRW61ioNSNMmMm8GMlIWJFezgJDVsChFyLbpp
 iXUaAV2gSh3QlExulXqUV6s1qABAobN1/CvRsbpF/GfpJftQG5XYv1jl3HqsiUWa+SKu
 uV6ftmThsgjn+AwLtzroKuvvk6qB7v0gvMMFKC+P8zK/v8po0rVniqr1Vbv31UQ3qGk3
 cTUfwOzfGCdCtzXLaij0i9R4EfF2cogXVw4HngAoFiBl1CSnuYKGGHoqbuM7L62IEbEk
 vEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142619; x=1769747419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QR518gAxrqo1bNDOHcPrbbKhUVaqwgMNV0ePc47R5oA=;
 b=bmAreFrkWFa/XeNnObasXcypT6ktrVtUSMvgBhwukU7rPNRolrwj4N3a1GhmUAsFlx
 HXmk2elF4WJ1UK9ishlZ0Fpa+pbEWI0OvKFjwtDf8pZtBp0Inae+Cr3o49KDnr1kq6WB
 myUH/6H3OZH6wIjM6Sne+k+gp0gfNJyRuaooHfReMQlY1itzZnQNDv/ufXvYYyCGYbnq
 K7dRjxhbS0Hzhf6ue4cX6qc3YCTTkUN7xo/0LUrHjFtV2D5Z9y40iQpCGjSuFHEr1sM2
 WQhTT/wXhH2W9TwasP0hiefPX1mIw3qGDTJTR4uZsJQdRYPFfropZsN+pKFWoQJjvwUs
 UqbA==
X-Gm-Message-State: AOJu0Yx+30SP6oIJKpF84x3AnqzVAPSgdaPPpv1IkimEGAiTJq4uqfPO
 bAkWHTdC/Vs0DUPrpMpcM4ivjRTWfbveikHN69Yj2dKHcRD6TakXQWk53Sdx4u7yyGKzNls+qNY
 cUgNJ
X-Gm-Gg: AZuq6aIDo2r4qG0vIcc5x0mQ2x7amCwOwIGOV7eBmrqRewt/alS9oSfTP14M5/biisj
 +M6TNgCoq99CLDDOS/RDR+3H9/8Lc96egi6VVMQdUZQ3hurUBTg8C2ySI/beyY+xdHvX1kuErG8
 /u0xmYnvYJiVuxpzUQWZUssr8iQ0X+dpTwe/gCgfRZHvUa6JoylrFXRQZydpYNbnOlKWgzT0COP
 LPfvMBiXDNDmW4UaKMyPbZI/SiMTJSY4kTS9UgCaWof0POGCX/tpcC/s+PMAL7Rf4vFdmcl1y6f
 bEKwleWnKWMZD2oGR96dGoGDIYBEc5AlUsrcq7FxWpJ/sBTp7rnsyfVYjcos5R/BjAbd6fzvwP3
 jcsO9r02bCD4D2ssGgCDeW9An9PgtkjjYdpdsm/NKxOYWa4Bz14wq20A/XS9yxURjWbeWrpO53B
 6hLGc53Q6+QLRLetRwNMAtPQ6ju7jM/OYoQWneMFuB331zpV5tSQ==
X-Received: by 2002:a05:600c:34ca:b0:480:4a4f:c366 with SMTP id
 5b1f17b1804b1-48051249cdcmr1101495e9.20.1769142618993; 
 Thu, 22 Jan 2026 20:30:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v11 12/18] eal: check for hugefile path overflow
Date: Thu, 22 Jan 2026 20:28:10 -0800
Message-ID: <20260123042945.159075-13-stephen@networkplumber.org>
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

When constructing huge filename path, check for possible
overflow of PATH_MAX.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_filesystem.h   | 10 +++++----
 lib/eal/linux/eal_hugepage_info.c | 34 +++++++++++++++++++------------
 lib/eal/linux/eal_memalloc.c      | 11 ++++++++--
 lib/eal/linux/eal_memory.c        |  9 ++++++--
 4 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/lib/eal/common/eal_filesystem.h b/lib/eal/common/eal_filesystem.h
index 70ae21b078..c2f2856e27 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -104,12 +104,14 @@ eal_hugepage_data_path(void)
 
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
index fe3351259e..7954bc1415 100644
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

