Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1BBEA3C23
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 10:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5DA7402D3;
	Thu,  9 Apr 2026 12:18:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B158C4028F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 12:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775729925; x=1807265925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uGfGsCMVJyHsXt5EmukSQKMzOpViXoq0fnoNhyVfDFE=;
 b=LIBaqN8eGuPE09M2al0BZifjMa9Nj0B5IU+W3nYoSu1xcFDfFyF0FX5t
 Q+cs+ySivMSAtAqUV+txUXt8oin4basIr6SivwkcLsP2+qUsCjrKhXAVm
 DW+16Dvbxh73C7TgXiKY+ZarerpsSEpaWfIKWfIYf5lqWTgfs6aUl2KZX
 atjZpGX/24eETfsQBChqL56hMQxEGo08VhAbX5Fy87ANLzXNMBvO4kyuk
 Ian6xQMt5XYGnCuOjuXK+bP2r4hSAEj6Uc/I3sWb3zMhIrulYEK0IH8ft
 2O1w/lrhxyKMJ/31KsGzPdM9rPdEc96vvCjQEFF2tlRsCPbdn6LYEIFaF Q==;
X-CSE-ConnectionGUID: xs5X8ThfT5qfI0kia8+0aA==
X-CSE-MsgGUID: izejxnbDQq2yM81psUl+kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76449444"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76449444"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 03:18:43 -0700
X-CSE-ConnectionGUID: SHYh5YsNStyi4IW5CJpjOA==
X-CSE-MsgGUID: FS3EdRjYQM23XU1Oo7WZMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="228659979"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa008.jf.intel.com with ESMTP; 09 Apr 2026 03:18:42 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v4] net/iavf: add support for QinQ strip
Date: Thu,  9 Apr 2026 10:19:51 +0000
Message-Id: <20260409101951.114492-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216103710.195777-1-anurag.mandal@intel.com>
References: <20260216103710.195777-1-anurag.mandal@intel.com>
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

QinQ strip with VLAN TPID 0x88a8 & 0x8100 support was absent.

This patch adds support for QinQ strip with both Outer VLAN
TPIDs 0x88a8 (802.1ad) & 0x8100 (802.1Q).
VLAN Extend should be enabled for the same and Outer VLAN
TPID should be set properly.

1. Tested QinQ stripping with TPIDs 0x88a8 as well as 0x8100.
2. Tested Double VLAN stripping i.e. QinQ (802.1ad/802.1Q) &
   VLAN (802.1Q) stripping simultaneously.
3. Tested Single VLAN (802.1Q) stripping.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V4: Addressed ai-code-review suggestions
V3: Rebased onto next-net-intel-for-next-net
V2: Addressed Coding Style Warnings

 doc/guides/nics/intel_vf.rst         | 31 ++++++++++++++
 drivers/net/intel/iavf/iavf.h        |  2 +
 drivers/net/intel/iavf/iavf_ethdev.c | 50 +++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  | 61 ++++++++++++++++++++++++++--
 4 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 5fa2ddc9ea..dfff69b982 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -771,3 +771,34 @@ the VLAN header tag length will be automatically added to MTU when configuring q
 As a consequence, when attempting to configure a VF port with MTU that,
 together with a VLAN tag header, exceeds maximum supported MTU,
 port configuration will fail if kernel driver has configured VLAN filtering on that VF.
+
+QinQ strip
+~~~~~~~~~~
+
+QinQ TPID is set as 0x8100 IEEE 802.1Q by default.
+For QinQ strip with TPID 0x88A8 IEEE 802.1ad,
+extend VLAN is enabled and VLAN outer TPID is set to 0x88A8.
+VLAN filter steps can be added before or after.
+
+To start ``testpmd``, and enable QinQ strip for TPID 0x88A8 on port 0:
+
+.. code-block:: console
+
+   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
+   ...
+
+   testpmd> vlan set extend on 0
+   testpmd> vlan set outer tpid 0x88A8 0
+   testpmd> vlan set qinq_strip on 0
+
+For QinQ strip with TPID 0x8100, extend VLAN is enabled only.
+
+To start ``testpmd``, and enable QinQ strip for default TPID on port 0:
+
+.. code-block:: console
+
+   ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
+   ...
+
+   testpmd> vlan set extend on 0
+   testpmd> vlan set qinq_strip on 0
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index f8008d0fda..6a77dacf59 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -387,6 +387,7 @@ struct iavf_adapter {
 	uint16_t fdir_ref_cnt;
 	struct iavf_devargs devargs;
 	bool mac_primary_set;
+	uint16_t tpid;  /* VLAN tag identifier */
 };
 
 /* IAVF_DEV_PRIVATE_TO */
