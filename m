Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E07C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:33:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 633C040611;
	Tue, 18 Aug 2026 15:33:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3C58F40269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060025; x=1818596025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=We+jyKeG16LrxfzkHkZ2U6RIu7Mbo6mha4a1Km5ERiQ=;
 b=JGjejoDoBqzXdiHsjTmfjHDlz3OL0juC2tT10JseMCMYZx7NCgwNW10I
 11wm32z/6agBl2JcA/faaVOe1RmoPViqlIxQLM6QFb5LS0qONzydS+CFL
 TIgtKEdQTV7VxSFw7vNVuExved/69Uu6IGwZ7/Vls02KTby2dRmpkBkb/
 7YvddBVgTQY2Xiq46BR0G/iMlYphGs+G9wTJfUT4CX23jFKXY605rpshY
 NbWNLBGjq/N9DFNP6IE7HMEwHGKroOvi8tzSZYprgM5AJbnjzVV9jnLV1
 hQ5DQmKDWG0mWVVp9kYapCtZs1HxbxgAwCElIeuahuLcjSy0fvtxJyTWj Q==;
X-CSE-ConnectionGUID: zp8dSAy3TQqSR+RcEb+HHw==
X-CSE-MsgGUID: o4IJF6+oRBisAds+j5iOwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757580"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757580"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:44 -0700
X-CSE-ConnectionGUID: /4vwcobnTNqli53oxMmfLA==
X-CSE-MsgGUID: wC+DuIgHQGaNNmq8WZ0ilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736522"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 01/39] telemetry: make cpuset init parameter const
Date: Tue, 18 Aug 2026 14:32:54 +0100
Message-ID: <20260818133334.2620165-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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

The cpuset parameter to telemetry_init is not modified so can be marked
as const. This can allow callers to pass the parameter from a const
structure rather than a modifiable one.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/telemetry/telemetry.c          | 4 ++--
 lib/telemetry/telemetry_internal.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index e591c1e283..956a261c13 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -56,7 +56,7 @@ static struct socket v1_socket; /* socket for v1 telemetry */
 
 static const char *telemetry_version; /* save rte_version */
 static const char *socket_dir;        /* runtime directory */
-static rte_cpuset_t *thread_cpuset;
+static const rte_cpuset_t *thread_cpuset;
 
 RTE_LOG_REGISTER_DEFAULT(logtype, WARNING);
 #define RTE_LOGTYPE_TELEMETRY logtype
@@ -658,7 +658,7 @@ telemetry_v2_init(void)
 
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
2.53.0

