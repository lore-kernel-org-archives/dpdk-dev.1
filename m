Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37DD10F9963
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79B8640650;
	Wed,  8 Apr 2026 19:44:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6BE74402E4
 for <dev@dpdk.org>; Wed,  8 Apr 2026 19:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775670258; x=1807206258;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7XFS33XsrJEy93uqJzc2jHofmOjsx1BC2qS7TeommYY=;
 b=M3kSesh/8zUiE1WQizaj0AxXrtivRCW5UzFa7/YRHatQA5Q+xVwhhoQH
 j8WyIuxV5fYdSBtfXgRsXhWnMQwkVQkeo5zMZRaqf1J0ZEZ5naD13oUwM
 tvECoJ5cnCoaRQTE+gBZhz+6ycslccw8JV3eNMj/hbLoQka/SqY8cQBVr
 uY4N8te05jitnenezTzsdH9aN1AGDs0wVYwEzaHTZmBpkgHjQfDhdI0Wr
 BfPYMb/6qDmn2HGsTwWK5eV2njh3abFo0FRTfMiNIEyLYiXe/PnBMBcPn
 2CieuzG6HGC30ahqrGqJZW+gELi2A7y4G02S7og0tRnT5RpLJ0xdF7MqU w==;
X-CSE-ConnectionGUID: IJhzeZ/OR3OszluJf9lwMQ==
X-CSE-MsgGUID: TAUnszkZTQyfP49+mmWLEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76851173"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="76851173"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 10:44:17 -0700
X-CSE-ConnectionGUID: RI43xyxRRXegGza+ySCGfg==
X-CSE-MsgGUID: OoFzwcvWSRCA5XUFxjk2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="266510690"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 08 Apr 2026 10:44:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>,
 Adam Hassick <ahassick@iol.unh.edu>
Subject: [PATCH v3 2/2] test: simplify spawning extra test processes
Date: Wed,  8 Apr 2026 18:44:04 +0100
Message-ID: <20260408174404.2002743-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408174404.2002743-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260408174404.2002743-1-bruce.richardson@intel.com>
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
on procfs on FreeBSD, by using argv[0] as the binary to run, rather than
querying procfs for /proc/self/exe (or /proc/curproc/file on FreeBSD).
The unit tests should never be running in a way that leads to argv[0]
not being the actual test binary.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Tested-by: Adam Hassick <ahassick@iol.unh.edu>
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

