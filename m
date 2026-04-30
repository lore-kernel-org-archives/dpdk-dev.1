Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0A0FF886F
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 08:57:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCDBE40285;
	Thu, 30 Apr 2026 10:57:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3CF0040280
 for <dev@dpdk.org>; Thu, 30 Apr 2026 10:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777539430; x=1809075430;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XIdJ3MNdT5oTH+ttlOgA2+nhjYhg9bl5aRs+rAd4x0k=;
 b=lqkilT+zIY354cvxhniVtDutH2O3YTFL9xTrDVBhrA/bd7LTbkcGLuLj
 Z/ncruRMbehhWPJgxIojAmZJeunShib5fsZeJwp0oo6i97OwN0lzSRTDX
 cNwox9LiicBsfVDAmkeQwXUKVKFcjNayL/v2sowBfofPMbw5XARUZTYoz
 St5o1FsbghcIHuVfsRU5xekI6RXj06HxHlrxF38Nn+55kSZyFD6FHDbcY
 vGy93azI4F5qWUhHSnhhBINXEdLbQPNYO76GpMGPju5cmeXGqy29Vmq0v
 p/z5Kzf1uf1jVB2LoOsf/n6jdrzMolmbVx2Brzkkd1reaTBIIv6DjXSWp Q==;
X-CSE-ConnectionGUID: LF56NRPCTzCd2zo9x436bA==
X-CSE-MsgGUID: Qj7W/elaTtWMex6Eyw92sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77649534"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="77649534"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 01:57:09 -0700
X-CSE-ConnectionGUID: M8bmvRjbTlu3r4T8g0Ac8A==
X-CSE-MsgGUID: ecdG5Kv7QkW1t9whClXmjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="233684429"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa010.jf.intel.com with ESMTP; 30 Apr 2026 01:57:06 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/iavf: add support for QinQ insertion
Date: Thu, 30 Apr 2026 08:58:13 +0000
Message-Id: <20260430085813.230798-1-anurag.mandal@intel.com>
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

QinQ insertion with VLAN TPID 0x88a8 support is absent.

This patch adds support for QinQ insertion for both
Outer VLAN TPIDs 0x88a8 (802.1ad) & 0x8100 (802.1Q).
VLAN Extend should be enabled for the same and Outer
VLAN TPID should be set properly for TPID 0x88a8.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/nics/intel_vf.rst        | 19 ++++++++++
 drivers/net/intel/iavf/iavf.h       |  1 +
 drivers/net/intel/iavf/iavf_vchnl.c | 56 +++++++++++++++++++++++++++--
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index dfff69b982..ce11ea6363 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -802,3 +802,22 @@ To start ``testpmd``, and enable QinQ strip for default TPID on port 0:
 
    testpmd> vlan set extend on 0
    testpmd> vlan set qinq_strip on 0
+
+QinQ Configuration
+~~~~~~~~~~~~~~~~~~
+
+When using QinQ Tx offload (``RTE_ETH_TX_OFFLOAD_QINQ_INSERT``),
+you must also enable ``RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``
+to configure the hardware for double VLAN mode.
+Without this, only the inner VLAN tag will be inserted.
+
+Example::
+
+  struct rte_eth_conf port_conf = {
+      .rxmode = {
+          .offloads = RTE_ETH_RX_OFFLOAD_VLAN_EXTEND,
+      },
+      .txmode = {
+          .offloads = RTE_ETH_TX_OFFLOAD_QINQ_INSERT,
+      },
+  };
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 6a77dacf59..0b6ed221d0 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -459,6 +459,7 @@ int iavf_get_supported_rxdid(struct iavf_adapter *adapter);
 int iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
 int iavf_config_outer_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
 int iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
+int iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
 int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
 			 bool add);
 int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter);
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index c2f340db81..6dd7d455ba 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -920,6 +920,51 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	return ret;
 }
 
+int
+iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	struct virtchnl_vlan_supported_caps *insertion_caps;
+	struct virtchnl_vlan_setting vlan_insert;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
+	struct iavf_cmd_info args;
+	uint32_t *ethertype;
+	int ret;
+
+	memset(&vlan_insert, 0, sizeof(vlan_insert));
+	insertion_caps = &vf->vlan_v2_caps.offloads.insertion_support;
+
+	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
+	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
+	    adapter->tpid == RTE_ETHER_TYPE_QINQ) {
+		ethertype = &vlan_insert.outer_ethertype_setting;
+		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_88A8;
+	} else if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+		   (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
+		   adapter->tpid == RTE_ETHER_TYPE_VLAN) {
+		ethertype = &vlan_insert.outer_ethertype_setting;
+		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_8100;
+	} else {
+		return -ENOTSUP;
+	}
+
+	vlan_insert.vport_id = vf->vsi_res->vsi_id;
+
+	args.ops = enable ? VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 :
+			    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2;
+	args.in_args = (uint8_t *)&vlan_insert;
+	args.in_args_size = sizeof(vlan_insert);
+	args.out_buffer = msg_buf;
+	args.out_size = IAVF_AQ_BUF_SZ;
+	ret = iavf_execute_vf_cmd_safe(adapter, &args);
+	if (ret)
+		PMD_DRV_LOG(ERR, "fail to execute command %s",
+			    enable ? "VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2" :
+				     "VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2");
+
+	return ret;
+}
+
 int
 iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 {
@@ -929,14 +974,21 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t *ethertype;
+	bool qinq = adapter->dev_data->dev_conf.rxmode.offloads &
+		    RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
+	bool insert_qinq = adapter->dev_data->dev_conf.txmode.offloads &
+			   RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
 	int ret;
 
+	if (qinq && insert_qinq)
+		iavf_config_outer_vlan_insert_v2(adapter, enable);
+
 	insertion_caps = &vf->vlan_v2_caps.offloads.insertion_support;
 
-	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+	if (!qinq && (insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_insert.outer_ethertype_setting;
-	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+	else if (qinq && (insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_insert.inner_ethertype_setting;
 	else
-- 
2.34.1

