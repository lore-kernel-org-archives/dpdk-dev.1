Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB633CCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F3DC40A6E;
	Fri,  3 Oct 2025 10:15:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id E00E240697
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479326; x=1791015326;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xocTyZAeENAGSSxsCI86IH3zKLbpCGNTh0uu84y9tHA=;
 b=fzawHHjNs4e5mbvuEWYnokNrbpXOr1Vk1aWXyZAttxje+NMtnqUn5IMP
 AWcxNIGPQLCQOHsd7FStkHOIcBLc5mH6CZcRdbQS/prKEMvQ8WtI4vGu2
 vkQfRBYCXdQhHlcV4n/EcEA4FgzEKuLeKZd42fCLqPlSb4MXQq2oMOYBz
 0qogLqiMRK55d29/YPS75ioBLh3wROoyACNvJSRn695PwUGkHLssIGHC+
 7WDRzz3sEKm1IGRfWxYjrrgMqD7I76A/RMer+QFUvJxshCkwxv8g8WYOc
 93qotAMaY5IdqqLZvXu9UO62Cn1O+efPrbhUW/YqhqvguRSUShM7Xt4yW g==;
X-CSE-ConnectionGUID: Cr35ms3cTHSeZa+jZTZo8A==
X-CSE-MsgGUID: 4oib2213TTSymW0OvlMZ2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473585"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473585"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:26 -0700
X-CSE-ConnectionGUID: HPlBmHZoSxKPtRnwgylccg==
X-CSE-MsgGUID: +tDDakP5THSWlrgtUEEzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525862"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 11/18] eal: simplify handling of conflicting cmdline options
Date: Fri,  3 Oct 2025 09:15:03 +0100
Message-ID: <20251003081510.1197166-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003081510.1197166-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
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
index b6aeeadd8d..db74bf2c61 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -184,6 +184,29 @@ struct rte_argparse eal_argparse  = {
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
@@ -208,6 +231,30 @@ eal_collate_args(int argc, char **argv)
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
@@ -1794,78 +1841,6 @@ eal_parse_args(void)
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

