Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F25C5AE59
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 06:21:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1472402E6;
	Wed, 28 May 2025 08:21:13 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D1AD240279;
 Wed, 28 May 2025 08:21:11 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5qmOD021285;
 Tue, 27 May 2025 23:21:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 N0Vg66pXSZ9gaPV98xH3cbdAe9E5BSNk0ZbHZJ3PEU=; b=Regrwc72tmRSMmexC
 OMKUZdUo7aA9P+gUKhb8VrothyD3BCXbLk5qMLvwbl5pxYYGC/l3k+EiMDRA9SPj
 bY5JSsBCRaDUtjA7QYh/ZKTrxRoXmlZZlFFxs7+SsW53oiNEzcva6tTMyUTZmzMt
 dJhM0TMREWOqb0HPXDkDnPAM3zuvjMeSwSzvtljOWGVTzpFe0FFx7JKYZJkarLH3
 aSw7pQlDHu2m/NOWwNM4JDygidK7HktJe1jrGlwMX3g9OC50Z4HU8k/fuJBpB84R
 HtsoIodPX/VeeKybYbc1sZ7qfv2PprOHFs8zydNUgByqL2qNGFHEeN3Q4ZtoMmrI
 Isk7Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wq820muu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 23:21:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 23:21:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 23:21:09 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 1EA523F7052;
 Tue, 27 May 2025 23:21:06 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 1/1] net/cnxk: mark invalid MAC address if it doesn't exist
Date: Wed, 28 May 2025 11:49:28 +0530
Message-ID: <20250528062104.974392-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409061152.1096849-1-skori@marvell.com>
References: <20250409061152.1096849-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OYFsCb_xLKh3T4-eaaJPQJc3ceu8Y7Qb
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=6836ab56 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=6QUqZH_voJl-rMapK_0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA1NCBTYWx0ZWRfX8RdK7ZhREj9X
 qC+guuCSG5Y7e8/EWnECK7Hl4WrmfZiu7CCLNDJR3KAhUWL0yfoHCnFs8JGcEo9+7FZfr3DJyjt
 qwnzfj2Ucl61uOy453mAE0foxAincwx7Y1JH0L79zJSICPJR8nWWFWbWumErqGWgwZ8ErkN/KSp
 m2vGcWlDzDfapAi8NXuegcHB8lq+SujJkgpP5w+382Ap15D67nZwNs9OeS6XZve31+pQVfzx4GI
 qukx3yIC0YJQCdIYEh+uHnY5Mzrq8FLQ8lk5Tcg75ejAK9lnxkRBzPRn2qUpgZ4ksV1sJkxdSs+
 XcqULeYmLKJRyQPrWXp/T5l+XhO81O4wf4qWp4ZjZOALBFXrWBPasAxVohD6ejCccthJ8Zen4jD
 bjJC+AFkimjmYTmzvJgOh4TbPUBkirkt0lpJbDEhK+CZ2NNN5DYZ8leGwiM7qQB1laF8/CuV
X-Proofpoint-GUID: OYFsCb_xLKh3T4-eaaJPQJc3ceu8Y7Qb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

When user requests to configure a device which is already in
configured state then first device gets resets to default and
then reconfigured with latest parameters.

While resetting the device, MAC address table is left stale which
causes entry update in later state.

Hence marking the MAC address entries as invalid to avoid any error
due to further operation on MAC table.

Fixes: b75e0aca84b0 ("net/cnxk: add device configuration operation")
Cc: stable@dpdk.org

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
v1..v2:
- Instead of restoring the MAC addresses, reset to them as invalid
  during restore process.

 drivers/net/cnxk/cnxk_ethdev.c     | 26 ++++++++++++--
 drivers/net/cnxk/cnxk_ethdev.h     |  3 ++
 drivers/net/cnxk/cnxk_ethdev_ops.c | 57 ++++++++++++++++++++++++++++--
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index b9a0b37425..64d7937be6 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1230,8 +1230,8 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 	uint16_t nb_rxq, nb_txq, nb_cq;
 	struct rte_ether_addr *ea;
 	uint64_t rx_cfg;
+	int rc, i;
 	void *qs;
-	int rc;
 
 	rc = -EINVAL;
 
@@ -1286,6 +1286,12 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		roc_nix_tm_fini(nix);
 		nix_rxchan_cfg_disable(dev);
 		roc_nix_lf_free(nix);
