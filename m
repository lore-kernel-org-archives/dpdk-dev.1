Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B98CCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:16:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF77340B8F;
	Fri,  3 Oct 2025 10:15:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id E94B1406B7
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479327; x=1791015327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jAqPy5Z15zmIF44aKymAkhE7YpNLpsfb2p04OidFkxg=;
 b=InLrdzJQDAxQc1lmuAG7wzVoCohp+Ix2ZKKgDR7TM4YGCmvbydbTjvmB
 PMXhLnkWKEHE1g7ZMTDwf5uQMTu2Z9+GTIdGA9EcbVKmH9//xdubvPo91
 7X6jFaeu9nNRJq4WjxDujPCMVGlsQ1RIUqhKW4xJdlVg/EuY94mOmQe/8
 gqeNtiv9R6N8Yf92/HzyBB7ZxXhfp5Xi4lc8dh+etdg2Ntuh6JLLEjKmv
 xKBv7xdT2PC6qUkGWwhg5Uq4Z8gEcPBCPWXqd08UalFT5++Tjc9f4dvP3
 K36iQcLB2RveoQ1s1kOROb1A75dQaxhAi3P5C5eEoCwMFUoTsC5B+XGgZ w==;
X-CSE-ConnectionGUID: ctOdFqagRWunO/t2WhaWqA==
X-CSE-MsgGUID: I14yuCPsSW+isI/MJP0BbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473589"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473589"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:27 -0700
X-CSE-ConnectionGUID: oxKmlncpTR6EfgzeQ4hWXA==
X-CSE-MsgGUID: +vZ3U8e9SB6TYkGPD8wRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525868"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 12/18] eal: automatically init arg list options
Date: Fri,  3 Oct 2025 09:15:04 +0100
Message-ID: <20251003081510.1197166-13-bruce.richardson@intel.com>
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

The tailq list options from commandline require initialization before
being used. This was being done by explicitly initing those values in
the collate function. A better option is to do so using macros at time
of structure definition, that way, adding a new list option does not
require any other code changes to initialize it.

Since we are now including the same header 3 times, and need to undefine
the macros between inclusions, we simplify things by just doing the
undef calls at the end of the included header.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 30 ++++++++++++-----------------
 lib/eal/common/eal_option_list.h    |  7 +++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index db74bf2c61..d7a8263f08 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -74,9 +74,19 @@ struct eal_init_args {
 
 #define INCLUDE_ALL_ARG 1  /* for struct definition, include even unsupported values */
 #include "eal_option_list.h"
-#undef INCLUDE_ALL_ARG
 };
-struct eal_init_args args;
+
+/* define the structure itself, with initializers. Only the LIST_ARGS need init */
+#define LIST_ARG(long, short, help_str, fieldname) .fieldname = TAILQ_HEAD_INITIALIZER(args.fieldname),
+#define STR_ARG(long, short, help_str, fieldname)
+#define OPT_STR_ARG(long, short, help_str, fieldname)
+#define BOOL_ARG(long, short, help_str, fieldname)
+#define STR_ALIAS(long, short, help_str, fieldname)
+
+struct eal_init_args args = {
+	#include "eal_option_list.h"
+};
+#undef INCLUDE_ALL_ARG
 
 /* an rte_argparse callback to append the argument to an arg_list
  * in args. The index is the offset into the struct of the list.
@@ -109,13 +119,6 @@ eal_usage(const struct rte_argparse *obj)
 		rte_application_usage_hook(obj->prog_name);
 }
 
-/* undef the *_ARG macros before redefining to generate the argparse arg list */
-#undef LIST_ARG
-#undef STR_ARG
-#undef OPT_STR_ARG
-#undef BOOL_ARG
-#undef STR_ALIAS
-
 /* For arguments which have an arg_list type, they use callback (no val_saver),
  * require a value, and have the SUPPORT_MULTI flag.
  */
@@ -216,15 +219,6 @@ eal_collate_args(int argc, char **argv)
 	if (argc < 1 || argv == NULL)
 		return -EINVAL;
 
-	/* initialize the list of arguments */
-	memset(&args, 0, sizeof(args));
-	TAILQ_INIT(&args.allow);
-	TAILQ_INIT(&args.block);
-	TAILQ_INIT(&args.driver_path);
-	TAILQ_INIT(&args.log_level);
-	TAILQ_INIT(&args.trace);
-	TAILQ_INIT(&args.vdev);
-
 	/* parse the arguments */
 	eal_argparse.prog_name = argv[0];
 	int retval = rte_argparse_parse(&eal_argparse, argc, argv);
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index 6a0c501680..f5c21c8376 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -88,3 +88,10 @@ STR_ALIAS("--socket-limit", NULL, "Alias for --numa-limit", numa_limit)
 STR_ARG("--vfio-intr", NULL, "VFIO interrupt mode (legacy|msi|msix)", vfio_intr)
 STR_ARG("--vfio-vf-token", NULL, "VF token (UUID) shared between SR-IOV PF and VFs", vfio_vf_token)
 #endif
+
+/* undefine all used defines */
+#undef LIST_ARG
+#undef STR_ARG
+#undef OPT_STR_ARG
+#undef BOOL_ARG
+#undef STR_ALIAS
-- 
2.48.1

