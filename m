Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97599606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ts77G07v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D913940DDD;
	Thu, 26 Nov 2026 19:15:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 8D8E440B9D
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716921; x=1827252921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EpIw0oLHUMnQKt+1OlDdUCbCJ21S05AF5+OaKIOczJw=;
 b=Ts77G07vG+ODuR3EoubQwhuwCRzfD6yI22TIxGu9ojrGNAzLcjWlSSIS
 hVoijyZu2eJMzB0YnmjTyLDnZ9McDgySyXpyjl1WzjELGZ7vTWpFFXmDV
 XURr35Ba845X+jwaenazDakZK2TegO+1UT4gIXUqaHOO/JIEjESR59Kcs
 o/siNBQ/jeEqq4JyWz9kNfLpG4p0g4/rTsI/AH/oZPAoIuURLPcQnqz6u
 QSRdo8VCV9+nV7RldUB89uMvx70YbysrVhneFyDPxfdCkmhpQZR9ENYF4
 N1LdUGFNkuIPO4rxYSB/Ih5rtf8P23zpMrwL90QIm0aEimTRNsus8oiT8 g==;
X-CSE-ConnectionGUID: CejzC/16RRGrCmhfHhdVkw==
X-CSE-MsgGUID: kAXXWIxHTg27f9COV0S53Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633617"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:20 -0800
X-CSE-ConnectionGUID: XN5ooYIUSx6Xhz1yWcKa0Q==
X-CSE-MsgGUID: n5kZ2QBiRJumhEFUOyFzOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733107"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 25/39] eal: separate runtime state update from arg parsing
Date: Thu, 26 Nov 2026 18:13:58 +0000
Message-ID: <20261126181414.124094-26-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
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

The eal_parse_args function was performing several updates to the
runtime state that do not logically belong in a parse_args function.
Move these to the "eal_adjust_config()" function, which is now renamed
to the more accurate "eal_apply_runtime_state()". Ensure too, that all
queries for the multi process mode use the runtime state rather than the
original user provided value, which needs resolution if it's AUTO.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 68 +++++++++++++----------------
 lib/eal/common/eal_options.h        |  2 +-
 lib/eal/freebsd/eal.c               |  7 +--
 lib/eal/linux/eal.c                 |  7 +--
 4 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b2aba99f12..ea49a44218 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2078,7 +2078,6 @@ int
 eal_parse_args(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
 	uint16_t lcore_id_base = 0;
@@ -2206,17 +2205,6 @@ eal_parse_args(void)
 	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
 		return -1;
 
-	if (user_cfg->main_lcore != -1) {
-		runtime_state->main_lcore = user_cfg->main_lcore;
-	} else {
-		/* default main lcore is the first one */
-		runtime_state->main_lcore = rte_get_next_lcore(-1, 0, 0);
-		if (runtime_state->main_lcore >= RTE_MAX_LCORE) {
-			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
-			return -1;
-		}
-	}
-
 	/* memory options */
 	if (args.memory_size != NULL) {
 		char *end = NULL;
@@ -2441,23 +2429,11 @@ eal_parse_args(void)
 		}
 	}
 
-#ifndef RTE_EXEC_ENV_WINDOWS
-	/* create runtime data directory. In no_shconf mode, skip any errors */
-	if (eal_create_runtime_dir() < 0) {
-		if (!user_cfg->no_shconf) {
-			EAL_LOG(ERR, "Cannot create runtime directory");
-			return -1;
-		}
-		EAL_LOG(WARNING, "No DPDK runtime directory created");
-	}
-#endif
-
-	if (eal_adjust_config() != 0) {
-		EAL_LOG(ERR, "Invalid configuration");
-		return -1;
-	}
+	/* sum per-NUMA memory requests into user_cfg->memory */
+	for (int i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		user_cfg->memory += user_cfg->numa_mem[i];
 
-	return 0;
+	return eal_apply_runtime_state();
 }
 
 static void
@@ -2505,20 +2481,38 @@ eal_cleanup_config(const struct eal_user_cfg *user_cfg)
 }
 
 int
-eal_adjust_config(void)
+eal_apply_runtime_state(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	int i;
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
-	if (user_cfg->process_type == RTE_PROC_AUTO)
-		user_cfg->process_type = eal_proc_type_detect();
+	/* set the main lcore */
+	if (user_cfg->main_lcore != -1) {
+		runtime_state->main_lcore = user_cfg->main_lcore;
+	} else {
+		/* default main lcore is the first one */
+		runtime_state->main_lcore = rte_get_next_lcore(-1, 0, 0);
+		if (runtime_state->main_lcore >= RTE_MAX_LCORE) {
+			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
+			return -1;
+		}
+	}
 
-	compute_ctrl_threads_cpuset();
+#ifndef RTE_EXEC_ENV_WINDOWS
+	/* create runtime data directory. In no_shconf mode, skip any errors */
+	if (eal_create_runtime_dir() < 0) {
+		if (!user_cfg->no_shconf) {
+			EAL_LOG(ERR, "Cannot create runtime directory");
+			return -1;
+		}
+		EAL_LOG(WARNING, "No DPDK runtime directory created");
+	}
+#endif
 
-	/* if no memory amounts were requested, this will result in 0 and
-	 * will be overridden later, right after eal_hugepage_info_init() */
-	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		user_cfg->memory += user_cfg->numa_mem[i];
+	runtime_state->process_type = (user_cfg->process_type == RTE_PROC_AUTO) ?
+			eal_proc_type_detect() : user_cfg->process_type;
+
+	compute_ctrl_threads_cpuset();
 
 	return 0;
 }
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 58fb3085e5..eee7339e90 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -14,7 +14,7 @@ int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
 int eal_apply_hugepage_mem_sz_limits(void);
-int eal_adjust_config(void);
+int eal_apply_runtime_state(void);
 int eal_cleanup_config(const struct eal_user_cfg *user_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 18333071de..acb650031b 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -284,9 +284,6 @@ static int
 eal_mem_config_init(void)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-
-	runtime_state->process_type = user_cfg->process_type;
 
 	switch (runtime_state->process_type) {
 	case RTE_PROC_PRIMARY:
@@ -564,7 +561,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* shared mem config not yet attached */
-		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
+		ret = rte_eal_process_type() == RTE_PROC_PRIMARY ?
 			eal_hugepage_info_init() :
 			eal_hugepage_info_read();
 		if (ret < 0) {
@@ -572,7 +569,7 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
-		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
 				eal_apply_hugepage_mem_sz_limits() < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 7f8010b61d..32b7206f63 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -366,9 +366,6 @@ static int
 eal_mem_config_init(void)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-
-	runtime_state->process_type = user_cfg->process_type;
 
 	switch (runtime_state->process_type) {
 	case RTE_PROC_PRIMARY:
@@ -736,7 +733,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* shared mem config not yet attached */
-		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
+		ret = rte_eal_process_type() == RTE_PROC_PRIMARY ?
 				eal_hugepage_info_init() :
 				eal_hugepage_info_read();
 		if (ret < 0) {
@@ -744,7 +741,7 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
-		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
 				eal_apply_hugepage_mem_sz_limits() < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
-- 
2.55.0

