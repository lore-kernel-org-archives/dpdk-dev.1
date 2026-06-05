Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8067BCD6E77
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 12:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A3BA402BA;
	Fri,  5 Jun 2026 14:32:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B3F7E4026A;
 Fri,  5 Jun 2026 14:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780662760; x=1812198760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r0Ey567nSaSoCHXv3+8UfYKA/8p6F4Hyu/RZsqeS9eo=;
 b=cZXxsSV46pRyWIxIzDW879QKqU5qyMvCmHtMb1UXuIsum965I/aGERg3
 s1uieCBRG4OhD5elHPItB2+edyH4xtUPLyonVqXPeNQO7oIvO3HEOmbvG
 yoorvefOc3EpUBaGROgAryv9Z7Xz5Hl5cdr9aD0Zn5bV0la0uC09B0Lri
 5tgYHDxHpsBcJBGsXOnZHufJ+Eu9GCeqGGjvS5TolipMV7+jMTWWP0TzD
 SNuPa7YLg6DZR2YaWTuAr7En18Ro7IMwI1/9DnK+AYCTswoXIBEi4KAs2
 jQJ+/4XELykWMZmsP1l4Dsb0pgOJ9h+ygGowrM+Lg1V9+KnsJwDyUUg2v w==;
X-CSE-ConnectionGUID: kwMxys2kTEiaGZ/5WIKDEA==
X-CSE-MsgGUID: yFwXfndyQluBkTWD6pMMBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81556387"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81556387"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 05:32:38 -0700
X-CSE-ConnectionGUID: MXgqQOcoQtK7cnCedpcyxA==
X-CSE-MsgGUID: vBybRiUtSZS+glFnbQO29g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="268762798"
Received: from icx009.iind.intel.com ([10.190.212.240])
 by fmviesa001.fm.intel.com with ESMTP; 05 Jun 2026 05:32:25 -0700
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 ciara.loftus@intel.com
Cc: shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, stable@dpdk.org
Subject: [PATCH v3] net/iavf: fix VF reset race and stale ARQ message handling
Date: Fri,  5 Jun 2026 12:36:46 +0000
Message-ID: <20260605123646.1328492-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518054227.110701-1-chaitanyababux.talluri@intel.com>
References: <20260518054227.110701-1-chaitanyababux.talluri@intel.com>
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

During VF reset, multiple issues can lead to initialization
instability.

The first issue is a race condition in the VF-initiated reset path,
where VFR state VFACTIVE is treated as both "reset not started" and
"reset completed" in iavf_check_vf_reset_done(). When a VF initiates
a reset, the PF may not have begun processing it by the time
iavf_check_vf_reset_done() is called. Since VFACTIVE satisfies the
completion check, the VF proceeds before the PF has acknowledged the
reset, resulting in inconsistent initialization and virtchnl command
failures (e.g., OP_VERSION timeout).

The second issue is the presence of stale messages in the Admin
Receive Queue (ARQ) after VF reset. After the admin queue is
re-initialized during reset recovery, the PF may post responses to
pre-reset commands or unsolicited events. These may include opcode 0
(VIRTCHNL_OP_UNKNOWN) or responses to commands issued before reset,
which can interfere with API negotiation and cause command mismatch
errors.

Additionally, opcode 0 messages generate excessive warning logs,
causing unnecessary noise during initialization.

The solution involves:

1. Introducing a wait-for-reset-start helper that polls RSTAT until
   it leaves VFACTIVE. This helper is used in VF-initiated reset paths
   to ensure that the PF has started processing the reset before VF
   reinitialization proceeds. It is invoked from iavf_handle_hw_reset()
   for event-driven resets and from iavf_queues_req_reset() for
   queue-change-triggered resets. It is intentionally not used in
   iavf_dev_reset() to avoid redundant wait and unnecessary delay
   when reset completion is already confirmed.

2. Draining stale ARQ messages after admin queue initialization
   during reset recovery only (vf->in_reset_recovery == true).
   During initial device probe, the admin queue is freshly allocated
   and does not contain stale entries.

3. Downgrading opcode 0 (VIRTCHNL_OP_UNKNOWN) message logging to
   DEBUG level while preserving mismatch detection for other
   opcodes, allowing polling to continue until a valid response
   is received.

4. Refactoring reset-start detection and ARQ drain logic into helper
   functions (iavf_wait_for_reset_start() and iavf_drain_arq()) to
   improve readability and maintainability.

5. Introducing a short delay after triggering VF reset in
   iavf_dev_reset() to mitigate timing issues between VF
   reinitialization and PF reset processing. This helps avoid
   virtchnl command failures when PF reset completion is not yet
   fully synchronized.

This fix primarily targets VF-initiated reset handling, while ARQ
drain and opcode handling improvements also benefit PF-initiated
reset recovery scenarios.

Fixes: 1428895ad417 ("net/iavf: fix disabling of promiscuous modes on close")
Cc: stable@dpdk.org

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---

v3:
- Rebased the patch.
- Changed the Fixes tag.

v2:
- Removed iavf_wait_for_reset_start() from iavf_dev_reset() to avoid
  redundant wait and 1-second delay after reset completion.
- Added iavf_wait_for_reset_start() to iavf_queues_req_reset() to
  properly handle queue-change-triggered resets.
- Retained usage in iavf_handle_hw_reset() for VF-initiated reset flow.
- Restricted iavf_drain_arq() to reset recovery paths only.
- Added delay in iavf_dev_reset() to mitigate reset timing issues.
---
 drivers/net/intel/iavf/iavf_ethdev.c | 64 ++++++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  | 16 +++++--
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8031e23a5..e87f3acf5f 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -106,6 +106,7 @@ static int iavf_dev_start(struct rte_eth_dev *dev);
 static int iavf_dev_stop(struct rte_eth_dev *dev);
 static int iavf_dev_close(struct rte_eth_dev *dev);
 static int iavf_dev_reset(struct rte_eth_dev *dev);
