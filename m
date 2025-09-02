Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E2CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:28:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AA0E40A6C;
	Tue,  2 Sep 2025 19:27:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id CB08140674
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834048; x=1788370048;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7RLmRhG4ok0M6mYJZ2Kb+6yIpAhbmKFuZaLwJmR1n2M=;
 b=h+vgMIdMqJIOKV6TOLqdppfhe0lbg3wR80gX/6aGxUDoIKp7NVPV2fT9
 0KVt3n1K5F8w9VWntzl+RTLghVEBn19aFq8o7umY/gDqRlIFgIejl2Nd5
 ur4PL+/8vN9ZQecsegCs7qfOHyk49tQ2sIF0nuPp4wFeXNOZVNKWDNEqK
 1m4bDKiRs+TZSk56jxEtiM03XYLfSmIfwApdB8VLRrd1h1OLk8XaQiQX5
 YDVfuY5uMU/32ued/52NoTj5auN80SL9CAhumHlRyw2Or5ATM6IQb8zS/
 d04DfgJ3bsDWZsJMPOEezIX3s2yuK4nkI4Uuni2r60YScnJxabOMeD7Ck Q==;
X-CSE-ConnectionGUID: kb9VicayRQmbaDEhLRrF5g==
X-CSE-MsgGUID: L36W1RFRSyqVjtIhJlVktw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69732019"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69732019"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:26 -0700
X-CSE-ConnectionGUID: B21TmwI2RC+UYVArp//eDw==
X-CSE-MsgGUID: 73mwCZWUTZyv4JJgVHSocA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229134"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:26 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 09/12] net/ice/base: improve global config lock behavior
Date: Tue,  2 Sep 2025 18:26:59 +0100
Message-ID: <890cfe97d9f716a7a65c028578bd1fc90ff04c4b.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
References: 
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

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_cfg_tx_topo function attempts to apply Tx scheduler topology
configuration based on NVM parameters, selecting either a 5 or 9 layer
topology.

As part of this flow, the driver acquires the "Global Configuration
Lock", which is a hardware resource associated with programming the DDP
package to the device. This "lock" is implemented by firmware as a way to
guarantee that only one PF can program the DDP for a device. Unlike a
traditional lock, once a PF has acquired this lock, no other PF will be
able to acquire it again (including that PF) until a core reset of the
device. Future requests to acquire the lock report that global
configuration has already completed.

The following flow is used to program the Tx topology:

 * Read the DDP package for scheduler configuration data
 * Acquire the global configuration lock
 * Program Tx scheduler topology according to DDP package data
 * Trigger a core reset which clears the global configuration lock

This is followed by the flow for programming the DDP package:

 * Acquire the global configuration lock (again)
 * Download the DDP package to the device
 * Release the global configuration lock.

However, if configuration of the Tx topology fails, (i.e.
ice_get_set_tx_topo() returns an error code), the driver exits
ice_cfg_tx_topo() immediately, and fails to trigger core reset.

While the global configuration lock is held, the firmware rejects most
AdminQ commands, as it is waiting for the DDP package download (or Tx
scheduler topology programming) to occur.

The current driver flows assume that the global configuration lock has
been reset after programming the Tx topology. Thus, the same PF attempts
to acquire the global lock again, and fails. This results in the driver
reporting "an unknown error occurred when loading the DDP package". It
then attempts to enter safe mode, but ultimately fails to finish
ice_probe() since nearly all AdminQ command report error codes, and the
driver stops loading the device at some point during its initialization.

We cannot simply release the global lock after a failed call to
ice_get_set_tx_topo(). Releasing the lock indicates to firmware that
global configuration (downloading of the DDP) has completed. Future
attempts by this or other PFs to load the DDP will fail with a report
that the DDP package has already been downloaded. Then, PFs will enter
safe mode as they realize that the package on the device does not meet
the minimum version requirement to load. The reported error messages are
confusing, as they indicate the version of the default "safe mode"
package in the NVM, rather than the version of the DDP package loaded
from the filesystem.

Instead, we need to trigger core reset to clear global configuration.
This is the lowest level of hardware reset which clears the global
configuration lock and related state. It also clears any already
downloaded DDP. Crucially, it does *not* clear the Tx scheduler topology
configuration.

Refactor ice_cfg_tx_topo() to always trigger a core reset after acquiring
the global lock, regardless of success or failure of the topology
configuration.

We need to re-initialize the HW structure when we trigger the core reset.
Previously, this was the responsibility of the core driver to cleanup
after the core reset. Instead, make it the responsibility of this
function. This avoids needless re-initialization for the cases where no
reset occurred.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_ddp.c | 34 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_ddp.c b/drivers/net/intel/ice/base/ice_ddp.c
index 850c722a3f..68e75be4d2 100644
--- a/drivers/net/intel/ice/base/ice_ddp.c
+++ b/drivers/net/intel/ice/base/ice_ddp.c
@@ -2370,7 +2370,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 	struct ice_buf_hdr *section;
 	struct ice_pkg_hdr *pkg_hdr;
 	enum ice_ddp_state state;
-	u16 i, size = 0, offset;
+	u16 size = 0, offset;
 	u32 reg = 0;
 	int status;
 	u8 flags;
@@ -2457,25 +2457,35 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 	/* check reset was triggered already or not */
 	reg = rd32(hw, GLGEN_RSTAT);
 	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
-		/* Reset is in progress, re-init the hw again */
 		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. layer topology might be applied already\n");
 		ice_check_reset(hw);
-		return 0;
+		/* Reset is in progress, re-init the hw again */
+		goto reinit_hw;
 	}
 
 	/* set new topology */
 	status = ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true);
 	if (status) {
-		ice_debug(hw, ICE_DBG_INIT, "Set tx topology is failed\n");
-		return status;
+		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology, status %d\n",
+			  status);
+		status = ICE_ERR_CFG;
 	}
 
-	/* new topology is updated, delay 1 second before issuing the CORRER */
-	for (i = 0; i < 10; i++)
-		ice_msec_delay(100, true);
+	/* Even if Tx topology config failed, we need to CORE reset here to
+	 * clear the global configuration lock. Delay 1 second to allow
+	 * hardware to settle then issue a CORER
+	 */
+	ice_msec_delay(1000, true);
 	ice_reset(hw, ICE_RESET_CORER);
-	/* CORER will clear the global lock, so no explicit call
-	 * required for release
-	 */
-	return 0;
+	ice_check_reset(hw);
+
+reinit_hw:
+	/* Since we triggered a CORER, re-initialize hardware */
+	ice_deinit_hw(hw);
+	if (ice_init_hw(hw)) {
+		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after setting Tx topology\n");
+		return ICE_ERR_RESET_FAILED;
+	}
+
+	return status;
 }
-- 
2.47.3

