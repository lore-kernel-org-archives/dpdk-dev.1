Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA7DCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 20:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6E50406B7;
	Wed,  8 Oct 2025 22:43:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5C60B40A80
 for <dev@dpdk.org>; Wed,  8 Oct 2025 22:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759956193; x=1791492193;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MFnNUnMArvN1MCy0gZ5XE9cpVdUB6rc+loeAlG8uQWQ=;
 b=Y8ZHRQuHhJuqfPdPgEwKjs1bOpxABCzyK9QIiqoLLHYdewLq5/sIcq6j
 xTfa9x3ZxzGYg424jOn5d4zBLNSCFg/Vwy7FGkRBLVgbATs/Kk3fYG97/
 RIizO7XB6j8eaZ8iPjFBIlC+zp8EvJjMGIBLXjpvvoMDO9aGx/OSKcjBL
 OGCnA276GadiZZ6KvA2Q4hQfY0XA6HLxyNdI5bGEpSpkJnt0LpErIefee
 xyf85N1sXrV0pyYB0Uy5ijjjDVTUtMQlqRTy2NyT5h9p++kH8AHq9Li9z
 SAfUMzpFcQN9lHZutBw3U6B5cNztr623+i3a8B/IZ/ZVz9qPxO9yjUnwr w==;
X-CSE-ConnectionGUID: aCv/jp6jQyap+kt57qZubg==
X-CSE-MsgGUID: FVBQj0QMR/6QYYbxvuJllg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62079256"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62079256"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 13:43:11 -0700
X-CSE-ConnectionGUID: E+mybVDKSg2jO3Xi3qZNkw==
X-CSE-MsgGUID: dzaZ3+5/TnSBQxpkSW7jrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; d="scan'208";a="179790669"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 08 Oct 2025 13:43:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 14/21] eal: simplify handling of conflicting cmdline
 options
Date: Wed,  8 Oct 2025 21:42:37 +0100
Message-ID: <20251008204244.2288583-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008204244.2288583-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251008204244.2288583-1-bruce.richardson@intel.com>
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

Use a utility function and macro to simplify the code for checking for
conflicting cmdline options. The checking can also be done at the
initial argument collating stage, shortening the argument
processing function which is very much on the long side.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 119 +++++++++++-----------------
 1 file changed, 47 insertions(+), 72 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 768b3544e3..a29c84c675 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -185,6 +185,29 @@ struct rte_argparse eal_argparse  = {
 	}
 };
 
+static inline bool
+conflicting_options(uintptr_t opt1, uintptr_t opt2, const char *opt1_name, const char *opt2_name)
+{
+	char name1[64];  /* should be the max length of any argument */
+	char name2[64];
+
+	strlcpy(name1, opt1_name, sizeof(name1));
+	strlcpy(name2, opt2_name, sizeof(name2));
+	for (int i = 0; name1[i] != '\0'; i++)
+		if (name1[i] == '_')
+			name1[i] = '-';
+	for (int i = 0; name2[i] != '\0'; i++)
+		if (name2[i] == '_')
+			name2[i] = '-';
+	if (opt1 && opt2) {
+		EAL_LOG(ERR, "Options '%s' and '%s' can't be used at the same time", name1, name2);
+		return true;
+	}
+	return false;  /* no conflicts */
+}
+#define CONFLICTING_OPTIONS(args, opt1, opt2) \
+	conflicting_options((uintptr_t)(args.opt1), (uintptr_t)(args.opt2), #opt1, #opt2)
+
 /* function to call into argparse library to parse the passed argc/argv parameters
  * to the eal_init_args structure.
  */
@@ -209,6 +232,30 @@ eal_collate_args(int argc, char **argv)
 	if (retval < 0)
 		return retval;
 
+	/* check for conflicting options */
+	/* both -a and -b cannot be used together (one list must be empty at least) */
+	if (!TAILQ_EMPTY(&args.allow) && !TAILQ_EMPTY(&args.block)) {
+		EAL_LOG(ERR, "Options allow (-a) and block (-b) can't be used at the same time");
+		return -1;
+	}
+
+	/* for non-list args, we can just check for zero/null values using macro */
+	if (CONFLICTING_OPTIONS(args, coremask, lcores) ||
+			CONFLICTING_OPTIONS(args, service_coremask, service_corelist) ||
+			CONFLICTING_OPTIONS(args, no_telemetry, telemetry) ||
+			CONFLICTING_OPTIONS(args, memory_size, numa_mem) ||
+			CONFLICTING_OPTIONS(args, no_huge, numa_mem) ||
+			CONFLICTING_OPTIONS(args, no_huge, huge_worker_stack) ||
+			CONFLICTING_OPTIONS(args, numa_limit, legacy_mem) ||
+			CONFLICTING_OPTIONS(args, legacy_mem, in_memory) ||
+			CONFLICTING_OPTIONS(args, legacy_mem, match_allocations) ||
+			CONFLICTING_OPTIONS(args, no_huge, match_allocations) ||
+			CONFLICTING_OPTIONS(args, no_huge, huge_unlink) ||
+			CONFLICTING_OPTIONS(args, single_file_segments, huge_unlink) ||
+			CONFLICTING_OPTIONS(args, no_huge, single_file_segments) ||
+			CONFLICTING_OPTIONS(args, in_memory, huge_unlink))
+		return -1;
+
 	argv[retval - 1] = argv[0];
 	return retval - 1;
 }
