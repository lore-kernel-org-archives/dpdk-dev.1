Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0117BC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 11:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24FA9410D0;
	Thu, 13 Mar 2025 12:38:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2B8E640EE3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 12:38:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741865917; x=1773401917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CBnqBY+nlADjOOgD49/bhrHcAZIF/IzihwuTKA3McOc=;
 b=Zr6xjpoKCtMvkuaSlfY1eM287SyfwMq+ZaAQ0VcdIKBZL6D7APLPMxlg
 pzbl7+bbD70qL1zWod6pf69XUrOHbfgZHLvInVGgl7MaFI+0HEWqrTbSg
 e7sPcKFvF7QoFTOalJ7IgYVTu0cnk0as1FKZ6EIEUHzo0jrnrJv+CikfV
 af+iAMI7vw1G6dSLggD4VBJgTobrZkpk0qIK/IiY33Vhf4Za95wTI3gdv
 c2n0ijTtL6d7DQhoHEyUAE8CfPIgP3G9pRi+3u68cHP4RrDffvTEizydm
 qcUbfYgn82saqjNQrCVX5oYjXq4hO4zgzZ6wdWMHuNv/Wnh7MFfGxdzra A==;
X-CSE-ConnectionGUID: ZISitIw0Tgyc5HvuChbTFQ==
X-CSE-MsgGUID: c0qaz/NzRya3TeCsNt++Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42145707"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="42145707"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 04:38:36 -0700
X-CSE-ConnectionGUID: 3L56h0UBSyOnVp5o55k7ZA==
X-CSE-MsgGUID: e8ShRF66QKOBXunuR1jkCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="120888946"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 04:38:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 1/3] eal: centralize core parameter parsing
Date: Thu, 13 Mar 2025 11:38:27 +0000
Message-ID: <20250313113829.1480907-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313113829.1480907-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
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

Rather than parsing the lcore parameters as they are encountered, just
save off the lcore parameters and then parse them at the end. This
allows better knowledge of what parameters are available or not when
parsing.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 183 +++++++++++++---------------
 1 file changed, 84 insertions(+), 99 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 79db9a47dd..55c49a923f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -151,7 +151,13 @@ TAILQ_HEAD_INITIALIZER(devopt_list);
 
 static int main_lcore_parsed;
 static int mem_parsed;
-static int core_parsed;
+static struct lcore_options {
+	const char *core_mask_opt;
+	const char *core_list_opt;
+	const char *core_map_opt;
+	const char *service_mask_opt;
+	const char *service_list_opt;
+} lcore_options = {0};
 
 /* Allow the application to print its usage message too if set */
 static rte_usage_hook_t rte_application_usage_hook;
@@ -674,7 +680,7 @@ eal_parse_service_coremask(const char *coremask)
 	if (count == 0)
 		return -1;
 
