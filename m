Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD21AD3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:44:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FEAD402C6;
	Sat,  6 Dec 2025 19:44:18 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 39A5840156
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:17 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42e2e52cc04so1141009f8f.0
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046657;
 x=1765651457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=FNgWQL2yOZBLCa92tLD0CG4+TPcB/iekyDw52Fsj+5cSpgDnNkRE8ZwK+V/1s9xZGm
 KkQ5LQLBkgjYTJt17xkH1/Qv3PpJWgzFtBwls3MgSe+QnkVzMOBifeIYAmru5HmfRLIx
 O9w6+9vHJ4U4BRFIlTd+OlQCHHa2gb3cJZUFPRzjvokDpW2Fw4lu3PjuaIXgVjdkEuTv
 Tcrhql3AVwLsMwM1mg2LP0/ybwM8cfBUoJ2KvRI9sKdvceS2qKlY7PLOO9XrZtgMJ1Hn
 Qo/zv6KcohLAxeVWcp7Cf4LdteV+plf88aszq9VAy0NePqHRtDqfa13hQdoF9/HV8jWY
 XCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046657; x=1765651457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmSXdBjct75LSnoQNuZFUBl2DwMeg+yCcP4lXKUx9yc=;
 b=RK5Sdp5q4QUSUWlaiKNR8ELirNZ/yVl/CjPDUXunLRxYgWvxVllHN0EjXYPyc9E/yW
 Pm3E7Sqzxett8YFO2qE/GGiPrAE1FHETjeRUDGmpgkBMwfNvfDPJ+zXIrcDEoHZb96/k
 OT7ePjq3vIIAh5HUw2ZLoeC6BSlgsknY1HZqVDhSXWaFa7L+SlDPSFc7tNiUrmHge5mu
 LoVqsJE3gNPwGkjl9NBVvufcYPsYWHuS4w1O3PnajYMNILtKBjQPo0pYAMK9Ple7t92z
 heOwh99Tb5yYtVyF61aPjsIVBAQaEvoencKHhtaI4yX7c2fBOj0sIoz3imkYFz42uQ1/
 j57A==
X-Gm-Message-State: AOJu0YxJYDSIBm9eYRGcTMR1T3eao1kA6uQl5IF3TAb4LmfAzKedcaNX
 WH3LLKJdXdqQ9p7gVCbTngzzTWoqh5Ue5pIuGSn9WKu0oQ5Vmc2cIJDov6RAkErWsdnxji0VO9c
 T87MI
X-Gm-Gg: ASbGncvDguT7i6sdZ9TGLKrgbaTknf3t6Lr9cbfh7mxHmz2btXSKRbZ5Ln6QfPGwdWJ
 xcy4qxj31KK9QgQYmg0GQepcuji9y9METs74lgxC/djTqRzx+8FSNpe/56PiniDkUdmGOmd2h4c
 XEX09ABV1PZD57zmANMID9sakMFYToKwIDUuU4R+62FzYTnklhQD8rkY2649migQcCqQI5mv1tj
 X+lIZI/yIyZq2O2aPs7aqi4GCve7odNIaqI+jnjvyDOF43lczsJShAAjRw61Il5xxJdlkiut68e
 4DxWjKmPzwWl+eg4fIqzSg+QAYSQpCVsbZU85BPWCAnWRMO11jy97yCdbO3y1kp3z7Ixc8Auydi
 W/jn3QO28mjQN4CBIJ2wGf+K92FnMVRO+j3w0XYz3GJoR56Su/n1MW/mH+TCH4FdM5AHoPb/GWQ
 5uHTDe5v1YgxCxpMgTGloHGZyh2FuuwK5glyitwkPZHMZrAHYOYQ==
X-Google-Smtp-Source: AGHT+IHePdv6X3wMJmg195vvGof1+TQ5EFz2hks79dMjNML5QRXXfT+r6RHCgcRh/Rp+0isFAMIOsg==
X-Received: by 2002:a05:6000:2486:b0:3ee:3dce:f672 with SMTP id
 ffacd0b85a97d-42f89f0fab3mr3497949f8f.4.1765046656773; 
 Sat, 06 Dec 2025 10:44:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 01/16] eal: use C library to parse filesystem table
Date: Sat,  6 Dec 2025 10:43:02 -0800
Message-ID: <20251206184410.542725-2-stephen@networkplumber.org>
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

