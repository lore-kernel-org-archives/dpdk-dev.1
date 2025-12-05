Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A39D2CE0B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A35D440B9C;
	Fri,  5 Dec 2025 03:30:10 +0100 (CET)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6E56640B91
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:30:06 +0100 (CET)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4ed861eb98cso17233091cf.3
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901806;
 x=1765506606; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Di8NYou8CemjW0YHySeicXeybrAlOOBuqsuDrt5pFc=;
 b=E/5GrHwvc/yYoHr79Q6V8xPC5WNGg1Xe8jBiC8//KENZRqT6LxH1mLLP/nAT0Z/Kws
 kusO0XVmxsEFr1KlsXuQZA5k/FMNfV3M9IJREWMjxQSeZlf3L1fbxb07YfunY46DAPQ0
 xAS1tAcFkQnyxPK/2uamrsZv6zMTThj10Y6QEdserTCbt1YNCifz2tJgrfT2mxuRlv8U
 alHQGEjod13lMpAwvBGg8PyhXfef8/FeSaUN6tKWOlJf+iHOFd48aB8A+ESI+X0nWlHS
 mbjmp5kIk1rbMRRXu6XbTZhxV5aNqLx5w8Jb3cVVPvsrghjbzK11xLqxHIM2EmI4NaqI
 tHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901806; x=1765506606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Di8NYou8CemjW0YHySeicXeybrAlOOBuqsuDrt5pFc=;
 b=VFb3QGTKZgNEiJYEidrYZKGBdQELVSVS/UZQlQYNhVCYxNgon2gFqCoFqJ6O2xZ3Z0
 TOUhsgwcHKsoEMQxWJx9UeW3v0JMdM91wKXBdq9w6Yri5cEh7U79pByX6ojJfFQyGMuZ
 8NyL/OTM2P5mre8j5CC7UXVaeuS1zFvHSf1zHxU6etu5pr9v/2tn5JD7pxbReMUEZL15
 +v9FwzJ94f2tXuh2fH/OGfNyZL9Zlv9XVn1H22BBHE2//Iyr06GfwppTh1Gy+p7c01st
 XwAY25jthAAbNBU28IHDTPlGylFm2cr11zPJbJMIxsyZaxat++EdJ+2WJgVr3V4HUCvr
 OOaQ==
X-Gm-Message-State: AOJu0Yz4H9vj9HmbAu1V9YI12TY1jRRhlviYSImfw3m3X9KOytpMsClN
 M8UGRlWDM70pR1++EeoAjFB6kZRBKAg3KMjbguesfwCgO7i/uKCspPCNH+5wFYb6YZybOP4lGvq
 /RGuV
X-Gm-Gg: ASbGncvPk4CT4NaGJ6Hyj/etcL0j7q62GnhZRWDtgdHWV0n9QGT0qANQ3QSG/+LhjN1
 erf1A9/WFtTPajQ0OghQej2Uj2LU0uE38CiYZHn0r4uAEIFBD0kNkRozHIDsNTubRlZttD/Jyhm
 n6mhSby12hfs9pZsFFlVR6Yixfs3/13Dkh/3rMXvyqAxItCh0LuT8FrljZTMrVnYMmTHAmoNhew
 Cqk7tG3GGTkK5P59kHBzl27ctgpKXofQr6wMTyNfEIpz9DTNQUg0wmvEr2sau+zzCSAkdEplCKv
 CFXIYvcNGVBAVTQDylz1Izv9j0bvSOxeO8FVl8Y2YKCG8B0/cvZOhlIFxbncs9B01fQrT5D6dZz
 g74SiB9mazc5+HK3sK5WE+8Lwd7Kmy1RDSJ2V80TYyob2KauDer9zVbJs1hDYR/3AXnbP65Wirw
 9Gg+5DldXyL1lP6KtPHzY+tlHWQjP5cUHNTMz+rScW82ZxqdJGWw==
X-Google-Smtp-Source: AGHT+IFBggg9aNYnMZtJ79Rv4h4xzHzG5TM5271VG+hYduAxs8bJ7av8AuoiZf+6LpZwnAeDz/QAHQ==
X-Received: by 2002:ac8:7e86:0:b0:4ee:1dd0:5a4f with SMTP id
 d75a77b69052e-4f0176da1c4mr112689191cf.61.1764901805772; 
 Thu, 04 Dec 2025 18:30:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:30:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 13/14] eal: check for hugefile path overflow
Date: Thu,  4 Dec 2025 18:28:22 -0800
Message-ID: <20251205022948.327743-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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
index 5371d9f1d6..006d2ff3e5 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -93,12 +93,14 @@ eal_hugepage_data_path(void)
 
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

