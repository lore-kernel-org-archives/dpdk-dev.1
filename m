Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF03CCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 11:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFB142C24;
	Fri, 17 Oct 2025 13:11:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 40F7B427A2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760699498; x=1792235498;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lhaIOMzSVCQZx68VTztIpDVgJ8QuqfmKb9pZWqbcj20=;
 b=SftN0c0zigGQXbU3zhlgKEG5fMsFFqv+WdyQM7tQDtt7xkSIP6cOm4xM
 1MvQ1LDlWLuf4x9bJmjDCSs942t+rnm2B5OJXd2cSwHzfDvTfSNygeD8W
 +EUqHjt27IZFnZyTPA19O2rpQBwmL9qbk1hWjQ9wWJMOGwAL9d+tHZauu
 1N5qrOTFzoRCAKv9dl7lmsQvINBsbrjnA4Afaclk8d7xPho39iy1bbLzX
 yUd2ivB9lMQEtf/mJkY7/viu3dR9vpSKdKXb3fV4s0YRJsCxhvhCP7sgA
 zr6A0v92EXlw0kVNntU4vsWBErkFuto1NkgUKYI1H0YRXni3S4AAl7kd9 Q==;
X-CSE-ConnectionGUID: JPDpDtkVQOancq5gulYvFg==
X-CSE-MsgGUID: oDk48j+rQsOCll0J3cvN9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74023715"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="74023715"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 04:11:37 -0700
X-CSE-ConnectionGUID: 2MGF4g0nS7GDHRwpm6aOkQ==
X-CSE-MsgGUID: CdwI0ADOQC6eJUZDpXYoGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="182654504"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2025 04:11:36 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC 2/3] net/iavf: implement device reinitialisation callback
Date: Fri, 17 Oct 2025 11:11:08 +0000
Message-Id: <20251017111109.1734792-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017111109.1734792-1-ciara.loftus@intel.com>
References: <20251017111109.1734792-1-ciara.loftus@intel.com>
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

Add support for the experimental device reinit API that simplifies the
process of resetting the device followed by restoring its configuration.
The reset will trigger a full PF-to-VF reset. If the device was started
when the call to reinit was made, it will be restarted again if the
no-poll-on-link-down devarg is set.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 52 ++++++++++++++++++++++------
 drivers/net/intel/iavf/iavf_vchnl.c  |  2 +-
 3 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 435902fbc2..bce409631c 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -563,6 +563,6 @@ int iavf_flow_sub_check(struct iavf_adapter *adapter,
 			struct iavf_fsub_conf *filter);
 void iavf_dev_watchdog_enable(struct iavf_adapter *adapter);
 void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
-void iavf_handle_hw_reset(struct rte_eth_dev *dev);
+void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 08c814725d..fc56e669ba 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -100,6 +100,7 @@ static int iavf_dev_start(struct rte_eth_dev *dev);
 static int iavf_dev_stop(struct rte_eth_dev *dev);
 static int iavf_dev_close(struct rte_eth_dev *dev);
 static int iavf_dev_reset(struct rte_eth_dev *dev);
+static int iavf_dev_reinit(struct rte_eth_dev *dev);
 static int iavf_dev_info_get(struct rte_eth_dev *dev,
 			     struct rte_eth_dev_info *dev_info);
 static const uint32_t *iavf_dev_supported_ptypes_get(struct rte_eth_dev *dev,
@@ -207,6 +208,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.dev_stop                   = iavf_dev_stop,
 	.dev_close                  = iavf_dev_close,
 	.dev_reset                  = iavf_dev_reset,
+	.dev_reinit                = iavf_dev_reinit,
 	.dev_infos_get              = iavf_dev_info_get,
 	.dev_supported_ptypes_get   = iavf_dev_supported_ptypes_get,
 	.link_update                = iavf_dev_link_update,
@@ -3069,6 +3071,26 @@ iavf_dev_reset(struct rte_eth_dev *dev)
 	return iavf_dev_init(dev);
 }
 
+/*
+ * Reinitialise VF device by resetting and reconfiguring it.
+ */
+static int
+iavf_dev_reinit(struct rte_eth_dev *dev)
+{
+	struct iavf_adapter *adapter;
+
+	adapter = dev->data->dev_private;
+	if (dev->data->dev_started && !adapter->devargs.no_poll_on_link_down) {
+		PMD_DRV_LOG(ERR, "Cannot reinit started port %u. Either stop the port or enable "
+				"no-poll-on-link-down in devargs.", dev->data->port_id);
+		return -EBUSY;
+	}
+
+	iavf_handle_hw_reset(dev, true);
+
+	return 0;
+}
+
 static inline bool
 iavf_is_reset(struct iavf_hw *hw)
 {
@@ -3096,18 +3118,23 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
  * Handle hardware reset
  */
 void
-iavf_handle_hw_reset(struct rte_eth_dev *dev)
+iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 {
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
 
-	if (!iavf_is_reset_detected(adapter)) {
-		PMD_DRV_LOG(DEBUG, "reset not start");
-		return;
+		if (!iavf_is_reset_detected(adapter)) {
+			PMD_DRV_LOG(DEBUG, "reset not start");
+			return;
+		}
 	}
 
 	vf->in_reset_recovery = true;
@@ -3124,12 +3151,15 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev)
 
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
+
+		dev->data->dev_started = 1;
+	}
 
-	dev->data->dev_started = 1;
 	goto exit;
 
 error:
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index b1b7a5bf94..460035d772 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -83,7 +83,7 @@ iavf_dev_event_handle(void *param __rte_unused)
 			struct iavf_adapter *adapter = pos->dev->data->dev_private;
 			if (pos->event == RTE_ETH_EVENT_INTR_RESET &&
 			    adapter->devargs.auto_reset) {
-				iavf_handle_hw_reset(pos->dev);
+				iavf_handle_hw_reset(pos->dev, false);
 				rte_free(pos);
 				continue;
 			}
-- 
2.34.1

