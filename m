Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E976109879E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 16:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D901D4065C;
	Fri, 20 Mar 2026 17:11:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0CA74402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 17:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774023085; x=1805559085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3edAdvaZY8TLGkBNA1j41Q5/D9+QH5mUNMAwJwL311o=;
 b=XTJS70RPx9y8DwI1PYjLqsvFiXkN9ILGd3kRVBPcGUnABv2EI9ajMLhN
 QkMbwQHM/hXZME0C8PZPKMng6xKPgW+j7ns6Pnz1uhbrqWAjzAkpy4EcN
 QVzIydq08n5ZAQ+s9bzIzU9ZmvcpErQSLEt/oZkNEm4ZYJsLuwhK/3BgO
 HQfDW38KAejRShUab4nA8Vdk5mVNCF7Xx5YXA8QsflsDEL6Y6spVescL2
 ChqrKC9RO+Zydeaqo0Ewjhy8Ovb2HWPF1K0yP3R6Pf4mReXklL2XJOHc5
 mLMu8pQktlIidfinwi1O/EpPpf/wLO5Wyoq0aeWNNYlj4ntwJVD7ihg6Y w==;
X-CSE-ConnectionGUID: 09RpJvngQgKnugYTtQhzfQ==
X-CSE-MsgGUID: fSosBUWSSFydMIMFWnOlgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74995178"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74995178"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 09:11:25 -0700
X-CSE-ConnectionGUID: dZ6pWWC4Q/ez/F/HxM3Piw==
X-CSE-MsgGUID: ve+3EcvgQWCXWSV+aTG2GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223546909"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2026 09:11:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, probb@iol.unh.edu,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/2] test: simplify spawning extra test processes
Date: Fri, 20 Mar 2026 16:11:08 +0000
Message-ID: <20260320161108.331745-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320161108.331745-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260320161108.331745-1-bruce.richardson@intel.com>
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

A number of tests require secondary processes or additional primary
process instances, so we have common code for managing that in the test
binary. Simplify that code a little, in the process removing dependency
on procfs on FreeBSD

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/process.h | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index df43966a2a..3ee899dbc8 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -19,14 +19,6 @@
 #include <rte_devargs.h>
 #include <rte_eal.h>
 
-#ifdef RTE_EXEC_ENV_FREEBSD
-#define self "curproc"
-#define exe "file"
-#else
-#define self "self"
-#define exe "exe"
-#endif
-
 #ifdef RTE_LIB_PDUMP
 #ifdef RTE_NET_RING
 #include <rte_thread.h>
@@ -96,7 +88,6 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 	int driver_path_num;
 	int argv_num;
 	int i, status;
-	char path[32];
 #ifdef RTE_LIB_PDUMP
 #ifdef RTE_NET_RING
 	rte_thread_t thread;
@@ -132,7 +123,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 
 #ifdef RTE_EXEC_ENV_LINUX
 		{
-			const char *procdir = "/proc/" self "/fd/";
+			const char *procdir = "/proc/self/fd/";
 			struct dirent *dirent;
 			char *endptr;
 			int fd, fdir;
@@ -188,15 +179,8 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 		/* set the environment variable */
 		if (setenv(RECURSIVE_ENV_VAR, env_value, 1) != 0)
 			rte_panic("Cannot export environment variable\n");
-
-		strlcpy(path, "/proc/" self "/" exe, sizeof(path));
-		if (execv(path, argv_cpy) < 0) {
-			if (errno == ENOENT) {
-				printf("Could not find '%s', is procfs mounted?\n",
-						path);
-			}
+		if (execv(argv_cpy[0], argv_cpy) < 0)
 			rte_panic("Cannot exec: %s\n", strerror(errno));
-		}
 	}
 	/* parent process does a wait */
 #ifdef RTE_LIB_PDUMP
-- 
2.51.0

