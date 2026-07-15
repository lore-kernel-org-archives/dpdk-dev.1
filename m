Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FCC44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 23:40:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A08840289;
	Thu, 16 Jul 2026 01:40:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id E6E56400D5;
 Thu, 16 Jul 2026 01:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784158856; x=1815694856;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UIP0kNKCOB8WQp13vq4YQCWTyhOtIwS1v1xdLUUgXbA=;
 b=ZrwPAHKuI4jE1mLZ2+UdYJZs5enLZrAuf6RbjkkC1pNlHK9vGygbaSyP
 +g6Ju1UmFeHXk1BYvDfU0jROo8J+A7Cxa7/z0K7Pz23jeu+7ejDYI6X3l
 0+CSFWf9GEza+L/DijolJ4OhTYt7rxDvj7m1LoU+uJ1b3VLsM2qndnYtB
 j6DfdKZc3MC5pSPv+gmm0UZSPgwOFilw+ugzZG1lD3CVRkMmv929gyr2e
 qxet78redSe/xK28hQHRuYqcQSiBqccuwNVEw1xRd5mjNvGrf85Ew/HqD
 rnP3ZDcwLBMpgjngZfn6Pmw78+VJ6ZJGgH3RhOCfxTveeIGiESy3dapJy g==;
X-CSE-ConnectionGUID: 10qEhWWkTpGN6WkYGUuLiQ==
X-CSE-MsgGUID: Z4mtPrWzQqaiAQhdcKXqcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110359878"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; d="scan'208";a="110359878"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 16:40:54 -0700
X-CSE-ConnectionGUID: p92EAqcpSJ2LtrMxr91/vA==
X-CSE-MsgGUID: 2Gl+1tMlTVWSR0HYn1OsCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; d="scan'208";a="252922059"
Received: from client-08.iind.intel.com ([10.190.203.152])
 by fmviesa007.fm.intel.com with ESMTP; 15 Jul 2026 16:40:53 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/iavf: fix VLAN offload when inner VLAN is not supported
Date: Wed, 15 Jul 2026 22:52:34 +0000
Message-ID: <20260715225234.482186-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.43.0
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

In Double VLAN mode (DVM) i.e. when RTE_ETH_RX_OFFLOAD_VLAN_EXTEND
is enabled, the single VLAN offloads are programmed on the inner
VLAN (0x8100) engine by iavf_config_vlan_strip_v2() &
iavf_config_vlan_insert_v2().
When the PF/hardware does not advertise inner VLAN offloading
capabilities, these functions return -ENOTSUP.

On the enable path,these -ENOTSUP are trsnalated into -EIO,
which makes device configuration fail.
However, in DVM, with the default outer TPID set as 0x8100,
a single 0x8100 tagged VLAN frame is handled by the outer
VLAN engine, so the missing inner capability is harmless
and should not fail the configuration.

This patch fixes the same by returning success when DVM is
enabled and the outer TPID is 0x8100, so the outer VLAN
engine services the single VLAN.
Changed "qinq" flag from 'int' to 'bool' to address memory
wastage.

Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f8fffa7802..f346837bf1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -920,7 +920,7 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t *ethertype;
-	int qinq = adapter->dev_data->dev_conf.rxmode.offloads &
+	bool qinq = adapter->dev_data->dev_conf.rxmode.offloads &
 		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
 	bool strip_qinq = adapter->dev_data->dev_conf.rxmode.offloads &
 			  RTE_ETH_RX_OFFLOAD_QINQ_STRIP;
@@ -943,7 +943,8 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 		 (stripping_caps->inner & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_strip.inner_ethertype_setting;
 	else
-		return -ENOTSUP;
+		/* Return success for non-inner VLAN supported hardware */
+		return (qinq && adapter->tpid == RTE_ETHER_TYPE_VLAN) ? 0 : -ENOTSUP;
 
 	memset(&vlan_strip, 0, sizeof(vlan_strip));
 	vlan_strip.vport_id = vf->vsi_res->vsi_id;
@@ -1036,7 +1037,8 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_insert.inner_ethertype_setting;
 	else
-		return -ENOTSUP;
+		/* Return success for non-inner VLAN supported hardware */
+		return (qinq && adapter->tpid == RTE_ETHER_TYPE_VLAN) ? 0 : -ENOTSUP;
 
 	memset(&vlan_insert, 0, sizeof(vlan_insert));
 	vlan_insert.vport_id = vf->vsi_res->vsi_id;
@@ -1067,7 +1069,7 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	struct virtchnl_vlan *vlan_setting;
 	struct iavf_cmd_info args;
 	uint32_t filtering_caps;
-	int qinq = adapter->dev_data->dev_conf.rxmode.offloads &
+	bool qinq = adapter->dev_data->dev_conf.rxmode.offloads &
 		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
 	int err;
 
-- 
2.43.0

