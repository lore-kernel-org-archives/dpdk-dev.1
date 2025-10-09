Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF3CCCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8855340B9B;
	Thu,  9 Oct 2025 15:01:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id D764B406B7
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014888; x=1791550888;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zazgTLtq0MMabpg2WlRD4/ePPmfQk/jgN71FJzXnnrk=;
 b=CkIpEnRxVfi6XBLjQhagx3zr69rG3cYCQxRKdGfHi7eUUPCNvCKqr+iw
 ARDGCy5nzpKm6uTduSMPoMpo+W40iPhUYbELZ8iu6650mMPgw333nICMx
 EJpBBQ0ddDkG0TW8bxlzgisZijSnSrMRt3CZ60yrffHGS8wXGKFRJiQ6c
 vYj83FqSBdB1PS9vYExohzhYKk6qI1kPLRkAvo0DUNeqtsc9pdYRuqOp8
 Sc/YVlhyuMt0pwIF87qmHKpZlY3PDJWn/E6xlQTpeROZ8rGs2hN6o40ir
 tKgU0RFe+4oNMdwM3oam/HEA4q7dyOdeArmrxjS6ljG0fROs5DY7FWECe A==;
X-CSE-ConnectionGUID: +CgzeKw4Tw6HapNpW54Qdg==
X-CSE-MsgGUID: 4Bj0G7y2Ttqb679og8uM0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663131"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663131"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:28 -0700
X-CSE-ConnectionGUID: ArMnoqKOS4++NlmhqijNew==
X-CSE-MsgGUID: +7SUpGrRTCGt2IqYWL3hVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951648"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:26 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 15/21] eal: automatically init arg list options
Date: Thu,  9 Oct 2025 14:00:50 +0100
Message-ID: <20251009130056.2630343-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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
index a29c84c675..8e17230c37 100644
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
@@ -217,15 +220,6 @@ eal_collate_args(int argc, char **argv)
 	if (argc < 1 || argv == NULL || argv[0] == NULL)
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

