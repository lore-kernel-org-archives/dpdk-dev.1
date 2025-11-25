Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15E3D0EE18
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 23:06:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 825CA402A9;
	Wed, 26 Nov 2025 00:06:41 +0100 (CET)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id E62204029A
 for <dev@dpdk.org>; Wed, 26 Nov 2025 00:06:39 +0100 (CET)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7b852bb31d9so6951037b3a.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 15:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764111999;
 x=1764716799; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efCsZnYXdevraDHRcixrbQARevOc4H6zBKMEFMdZPDA=;
 b=XAjiSGGp8APqSMi37BKWJMsz27l2yf/u0W2z6kV5btXcky2/kIXYUZ6mU7I9K7R3Ec
 mxOvV/uoVpOqB3rV/XKTmlk3IugB1h+eBNNfmSpFhGLz3tAmWmLfONod5f/TNeFmerGQ
 9MQAKbZvVwQWhUHd72sfTpEZhwEGw5XgDmTv2m9dCTCUns7Fv5wxppbxlmQ3DJ+rhZRH
 bqcf5Ry/IjuNTM13HC76tgUskYjJVyj5vDFnij8n4NGLiWcVz1Id6lCe5NO8gF4ubVPm
 fA7kTN62mbiaXoW2ObulAsogloDLYW+HTyYeN9LYhSi/jRyaIUeqpKHOeGVKayjz9RqP
 HEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764111999; x=1764716799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=efCsZnYXdevraDHRcixrbQARevOc4H6zBKMEFMdZPDA=;
 b=JKsn2wyWSDjJ1+Z3+dNymwW8SzEqR5cq0NsT3LdHSaG79c4JSqJmppOB1O+65YenKC
 bdS6lqLl/5TIaKO48XUhFw9kcoZcNdPGTl/qLEJW04HA8G7kr8Y7Q7PNPg2amuzXw9/u
 XmAmcC0PnY39j4ydyV+gnCnnRfKoLQTd5jnmU9Ym4knhaZhxYzEc3Rkkshh5qc4glO4v
 ayaI+5vmdVERWshPvK/fPMsZ6/WYlsD3d8gTTjDEH5x2OQeXPK2yfG7UY7iFlG1UAnJH
 +Tyl/DO2AzdzDWY0MA8p4QwQEvpsPkr5Vq5/svS5HxY3c/eQOIGj/7i/KuX384m3KePs
 ayMQ==
X-Gm-Message-State: AOJu0YzjPG4eCowiK6AZbCIJJY2u9Xd0wQivaGjeTEmWRhc4FjOeUx9g
 qO1BtU0xZkzx3/jor/kww1iMfWRFbT+ZzoO3JkaIco8UjZMDFpd/XSk+7NwmYnqRMo+CD4lvRYr
 PyWCu
X-Gm-Gg: ASbGncuVOpmAq+Vijlf54R0FCVO27gOfLw9H75LTcRDCHc/CL4EQg7LKnhQhBXStIe9
 xhv8Ul+WxThcK787WWBKR4OLwQGElFNpeARQLuej6+3sIJ0XCmlQxWRY6u9hdtCzNrqpPixWwUn
 VW6+yMj1sYd1PyJmUbEpGe6BtSa2Ac22QNg9U6gtLQ0QL5HZrsKEbQZpbuKlWmlkc9n15qjB7lW
 sXbIzYVT/KrAbB4UMImIGRmrv6YAHEIRNhgXVMSoYhoFVVoRidt36+IAVXZOQLG9Jg8cejN1Lek
 0hyW1gyn3+5JVfi0V48/ZPhSszhRm7C1I/tYCC8+3nJroq2ghGNQgwXy5Q95fr0GW2tVaIQ2Ckt
 nrWndPzuK/TmLho+RjJQniiZzdU9QEec6vrAY1lofwcU8y1IzKYJZqf8rh+Sihr5fxvYUJRWOoC
 H/SXAqnLP1hyF18k5SE2muXtJV7XDWliYUllMi+fFdFCvbKimgVQ==
X-Google-Smtp-Source: AGHT+IFr7SusZHnRd+WRWmMOa0h8Fl4HCu/u2qCGWQju4bXC3vfRT1Zb93vL45WdmadNKr4WiMgXfA==
X-Received: by 2002:a05:6a00:399c:b0:7ac:87af:cf3c with SMTP id
 d2e1a72fcca58-7c58c2b2380mr20167237b3a.8.1764111998746; 
 Tue, 25 Nov 2025 15:06:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3ed471060sm19246798b3a.15.2025.11.25.15.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 15:06:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC v2] eal: use C library to parse filesystem table
Date: Tue, 25 Nov 2025 15:05:41 -0800
Message-ID: <20251125230636.157621-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251122194921.158921-1-stephen@networkplumber.org>
References: <20251122194921.158921-1-stephen@networkplumber.org>
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
v2 - implement suggestion to simplify conditionals

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

