Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9F606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MEqPY656
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB1540616;
	Thu, 26 Nov 2026 19:14:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 3D0C1402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716864; x=1827252864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ppQcGHU2aP6T2leHzA2TU+ERBDS7msmyS31wrzc5QQg=;
 b=MEqPY656QNsX0DNptcSnHD29GElO/2Dtj/fgS4ek/mssH0R9KFrDi9To
 lc8cbQHjO9jaX4dZh4bAw/RT7p30sdKKs3fyHest3U37hquvrG9/fUs3Y
 rKXrVXtfX+dv0qfIuVtvFTSUtMMjbG1WYcV8DvX5tuJDBWwe0qjtQSUSW
 LFLm36ww6/D/kRP6b9/eo9UkylKwHRfA5vSFyHGNPmyNEh5UbRr8kDm0X
 v/lrsllqcG/de+APJzm0IJZ5g8skIdiF2Q34fktPoZR1n5X2E2FjrCe86
 4Twv8vnvx4zm37NVUeOtXOlhXCCW5cqVQoRADtcPs4u2y22boVT/Qi9hh w==;
X-CSE-ConnectionGUID: wpqzdCrsTfiMthYSKok20Q==
X-CSE-MsgGUID: tI+TIn87SVCx/ZczNaP74A==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633539"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:19 -0800
X-CSE-ConnectionGUID: 9GfuqM/QQZeg7liMXzVV+w==
X-CSE-MsgGUID: R2a6tqbGRHyHfQUeil9vqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732839"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 01/39] telemetry: make cpuset init parameter const
Date: Thu, 26 Nov 2026 18:13:34 +0000
Message-ID: <20261126181414.124094-2-bruce.richardson@intel.com>
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

The cpuset parameter to telemetry_init is not modified so can be marked
as const. This can allow callers to pass the parameter from a const
structure rather than a modifiable one.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/telemetry/telemetry.c          | 4 ++--
 lib/telemetry/telemetry_internal.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index f5218df4b8..9b7e78dffd 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -54,7 +54,7 @@ static struct socket v1_socket; /* socket for v1 telemetry */
 
 static const char *telemetry_version; /* save rte_version */
 static const char *socket_dir;        /* runtime directory */
-static rte_cpuset_t *thread_cpuset;
+static const rte_cpuset_t *thread_cpuset;
 
 RTE_LOG_REGISTER_DEFAULT(logtype, WARNING);
 #define RTE_LOGTYPE_TELEMETRY logtype
@@ -656,7 +656,7 @@ telemetry_v2_init(void)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_telemetry_init)
 int32_t
-rte_telemetry_init(const char *runtime_dir, const char *rte_version, rte_cpuset_t *cpuset)
+rte_telemetry_init(const char *runtime_dir, const char *rte_version, const rte_cpuset_t *cpuset)
 {
 	telemetry_version = rte_version;
 	socket_dir = runtime_dir;
diff --git a/lib/telemetry/telemetry_internal.h b/lib/telemetry/telemetry_internal.h
index 2fd9fbd7c1..4a6b2e9838 100644
--- a/lib/telemetry/telemetry_internal.h
+++ b/lib/telemetry/telemetry_internal.h
@@ -119,6 +119,6 @@ typedef int (*rte_log_fn)(uint32_t level, uint32_t logtype, const char *format,
  */
 __rte_internal
 int
-rte_telemetry_init(const char *runtime_dir, const char *rte_version, rte_cpuset_t *cpuset);
+rte_telemetry_init(const char *runtime_dir, const char *rte_version, const rte_cpuset_t *cpuset);
 
 #endif
-- 
2.55.0

