Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B4EC53209
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:10:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2304440279;
	Mon, 27 Jul 2026 15:10:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9B22A400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785157857; x=1816693857;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cUewVA1cQjznm9MAXjwomAsFPhFUF01JtW/JXu6NsTE=;
 b=C5fl6Ibh9dCql6WoO+s1CGMj9giYwWVp+IkI7aTan9k9NpZZacQUfEsz
 K6to1cc7xuZq9IIDgKX+P/ikzBdw8IIRCHtKQrcvo/24Cf0MzEkj/ZMrQ
 T/aSuqpvVG2uTPic2fg7LYtXQZVrQWdMwmlMS//J/7lwksiZlxLafyFcS
 OcZIfsxVvnvq9QxezdcJnMgegtCBUQnI9QGhNMQ94J1c5aGkd2ZSoL9Cm
 o3XOPEzskFyxvnsaqaOpIn5S9Y5PYSPzaIslWZIE3fKwOhVRaTCHqNLWS
 D0LdZg9fm24uTjsgXEqt89Iwj8j0BJJuUG8p0mgq+dnyIXQGncYmn4Bp2 Q==;
X-CSE-ConnectionGUID: oTcERYutQuaAqUHMduyiEg==
X-CSE-MsgGUID: tQvfYJouQYSnBJF9lAdiCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84701149"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="84701149"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 06:10:55 -0700
X-CSE-ConnectionGUID: j+IZeS24RkuCWMhieGRc/g==
X-CSE-MsgGUID: Vn4eRS/8TUKrYC6Jm7IUUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="261377373"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa004.fm.intel.com with ESMTP; 27 Jul 2026 06:10:53 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2] net/iavf: add clock read support
Date: Mon, 27 Jul 2026 13:10:16 +0000
Message-Id: <20260727131016.790792-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727102444.789833-1-anurag.mandal@intel.com>
References: <20260727102444.789833-1-anurag.mandal@intel.com>
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

Implemented read_clock ethdev operation by adding
iavf_dev_read_clock() feature to get current time
in nanoseconds for scheduling packets based on
transmit time.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V2: Addressed minor typo

 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 24 ++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  | 13 ++++++++++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..416625d9fb 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -533,4 +533,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 bool is_iavf_supported(struct rte_eth_dev *dev);
 void iavf_hash_uninit(struct iavf_adapter *ad);
+int iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index e475b64971..1a36885107 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -165,6 +165,7 @@ static int iavf_set_mc_addr_list(struct rte_eth_dev *dev,
 			struct rte_ether_addr *mc_addrs,
 			uint32_t mc_addrs_num);
 static int iavf_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
+static int iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
 
 static const struct rte_pci_id pci_id_iavf_map[] = {
 	{ RTE_PCI_DEVICE(IAVF_INTEL_VENDOR_ID, IAVF_DEV_ID_ADAPTIVE_VF) },
@@ -264,6 +265,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.tx_done_cleanup	    = iavf_dev_tx_done_cleanup,
 	.get_monitor_addr           = iavf_get_monitor_addr,
 	.tm_ops_get                 = iavf_tm_ops_get,
+	.read_clock                 = iavf_dev_read_clock,
 };
 
 static int
@@ -3662,6 +3664,28 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
 	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
 }
 
+static int
+iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
+{
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	int ret;
+
+	if (adapter->closed)
+		return -EIO;
+
+	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) ||
+	    !(vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_READ_PHC))
+		return -ENOTSUP;
+
+	ret = iavf_phc_get_time(adapter, clock);
+	if (ret != 0)
+		return -EIO;
+
+	return 0;
+}
+
 RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f346837bf1..a63639549c 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -2521,9 +2521,8 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
 }
 
 int
-iavf_get_phc_time(struct ci_rx_queue *rxq)
+iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time)
 {
-	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_phc_time phc_time;
@@ -2543,9 +2542,17 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 			    "Failed to execute command of VIRTCHNL_OP_1588_PTP_GET_TIME");
 		goto out;
 	}
-	rxq->phc_time = ((struct virtchnl_phc_time *)args.out_buffer)->time;
+	*time = ((struct virtchnl_phc_time *)args.out_buffer)->time;
 
 out:
 	rte_spinlock_unlock(&vf->phc_time_aq_lock);
 	return err;
 }
+
+int
+iavf_get_phc_time(struct ci_rx_queue *rxq)
+{
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
+
+	return iavf_phc_get_time(adapter, &rxq->phc_time);
+}
-- 
2.34.1