@@ -1795,78 +1842,6 @@ eal_parse_args(void)
 	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	struct arg_list_elem *arg;
 
-	/* check for conflicting options */
-	/* both -a and -b cannot be used together (one list must be empty at least) */
-	if (!TAILQ_EMPTY(&args.allow) && !TAILQ_EMPTY(&args.block)) {
-		EAL_LOG(ERR, "Options allow (-a) and block (-b) can't be used at the same time");
-		return -1;
-	}
-	/* both -l and -c cannot be used at the same time */
-	if (args.coremask != NULL && args.lcores != NULL) {
-		EAL_LOG(ERR, "Options coremask (-c) and core list (-l) can't be used at the same time");
-		return -1;
-	}
-	/* both -s and -S cannot be used at the same time */
-	if (args.service_coremask != NULL && args.service_corelist != NULL) {
-		EAL_LOG(ERR, "Options service coremask (-s) and service core list (-S) can't be used at the same time");
-		return -1;
-	}
-	/* can't have both telemetry and no-telemetry */
-	if (args.no_telemetry && args.telemetry) {
-		EAL_LOG(ERR, "Options telemetry and no-telemetry can't be used at the same time");
-		return -1;
-	}
-	/* can't have both -m and --socket-mem */
-	if (args.memory_size != NULL && args.numa_mem != NULL) {
-		EAL_LOG(ERR, "Options -m and --numa-mem can't be used at the same time");
-		return -1;
-	}
-	/* can't use both no-huge and socket-mem */
-	if (args.no_huge && args.numa_mem) {
-		EAL_LOG(ERR, "Options --no-huge and --numa-mem can't be used at the same time");
-		return -1;
-	}
-	/* can't use no-huge and huge-worker-stack */
-	if (args.huge_worker_stack != NULL && args.no_huge) {
-		EAL_LOG(ERR, "Options --no-huge and --huge-worker-stack can't be used at the same time");
-		return -1;
-	}
-	/* can't use socket-limit and legacy-mem */
-	if (args.numa_limit != NULL && args.legacy_mem) {
-		EAL_LOG(ERR, "Options --numa-limit and --legacy-mem can't be used at the same time");
-		return -1;
-	}
-	/* can't use legacy-mem and in-memory */
-	if (args.legacy_mem && args.in_memory) {
-		EAL_LOG(ERR, "Options --legacy-mem and --in-memory can't be used at the same time");
-		return -1;
-	}
-	/* can't use legacy-mem and match-allocations */
-	if (args.legacy_mem && args.match_allocations) {
-		EAL_LOG(ERR, "Options --legacy-mem and --match-allocations can't be used at the same time");
-		return -1;
-	}
-	/* can't use no-huge and match-allocations */
-	if (args.no_huge && args.match_allocations) {
-		EAL_LOG(ERR, "Options --no-huge and --match-allocations can't be used at the same time");
-		return -1;
-	}
-	/* can't use no-huge and huge-unlink */
-	if (args.no_huge && args.huge_unlink) {
-		EAL_LOG(ERR, "Options --no-huge and --huge-unlink can't be used at the same time");
-		return -1;
-	}
-	/* can't use single-file-segments and huge-unlink */
-	if (args.single_file_segments && args.huge_unlink) {
-		EAL_LOG(ERR, "Options --single-file-segments and --huge-unlink can't be used at the same time");
-		return -1;
-	}
-	/* can't use in-memory and huge-unlink */
-	if (args.in_memory && args.huge_unlink) {
-		EAL_LOG(ERR, "Options --in-memory and --huge-unlink can't be used at the same time");
-		return -1;
-	}
-
 	/* print version before anything else */
 	/* since message is explicitly requested by user, we write message
 	 * at highest log level so it can always be seen even if info or
-- 
2.48.1

