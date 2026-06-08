Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A5DCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3EA64066C;
	Mon,  8 Jun 2026 16:55:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A6C99402DD;
 Mon,  8 Jun 2026 16:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780930534; x=1812466534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hAkDQIvd3EHRl2sxrf9vmb2NjaOojQeDVQOPo3Q9kRs=;
 b=Xi/6NQ6WlsYDnoub7j07bVrIU3O/C2qg3xxn6FpdySiprGT0gQob9fyv
 nLHLFnUUmbl5qoRg3AfbjPb7UMEJAsHmggvvzzxvWArSqcnDgQzhMaIHI
 nnA1bP/LQowjoQFCIifMDW37Nwd+JkEb7ZObqB5wjjEUGl9+CXDqJpn/e
 z+k0hiZNApLr9NUfqMAtdUi/fJJUYKYGNYpOS/B6FobPIQF7XXVmuEtPH
 YukvSfjSpOCPLenSjxDgoOAUsM8I5VDIDvgBbokqImCQPOiDkvjypTboI
 6oJTX7jwcgTOa0irfIEzWwRJLxCwMdtXZL2kmZdl6eUxC2FFutzhC2S4K A==;
X-CSE-ConnectionGUID: sWb+kI0tTIybvoX03zgliQ==
X-CSE-MsgGUID: ptdTQHmVQxS5x7Cw6MdDZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93055941"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="93055941"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 07:55:32 -0700
X-CSE-ConnectionGUID: Dtf1YtAOTuWNb4XtKibrrw==
X-CSE-MsgGUID: /1DXGui1RgGjUyRwTwuzUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="247436460"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa004.fm.intel.com with ESMTP; 08 Jun 2026 07:55:31 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH 2/3] net/iavf: wait for PF reset start before reinitializing
Date: Mon,  8 Jun 2026 14:55:17 +0000
Message-ID: <20260608145518.1705524-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608145518.1705524-1-ciara.loftus@intel.com>
References: <20260608145518.1705524-1-ciara.loftus@intel.com>
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

Commit 1428895ad417 ("net/iavf: fix disabling of promiscuous modes on
close") added a synchronous VIRTCHNL round-trip on the close path
before the reset request is sent. This delays the reset just long
enough that `IAVF_VFGEN_RSTAT` still reads `VIRTCHNL_VFR_VFACTIVE`
when the re-init path polls it for reset completion. The driver
interprets this as the reset being complete, when in fact it has not
yet started, and proceeds to issue VIRTCHNL commands before the PF
has disabled the VF mailbox.

Fix by polling `IAVF_VF_ARQLEN1.ARQENABLE` immediately after the reset
request and before shutting down the admin queue, when the close is
triggered by a reset. The PF clears this bit as its first reset action,
providing an unambiguous signal that the reset is in progress.

Fixes: 1428895ad4 ("net/iavf: fix disabling of promiscuous modes on close")
Cc: stable@dpdk.org

Reported-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 2615b6f034..4444602a30 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -291,6 +291,7 @@ struct iavf_info {
 	struct rte_eth_dev *eth_dev;
 
 	bool in_reset_recovery;
+	bool reset_pending;
 
 	uint32_t ptp_caps;
 	rte_spinlock_t phc_time_aq_lock;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8031e23a5..a38132e80e 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -106,6 +106,7 @@ static int iavf_dev_start(struct rte_eth_dev *dev);
 static int iavf_dev_stop(struct rte_eth_dev *dev);
 static int iavf_dev_close(struct rte_eth_dev *dev);
 static int iavf_dev_reset(struct rte_eth_dev *dev);
+static bool iavf_is_reset_detected(struct iavf_adapter *adapter);
 static int iavf_dev_info_get(struct rte_eth_dev *dev,
 			     struct rte_eth_dev_info *dev_info);
 static const uint32_t *iavf_dev_supported_ptypes_get(struct rte_eth_dev *dev,
@@ -3196,6 +3197,14 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	iavf_flow_uninit(adapter);
 
 	iavf_vf_reset(hw);
+	/*
+	 * If a reset is pending, wait for the PF to disable the VF's admin
+	 * receive queue (its first reset action) before we shut it down
+	 * ourselves.  This ensures iavf_check_vf_reset_done() does not see
+	 * a stale VFACTIVE value on the re-init path.
+	 */
+	if (vf->reset_pending)
+		iavf_is_reset_detected(adapter);
 	vf->aq_intr_enabled = false;
 	iavf_shutdown_adminq(hw);
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
@@ -3273,6 +3282,7 @@ iavf_dev_reset(struct rte_eth_dev *dev)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	/*
 	 * Check whether the VF reset has been done and inform application,
 	 * to avoid calling the virtual channel command, which may cause
@@ -3285,8 +3295,10 @@ iavf_dev_reset(struct rte_eth_dev *dev)
 	}
 	iavf_set_no_poll(adapter, false);
 
+	vf->reset_pending = true;
 	PMD_DRV_LOG(DEBUG, "Start dev_reset ...");
 	ret = iavf_dev_uninit(dev);
+	vf->reset_pending = false;
 	if (ret)
 		return ret;
 
-- 
2.43.0

