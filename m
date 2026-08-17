Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA67CC5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:49:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAB344060A;
	Mon, 17 Aug 2026 08:49:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0BFE24060A
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786949392; x=1818485392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3sCanruMH3zA36o6fu645gWxrIYVwXYLgbgcLkWXom8=;
 b=kRF4RGcrl1348XP0jH2zeAfHxkkMWSOEo445mO88D7bJvRsxMuGkXcOv
 6T73eU5bpowsu3sOgSl4aT5PkdlfkFPD6uO7j9Y3raZE9FvqFFJ3OuTHD
 0Z35ofydKoTNIdZ54GKOpocZ19fPJp4Wn2w9WZBKWPbNaxoom8OY4EMI0
 9RgC9d2iRu3TfD8e+IACphOKhbqsR1MDLIE50Wya4uwdAR9FXlJnGTBJ+
 WdeGl3jieqAdInVzNGa3OptiEk+LRiM3Ubt3K047S5XbA6WnebxSPOK41
 tGT3db+rjb9Fem2z3wviSGWKNaUIi2myVkJ89fYjL0acnYDzPgC0zRGEE Q==;
X-CSE-ConnectionGUID: m8UH4uxQSkuVwkz2qCvxWQ==
X-CSE-MsgGUID: u1A/S0MVR6uUS8dtXL6xwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91095598"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="91095598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:49:51 -0700
X-CSE-ConnectionGUID: o7MdYeQhQLmc6p5prxMgLA==
X-CSE-MsgGUID: YR3UFDCOQHOAG1P7OKUahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="262195954"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 16 Aug 2026 23:49:48 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v3 2/7] net/iavf: defer device start when PF VSI not ready
Date: Mon, 17 Aug 2026 06:48:41 +0000
Message-Id: <ce23295863326e2e77edfb71cfcb7e48b1b496c8.1786948817.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786948817.git.anurag.mandal@intel.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
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

Fixes: 3e6a5d2d310a ("net/iavf: add devargs to enable VF auto-reset")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  2 +
 drivers/net/intel/iavf/iavf_ethdev.c | 61 ++++++++++++++++++++++++++--
 drivers/net/intel/iavf/iavf_vchnl.c  |  3 ++
 3 files changed, 62 insertions(+), 4 deletions(-)

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
index e475b64971..ebe0183a77 100644
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
@@ -3662,6 +3676,45 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
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
+
+	if (vf->vf_reset || vf->in_reset_recovery)
+		return;
+
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
+	vf->start_pending = false;
+	PMD_DRV_LOG(DEBUG, "PF link back up; resuming deferred dev_start");
+	ret = iavf_dev_start(dev);
+	if (ret == 0) {
+		dev->data->dev_started = 1;
+	} else {
+		PMD_DRV_LOG(ERR,
+			    "deferred dev_start failed (ret=%d); will retry on next link-up",
+			    ret);
+		vf->start_pending = true;
+	}
+}
+
 RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 23e4107743..b6864d8d69 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -271,6 +271,9 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 			    adapter->no_poll ? "on" : "off");
 	}
 
+	/* Retry a dev_start deferred by reset recovery, before the LSC post. */
+	iavf_resume_pending_start(dev);
+
 	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
 
 	PMD_DRV_LOG(INFO, "Link status update:%s",
-- 
2.34.1

