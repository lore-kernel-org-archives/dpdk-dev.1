Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F18FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18E8C4066C;
	Thu, 30 Apr 2026 13:14:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E6A5D40672
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547694; x=1809083694;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xl69y8O74XQzBTvCuA4Sf6NHHd+haJ3QZt710NaQqF0=;
 b=kV8edwn4WQrs6BO6zMml3Nt7mtzc2xocOwD5euLQ7dLjpt6BnA3iJeR7
 NhARdNCYGok//K1p97hUODhwdQdthO00sOFTe/HEG+ikAymT3I/hweLFb
 pTGqzRKfZw1EUsd2S6+7mG1HGsbPhvW1QWNXEq1TaAPzj/4Idm6dh21Yk
 mqpnfvSAcZt79XLsi9Xp89JPAdoOlBHk6bNXDiXknE+nX8isY/h4OWjb1
 q72OlpGi+EZQY4hyCnyf6g3uFzuQt/rUhMuMgtNdaKlbfNIahBX4LqWpb
 wLMMR6ucTJ2+x5ruYJpk+0ObT8bHEd7jSRdLoM+rhhb+4gGMNcHk6CFrS w==;
X-CSE-ConnectionGUID: IZ3FE/hXQJ6ThrQ5wcbAPw==
X-CSE-MsgGUID: 3EEZlgIYTA65aA997irlpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482262"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482262"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:14:53 -0700
X-CSE-ConnectionGUID: Nu9Tn3M4TDq17IRreSYGPQ==
X-CSE-MsgGUID: fJtkcORoRZG+AP/miSXBVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444698"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:14:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Mohammad Abdul Awal <mohammad.abdul.awal@intel.com>,
 Remy Horton <remy.horton@intel.com>
Subject: [PATCH v1 02/15] net/ixgbe: fix shared PF pointer in representor
Date: Thu, 30 Apr 2026 12:14:31 +0100
Message-ID: <0c5f728bca3ffa05b0077559ae2fdfa5b4edd497.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
References: 
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

Currently, ixgbe representor private data stores a PF ethdev pointer.
That pointer is process local, but it is stored in shared memory, so a
secondary process can read an invalid pointer value.

Fix this by storing PF port id in representor private data and resolving
PF ethdev from rte_eth_devices[] in each process. Return -ENODEV when the
PF port is not valid.

This is not technically a bug in practice as using `rte_flow` from
secondary processes isn't supported, but we still shouldn't do that.

Fixes: cf80ba6e2038 ("net/ixgbe: add support for representor ports")
Cc: declan.doherty@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  2 +-
 .../net/intel/ixgbe/ixgbe_vf_representor.c    | 63 ++++++++++++++-----
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 9454cbee0a..5c95507d60 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1818,7 +1818,7 @@ eth_ixgbe_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 
 		representor.vf_id = eth_da.representor_ports[i];
 		representor.switch_domain_id = vfinfo->switch_domain_id;