+static int iavf_wait_for_reset_start(struct iavf_hw *hw);
 static int iavf_dev_info_get(struct rte_eth_dev *dev,
 			     struct rte_eth_dev_info *dev_info);
 static const uint32_t *iavf_dev_supported_ptypes_get(struct rte_eth_dev *dev,
@@ -605,6 +606,7 @@ iavf_queues_req_reset(struct rte_eth_dev *dev, uint16_t num)
 	struct iavf_adapter *ad =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf =  IAVF_DEV_PRIVATE_TO_VF(ad);
+	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(ad);
 	int ret;
 
 	ret = iavf_request_queues(dev, num);
@@ -616,6 +618,8 @@ iavf_queues_req_reset(struct rte_eth_dev *dev, uint16_t num)
 			vf->vsi_res->num_queue_pairs, num);
 
 	iavf_dev_watchdog_disable(ad);
+	/* Wait for PF to start processing reset triggered by queue change */
+	iavf_wait_for_reset_start(hw);
 	ret = iavf_dev_reset(dev);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "vf reset failed");
@@ -2086,6 +2090,30 @@ iavf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	return 0;
 }
 
+/* Wait until PF acknowledges VF reset (RSTAT leaves VFACTIVE) */
+static int
+iavf_wait_for_reset_start(struct iavf_hw *hw)
+{
+	int i;
+	uint32_t rstat;
+
+	for (i = 0; i < 100; i++) {
+		rte_delay_ms(10);
+
+		rstat = IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT);
+		rstat &= IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
+		rstat >>= IAVF_VFGEN_RSTAT_VFR_STATE_SHIFT;
+
+		if (rstat != VIRTCHNL_VFR_VFACTIVE)
+			return 0;
+	}
+
+	PMD_DRV_LOG(DEBUG, "VF reset did not start within timeout");
+	return -1;
+}
+
+static void iavf_drain_arq(struct iavf_hw *hw, struct iavf_info *vf);
+
 static int
 iavf_check_vf_reset_done(struct iavf_hw *hw)
 {
@@ -2618,6 +2646,30 @@ iavf_init_proto_xtr(struct rte_eth_dev *dev)
 	}
 }
 
+/* Drain stale Admin Receive Queue messages after reset */
+static void
+iavf_drain_arq(struct iavf_hw *hw, struct iavf_info *vf)
+{
+	struct iavf_arq_event_info event;
+	int drain_count = 0;
+
+	memset(&event, 0, sizeof(event));
+	event.msg_buf = vf->aq_resp;
+
+	while (drain_count < IAVF_AQ_LEN) {
+		event.buf_len = IAVF_AQ_BUF_SZ;
+
+		if (iavf_clean_arq_element(hw, &event, NULL) != IAVF_SUCCESS)
+			break;
+
+		drain_count++;
+	}
+
+	if (drain_count > 0)
+		PMD_INIT_LOG(DEBUG, "Drained %d stale ARQ messages",
+				drain_count);
+}
+
 static int
 iavf_init_vf(struct rte_eth_dev *dev)
 {
@@ -2654,6 +2706,10 @@ iavf_init_vf(struct rte_eth_dev *dev)
 		goto err;
 	}
 
+	/* Drain stale ARQ messages only during reset recovery */
+	if (vf->in_reset_recovery)
+		iavf_drain_arq(hw, vf);
+
 	if (iavf_check_api_version(adapter) != 0) {
 		PMD_INIT_LOG(ERR, "check_api version failed");
 		goto err_api;
@@ -3289,6 +3345,8 @@ iavf_dev_reset(struct rte_eth_dev *dev)
 	ret = iavf_dev_uninit(dev);
 	if (ret)
 		return ret;
+	/* Add delay before re-initialization */
+	rte_delay_ms(50);
 
 	return iavf_dev_init(dev);
 }
@@ -3352,6 +3410,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_adapter *adapter = dev->data->dev_private;
+	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	int ret;
 	bool restart_device = false;
 
@@ -3370,6 +3429,11 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	vf->in_reset_recovery = true;
 	iavf_set_no_poll(adapter, false);
 
+	/* For VF-initiated reset, wait for PF to start processing it */
+	if (vf_initiated_reset)
+		if (iavf_wait_for_reset_start(hw) != 0)
+			PMD_DRV_LOG(WARNING, "PF did not acknowledge VF reset");
+
 	/* Call the pre reset callback */
 	if (vf->pre_reset_cb != NULL)
 		vf->pre_reset_cb(dev->data->port_id, vf->pre_reset_cb_arg);
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..0a536a15e0 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -296,11 +296,21 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 					__func__, vpe->event);
 		}
 	}  else {
-		/* async reply msg on command issued by vf previously */
+		/* Async reply for previously issued VF command.
+		 * Stale messages from before reset are ignored, and polling
+		 * continues until the expected response is received.
+		 */
 		result = IAVF_MSG_CMD;
 		if (opcode != vf->pend_cmd) {
-			PMD_DRV_LOG(WARNING, "command mismatch, expect %u, get %u",
-					vf->pend_cmd, opcode);
+			if (opcode == VIRTCHNL_OP_UNKNOWN)
+				PMD_DRV_LOG(DEBUG,
+					    "Ignoring stale msg (opcode 0), pending cmd %u",
+					    vf->pend_cmd);
+			else
+				PMD_DRV_LOG(WARNING,
+					    "command mismatch, expect %u, get %u",
+					    vf->pend_cmd, opcode);
+
 			result = IAVF_MSG_ERR;
 		}
 	}
-- 
2.43.0

