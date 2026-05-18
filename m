Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23627CD343F
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 05:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD288402A7;
	Mon, 18 May 2026 07:38:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0AAB140264;
 Mon, 18 May 2026 07:38:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779082681; x=1810618681;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Oh6lOep/CApZ+rdycpHpvLfFAGl4OuOGVAjlS33iE8U=;
 b=cm8Nc9DUvyo86SzBfu39S03GGmjcy8v+y7ee1ic+P+4tgA3EpD8ty6Nq
 QDUvSgcN0+flxqEGee50SEjamzsm2g2gFvQcBKhpvQubZBcvG5J2g7Qy1
 LqCI8BXWASABK8WqkCZdrnxHc/bjxXaxQWydWTWskBJB67izA0grHZlIG
 RlYMKwrTX0giVWwuEBV8qnBYTLUDBWjReT5rUstkI7q/7qNpIkTj/VoZW
 myC7NF1UKlrv+MfSy/75S+luC9dbfOXJIIsebJB/qJyghpj6rkoCv+7fJ
 MSk1lKDFVrLSG4jiElgGedQguC4QqTOeVdAfO+WEoj2f9oz7iPgztJjNW w==;
X-CSE-ConnectionGUID: YEC9P+y5Ru6dpfpBFm0H1Q==
X-CSE-MsgGUID: pknEzqA/SwK+lxQuUQ/NIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="102601150"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="102601150"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 22:38:00 -0700
X-CSE-ConnectionGUID: 6KGWzuf2Q9a5DiTXmzvRpw==
X-CSE-MsgGUID: OnG8/u/UQe2+BIRT67X3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="236291179"
Received: from icx009.iind.intel.com ([10.190.212.240])
 by fmviesa007.fm.intel.com with ESMTP; 17 May 2026 22:37:57 -0700
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, stable@dpdk.org
Subject: [PATCH] net/iavf: fix VF reset race and stale ARQ message handling
Date: Mon, 18 May 2026 05:42:27 +0000
Message-ID: <20260518054227.110701-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
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

During VF reset, multiple issues can lead to initialization instability.

The first issue is a race condition in iavf_check_vf_reset_done(),
where VFR state VFACTIVE is treated as both "reset not started" and
"reset completed". This can allow the VF to proceed before the PF
has acknowledged the reset, resulting in inconsistent initialization.

The second issue is the presence of stale messages in the Admin
Receive Queue (ARQ) after VF reset. These may include opcode 0
(VIRTCHNL_OP_UNKNOWN) or responses to commands issued before reset,
which can interfere with API negotiation and cause command mismatch
errors.

Additionally, opcode 0 messages generate excessive warning logs,
causing unnecessary noise during initialization.

The solution involves:
1. Introducing a two-phase reset wait mechanism in
   iavf_check_vf_reset_done():
   - Wait for RSTAT to leave VFACTIVE to confirm reset start.
   - Wait for RSTAT to return to VFACTIVE or COMPLETED to confirm
     reset completion.

2. Draining stale ARQ messages after admin queue initialization
   and before issuing commands in iavf_init_vf().

3. Downgrading opcode 0 message logging to DEBUG level while
   preserving mismatch detection for other opcodes.

4. Refactoring reset-start detection and ARQ drain logic into
   helper functions (iavf_wait_for_reset_start() and
   iavf_drain_arq()) to improve readability and reuse.

This ensures reliable VF reset handling and stable initialization.

Fixes: 28a1a72eac26 ("net/iavf: add VF initiated reset")
Cc: stable@dpdk.org

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 54 ++++++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  | 16 +++++++--
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..692e4455dc 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2002,11 +2002,36 @@ iavf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
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
+	return -1;
+}
+
 static int
 iavf_check_vf_reset_done(struct iavf_hw *hw)
 {
 	int i, reset;
 
+	/* Phase 1: wait for reset to start (leave VFACTIVE) */
+	if (iavf_wait_for_reset_start(hw) != 0)
+		PMD_DRV_LOG(DEBUG, "VF reset did not start within timeout");
+
 	for (i = 0; i < IAVF_RESET_WAIT_CNT; i++) {
 		reset = IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT) &
 			IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
@@ -2517,6 +2542,31 @@ iavf_init_proto_xtr(struct rte_eth_dev *dev)
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
+		PMD_INIT_LOG(DEBUG,
+				"Drained %d stale ARQ messages",
+				drain_count);
+}
+
 static int
 iavf_init_vf(struct rte_eth_dev *dev)
 {
@@ -2558,6 +2608,10 @@ iavf_init_vf(struct rte_eth_dev *dev)
 		PMD_INIT_LOG(ERR, "unable to allocate vf_aq_resp memory");
 		goto err_aq;
 	}
+
+	/* Drain stale ARQ messages after VF reset */
+	iavf_drain_arq(hw, vf);
+
 	if (iavf_check_api_version(adapter) != 0) {
 		PMD_INIT_LOG(ERR, "check_api version failed");
 		goto err_api;
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 08dd6f2d7f..a014be8b57 100644
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
+						"Ignoring stale msg (opcode 0), pending cmd %u",
+						vf->pend_cmd);
+			else
+				PMD_DRV_LOG(WARNING,
+						"command mismatch, expect %u, get %u",
+						vf->pend_cmd, opcode);
+
 			result = IAVF_MSG_ERR;
 		}
 	}
-- 
2.43.0