+
+		/* Reset to invalid */
+		for (i = 0; i < dev->max_mac_entries; i++)
+			dev->dmac_idx_map[i] = CNXK_NIX_DMAC_IDX_INVALID;
+
+		dev->dmac_filter_count = 1;
 	}
 
 	dev->rx_offloads = rxmode->offloads;
@@ -1891,7 +1897,7 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
 	struct rte_security_ctx *sec_ctx;
 	struct roc_nix *nix = &dev->nix;
 	struct rte_pci_device *pci_dev;
-	int rc, max_entries;
+	int rc, max_entries, i;
 
 	eth_dev->dev_ops = &cnxk_eth_dev_ops;
 	eth_dev->rx_queue_count = cnxk_nix_rx_queue_count;
@@ -1993,6 +1999,17 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
 		goto free_mac_addrs;
 	}
 
+	dev->dmac_addrs = rte_malloc("dmac_addrs", max_entries * RTE_ETHER_ADDR_LEN, 0);
+	if (dev->dmac_addrs == NULL) {
+		plt_err("Failed to allocate memory for dmac addresses");
+		rc = -ENOMEM;
+		goto free_mac_addrs;
+	}
+
+	/* Reset to invalid */
+	for (i = 0; i < max_entries; i++)
+		dev->dmac_idx_map[i] = CNXK_NIX_DMAC_IDX_INVALID;
+
 	dev->max_mac_entries = max_entries;
 	dev->dmac_filter_count = 1;
 
@@ -2051,6 +2068,8 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
 
 free_mac_addrs:
 	rte_free(eth_dev->data->mac_addrs);
+	rte_free(dev->dmac_addrs);
+	dev->dmac_addrs = NULL;
 	rte_free(dev->dmac_idx_map);
 dev_fini:
 	roc_nix_dev_fini(nix);
@@ -2182,6 +2201,9 @@ cnxk_eth_dev_uninit(struct rte_eth_dev *eth_dev, bool reset)
 	rte_free(dev->dmac_idx_map);
 	dev->dmac_idx_map = NULL;
 
+	rte_free(dev->dmac_addrs);
+	dev->dmac_addrs = NULL;
+
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
 
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index d62cc1ec20..1ced6dd65e 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -106,6 +106,8 @@
 /* Fastpath lookup */
 #define CNXK_NIX_FASTPATH_LOOKUP_MEM "cnxk_nix_fastpath_lookup_mem"
 
