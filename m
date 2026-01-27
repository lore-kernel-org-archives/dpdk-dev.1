Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D44D340A6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D30C8410E7;
	Tue, 27 Jan 2026 17:33:28 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id CBBB4410D0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:27 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so3520510f8f.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531607;
 x=1770136407; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DZ45ZiUMB7MuVHKSrhTB6uic+KrL75DTYiaXJpgZrw=;
 b=DSIbPMOHL3lswZi6NOs2+fxQ94vlTJ2nRYk5K//4/aKkhFvGpM/V47U5gNuqdshR5f
 9CENzmCkKJs6SrpWGYxRywNPMMqiXFQRgtwTtJqTLZnkHqFKcf4XoNAgD74qbhsYCB9I
 gwa1AUTKEldqJPZIxKXRQU5G0nrHCVfNm1CTF04wlnXyrZCOSA+4vyytHnajTbDS9Pyl
 YPUSzU3AYdq2YK3hiqx9EYz+u1O6W8MACO8VBtN7ko/Cy3cBi/cPyP7iJvd+ghT+HTf5
 EYLumQOVA1z2bYq9OK8eX32NBzv25jFzdmVze1V5a4JxO/ADlMzjJx6FwukaQwHccZFV
 RQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531607; x=1770136407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9DZ45ZiUMB7MuVHKSrhTB6uic+KrL75DTYiaXJpgZrw=;
 b=dIjwhiz8l88VrG1RekeZzJfTSpO+ikl5kRZyFHXr4ElTDpyZ6Y4RpnEZw+BCkEqlgV
 +VCQpIoXIjuh7OeNq6RnEqH1wH74lu8TNUHMFNDth10jJ9pC2EeI+lKL7qxskJ8YKoYs
 j2Tfm9dcf43sypcemmWk9MTx5ogk6WzuQ3Pm3b66+vcPXV1BOxCe7nn7Gkr2nYUjKvks
 nMcg1RWjMd5MwilQk5RQqIsTmfv//ClH99iM7shqw9Ns5VbJg4Uq0vbUBmrOy/F9yQcD
 CGX4YHh7H2dIoNRwqo8MYJqFTLKzxw2C9XKJl6jJZGZrQ1Ow+Q1TrvAhVAiId3t3c9Jz
 uLzw==
X-Gm-Message-State: AOJu0YyYVSiYqJTnw1Ga89T6tyUR6m2LxXJhzZPVwoDtPzAd/U9it850
 inBFM54zXUsbBSvVOmNwRI4g/uZOrGpyU3elKSH+5O4XABgnw5ks4Sh0WkFID9fJJ0AyfOpOV8I
 bVCM6
X-Gm-Gg: AZuq6aICfyCEY35zi+R/FzVrEbFfEyMGYxwrlzjFGKO5tAPCV6Y3tA/1n3tSDj7KDOm
 LLPCK7luIi6+9Jd4Qz/iReBWdC6zW0FS76OkpGqStKUYvuUxXmoNNXkHzLW8wqhwxEG6clSNWUq
 h0q2jRoc4BRGIQ+pK1kOJztfp/jV+gS9Vsqo/YV7RL7+oqBfKlnVihVc15bo7uiZneG7lNXboCI
 bW8tZyd3pMsZdEka6bK815CsT3QTgAMS1PvypgHQ6UXEyt1fpSbQFjCQyLlUc6RY98EPnoVaR9k
 Umur13FL0XsDWgJa/ZvIWiYkR4fSLxVr9cgIN0d1oCafZipXwG1vuo/J8e1Fks37aZxWTrGJb17
 4k/4ZseGUizm+xIp1css/PQ/9O+Kly418Up5ibP29iG7Tao0OLpriWQMffuo3m3MZ12pTcmeLZ5
 vjDEJXIKCnwKUfTqFquA9rQWWyPd6a+0bz6lCC0nQyyPtUlAcS80rY9Zo1d87c
X-Received: by 2002:a05:6000:4313:b0:432:b953:b02b with SMTP id
 ffacd0b85a97d-435dd1f0bb3mr3973969f8f.16.1769531607335; 
 Tue, 27 Jan 2026 08:33:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v13 11/17] eal: check for hugefile path overflow
Date: Tue, 27 Jan 2026 08:30:25 -0800
Message-ID: <20260127163258.75566-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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
 lib/eal/linux/eal_hugepage_info.c | 34 +++++++++++++++++++++----------
 lib/eal/linux/eal_memalloc.c      | 11 ++++++++--
 lib/eal/linux/eal_memory.c        |  9 ++++++--
 4 files changed, 45 insertions(+), 19 deletions(-)

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
index f6d7098a07..b3b53fee6b 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -70,11 +70,14 @@ create_shared_memory(const char *filename, const size_t mem_size)
 
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
@@ -135,13 +138,15 @@ get_num_hugepages(const char *subdir, size_t sz, unsigned int reusable_pages)
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
@@ -149,13 +154,16 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		closedir(socketdir);
 	} else {
 		/* Can't find socket dir, so ignore it */
-		return 0;
+		goto nopages;
+	}
+
+	if (asprintf(&path, "%s/%s/%s", socketpath, subdir, nr_hp_file) < 0) {
+		EAL_LOG(ERR, "Can not format free hugepages path");
+		goto nopages;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
-			socketpath, subdir, nr_hp_file);
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
-		return 0;
+		goto nopages;
 
 	if (num_pages == 0)
 		EAL_LOG(WARNING, "No free %zu kB hugepages reported on node %u",
@@ -168,6 +176,10 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
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