-	if (core_parsed && taken_lcore_count != count) {
+	if (taken_lcore_count != count) {
 		EAL_LOG(WARNING,
 			"Not all service cores are in the coremask. "
 			"Please ensure -c or -l includes service cores");
@@ -684,17 +690,6 @@ eal_parse_service_coremask(const char *coremask)
 	return 0;
 }
 
-static int
-eal_service_cores_parsed(void)
-{
-	int idx;
-	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		if (lcore_config[idx].core_role == ROLE_SERVICE)
-			return 1;
-	}
-	return 0;
-}
-
 static int
 update_lcore_config(int *cores)
 {
@@ -903,7 +898,7 @@ eal_parse_service_corelist(const char *corelist)
 	if (count == 0)
 		return -1;
 
-	if (core_parsed && taken_lcore_count != count) {
+	if (taken_lcore_count != count) {
 		EAL_LOG(WARNING,
 			"Not all service cores were in the coremask. "
 			"Please ensure -c or -l includes service cores");
@@ -1673,83 +1668,20 @@ eal_parse_common_option(int opt, const char *optarg,
 		a_used = 1;
 		break;
 	/* coremask */
-	case 'c': {
-		int lcore_indexes[RTE_MAX_LCORE];
-
-		if (eal_service_cores_parsed())
-			EAL_LOG(WARNING,
-				"Service cores parsed before dataplane cores. Please ensure -c is before -s or -S");
-		if (rte_eal_parse_coremask(optarg, lcore_indexes) < 0) {
-			EAL_LOG(ERR, "invalid coremask syntax");
-			return -1;
-		}
-		if (update_lcore_config(lcore_indexes) < 0) {
-			char *available = available_cores();
-
-			EAL_LOG(ERR,
-				"invalid coremask, please check specified cores are part of %s",
-				available);
-			free(available);
-			return -1;
-		}
-
-		if (core_parsed) {
-			EAL_LOG(ERR, "Option -c is ignored, because (%s) is set!",
-				(core_parsed == LCORE_OPT_LST) ? "-l" :
-				(core_parsed == LCORE_OPT_MAP) ? "--lcores" :
-				"-c");
-			return -1;
-		}
-
-		core_parsed = LCORE_OPT_MSK;
+	case 'c':
+		lcore_options.core_mask_opt = optarg;
 		break;
-	}
 	/* corelist */
-	case 'l': {
-		int lcore_indexes[RTE_MAX_LCORE];
-
-		if (eal_service_cores_parsed())
-			EAL_LOG(WARNING,
-				"Service cores parsed before dataplane cores. Please ensure -l is before -s or -S");
-
-		if (eal_parse_corelist(optarg, lcore_indexes) < 0) {
-			EAL_LOG(ERR, "invalid core list syntax");
-			return -1;
-		}
-		if (update_lcore_config(lcore_indexes) < 0) {
-			char *available = available_cores();
-
-			EAL_LOG(ERR,
-				"invalid core list, please check specified cores are part of %s",
-				available);
-			free(available);
-			return -1;
-		}
-
-		if (core_parsed) {
-			EAL_LOG(ERR, "Option -l is ignored, because (%s) is set!",
-				(core_parsed == LCORE_OPT_MSK) ? "-c" :
-				(core_parsed == LCORE_OPT_MAP) ? "--lcores" :
-				"-l");
-			return -1;
-		}
-
-		core_parsed = LCORE_OPT_LST;
+	case 'l':
+		lcore_options.core_list_opt = optarg;
 		break;
-	}
 	/* service coremask */
 	case 's':
-		if (eal_parse_service_coremask(optarg) < 0) {
-			EAL_LOG(ERR, "invalid service coremask");
-			return -1;
-		}
+		lcore_options.service_mask_opt = optarg;
 		break;
 	/* service corelist */
 	case 'S':
-		if (eal_parse_service_corelist(optarg) < 0) {
-			EAL_LOG(ERR, "invalid service core list");
-			return -1;
-		}
+		lcore_options.service_list_opt = optarg;
 		break;
 	/* size of memory */
 	case 'm':
@@ -1918,21 +1850,7 @@ eal_parse_common_option(int opt, const char *optarg,
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
 	case OPT_LCORES_NUM:
-		if (eal_parse_lcores(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameter for --"
-				OPT_LCORES);
-			return -1;
-		}
-
-		if (core_parsed) {
-			EAL_LOG(ERR, "Option --lcores is ignored, because (%s) is set!",
-				(core_parsed == LCORE_OPT_LST) ? "-l" :
-				(core_parsed == LCORE_OPT_MSK) ? "-c" :
-				"--lcores");
-			return -1;
-		}
-
-		core_parsed = LCORE_OPT_MAP;
+		lcore_options.core_map_opt = optarg;
 		break;
 	case OPT_LEGACY_MEM_NUM:
 		conf->legacy_mem = 1;
@@ -1973,6 +1891,7 @@ eal_parse_common_option(int opt, const char *optarg,
 
 	}
 
+
 	return 0;
 
 ba_conflict:
@@ -2046,8 +1965,74 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
-	if (!core_parsed)
+	/* handle all the various core options, ignoring order of them.
+	 * First check that multiple lcore options (coremask, corelist, coremap) are
+	 * not used together. Then check that the service options (coremask, corelist)
+	 * are not both set. In both cases error out if multiple options are set.
+	 */
+	if ((lcore_options.core_mask_opt && lcore_options.core_list_opt) ||
+			(lcore_options.core_mask_opt && lcore_options.core_map_opt) ||
+			(lcore_options.core_list_opt && lcore_options.core_map_opt)) {
+		EAL_LOG(ERR, "Only one of -c, -l and --"OPT_LCORES" may be given at a time");
+		return -1;
+	}
+	if ((lcore_options.service_mask_opt && lcore_options.service_list_opt)) {
+		EAL_LOG(ERR, "Only one of -s and -S may be given at a time");
+		return -1;
+	}
+
+	if (lcore_options.core_mask_opt) {
+		int lcore_indexes[RTE_MAX_LCORE];
+
+		if (rte_eal_parse_coremask(lcore_options.core_mask_opt, lcore_indexes) < 0) {
+			EAL_LOG(ERR, "invalid coremask syntax");
+			return -1;
+		}
+		if (update_lcore_config(lcore_indexes) < 0) {
+			char *available = available_cores();
+
+			EAL_LOG(ERR,
+				"invalid coremask, please check specified cores are part of %s",
+				available);
+			free(available);
+			return -1;
+		}
+	} else if (lcore_options.core_list_opt) {
+		int lcore_indexes[RTE_MAX_LCORE];
+
+		if (eal_parse_corelist(lcore_options.core_list_opt, lcore_indexes) < 0) {
+			EAL_LOG(ERR, "invalid core list syntax");
+			return -1;
+		}
+		if (update_lcore_config(lcore_indexes) < 0) {
+			char *available = available_cores();
+
+			EAL_LOG(ERR,
+				"invalid core list, please check specified cores are part of %s",
+				available);
+			free(available);
+			return -1;
+		}
+	} else if (lcore_options.core_map_opt) {
+		if (eal_parse_lcores(lcore_options.core_map_opt) < 0) {
+			EAL_LOG(ERR, "invalid parameter for --"	OPT_LCORES);
+			return -1;
+		}
+	} else {
 		eal_auto_detect_cores(cfg);
+	}
+
+	if (lcore_options.service_mask_opt) {
+		if (eal_parse_service_coremask(lcore_options.service_mask_opt) < 0) {
+			EAL_LOG(ERR, "invalid service coremask");
+			return -1;
+		}
+	} else if (lcore_options.service_list_opt) {
+		if (eal_parse_service_corelist(lcore_options.service_list_opt) < 0) {
+			EAL_LOG(ERR, "invalid service core list");
+			return -1;
+		}
+	}
 
 	if (internal_conf->process_type == RTE_PROC_AUTO)
 		internal_conf->process_type = eal_proc_type_detect();
-- 
2.43.0