+#define CNXK_NIX_DMAC_IDX_INVALID -1
+
 struct cnxk_fc_cfg {
 	enum rte_eth_fc_mode mode;
 	uint8_t rx_pause;
@@ -342,6 +344,7 @@ struct cnxk_eth_dev {
 	uint8_t max_mac_entries;
 	bool dmac_filter_enable;
 	int *dmac_idx_map;
+	struct rte_ether_addr *dmac_addrs;
 
 	uint16_t flags;
 	uint8_t ptype_disable;
diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 9970c5ff5c..abef1a9eaf 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -473,11 +473,20 @@ cnxk_nix_mac_addr_add(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr,
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_nix *nix = &dev->nix;
+	struct rte_ether_addr *current;
 	int rc;
 
-	PLT_SET_USED(index);
 	PLT_SET_USED(pool);
 
+	if (dev->dmac_idx_map[index] != CNXK_NIX_DMAC_IDX_INVALID) {
+		current = &dev->dmac_addrs[index];
+		plt_nix_dbg("Mac address %02x:%02x:%02x:%02x:%02x:%02x already exists at index %u",
+			    current->addr_bytes[0], current->addr_bytes[1], current->addr_bytes[2],
+			    current->addr_bytes[3], current->addr_bytes[4], current->addr_bytes[5],
+			    index);
+		return 0;
+	}
+
 	rc = roc_nix_mac_addr_add(nix, addr->addr_bytes);
 	if (rc < 0) {
 		plt_err("Failed to add mac address, rc=%d", rc);
@@ -485,6 +494,11 @@ cnxk_nix_mac_addr_add(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr,
 	}
 
 	dev->dmac_idx_map[index] = rc;
+	plt_nix_dbg("Added mac address %02x:%02x:%02x:%02x:%02x:%02x at index %u(%d)",
+		    addr->addr_bytes[0], addr->addr_bytes[1], addr->addr_bytes[2],
+		    addr->addr_bytes[3], addr->addr_bytes[4], addr->addr_bytes[5], index, rc);
+
+	memcpy(&dev->dmac_addrs[index], addr, RTE_ETHER_ADDR_LEN);
 
 	/* Enable promiscuous mode at NIX level */
 	roc_nix_npc_promisc_ena_dis(nix, true);
@@ -506,6 +520,8 @@ cnxk_nix_mac_addr_del(struct rte_eth_dev *eth_dev, uint32_t index)
 	if (rc)
 		plt_err("Failed to delete mac address, rc=%d", rc);
 
+	plt_nix_dbg("Deleted mac address at index %u(%d)", index, dev->dmac_idx_map[index]);
+	dev->dmac_idx_map[index] = CNXK_NIX_DMAC_IDX_INVALID;
 	dev->dmac_filter_count--;
 }
 
@@ -1117,6 +1133,23 @@ cnxk_nix_rss_hash_conf_get(struct rte_eth_dev *eth_dev,
 	return 0;
 }
 
+static int
+nix_find_mac_addr(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct rte_ether_addr null_mac_addr;
+	int i;
+
+	memset(&null_mac_addr, 0, sizeof(null_mac_addr));
+	addr = addr ? addr : &null_mac_addr;
+	for (i = 0; i < dev->max_mac_entries; i++) {
+		if (!memcmp(&eth_dev->data->mac_addrs[i], addr, sizeof(*addr)))
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 static inline int
 nix_mc_addr_list_flush(struct rte_eth_dev *eth_dev)
 {
@@ -1138,6 +1171,9 @@ nix_mc_addr_list_flush(struct rte_eth_dev *eth_dev)
 				return rc;
 			}
 
+			plt_nix_dbg("Deleted mac address at index %u(%d)", i, dev->dmac_idx_map[i]);
+
+			dev->dmac_idx_map[i] = CNXK_NIX_DMAC_IDX_INVALID;
 			dev->dmac_filter_count--;
 			/* Update address in NIC data structure */
 			rte_ether_addr_copy(&null_mac_addr,
@@ -1155,7 +1191,7 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev *eth_dev, struct rte_ether_ad
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct rte_eth_dev_data *data = eth_dev->data;
 	struct roc_nix *nix = &dev->nix;
-	int index, mc_addr_cnt = 0;
+	int index, mc_addr_cnt = 0, j;
 	uint32_t i;
 
 	if (!mc_addr_set || !nb_mc_addr)
@@ -1174,8 +1210,15 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev *eth_dev, struct rte_ether_ad
 	}
 	nix_mc_addr_list_flush(eth_dev);
 
+	j = 0;
 	/* Multicast addresses are to be installed */
 	for (i = 0; i < nb_mc_addr; i++) {
+		j = nix_find_mac_addr(eth_dev, NULL);
+		if (j < 0) {
+			plt_err("Failed to find free mac address");
+			return -ENOSPC;
+		}
+
 		index = roc_nix_mac_addr_add(nix, mc_addr_set[i].addr_bytes);
 		if (index < 0) {
 			plt_err("Failed to add mcast mac address, rc=%d",
@@ -1183,9 +1226,17 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev *eth_dev, struct rte_ether_ad
 			return index;
 		}
 
+		dev->dmac_idx_map[j] = index;
+		plt_nix_dbg("Added mac address %02x:%02x:%02x:%02x:%02x:%02x at index %u(%d)",
+			    mc_addr_set[i].addr_bytes[0], mc_addr_set[i].addr_bytes[1],
+			    mc_addr_set[i].addr_bytes[2], mc_addr_set[i].addr_bytes[3],
+			    mc_addr_set[i].addr_bytes[4], mc_addr_set[i].addr_bytes[5], j, index);
+
 		dev->dmac_filter_count++;
 		/* Update address in NIC data structure */
-		rte_ether_addr_copy(&mc_addr_set[i], &data->mac_addrs[index]);
+		rte_ether_addr_copy(&mc_addr_set[i], &data->mac_addrs[j]);
+		rte_ether_addr_copy(&mc_addr_set[i], &dev->dmac_addrs[j]);
+		data->mac_pool_sel[j] = RTE_BIT64(0);
 	}
 
 	roc_nix_npc_promisc_ena_dis(nix, true);
-- 
2.43.0

