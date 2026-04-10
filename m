Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79801F44866
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50E54402E9;
	Fri, 10 Apr 2026 15:13:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 754B6402AF
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826814; x=1807362814;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jfRVJ74I1G3lq9qiLkrsN5uSVejDeBJHM2aojyT6iDQ=;
 b=k4DulegliA3/JN2bg1O40FkhRAhvSHKnDNksIolFjvCheUhA6y3hi+iD
 Ayc/RrzWHV1wPJWsSApQdad19Axo/Pzuj3CK6KPUIR0lmFVJsTsCayEbd
 Pw3KwuDZAabc31ENDGfx1D6bWvMHqPnANyGFzosc/D7NiOZCItI4FT0Dy
 PTGtfQi6WcmA8ZTSjDPOr+AGV/glRpELJHD74PY1DxvfBMP4SiyuefVDP
 UUbtskAYJ+NTyhz3yeTbCbK6mKVP0jbwdnR4BUR8298s2XI70lcp2n4Fw
 fpwyGbeZKbEgdA/4ou3asUMg7+V1YJw+PwdD3BkYHAN5095ilZcX9d2pj A==;
X-CSE-ConnectionGUID: ZLHU+0o9SnytJuCeeczS2w==
X-CSE-MsgGUID: sChNrEhWQ4aZxHvPTQ5AVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736310"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736310"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:33 -0700
X-CSE-ConnectionGUID: nMyvh/T+SMKA61Zi93LafQ==
X-CSE-MsgGUID: hugQTJgrQAKvrSqQMaoo1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084616"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:31 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Mohammad Abdul Awal <mohammad.abdul.awal@intel.com>,
 Remy Horton <remy.horton@intel.com>
Subject: [PATCH v3 01/29] net/ixgbe: fix shared PF pointer in representor
Date: Fri, 10 Apr 2026 14:12:55 +0100
Message-ID: <ae480c5cc953ddd648f83795d2b80d4137496a49.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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
index 57d929cf2c..6f758b802d 100644
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
index 32d7b98ed1..a014dbff10 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -504,7 +504,7 @@ struct ixgbe_adapter {
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

