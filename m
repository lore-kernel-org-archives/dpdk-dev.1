Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9920FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DF8940A81;
	Wed, 29 Apr 2026 18:59:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 719E84066A;
 Wed, 29 Apr 2026 18:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481946; x=1809017946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f/IplTxeAkGrowp4Rwfedd7Pl49dEBK4a5fo5HrXJGU=;
 b=BIEl7IqvIuXrufPF/F8IHFG1WM/svIU9Sea4vGPhv+O5h3FpQr+Ut86Q
 4h0frkqnXqf7BDMRDUryxk2cft430CUS2ZpjI76ZRDK2l7qaZmpEdEcW9
 00lcfW5uORgkqKQRhdUa7rfhLbLVY6TWlKjcgFwNiP7g12DHJKjrPrMl/
 TgGJnDrGiTQgFcFU1zDZ5eSj71+1UpHLgVerezoYsg6RSe2x/tStdTwhw
 2tv5GDOkjEw5m3LFgOgjtS+2XQF4oc2DO0bD0gzPeyb+X+R7kkIZzDM6/
 Gtmb/WfMhHb1t3CAsiQaVa4Nnh4VrK8F/iQGjdnANJ5vTUmcivSXoAQWR A==;
X-CSE-ConnectionGUID: ZSrelribRXSea7XRNybcsA==
X-CSE-MsgGUID: Bn3c1lD5RAuBvygzunwb8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725302"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725302"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:06 -0700
X-CSE-ConnectionGUID: 2oDryB8STZasFboDmlaJhw==
X-CSE-MsgGUID: pI//ZJ4nQcOTJQ7rhYVXTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696945"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 08/44] telemetry: make cpuset init parameter const
Date: Wed, 29 Apr 2026 17:58:00 +0100
Message-ID: <20260429165845.2136843-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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
index b109d076d4..70c00d5940 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -56,7 +56,7 @@ static struct socket v1_socket; /* socket for v1 telemetry */

 static const char *telemetry_version; /* save rte_version */
 static const char *socket_dir;        /* runtime directory */
-static rte_cpuset_t *thread_cpuset;
+static const rte_cpuset_t *thread_cpuset;

 RTE_LOG_REGISTER_DEFAULT(logtype, WARNING);
 #define RTE_LOGTYPE_TELEMETRY logtype
@@ -657,7 +657,7 @@ telemetry_v2_init(void)

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
2.51.0

