Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F50CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50C6340689;
	Mon,  8 Jun 2026 18:29:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 669E24029D;
 Mon,  8 Jun 2026 18:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780936156; x=1812472156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Dv0YO3IuTc1q6XBS5VEovxElGbPxuvmMa3C45SNRfU=;
 b=hBob3tYfkjbQJ10uFkzPEEJ9i3MFnCWWx5jtMlGDLObJJ4UfOrCnbbR+
 yidUZxaSt8a6swPjlOHJFFkYkNOp926QAfnAjGhtEe/4iwItRWNO1Rhcy
 4kZHwePOp95ynuo3W1LXqMJSfzWMudmQrvkxMh4mBeetxPu18KTDTF2p0
 aY1X/i+q8xbIulzA9HuRr4+Z6lZAp6Dhz2JE63sPakBJpzuA8eNF2yuT+
 +bigg+G0g3z18yky7JJrD23NJKxdfPjTTPUHG+xGbLwQ+K+PXEkBMginC
 ATFTdahXllmVuQThKrvbU1MCJBh8yyxZZ8DGpXlSFMN+WW5ozUTn6gdu8 A==;
X-CSE-ConnectionGUID: g6RXqTY4QLS2vFpKGke9zQ==
X-CSE-MsgGUID: Zok9DG78QFy1OTIzNwzfPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81532405"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81532405"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:29:15 -0700
X-CSE-ConnectionGUID: p79hku2zQGSrieLdFfsh4g==
X-CSE-MsgGUID: RnidkKupTsqgOgLhcu9ClA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="269292272"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa002.fm.intel.com with ESMTP; 08 Jun 2026 09:29:14 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH v4] net/iavf: fix duplicate VF reset during PF reset recovery
Date: Mon,  8 Jun 2026 16:29:36 +0000
Message-Id: <20260608162936.354248-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605202911.314359-1-anurag.mandal@intel.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
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

During PF initiated reset recovery, iavf_dev_close() sending
an extra VIRTCHNL_OP_RESET_VF while recovery is already in progress.
That second reset can leave PF/VF virtchnl state inconsistent and
cause VIRTCHNL_OP_CONFIG_VSI_QUEUES to fail with ERR_PARAM after
ToR link flap/power-cycle, leaving the VF unable to recover.
This results in connection loss.

This patch skipped close-time VF reset and related close-time
virtchnl operations when PF triggered reset recovery is set.
This is done to avoid a duplicate VF reset, and keep normal
behavior for application-driven close.

Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without interrupt")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V4: Addressed Ciara Loftus comments
  - split VF reset from other code changes 
V3: Addressed latest ai-code-review comments
V2: Addressed ai-code-review comments

 doc/guides/rel_notes/release_26_07.rst |  3 +++
 drivers/net/intel/iavf/iavf_ethdev.c   | 37 +++++++++++++++-----------
 drivers/net/intel/iavf/iavf_vchnl.c    | 18 ++++++++++---
 3 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index d2563ac503..f6899a78c3 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -95,6 +95,9 @@ New Features
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
+  * Prevented duplicate 'VIRTCHNL_OP_RESET_VF' during a PF-initiated
+    reset recovery, which earlier caused virtchnl state corruption
+    and connection loss after a top-of-rack (ToR) link flap/power-cycle.
 
 * **Updated PCAP ethernet driver.**
 
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8031e23a5..99457ae510 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3166,24 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
 
 	ret = iavf_dev_stop(dev);
 
-	/*
-	 * Release redundant queue resource when close the dev
-	 * so that other vfs can re-use the queues.
-	 */
-	if (vf->lv_enabled) {
-		ret = iavf_request_queues(dev, IAVF_MAX_NUM_QUEUES_DFLT);
-		if (ret)
-			PMD_DRV_LOG(ERR, "Reset the num of queues failed");
+	/* Skip RESET_VF on a PF-initiated reset */
+	if (!adapter->closed && !vf->in_reset_recovery) {
+		/*
+		 * Release redundant queue resource when close the dev
+		 * so that other vfs can re-use the queues.
+		 */
+		if (vf->lv_enabled) {
+			ret = iavf_request_queues(dev, IAVF_MAX_NUM_QUEUES_DFLT);
+			if (ret)
+				PMD_DRV_LOG(ERR, "Reset the num of queues failed");
+			vf->max_rss_qregion = IAVF_MAX_NUM_QUEUES_DFLT;
+		}
 
-		vf->max_rss_qregion = IAVF_MAX_NUM_QUEUES_DFLT;
+		/*
+		 * Disable promiscuous mode before resetting the VF. This is to avoid
+		 * potential issues when the PF is bound to the kernel driver.
+		 */
+		if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
+			iavf_config_promisc(adapter, false, false);
 	}
 
-	/* Disable promiscuous mode before resetting the VF. This is to avoid
-	 * potential issues when the PF is bound to the kernel driver.
-	 */
-	if (vf->promisc_unicast_enabled || vf->promisc_multicast_enabled)
-		iavf_config_promisc(adapter, false, false);
-
 	adapter->closed = true;
 
 	/* free iAVF security device context all related resources */
@@ -3195,7 +3198,9 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	iavf_flow_flush(dev, NULL);
 	iavf_flow_uninit(adapter);
 
-	iavf_vf_reset(hw);
+	/* Skip RESET_VF on a PF-initiated reset */
+	if (!vf->in_reset_recovery)
+		iavf_vf_reset(hw);
 	vf->aq_intr_enabled = false;
 	iavf_shutdown_adminq(hw);
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..cf3513ef94 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -283,9 +283,21 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 					vf->link_up ? "up" : "down");
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
-			vf->vf_reset = true;
-			iavf_set_no_poll(adapter, false);
-			PMD_DRV_LOG(INFO, "VF is resetting");
+			/*
+			 * Force link down on impending reset to drop
+			 * the cached link-up state; a fresh LSC up
+			 * event will be re-issued by the PF once the
+			 * VF is reinitialised.
+			 */
+			vf->link_up = false;
+			if (!vf->vf_reset) {
+				vf->vf_reset = true;
+				iavf_set_no_poll(adapter, false);
+				iavf_dev_event_post(vf->eth_dev,
+					RTE_ETH_EVENT_INTR_RESET,
+					NULL, 0);
+			}
+			PMD_DRV_LOG(DEBUG, "VF is resetting");
 			break;
 		case VIRTCHNL_EVENT_PF_DRIVER_CLOSE:
 			vf->dev_closed = true;
-- 
2.34.1

