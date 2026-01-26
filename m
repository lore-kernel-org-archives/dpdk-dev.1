Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFADD1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C75D440BA2;
	Tue, 27 Jan 2026 00:24:58 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 12A3440DCF
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:57 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-432d2670932so4635135f8f.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469897;
 x=1770074697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRsjyC/SqJFn1FSYPH0B4ComJWgG/yPJUtNlNDXCheY=;
 b=J9O691W9J+wQ3FGencv92N2FCOjeinmYC1MUE6NNuTkLazfGqL1M8F8cpwwg8S+635
 K2OnFH8sT1rPtNwIGCf4ga0LJagTh4UIkJiZuG4r3d+s2cD7NjiGurpi7mz9KD6tssEf
 f5rJ9vealWZPMCY5GA/je6V8ak9CCrDNSPqFB2+9uSndPp7Xy+9bEhhPDk1x0OCAE3k5
 7TBZOAdqIenkh/IEKwTh5J8DyVfJRRrP6PfZ6Zk7ZC9WxEces91rGnQ6YbaoaKqI+Dn3
 nnjeCqRJCBtYX2+8W4i5A3vCuym9XhaF79yc1i+TPeIfQvd6gzo5GZNpoq95WWM7egto
 O/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469897; x=1770074697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRsjyC/SqJFn1FSYPH0B4ComJWgG/yPJUtNlNDXCheY=;
 b=fwkTtbum99H+WqaeZPPgtCAi3PqBHwS6n+FEIIJf13XnfAOYW4Qs+UgMdlrESnyLYY
 KWzLhnIZFrvVEOFkRtI4WGS9r99jByBNLAGlBAyOIh5d2C/FAju+b5WruqmywRje+eoV
 t4UKYN3iBwCY07tjjlIodTV08BZr+8Lx3HSSVUZ9EGylPexmsDeK5yDlz/ImdTaMRpDZ
 ogADOUbN4YiVkmD66jwi5jJb79MqEpqaRmlCKHyuvLNWP74ds8I2USb1FjFFVpOSA+vI
 2u6jnXOK1LmUNKOjoNomjlnhrMiIx2+SL0dBJEUTg37LQ0Kavd0eYKLEHXurmcqXXtky
 z9gw==
X-Gm-Message-State: AOJu0Yw5QrBxY3b8KbF+xLdQMvuLHJm2T0j0lLdQGO6T+sjuIdO6x5cr
 Xy0UHsBcsX2Sz6EGeHI6QQBEO4fTUtHuQ7Bp5hJAq3mk2EZsbk4oobbuwI8cqsZeIp8EeVMWavb
 /u4Kd
X-Gm-Gg: AZuq6aL7Q5A/slVDEcSB814LApI7rulqIA0ACG3+OueN47Zdq5HO4XMwtq8QxyhrakH
 vGsWu+FQRsmC3xsYpBtaHw5scd6Z1LJIiBrmxYyMi8U8DgJNWyESnOEV2Fv0Pp4oRIXisV2P20/
 eKaPxBZuT0fcbEJOMMrBMCXuJHaGVvJhYmvif/FUDENSBt9ysHuaWt3CSrVdMwVaqAaDmV+Sjn0
 RJ17V6ETu7DBY818/xDFfq2JZoMldOLSmTLRMF3i8M0r+4fJGFBquG2YouZ89GQj27SeFQarhxb
 1PpG41IjS+HCAcccMqtl90X9RV3JqGUdxjQ3TK+1CZnHSUdF4TiVrw5guwhdw+RIZtKPrglmxuk
 sna7JH0q20CqXKebMvV5YRFXpMzOCru/QuOHI0EXUiWDlcXa6xwQwtHVt1GAowC4AZiIzCOiA+y
 KBDC1RZVMtL3Ybl7dRO4fteu2gjDLiVAJQzLBahNbVw6QzAvAPlQ==
X-Received: by 2002:adf:f644:0:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-435ca193d9fmr6238323f8f.34.1769469896605; 
 Mon, 26 Jan 2026 15:24:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v12 11/17] eal: check for hugefile path overflow
Date: Mon, 26 Jan 2026 15:22:19 -0800
Message-ID: <20260126232428.276534-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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
index f4c03b7ce5..2ccf6b4e1e 100644
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
@@ -147,13 +152,16 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
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
@@ -166,6 +174,10 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
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

