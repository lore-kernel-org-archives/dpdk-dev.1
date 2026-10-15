Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D13CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 471A14027C;
	Thu, 15 Oct 2026 16:21:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C2B27400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074070; x=1823610070;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vxCLkHWmL4SL7l/Vw14KgiTtFK35eDJFobIk0+EUkxA=;
 b=Lt7zTu1e43vf5QObn8Kn6ghNBu+8GwWs/xG0pbg6yekqZrb3aGbpX4pt
 E2PxMDytX2WnTW8O9PvjcsGqPLb/lDQbGYC88uCYTTQqktVK/wsIVwboE
 t7PY9nY1XWdnW4DYukDYaCqjxqClGFsB2ePKC3+EsyeA1cn0cV9fP1Huj
 8NbWuz/f++nQ59O1LBI85iJ9oyy/Oml+crhgt3xhYPprGthkuS6SCq2oh
 gWu6m25GQdR9YyK0KFjOhzhbDKcj507gF8ITTNZPuLs+SNZmACLhKJoiS
 eHxN7NL/Y+XVVuAgyK97S8QN9ANbnCxVFDXnB7is3M2r6o/AquNPLntdn Q==;
X-CSE-ConnectionGUID: diLx037ZTZOMwoaG1inNMw==
X-CSE-MsgGUID: IlMNCe/NQ+ita7sfnh09/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="845358"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="845358"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:21:09 -0700
X-CSE-ConnectionGUID: 5Oq4F15TSzu4VbnaB88Ybg==
X-CSE-MsgGUID: SCrIn2N3TfefYPrVVde96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1779218"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 07:21:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 1/3] net/ixgbe: avoid private driver include in testpmd
Date: Thu, 15 Oct 2026 15:21:02 +0100
Message-ID: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261014203435.583064-1-thomas@monjalon.net>
References: <20261014203435.583064-1-thomas@monjalon.net>
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

From: Thomas Monjalon <thomas@monjalon.net>

Testpmd commands should use the driver's public API
rather than access its private structures directly.
Note: ixgbe_testpmd.c should be considered as part of testpmd.

ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
operations are available through the private adapter structure.

Rely on the public bypass API to check availability
and handle -ENOTSUP in the commands.
Remove ixgbe_ethdev.h, ethdev_driver.h
and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_testpmd.c | 55 ++++++++++---------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_testpmd.c b/drivers/net/intel/ixgbe/ixgbe_testpmd.c
index e0d161eafe..e209093477 100644
--- a/drivers/net/intel/ixgbe/ixgbe_testpmd.c
+++ b/drivers/net/intel/ixgbe/ixgbe_testpmd.c
@@ -2,11 +2,12 @@
  * Copyright(c) 2010-2016 Intel Corporation.
  */
 
-/* Required for ixgbe internal structures to be aligned with the driver */
-#define RTE_LIBRTE_IXGBE_BYPASS
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 
-#include <ethdev_driver.h>
-#include "ixgbe_ethdev.h"
+#include <rte_string_fns.h>
 #include "rte_pmd_ixgbe.h"
 
 #include <cmdline_parse_etheraddr.h>
