Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850CCCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:33:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DAA741149;
	Thu, 16 Oct 2025 13:33:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A91D840EE4
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760614379; x=1792150379;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=S0KFo0Lvj56z4ks3YsLxBsv4dzSN9cJecsQt2GyEOY0=;
 b=bDfeWZvp5QhCaUxsGR3iO0gpV2yz7k9dtO/eWyQFmfSmdgb2EH39otBc
 /DOaOmYzSn5K1DnbfzmXquHBOREO2LLdSFw80Y1d5W0392BbZD5yy7OFj
 uWAkmixQZyuNBVdOVtVipeJFqrthnJOD/j3mMgbWQFctTze3CKueBlMo9
 wjV5LlNN1XVFaUxT+8zYfcPKFK+dMCXVYISWS24/lBqQX8T1a2nkgPM/+
 G80zqJdowf8sARpjZldCe9KPPCxFjTATLWxKu9eOYQt/Yqyq1gOB7Dquq
 SV5NOpfgkNBo9FWaz8eQN9YMVEEUM5TBif0MT0JCLLJb1obagD7ARj941 g==;
X-CSE-ConnectionGUID: yvJV2OmpSC++g0oG/3Ihow==
X-CSE-MsgGUID: GML527aoQu+H4CkIUVsxrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66634250"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="66634250"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 04:32:54 -0700
X-CSE-ConnectionGUID: CixkzAe7SwqYtMyNQYz5DQ==
X-CSE-MsgGUID: gB8gSPUhQtKAS/Fayweycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="186444166"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa003.jf.intel.com with ESMTP; 16 Oct 2025 04:32:53 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/iavf: ensure no polling during VF initiated reset
Date: Thu, 16 Oct 2025 11:32:24 +0000
Message-Id: <20251016113224.1652880-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

Ensure that the datapath functions will not poll during a vf initiated
reset. Otherwise the datapath could access freed resources and cause a
core dump. Achieve this by ensuring that the no-poll-on-link-down devarg
is set when trying to reinit a started device. If it's not set, suggest
stopping the port before the reinit.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 40 +++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 95e5832f03..72d79447e1 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3102,13 +3102,18 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_adapter *adapter = dev->data->dev_private;
 	int ret;
+	bool restart_device = false;
 
-	if (!dev->data->dev_started)
-		return;
+	if (vf_initiated_reset) {
+		restart_device = dev->data->dev_started;
+	} else {
+		if (!dev->data->dev_started)
+			return;
 
-	if (!vf_initiated_reset && !iavf_is_reset_detected(adapter)) {
-		PMD_DRV_LOG(DEBUG, "reset not start");
-		return;
+		if (!iavf_is_reset_detected(adapter)) {
+			PMD_DRV_LOG(DEBUG, "reset not start");
+			return;
+		}
 	}
 
 	vf->in_reset_recovery = true;
@@ -3125,12 +3130,14 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 
 	iavf_dev_xstats_reset(dev);
 
-	/* start the device */
-	ret = iavf_dev_start(dev);
-	if (ret)
-		goto error;
+	if (!vf_initiated_reset || restart_device) {
+		/* start the device */
+		ret = iavf_dev_start(dev);
+		if (ret)
+			goto error;
 
-	dev->data->dev_started = 1;
+		dev->data->dev_started = 1;
+	}
 	goto exit;
 
 error:
@@ -3147,6 +3154,7 @@ int
 rte_pmd_iavf_reinit(uint16_t port)
 {
 	struct rte_eth_dev *dev;
+	struct iavf_adapter *adapter;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
@@ -3157,6 +3165,18 @@ rte_pmd_iavf_reinit(uint16_t port)
 		return -ENOTSUP;
 	}
 
+	if (!dev->data->dev_configured) {
+		PMD_DRV_LOG(ERR, "Cannot reinit unconfigured port %u.", port);
+		return -EINVAL;
+	}
+
+	adapter = dev->data->dev_private;
+	if (dev->data->dev_started && !adapter->devargs.no_poll_on_link_down) {
+		PMD_DRV_LOG(ERR, "Cannot reinit started port %u. Either stop the port or enable "
+				"no-poll-on-link-down in devargs.", port);
+		return -EINVAL;
+	}
+
 	iavf_handle_hw_reset(dev, true);
 
 	return 0;
-- 
2.34.1

