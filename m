Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59572CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B38240F1A;
	Thu,  2 Oct 2025 19:43:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7F9FE40ED6
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427018; x=1790963018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xocTyZAeENAGSSxsCI86IH3zKLbpCGNTh0uu84y9tHA=;
 b=UExMa9pVZknLf8ykqo8KH2e3QnFuk3fW+6WgAfRUWylN740Gx/+9izTr
 jVNdJDK45DcC/KT7UETQhrB46CuV3QWDwG2OBU/kFbmnJ4z6IBtEIpd5+
 V5R8AEde5vQs0VZg3BHXEIkpH+tYkLL7OgO200P0TXhKzzHzxei2MyGBR
 P7igpSU+lFRluHouxgnms8JIqUVMjMLWi2lcc4fNllrRy6Szd4C0NfxLn
 OtJn9YnPeMkI+ec968K8N1Gp2+HqjwZTdvuHLjDw1A0GMDqmNtePx8m45
 Zjr4ZQ5qA+5wj13gm4B6bP1IfaltMv3qfRRDqEsG7kmRuV0VObzdfKzND Q==;
X-CSE-ConnectionGUID: U32XVwAERwOR7W2CdeWKiw==
X-CSE-MsgGUID: evZHuEIXQ5ubQBrI3lyObA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271869"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271869"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:37 -0700
X-CSE-ConnectionGUID: rtoAlcCaQy6WQ3hr9BgapA==
X-CSE-MsgGUID: 2RTlKSj5Sb6gn2F6/GjkzQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:36 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 11/18] eal: simplify handling of conflicting cmdline options
Date: Thu,  2 Oct 2025 18:43:08 +0100
Message-ID: <20251002174315.962992-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
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

