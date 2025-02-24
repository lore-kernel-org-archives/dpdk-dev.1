Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D18DC021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D3C940E03;
	Mon, 24 Feb 2025 10:41:28 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 24C3340A8A
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:41:25 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O515Gs009516
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:41:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 VVJwN0ApKnhXHwmtC5uT5XHWTST64zqSgxKuyDYhLc=; b=GN/fohZUgLGN+YbPw
 Lhn0HPhKRkT5HDbASf3SGOJ7xivcNy1g8mmV2k3yIdHscVFRBSV4Ktrkx2NNdoax
 ognQLUB1rgHS2gTtz42NXGZXfuaIcK+6lFVUU6mDoA5euiL+9GQvpuiZBhuhRU9t
 nKzIUIsR0d5hT6Vuiyzbx4liC9UEP0pQxePyfYmZYI5qN9n2fTJrbHCjIc7VxiWc
 HtxBHTh5G7Vw9HTQhnB2efrpbEaDuhebelOBRz9McRRY/wG5qq+qs0+cXjjVQNBX
 CzeZlfU6MOFxw5PMErxkI4dAXO5kiu8WkL9gyk4NItaJompHeqEhCdGafDbVwNtY
 0hHPw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbspv8-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:41:24 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:41:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:41:00 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 5692F3F7067;
 Mon, 24 Feb 2025 01:40:58 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 32/33] net/cnxk: update MC address list configure API
Date: Mon, 24 Feb 2025 15:09:14 +0530
Message-ID: <20250224093915.1253215-32-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sFPvfG3he4gdyDzWOE8zjx95Eig76cfy
X-Proofpoint-ORIG-GUID: sFPvfG3he4gdyDzWOE8zjx95Eig76cfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Satha Rao <skoteshwar@marvell.com>

Return -ENOSPC when there is no space to update the complete MC address
list, without flushing the existing list of addresses.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev_ops.c | 32 ++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 5b0948e07a..9970c5ff5c 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -1117,17 +1117,14 @@ cnxk_nix_rss_hash_conf_get(struct rte_eth_dev *eth_dev,
 	return 0;
 }
 
-int
-cnxk_nix_mc_addr_list_configure(struct rte_eth_dev *eth_dev,
-				struct rte_ether_addr *mc_addr_set,
-				uint32_t nb_mc_addr)
+static inline int
+nix_mc_addr_list_flush(struct rte_eth_dev *eth_dev)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct rte_eth_dev_data *data = eth_dev->data;
 	struct rte_ether_addr null_mac_addr;
 	struct roc_nix *nix = &dev->nix;
-	int rc, index;
-	uint32_t i;
+	int i, rc = 0;
 
 	memset(&null_mac_addr, 0, sizeof(null_mac_addr));
 
@@ -1148,15 +1145,34 @@ cnxk_nix_mc_addr_list_configure(struct rte_eth_dev *eth_dev,
 		}
 	}
 
+	return rc;
+}
+
+int
+cnxk_nix_mc_addr_list_configure(struct rte_eth_dev *eth_dev, struct rte_ether_addr *mc_addr_set,
+				uint32_t nb_mc_addr)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct roc_nix *nix = &dev->nix;
+	int index, mc_addr_cnt = 0;
+	uint32_t i;
+
 	if (!mc_addr_set || !nb_mc_addr)
-		return 0;
+		return nix_mc_addr_list_flush(eth_dev);
+
+	/* Count multicast MAC addresses in list */
+	for (i = 0; i < dev->max_mac_entries; i++)
+		if (rte_is_multicast_ether_addr(&data->mac_addrs[i]))
+			mc_addr_cnt++;
 
 	/* Check for available space */
 	if (nb_mc_addr >
-	    ((uint32_t)(dev->max_mac_entries - dev->dmac_filter_count))) {
+	    ((uint32_t)(dev->max_mac_entries - (dev->dmac_filter_count - mc_addr_cnt)))) {
 		plt_err("No space is available to add multicast filters");
 		return -ENOSPC;
 	}
+	nix_mc_addr_list_flush(eth_dev);
 
 	/* Multicast addresses are to be installed */
 	for (i = 0; i < nb_mc_addr; i++) {
-- 
2.34.1