-		representor.pf_ethdev = pf_ethdev;
+		representor.pf_port_id = pf_ethdev->data->port_id;
 
 		/* representor port net_bdf_port */
 		snprintf(name, sizeof(name), "net_%s_representor_%d",
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 38d476d309..1293ea49cb 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -518,7 +518,7 @@ struct ixgbe_adapter {
 struct ixgbe_vf_representor {
 	uint16_t vf_id;
 	uint16_t switch_domain_id;
-	struct rte_eth_dev *pf_ethdev;
+	uint16_t pf_port_id;
 };
 
 int ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params);
diff --git a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
index 901d80e406..52b43530c0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
+++ b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
@@ -13,14 +13,27 @@
 #include "ixgbe_rxtx.h"
 #include "rte_pmd_ixgbe.h"
 
+static struct rte_eth_dev *
+ixgbe_vf_representor_pf_get(const struct ixgbe_vf_representor *representor)
+{
+	if (!rte_eth_dev_is_valid_port(representor->pf_port_id))
+		return NULL;
+
+	return &rte_eth_devices[representor->pf_port_id];
+}
+
 
 static int
 ixgbe_vf_representor_link_update(struct rte_eth_dev *ethdev,
 	int wait_to_complete)
 {
 	struct ixgbe_vf_representor *representor = ethdev->data->dev_private;
+	struct rte_eth_dev *pf_ethdev = ixgbe_vf_representor_pf_get(representor);
 
-	return ixgbe_dev_link_update_share(representor->pf_ethdev,
+	if (pf_ethdev == NULL)
+		return -ENODEV;
+
+	return ixgbe_dev_link_update_share(pf_ethdev,
 		wait_to_complete, 0);
 }
 
@@ -29,9 +42,13 @@ ixgbe_vf_representor_mac_addr_set(struct rte_eth_dev *ethdev,
 	struct rte_ether_addr *mac_addr)
 {
 	struct ixgbe_vf_representor *representor = ethdev->data->dev_private;
+	struct rte_eth_dev *pf_ethdev = ixgbe_vf_representor_pf_get(representor);
+
+	if (pf_ethdev == NULL)
+		return -ENODEV;
 
 	return rte_pmd_ixgbe_set_vf_mac_addr(
-		representor->pf_ethdev->data->port_id,
+		pf_ethdev->data->port_id,
 		representor->vf_id, mac_addr);
 }
 
@@ -40,11 +57,14 @@ ixgbe_vf_representor_dev_infos_get(struct rte_eth_dev *ethdev,
 	struct rte_eth_dev_info *dev_info)
 {
 	struct ixgbe_vf_representor *representor = ethdev->data->dev_private;
+	struct rte_eth_dev *pf_ethdev = ixgbe_vf_representor_pf_get(representor);
 
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(
-		representor->pf_ethdev->data->dev_private);
+	if (pf_ethdev == NULL)
+		return -ENODEV;
 
-	dev_info->device = representor->pf_ethdev->device;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(pf_ethdev->data->dev_private);
+
+	dev_info->device = pf_ethdev->device;
 
 	dev_info->min_rx_bufsize = 1024;
 	/**< Minimum size of RX buffer. */
@@ -70,11 +90,11 @@ ixgbe_vf_representor_dev_infos_get(struct rte_eth_dev *ethdev,
 	/**< Device TX offload capabilities. */
 
 	dev_info->speed_capa =
-		representor->pf_ethdev->data->dev_link.link_speed;
+		pf_ethdev->data->dev_link.link_speed;
 	/**< Supported speeds bitmap (RTE_ETH_LINK_SPEED_). */
 
 	dev_info->switch_info.name =
-		representor->pf_ethdev->device->name;
+		pf_ethdev->device->name;
 	dev_info->switch_info.domain_id = representor->switch_domain_id;
 	dev_info->switch_info.port_id = representor->vf_id;
 
@@ -123,10 +143,14 @@ ixgbe_vf_representor_vlan_filter_set(struct rte_eth_dev *ethdev,
 	uint16_t vlan_id, int on)
 {
 	struct ixgbe_vf_representor *representor = ethdev->data->dev_private;
+	struct rte_eth_dev *pf_ethdev = ixgbe_vf_representor_pf_get(representor);
 	uint64_t vf_mask = 1ULL << representor->vf_id;
 
+	if (pf_ethdev == NULL)
+		return -ENODEV;
+
 	return rte_pmd_ixgbe_set_vf_vlan_filter(
-		representor->pf_ethdev->data->port_id, vlan_id, vf_mask, on);
+		pf_ethdev->data->port_id, vlan_id, vf_mask, on);
 }
 
 static void
@@ -134,8 +158,12 @@ ixgbe_vf_representor_vlan_strip_queue_set(struct rte_eth_dev *ethdev,
 	__rte_unused uint16_t rx_queue_id, int on)
 {
 	struct ixgbe_vf_representor *representor = ethdev->data->dev_private;
+	struct rte_eth_dev *pf_ethdev = ixgbe_vf_representor_pf_get(representor);
 
-	rte_pmd_ixgbe_set_vf_vlan_stripq(representor->pf_ethdev->data->port_id,
+	if (pf_ethdev == NULL)
+		return;
+
+	rte_pmd_ixgbe_set_vf_vlan_stripq(pf_ethdev->data->port_id,
 		representor->vf_id, on);
 }
 
@@ -175,6 +203,7 @@ int
 ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params)
 {
 	struct ixgbe_vf_representor *representor = ethdev->data->dev_private;
+	struct rte_eth_dev *pf_ethdev;
 
 	struct ixgbe_vf_info *vf_data;
 	struct rte_pci_device *pci_dev;
@@ -187,17 +216,21 @@ ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params)
 		((struct ixgbe_vf_representor *)init_params)->vf_id;
 	representor->switch_domain_id =
 		((struct ixgbe_vf_representor *)init_params)->switch_domain_id;
-	representor->pf_ethdev =
-		((struct ixgbe_vf_representor *)init_params)->pf_ethdev;
+	representor->pf_port_id =
+		((struct ixgbe_vf_representor *)init_params)->pf_port_id;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(representor->pf_ethdev);
+	pf_ethdev = ixgbe_vf_representor_pf_get(representor);
+	if (pf_ethdev == NULL)
+		return -ENODEV;
+
+	pci_dev = RTE_ETH_DEV_TO_PCI(pf_ethdev);
 
 	if (representor->vf_id >= pci_dev->max_vfs)
 		return -ENODEV;
 
 	ethdev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
 	ethdev->data->representor_id = representor->vf_id;
-	ethdev->data->backer_port_id = representor->pf_ethdev->data->port_id;
+	ethdev->data->backer_port_id = pf_ethdev->data->port_id;
 
 	/* Set representor device ops */
 	ethdev->dev_ops = &ixgbe_vf_representor_dev_ops;
@@ -214,13 +247,13 @@ ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params)
 
 	/* Reference VF mac address from PF data structure */
 	vf_data = *IXGBE_DEV_PRIVATE_TO_P_VFDATA(
-		representor->pf_ethdev->data->dev_private);
+		pf_ethdev->data->dev_private);
 
 	ethdev->data->mac_addrs = (struct rte_ether_addr *)
 		vf_data[representor->vf_id].vf_mac_addresses;
 
 	/* Link state. Inherited from PF */
-	link = &representor->pf_ethdev->data->dev_link;
+	link = &pf_ethdev->data->dev_link;
 
 	ethdev->data->dev_link.link_speed = link->link_speed;
 	ethdev->data->dev_link.link_duplex = link->link_duplex;
-- 
2.47.3