@@ -456,6 +457,7 @@ int iavf_configure_rss_key(struct iavf_adapter *adapter);
 int iavf_configure_queues(struct iavf_adapter *adapter, uint16_t num_queue_pairs);
 int iavf_get_supported_rxdid(struct iavf_adapter *adapter);
 int iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
+int iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
 int iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
 int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
 			 bool add);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 3126d9b644..5da2cd43c2 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -127,6 +127,8 @@ static int iavf_dev_add_mac_addr(struct rte_eth_dev *dev,
 static void iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index);
 static int iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
 				   uint16_t vlan_id, int on);
+static int iavf_vlan_tpid_set(struct rte_eth_dev *dev,
+			     enum rte_vlan_type vlan_type, uint16_t tpid);
 static int iavf_dev_vlan_offload_set(struct rte_eth_dev *dev, int mask);
 static int iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
 				   struct rte_eth_rss_reta_entry64 *reta_conf,
@@ -226,6 +228,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.mac_addr_remove            = iavf_dev_del_mac_addr,
 	.set_mc_addr_list			= iavf_set_mc_addr_list,
 	.vlan_filter_set            = iavf_dev_vlan_filter_set,
+	.vlan_tpid_set              = iavf_vlan_tpid_set,
 	.vlan_offload_set           = iavf_dev_vlan_offload_set,
 	.rx_queue_start             = iavf_dev_rx_queue_start,
 	.rx_queue_stop              = iavf_dev_rx_queue_stop,
@@ -1365,6 +1368,36 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint32_t index)
 	vf->mac_num--;
 }
 
+static int
+iavf_vlan_tpid_set(struct rte_eth_dev *dev, enum rte_vlan_type vlan_type, uint16_t tpid)
+{
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	int qinq = dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
+
+	if (vlan_type != RTE_ETH_VLAN_TYPE_OUTER) {
+		PMD_DRV_LOG(ERR, "Unsupported vlan type.");
+		return -EINVAL;
+	} else if (!qinq) {
+		PMD_DRV_LOG(ERR, "VLAN-extend disabled.");
+		return -ENOSYS;
+	} else if (tpid != RTE_ETHER_TYPE_VLAN &&
+		   tpid != RTE_ETHER_TYPE_QINQ) {
+		PMD_DRV_LOG(ERR, "tpid supported 0x8100/0x88A8");
+		return -ENOTSUP;
+	}
+
+	/* This API only fills internal iavf_adapter structure
+	 * and does not send any signal to hardware.
+	 * Inner VLAN always 0x8100, so not set explicitly.
+	 */
+	if (qinq && vlan_type == RTE_ETH_VLAN_TYPE_OUTER)
+		adapter->tpid = tpid; /* Outer VLAN can be 0x88a8 or 0x8100 */
+
+	return 0;
+}
+
 static int
 iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
 {
@@ -1453,6 +1486,8 @@ iavf_dev_vlan_offload_set_v2(struct rte_eth_dev *dev, int mask)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	bool enable;
+	int qinq = dev->data->dev_conf.rxmode.offloads &
+		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
 	int err;
 
 	if (mask & RTE_ETH_VLAN_FILTER_MASK) {
@@ -1472,6 +1507,20 @@ iavf_dev_vlan_offload_set_v2(struct rte_eth_dev *dev, int mask)
 			return -EIO;
 	}
 
+	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
+		if (!qinq) {
+			PMD_DRV_LOG(ERR, "VLAN-extend disabled");
+			return -ENOSYS;
+		}
+		enable = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP);
+		err = iavf_config_outer_vlan_strip_v2(adapter, enable);
+		/* If not support, the stripping is already disabled by PF */
+		if (err == -ENOTSUP && !enable)
+			err = 0;
+		if (err)
+			return -EIO;
+	}
+
 	return 0;
 }
 
