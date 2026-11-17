Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C8606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KpZGG4o2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E963402A4;
	Tue, 17 Nov 2026 16:49:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id CEC9F4029E
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794930595; x=1826466595;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rQshUTbP16Ri8t4mxWh3ellfoHZIId0ZTkyL039Gra8=;
 b=KpZGG4o2AiFTdj7VUuIbgUvPep74E9kHjas4GeQt0LM7E2my/p3KAUnU
 FwYxdeGK3L/8AbCSSlmWiKeox3QohQIwd/jQNXXclbHys/Az4Z7jauDuf
 nI0Mg0xQ2mPNYRrshRKGgtvR3NdHIwZYj1FnHHodFmG/qnBdUnPdrS9Fr
 twVBvIm50vCENjKgwJ2Bqu5XcSQ9g0Q+B1cd3+aqTIVnrSu87zy6119uf
 +4h2KjhQzcS+zFaOo5ppt/e51V042yVRoVf5G4OEFRdByEM5ki68aS0eE
 MRfmgaTdE4gtDrdHEcuDjS3tALRMGuL8lVZblbXVDX2wUl4aZPrePS/Wk Q==;
X-CSE-ConnectionGUID: Q0E23tmvQjOz20qaVhr4wQ==
X-CSE-MsgGUID: l4YjmiTQRguG7nK0daYJPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3746487"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3746487"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 07:49:52 -0800
X-CSE-ConnectionGUID: uLuJrpnTS+qxN95TOX/5Xg==
X-CSE-MsgGUID: koETgTw+SGWto6qsHGQQ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10003733"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by fmviesa003.fm.intel.com with ESMTP; 17 Nov 2026 07:49:51 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>
Subject: [PATCH] app/wycheproof: avoid path check before opening vectors
Date: Tue, 17 Nov 2026 15:49:49 +0000
Message-Id: <20261117154949.4153145-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Checking the vector path with stat() before opening it leaves a
check/use race if the path changes between the two operations.

Open the directory directly and fall back to file processing only
when opendir() fails with ENOTDIR. Propagate other directory-open
errors and remove the unused stat header.

Coverity issue: 360736

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 app/wycheproof_validation/main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/app/wycheproof_validation/main.c b/app/wycheproof_validation/main.c
index 9b8182f15b..41ae182803 100644
--- a/app/wycheproof_validation/main.c
+++ b/app/wycheproof_validation/main.c
@@ -12,7 +12,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/stat.h>
 
 #include <jansson.h>
 
@@ -2031,19 +2030,16 @@ process_file(const char *path, struct app_stats *stats)
 static int
 process_path(const char *path, struct app_stats *stats)
 {
-	struct stat path_stat;
 	DIR *directory;
 	struct dirent *entry;
 	int ret = 0;
 
-	if (stat(path, &path_stat) != 0)
-		return -errno;
-	if (!S_ISDIR(path_stat.st_mode))
-		return process_file(path, stats);
-
 	directory = opendir(path);
-	if (directory == NULL)
+	if (directory == NULL) {
+		if (errno == ENOTDIR)
+			return process_file(path, stats);
 		return -errno;
+	}
 	while ((entry = readdir(directory)) != NULL) {
 		char file_path[PATH_MAX];
 		size_t name_length = strlen(entry->d_name);
-- 
2.34.1

