Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B511DCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 14:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EFB940652;
	Wed,  3 Jun 2026 16:34:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id A5021402A9;
 Wed,  3 Jun 2026 16:34:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780497281; x=1812033281;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qt9CfHtPViT57ry86hIPnzMyWv2Erg8oMC0ieDAG6cc=;
 b=GXghL/IDbHuZm1wZo2VEAHjoNwCYBGqbVFRcU7mMb1/0UUiLdPMzJUtC
 oe18nCCmRDX9AbpBK+kwVAswv1360C7o2zScNt21OREM0S/y2ve0+KkMc
 nVdZ1RVf7kxZ9Wk/QSL2W0eihfdeLQqS1/OcnyDtJVZbqdLhEQvjOJYy/
 Uq+sPuk1Unbrdbhe44tFjm584ZcLwkRHuy8v/nUVK6Mcp21Xpjh08UlGd
 lTWDfFcYdnAGD8R+DPfcQ/w+V4Z9waRHOXnUkcsbHEIMfjWch9xvXd2bi
 AqmXGvZLwpU/P3RzCzQ67soRYHwXuEbyILa7bKk97gUiJAIrgsz0LLoCL w==;
X-CSE-ConnectionGUID: MzZ8wpPdS7S+9vKCigGDZA==
X-CSE-MsgGUID: 4MRZjSs+RZ61W44qAzuc3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91882187"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="91882187"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 07:34:40 -0700
X-CSE-ConnectionGUID: ikCVK+FyTC2twM6Zh7enFw==
X-CSE-MsgGUID: s7bMhWTFTouJA+xhzyFjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="244106823"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 03 Jun 2026 07:34:39 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/2] net/i40e: fix blocking link wait on device start
Date: Wed,  3 Jun 2026 14:34:07 +0000
Message-ID: <20260603143407.1108527-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603143407.1108527-1-ciara.loftus@intel.com>
References: <20260603143407.1108527-1-ciara.loftus@intel.com>
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

Currently, device start performs a synchronous link status update,
blocking for up to one second if the link is not yet up. This causes
unnecessary startup delay in scenarios where the link partner is slow to
come up or unavailable.

The wait was introduced alongside the maximum frame size MAC config
command. Some devices require the link to be up before issuing that
command, so the solution was to block at device start until link was
established.

To address the issue, remove the unconditional blocking wait. Take note
if the link was down at the time of the MAC config command during device
start and if it was, re-issue the command upon notification of the first
link-up event.

In the case where all interrupt vectors are consumed by Rx queues, no
interrupt or alarm handler is available to process link-up events. The
blocking wait is retained for this narrow case to preserve correctness.

Fixes: 82fcf20d039c ("net/i40e: fix maximum frame size configuration")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 25 +++++++++++++++++++++----
 drivers/net/intel/i40e/i40e_ethdev.h |  2 ++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index e818b6fc7c..a7c00033e5 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -2565,15 +2565,19 @@ i40e_dev_start(struct rte_eth_dev *dev)
 					       I40E_AQ_EVENT_MEDIA_NA), NULL);
 		if (ret != I40E_SUCCESS)
 			PMD_DRV_LOG(WARNING, "Fail to set phy mask");
-
-		/* Call get_link_info aq command to enable/disable LSE */
-		i40e_dev_link_update(dev, 1);
 	}
 
 	if (dev->data->dev_conf.intr_conf.rxq == 0) {
+		i40e_dev_link_update(dev, 0);
+		pf->mac_config_on_link_up = !dev->data->dev_link.link_status;
 		rte_eal_alarm_set(I40E_ALARM_INTERVAL,
 				  i40e_dev_alarm_handler, dev);
 	} else {
+		/* Block if no interrupt handler can process link-up events, to help
+		 * ensure that MAC config is applied when the link is up.
+		 */
+		i40e_dev_link_update(dev, !rte_intr_allow_others(intr_handle));
+		pf->mac_config_on_link_up = !dev->data->dev_link.link_status;
 		/* enable uio intr after callback register */
 		rte_intr_enable(intr_handle);
 	}
@@ -6867,6 +6871,7 @@ static void
 i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 {
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_arq_event_info info;
 	uint16_t pending, opcode;
 	uint8_t msg_buf[I40E_AQ_BUF_SZ] = {0};
@@ -6899,9 +6904,21 @@ i40e_dev_handle_aq_msg(struct rte_eth_dev *dev)
 			break;
 		case i40e_aqc_opc_get_link_status:
 			ret = i40e_dev_link_update(dev, 0);
-			if (!ret)
+			/* Some devices require MAC config to be applied when the link comes up. */
+			if (!ret) {
+				if (pf->mac_config_on_link_up && dev->data->dev_link.link_status) {
+					uint16_t max_frame_size;
+
+					max_frame_size = dev->data->mtu ?
+						dev->data->mtu + I40E_ETH_OVERHEAD :
+						I40E_FRAME_SIZE_MAX;
+					i40e_aq_set_mac_config(hw, max_frame_size, TRUE,
+								false, 0, NULL);
+					pf->mac_config_on_link_up = false;
+				}
 				rte_eth_dev_callback_process(dev,
 					RTE_ETH_EVENT_INTR_LSC, NULL);
+			}
 			break;
 		default:
 			PMD_DRV_LOG(DEBUG, "Request %u is not supported yet",
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index d57c53f661..7524defdb7 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1191,6 +1191,8 @@ struct i40e_pf {
 
 	/* When firmware > 8.3, the enable flag for outer VLAN processing */
 	bool fw8_3gt;
+	/* MAC config needs re-applying when link first comes up */
+	bool mac_config_on_link_up;
 
 	struct i40e_vf_msg_cfg vf_msg_cfg;
 	uint64_t prev_rx_bytes;
-- 
2.43.0

