Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EDDC561E6
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB81C40679;
	Thu,  6 Aug 2026 10:27:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7F06A4065A
 for <dev@dpdk.org>; Thu,  6 Aug 2026 10:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786004870; x=1817540870;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VflFMUIVBQ805jUaSg/lAWaUAqFC8jFKOuH8K4LaNaM=;
 b=hE68v86t1TJfcV0Ge09th4ZhqHZ+DsfukUe2Mgz5ZHZvDLu6TITT/Knu
 nlCksUds7rFMwimWKlvPpB9lWi66wwdBSVaUluk/fH8FE/yVoz3sVaqeA
 CwWt8KE5h3d/+XCLg1Ktubj+DYsEL6Ec/SMR1EYD7gzQusoEd8588Sn+i
 htSA8/66uy1f948b1jNM1cO147fwCJnPsLaXMLzHzBuWJHRnt/IOSe8ri
 ecW+vI5K6DLf5mtreW0+DTKN0fKCt7y0ZfS1To9PIEdWRA7TXLOzuDfBp
 4RJEyo3rbQKXYzqQ2KmH9K9DZecXnHBwZbdZskoFAXy23jnFo/CTaPiRG w==;
X-CSE-ConnectionGUID: USCfaBIcRZGN4lnWvpI3Jg==
X-CSE-MsgGUID: qocmeIAkSsGkemCDMnWKug==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86666981"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86666981"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 01:27:49 -0700
X-CSE-ConnectionGUID: tgsySaq7RhSwssNqB5OPjg==
X-CSE-MsgGUID: txjueDSMShS0Z4ON5GcKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="259421005"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 01:27:47 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 2/5] net/iavf: defer device start when PF VSI not ready
Date: Thu,  6 Aug 2026 08:26:25 +0000
Message-Id: <39df153b08742a36bfe74bac5026d14a2dc95f1d.1786004043.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786004043.git.anurag.mandal@intel.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
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

During reset recovery iavf_dev_start() might fail (typically -EIO
from VIRTCHNL_OP_CONFIG_VSI_QUEUES) because the PF VSI is not yet
active, leaving the VF down and requiring manual intervention
to recover.

Added a start_pending flag: when device start fails during recovery,
defer it instead of erroring out and resume it from newly added
iavf_resume_pending_start() on the next link-up event, so the
VF comes back automatically.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  2 +
 drivers/net/intel/iavf/iavf_ethdev.c | 56 ++++++++++++++++++++++++++--
 drivers/net/intel/iavf/iavf_vchnl.c  | 16 +++++++-
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..e76c3bb410 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -293,6 +293,7 @@ struct iavf_info {
 	bool in_reset_recovery;
 	bool reset_pending;
 	bool pf_reset_in_progress;
+	bool start_pending;
 
 	uint32_t ptp_caps;
 	rte_spinlock_t phc_time_aq_lock;
@@ -533,4 +534,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 bool is_iavf_supported(struct rte_eth_dev *dev);
 void iavf_hash_uninit(struct iavf_adapter *ad);
+void iavf_resume_pending_start(struct rte_eth_dev *dev);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index e475b64971..87b826c873 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1093,6 +1093,9 @@ iavf_dev_start(struct rte_eth_dev *dev)
 
 	iavf_phc_sync_alarm_start(dev);
 
+	/* An explicit start supersedes any pending deferred start */
+	vf->start_pending = false;
+
 	return 0;
 
 error:
@@ -1131,6 +1134,9 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	adapter->stopped = 1;
 	dev->data->dev_started = 0;
 
+	/* An explicit stop cancels any pending deferred start */
+	vf->start_pending = false;
+
 	return 0;
 }
 
@@ -3425,6 +3431,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 
 	vf->in_reset_recovery = true;
 	vf->pf_reset_in_progress = !vf_initiated_reset;
+	vf->start_pending = false;
 	iavf_set_no_poll(adapter, false);
 
 	/* Call the pre reset callback */
@@ -3445,10 +3452,17 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	if (!vf_initiated_reset || restart_device) {
 		/* start the device */
 		ret = iavf_dev_start(dev);
-		if (ret)
-			goto error;
-
-		dev->data->dev_started = 1;
+		if (ret == 0) {
+			dev->data->dev_started = 1;
+		} else {
+			PMD_DRV_LOG(WARNING,
+				    "dev_start failed during reset recovery (rc=%d);"
+				    "deferring to next link-up event",
+				    ret);
+			vf->start_pending = true;
+			dev->data->dev_started = 0;
+			ret = 0;
+		}
 	}
 
 	/* Restore settings after the reset */
@@ -3662,6 +3676,40 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
 	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
 }
 
+void
+iavf_resume_pending_start(struct rte_eth_dev *dev)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	int ret;
+
+	if (!vf->start_pending)
+		return;
+	/*
+	 * If the application has already (re)started the port itself, the
+	 * deferred start is stale, the application's action is honoured
+	 * and resume pending is dropped to avoid starting an
+	 * already-running port a second time.
+	 */
+	if (dev->data->dev_started) {
+		vf->start_pending = false;
+		return;
+	}
+
+	if (!vf->link_up)
+		return;
+
+	PMD_DRV_LOG(DEBUG, "PF link back up; resuming deferred dev_start");
+	ret = iavf_dev_start(dev);
+	if (ret == 0) {
+		dev->data->dev_started = 1;
+		vf->start_pending = false;
+	} else {
+		PMD_DRV_LOG(ERR,
+			    "deferred dev_start failed (ret=%d); will retry on next link-up",
+			    ret);
+	}
+}
+
 RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 56918ebcc1..8e102b02aa 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -260,7 +260,7 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 	 * (link is down or a VF reset is in progress); the watchdog drives
 	 * auto-reset recovery, so it must remain armed in those cases.
 	 */
-	if (vf->link_up && !vf->vf_reset)
+	if (vf->link_up && !vf->vf_reset && !vf->in_reset_recovery)
 		iavf_dev_watchdog_disable(adapter);
 	else
 		iavf_dev_watchdog_enable(adapter);
@@ -271,6 +271,20 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 			    adapter->no_poll ? "on" : "off");
 	}
 
+	/*
+	 * Resume a deferred dev_start.
+	 * iavf_handle_hw_reset() sets vf->start_pending when
+	 * reset recovery completed dev_init() but iavf_dev_start()
+	 * itself failed (typically -EIO from VIRTCHNL_OP_CONFIG_VSI_QUEUES
+	 * when the PF VSI was inactive).
+	 * A link-up event implies the PF VSI is active again, so retry now.
+	 * Run before the LSC event post so the port is ready to accept Tx
+	 * by the time the app's link-up callback fires; no_poll has already
+	 * been cleared above so bursts go through as soon as
+	 * dev_start sets dev_started=1.
+	 */
+	iavf_resume_pending_start(dev);
+
 	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
 
 	PMD_DRV_LOG(INFO, "Link status update:%s",
-- 
2.34.1