@@ -621,20 +622,6 @@ static cmdline_parse_inst_t cmd_tc_min_bw = {
 /* The NIC bypass watchdog timeout. */
 uint32_t bypass_timeout = RTE_PMD_IXGBE_BYPASS_TMT_OFF;
 
-static inline bool
-check_bypass_enabled(portid_t port_id)
-{
-	struct ixgbe_adapter *adapter;
-
-	adapter = rte_eth_devices[port_id].data->dev_private;
-	if (adapter->bps.ops.bypass_rw == NULL) {
-		fprintf(stderr, "Bypass is not enabled on this port.\n");
-		return false;
-	}
-
-	return true;
-}
-
 /* Enable bypass mode */
 struct cmd_config_bypass_result {
 	cmdline_fixed_string_t port;
@@ -704,9 +691,6 @@ cmd_set_bypass_mode_parsed(void *parsed_result,
 	portid_t port_id = res->port_id;
 	int32_t rc = -EINVAL;
 
-	if (!check_bypass_enabled(port_id))
-		return;
-
 	if (!strcmp(res->value, "bypass"))
 		bypass_mode = RTE_PMD_IXGBE_BYPASS_MODE_BYPASS;
 	else if (!strcmp(res->value, "isolate"))
@@ -716,7 +700,9 @@ cmd_set_bypass_mode_parsed(void *parsed_result,
 
 	/* Set the bypass mode for the relevant port. */
 	rc = rte_pmd_ixgbe_bypass_state_set(port_id, &bypass_mode);
-	if (rc != 0)
+	if (rc == -ENOTSUP)
+		fprintf(stderr, "Bypass is not enabled on this port.\n");
+	else if (rc != 0)
 		fprintf(stderr, "\t Failed to set bypass mode for port = %d.\n",
 			port_id);
 }
@@ -773,9 +759,6 @@ cmd_set_bypass_event_parsed(void *parsed_result,
 	uint32_t bypass_event = RTE_PMD_IXGBE_BYPASS_EVENT_NONE;
 	uint32_t bypass_mode = RTE_PMD_IXGBE_BYPASS_MODE_NORMAL;
 
-	if (!check_bypass_enabled(port_id))
-		return;
-
 	if (!strcmp(res->event_value, "timeout"))
 		bypass_event = RTE_PMD_IXGBE_BYPASS_EVENT_TIMEOUT;
 	else if (!strcmp(res->event_value, "os_on"))
@@ -803,6 +786,10 @@ cmd_set_bypass_event_parsed(void *parsed_result,
 			rc = rte_pmd_ixgbe_bypass_wd_timeout_store(port_id,
 				bypass_timeout);
 		}
+		if (rc == -ENOTSUP) {
+			fprintf(stderr, "Bypass is not enabled on this port.\n");
+			return;
+		}
 		if (rc != 0) {
 			fprintf(stderr,
 				"Failed to set timeout value %u for port %d, errto code: %d.\n",
@@ -813,7 +800,9 @@ cmd_set_bypass_event_parsed(void *parsed_result,
 	/* Set the bypass event to transition to bypass mode. */
 	rc = rte_pmd_ixgbe_bypass_event_store(port_id, bypass_event,
 		bypass_mode);
-	if (rc != 0)
+	if (rc == -ENOTSUP)
+		fprintf(stderr, "Bypass is not enabled on this port.\n");
+	else if (rc != 0)
 		fprintf(stderr, "\t Failed to set bypass event for port = %d.\n",
 			port_id);
 }
@@ -952,11 +941,13 @@ cmd_show_bypass_config_parsed(void *parsed_result,
 		"power supply off",
 		"timeout"};
 
-	if (!check_bypass_enabled(port_id))
-		return;
-
 	/* Display the bypass mode.*/
-	if (rte_pmd_ixgbe_bypass_state_show(port_id, &bypass_mode) != 0) {
+	rc = rte_pmd_ixgbe_bypass_state_show(port_id, &bypass_mode);
+	if (rc == -ENOTSUP) {
+		fprintf(stderr, "Bypass is not enabled on this port.\n");
+		return;
+	}
+	if (rc != 0) {
 		fprintf(stderr, "\tFailed to get bypass mode for port = %d\n",
 			port_id);
 		return;
@@ -985,10 +976,6 @@ cmd_show_bypass_config_parsed(void *parsed_result,
 				modes[event_mode]);
 		}
 	}
-	if (rc != 0)
-		fprintf(stderr,
-			"\tFailed to get bypass configuration for port = %d\n",
-			port_id);
 }
 
 static cmdline_parse_token_string_t cmd_showbypass_config_show =
-- 
2.52.0

