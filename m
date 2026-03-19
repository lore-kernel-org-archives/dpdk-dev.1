Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B51090257
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F41C40670;
	Thu, 19 Mar 2026 18:14:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3E0CD40649;
 Thu, 19 Mar 2026 18:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940438; x=1805476438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nw4vCGx8TSQ4tpX/zkEKPYjAqsK+T3bYMrvA1x7jUTM=;
 b=RPgN1hMizpvAAblIpf5qBHeaWt8d2kVQA6z06OdNNAKqmlXcyFDQ3XpM
 Af2Y0IiIT6DPtX12Ad0oXWc0nVVFgoxul9wNwe8EG4OqAlOH6ptKNiQ7s
 f5SoCJCZm53+bCz/22ppJYKUGIVtSWak539MkXE78tj+FO8agITd+Debi
 uPolVBx/njh/xv021AB3PsBQMb4Mdk58CGNzg+BnU+jF+upM/03AjPmLX
 3md5rD6NEIvPpthfDD8767OB8taZiNnCeM2K1wjXCTbrgutEgruhVLyon
 hN/f75y/m+sGn8enNTR9qK3FZIatTicWHlYGMbBATmuKPGCueOa+LTj6o g==;
X-CSE-ConnectionGUID: XfscdJnKS3ynW9e90whUDQ==
X-CSE-MsgGUID: nxykxyCOS4+QKrF9ZpZoIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648062"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648062"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:49 -0700
X-CSE-ConnectionGUID: T1b6C7D6So6CyHwoipji4w==
X-CSE-MsgGUID: Nb4ZXbyISqyWUaphQ6AMMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979644"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 7/7] test/debug: fix unit test on FreeBSD
Date: Thu, 19 Mar 2026 17:11:41 +0000
Message-ID: <20260319171334.1151425-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
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

Fix the test_debug unit test on FreeBSD by:
* passing no-telemetry to the additional process calls
* ensuring that we always use the no-huge and no-shconf params
* removing the dependency on procfs to get the exe and using argv[0]
  instead

Bugzilla ID: 761 (partial fix)
Fixes: 764bf26873b9 ("add FreeBSD support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/process.h    | 11 ++++++++---
 app/test/test_debug.c |  6 +++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index df43966a2a..46b69ce330 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -96,7 +96,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	int driver_path_num;
 	int argv_num;
 	int i, status;
-	char path[32];
+	char *path;
 #ifdef RTE_LIB_PDUMP
 #ifdef RTE_NET_RING
 	rte_thread_t thread;
@@ -188,8 +188,13 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 		/* set the environment variable */
 		if (setenv(RECURSIVE_ENV_VAR, env_value, 1) != 0)
 			rte_panic("Cannot export environment variable\n");
-
-		strlcpy(path, "/proc/" self "/" exe, sizeof(path));
+#ifdef RTE_EXEC_ENV_LINUX
+		char path_buf[32];
+		strlcpy(path_buf, "/proc/" self "/" exe, sizeof(path_buf));
+		path = path_buf;
+#else
+		path = argv_cpy[0];
+#endif
 		if (execv(path, argv_cpy) < 0) {
 			if (errno == ENOENT) {
 				printf("Could not find '%s', is procfs mounted?\n",
diff --git a/app/test/test_debug.c b/app/test/test_debug.c
index bfda4d1aa3..eda9c3e0e1 100644
--- a/app/test/test_debug.c
+++ b/app/test/test_debug.c
@@ -154,15 +154,15 @@ test_debug(void)
 	test_args[2] = "-l";
 	test_args[3] = core;
 
-	if (rte_eal_has_hugepages()) {
+	if (rte_eal_has_hugepages() && RTE_EXEC_ENV_IS_LINUX) {
 		test_args[4] = "";
 		test_args[5] = "";
 		test_args[6] = "";
 		test_args[7] = "";
 	} else {
 		test_args[4] = "--no-huge";
-		test_args[5] = "-m";
-		test_args[6] = "2048";
+		test_args[5] = "-m2048";
+		test_args[6] = "--no-telemetry";
 #ifdef RTE_ARCH_PPC_64
 		/* iova=pa is the default, but fails on ppc64 with --no-huge */
 		test_args[7] = "--iova-mode=va";
-- 
2.51.0

