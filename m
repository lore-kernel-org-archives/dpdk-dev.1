Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF7AD3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B31240670;
	Fri,  5 Dec 2025 21:16:06 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 9BB0D40667
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:04 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso20120075e9.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965764;
 x=1765570564; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxBPZqSt2JO45DtrzcCWLwlSOwRe8QCA/EethZZgdlk=;
 b=ksQOWvUJ1YWlIFYoiglVcfCX9aheqg/X7MEMCNucTcI3Yucldrm1VrqkYKyzvJm7Lz
 /kmGdchQ4R/joIoOrtLtdH0skMdeyA1V6XOOfFfMJ4Ec44yTMHwOxk47sAWMVYc8QPSy
 Ty9tPpkHI4uFWwI9BL6JmfI1WuC2/tcV4NIbwBzsSp1xclc/Q+o5DBzOohMY2/4kUq1I
 O+3lkoQHcoQtg+JZpQsWUX2nkK+wPpxuNGVCrUremkLs88n7u5ykHvKCuRRBb+wABNSI
 jKrotyS9YWPGTe+GSHOCw8+EVNowdjdzu2INUkRR9a5WpzLZVrWM09EZcZbBVb/lS17w
 Nvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965764; x=1765570564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxBPZqSt2JO45DtrzcCWLwlSOwRe8QCA/EethZZgdlk=;
 b=coFN7EW/1hrIEjXtr4BIBEyhbieI/6BfXUYzUSY4boMV13ccb0885CC7L+Vi23rQS5
 lcTT3SbZUclt9bt7Ai1cXWJ+qf0KAIivWo65kAKdGRDd0Kl/3E2uzaUb9Jyov7hyd2NO
 hFaQgUudKI7d1SKVIUt7GVx2YIDvCQgvV8QgbNAVGT54ADtCYkvInS/NbO+YQPxMiVuu
 L8NzD8fypPcLx4DzRji4vtodXnoMJ06D0TfIyb0wPWxk2/Z0hxIJKbjPVH/VY7HoUPDl
 Rj4cMp9tThw6bicUENMlxOJv1gj7itSeVVd6QlHLh4ahdorZL9o8FRqb1rHWiw6FtQHc
 kSPQ==
X-Gm-Message-State: AOJu0Yz2O8fOC7lGPGrR8/SoVOMKF3nBvjIL6aeRmeBgfSVm5NIV2aCP
 sJksj9GpqAVfhfe11svOzbN8FFKlXpjOQYgKbb55AYu3RtxDP0gU10PwwDzJenrhmOIQaU0v4ot
 uT0Ky
X-Gm-Gg: ASbGnctUZmP6BRwJbdkkMe0hleX5HT6rJn/CTeAKEFUXTOYLsBaDEJnv/YufiU08WkW
 2StYOAg6uGkPN3SFrU8ZdCHs5dxOxXJAXu9UMb4ZeQIYmftcwDlhHJjxNn7+bTzqdYPK2Y97IEj
 CHDgt+gEkuwaXGIbTxsVuvnH2+Ew8VvoHVX//pj25rGDjTolrSXbz43gUQq9yv0fGJLg3coIhxM
 ONH5O6BjRWpCTnqp/KhJT7oVClq0SnvNvj3H3hGUi2dlqNIvDmKAGsvSh+nj+pSA3a6vC/fIyb7
 4iICH6rLyRBdIiKS6VKzv3L9mDIO9ZzDxGJwrfDW+Wq2nof8bayQIwRG1uW7RHj8ndrWVrHLWAN
 eStwcDs6xTdIf/38kWwP3bUi3wMuboMf0CBDz0bQ8EDRr7nQ5Jkr9jrhboiBP1tF+sgn3sIugmF
 N7gjU7Jpo6/oM4TE13bI5A3BuszQvHRaZ2GWTiIelRkPH/UA4jHQ==
X-Google-Smtp-Source: AGHT+IEzcAfnREeu1XCpMVMlMR1GsRr2gz5mGYAtzHJL/9XPWc6KelgO+rxC4GGbH8N1ncD25In36A==
X-Received: by 2002:a05:600c:3b07:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-47939e38701mr4800345e9.29.1764965764208; 
 Fri, 05 Dec 2025 12:16:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:16:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 11/16] eal: check for hugefile path overflow
Date: Fri,  5 Dec 2025 12:11:40 -0800
Message-ID: <20251205201537.251131-12-stephen@networkplumber.org>
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

When constructing huge filename path, check for possible
overflow of PATH_MAX.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_filesystem.h | 10 ++++++----
 lib/eal/linux/eal_memalloc.c    | 11 +++++++++--
 lib/eal/linux/eal_memory.c      |  9 +++++++--
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/lib/eal/common/eal_filesystem.h b/lib/eal/common/eal_filesystem.h
index ce52babb7f..4cc5b22a16 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -94,12 +94,14 @@ eal_hugepage_data_path(void)
 
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