@@ -2812,6 +2861,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	adapter->dev_data = eth_dev->data;
 	adapter->stopped = 1;
 	adapter->mac_primary_set = false;
+	adapter->tpid = RTE_ETHER_TYPE_VLAN; /* VLAN TPID set to 0x8100 by default */
 
 	if (iavf_dev_event_handler_init())
 		goto init_vf_err;
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 23d115298c..c2f340db81 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -829,6 +829,50 @@ iavf_get_supported_rxdid(struct iavf_adapter *adapter)
 	return 0;
 }
 
+int
+iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	struct virtchnl_vlan_supported_caps *stripping_caps;
+	struct virtchnl_vlan_setting vlan_strip;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
+	struct iavf_cmd_info args;
+	uint32_t *ethertype;
+	int ret;
+
+	memset(&vlan_strip, 0, sizeof(vlan_strip));
+	stripping_caps = &vf->vlan_v2_caps.offloads.stripping_support;
+	if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
+	    (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
+	    adapter->tpid == RTE_ETHER_TYPE_QINQ) {
+		ethertype = &vlan_strip.outer_ethertype_setting;
+		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_88A8;
+	} else if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+		   (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
+		   adapter->tpid == RTE_ETHER_TYPE_VLAN) {
+		ethertype = &vlan_strip.outer_ethertype_setting;
+		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_8100;
+	} else {
+		return -ENOTSUP;
+	}
+
+	vlan_strip.vport_id = vf->vsi_res->vsi_id;
+
+	args.ops = enable ? VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2 :
+			    VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2;
+	args.in_args = (uint8_t *)&vlan_strip;
+	args.in_args_size = sizeof(vlan_strip);
+	args.out_buffer = msg_buf;
+	args.out_size = IAVF_AQ_BUF_SZ;
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
+	if (ret)
+		PMD_DRV_LOG(ERR, "fail to execute command %s",
+			    enable ? "VIRTCHNL_OP_ENABLE_VLAN_STRIPPING_V2" :
+				     "VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2");
+
+	return ret;
+}
+
 int
 iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 {
@@ -838,14 +882,20 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t *ethertype;
+	int qinq = adapter->dev_data->dev_conf.rxmode.offloads &
+		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
 	int ret;
 
 	stripping_caps = &vf->vlan_v2_caps.offloads.stripping_support;
 
-	if ((stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+	/* When VLAN extend is disabled, Single VLAN mode which is Outer VLAN
+	 * When VLAN extend is enabled, QinQ mode, this API works only on
+	 * Inner VLAN strip which is always 0x8100.
+	 */
+	if (!qinq && (stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 	    (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_strip.outer_ethertype_setting;
-	else if ((stripping_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+	else if (qinq && (stripping_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 		 (stripping_caps->inner & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_strip.inner_ethertype_setting;
 	else
@@ -921,6 +971,8 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	struct virtchnl_vlan *vlan_setting;
 	struct iavf_cmd_info args;
 	uint32_t filtering_caps;
+	int qinq = adapter->dev_data->dev_conf.rxmode.offloads &
+		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
 	int err;
 
 	supported_caps = &vf->vlan_v2_caps.filtering.filtering_support;
@@ -938,7 +990,10 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	memset(&vlan_filter, 0, sizeof(vlan_filter));
 	vlan_filter.vport_id = vf->vsi_res->vsi_id;
 	vlan_filter.num_elements = 1;
-	vlan_setting->tpid = RTE_ETHER_TYPE_VLAN;
+	if (qinq && adapter->tpid == RTE_ETHER_TYPE_QINQ)
+		vlan_setting->tpid = RTE_ETHER_TYPE_QINQ;
+	else
+		vlan_setting->tpid = RTE_ETHER_TYPE_VLAN;
 	vlan_setting->tci = vlanid;
 
 	args.ops = add ? VIRTCHNL_OP_ADD_VLAN_V2 : VIRTCHNL_OP_DEL_VLAN_V2;
-- 
2.34.1

