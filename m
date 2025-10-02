Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BACCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE4BE410DF;
	Thu,  2 Oct 2025 19:43:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8C4D040E68
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427019; x=1790963019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jAqPy5Z15zmIF44aKymAkhE7YpNLpsfb2p04OidFkxg=;
 b=Uk4fzJtwdg6inqwRw2ldN5fRzEeM5E8RqVdiGxOajaNoUmoPohWATqQ1
 Wtp27SN28cuj5OkwUFA+/QLnfjy1j6JfqEoYU39JjMAqWGt6Iyf/QMEhM
 7QIEzcZ7CGwTSC+I+URh9E/oZpAyYsaQJoe4ut7AFTX6USwmgLJR2AZhf
 BeqGp56/HcZ8fIe2jJlIlC83oTuOBoqpM8a4Ciz34H4gAFD7FQGRZxbT0
 HYpxoxa8YSRd92zawbhgB59BAkg02xqUz4VBq41JKlFJDXtdh+NrIM8gP
 /GFSpCqr7Bxdjf1qIPUvM2KG35JBcHovN9RtEhda/uTdO22LFuGuVTkL5 w==;
X-CSE-ConnectionGUID: 6z36kZOnQQerWwnIYhh8qQ==
X-CSE-MsgGUID: nh97Wf+ATR60GmO68GluPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271872"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271872"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:38 -0700
X-CSE-ConnectionGUID: i/6UYVKdQGiBaS7BXnhq1w==
X-CSE-MsgGUID: 8DaCndusRG22nwpqP+cZ7w==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 12/18] eal: automatically init arg list options
Date: Thu,  2 Oct 2025 18:43:09 +0100
Message-ID: <20251002174315.962992-13-bruce.richardson@intel.com>
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

