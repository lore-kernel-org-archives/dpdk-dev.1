Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C3CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 04:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A46640431;
	Tue, 16 Jun 2026 06:35:50 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E1E3340431
 for <dev@dpdk.org>; Tue, 16 Jun 2026 06:35:48 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0UQf21258264 for <dev@dpdk.org>; Mon, 15 Jun 2026 21:35:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 gsTOYQJO79qIEODX6DIQWj0vqbSGEcYAsfLFrC3H2M=; b=jVsAJeBQ1fj+XQTTg
 wgmlGAPSktQnZ2Y37Aw3S7f3wKC5FbW7xHoouVyy9KOxAuXu6MUIzpE782hXT8kT
 D777bB9Cg4NE5JY8e+R0UZLERNENxSv2YapjloDPhIcAS+nn8uBGm6efdz1SI7OX
 WeZSa5UhnBBEXCaXVexWUrFVztlYGD3lrOqAWsxgh7MinsPToft9m+yAanESTtdc
 nfj2NOQkwKuw2J0igMUoNh0vg3zKGYPQIaVJKTBnFtai5fAeYv+jFnqYmvvMiP6W
 2GfOD8JpzhD+NyWaE0n9DG8NVDUjJ3ecRd/1Cyre9jnJ4h6dwvKsQmK0qBissCk2
 keHYA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf8y9f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 21:35:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 21:35:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 21:35:47 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 76ADF3F7087;
 Mon, 15 Jun 2026 21:35:44 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 2/2] net/cnxk: add FEC get set and capability ops
Date: Tue, 16 Jun 2026 10:05:36 +0530
Message-ID: <20260616043536.4034946-2-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616043536.4034946-1-rkudurumalla@marvell.com>
References: <20260416120031.3553798-2-rkudurumalla@marvell.com>
 <20260616043536.4034946-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA0MiBTYWx0ZWRfX9hkZ4bfwPmC6
 sRfR7KQrTaCkpYJQu4XSM14PL/Eh1Y5mPzhbr0EUDKvhbSSGXCVR+24Rrms08tyfelsH/NSMDTZ
 upoDGdKTsEdI6Mh4bDwXSqvegd+vHQd3f3uQWsoa0ANZL76zTOTAf1L95+CaHsM3EV1WgkCtznl
 MNAjUE+xQIus9yBtjkRxEUlMg39fwMGP4UdEs3COZ2S54+7JUAJ9GJeBCIOVkCTiP/OvTv65eFj
 0P5iuxPRKawRjGZiyLFVdt4rmKnG/PGUEm4CcaAn58nWsRBbGwYu8GmwUMWzi8J002ku4Lx1yrM
 Fu98WHw0TDyF0FrPa2aa8b3Nzukk6NtC0+yVc98kYqCMiTWyHNsPY06Rc/nQFhc+upAYNEh768/
 05/z4fNlGBp2QFAIOaG4vC1VzUg8wGkPA1iOuEG877+ve+F1+4K2vv9BszPC1LaJURXMsn9vyER
 GGXxVqjNqfjSs2ORQfg==
X-Proofpoint-ORIG-GUID: x65ty4dICG-lT0N4mU6BjNywHLYieEbx
X-Proofpoint-GUID: x65ty4dICG-lT0N4mU6BjNywHLYieEbx
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a30d2a3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=a0hV255zRWZus3TyfywA:9
 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA0MiBTYWx0ZWRfX5cRud+tZD1Zh
 BTxGQ6CaFU6uY02oM+0GcFYqnDOQNdSxeTgfBwcivawfU3wGOtLY9n4jqsmnmKgkr1Pn7c31T5A
 lSjvZPTUGhScXsbz+NvciniQ8uZquPY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
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

Add ethdev FEC operations for cnxk NIX driver:
- fec_get_capability: Report supported FEC modes per speed.
  If firmware provides supported FEC info, return actual
  capabilities for current link speed. Otherwise, fall back
  to a default capability table for common speeds.
- fec_get: Query current FEC mode from link info
- fec_set: Configure FEC mode on the link. AUTO mode
  defaults to Reed-Solomon FEC.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 doc/guides/nics/cnxk.rst           | 45 ++++++++++++++
 doc/guides/nics/features/cnxk.ini  |  1 +
 drivers/net/cnxk/cnxk_ethdev.c     |  3 +
 drivers/net/cnxk/cnxk_ethdev.h     |  6 ++
 drivers/net/cnxk/cnxk_ethdev_ops.c | 94 ++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index b5bd50ceea..0891767f83 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -29,6 +29,7 @@ Features of the CNXK Ethdev PMD are:
 - Port hardware statistics
 - Link state information
 - Link flow control
+- Forward Error Correction (FEC)
 - MTU update
 - Scatter-Gather IO support
 - Vector Poll mode driver
@@ -513,6 +514,50 @@ Runtime Config Options
    parameters to all the PCIe devices if application requires to configure on
    all the ethdev ports.
 
+Forward Error Correction (FEC)
+------------------------------
+
+The CNXK PMD supports the DPDK FEC ethdev APIs on physical function (PF) ports
+for links where firmware reports FEC support (typically high-speed Ethernet
+interfaces such as 25G, 50G and 100G).
+
+Supported FEC modes exposed through the ethdev API are:
+
+- ``RTE_ETH_FEC_NOFEC``: FEC disabled
+- ``RTE_ETH_FEC_AUTO``: maps to Reed-Solomon (RS) FEC on set
+- ``RTE_ETH_FEC_BASER``: Base-R FEC
+- ``RTE_ETH_FEC_RS``: Reed-Solomon FEC
+
+``rte_eth_fec_get_capability()`` reports the FEC modes supported by firmware for
+the current link speed. ``rte_eth_fec_get()`` returns the active FEC mode from
+link information. ``rte_eth_fec_set()`` configures the FEC mode on the link.
+
+.. note::
+
+   ``rte_eth_fec_get_capability()`` and ``rte_eth_fec_set()`` are supported on
+   PF ports only. SR-IOV virtual function (VF) ports can use
+   ``rte_eth_fec_get()`` to read the current FEC mode from link status.
+
+Example usage:
+
+.. code-block:: c
+
+   struct rte_eth_fec_capa capa[1];
+   uint32_t fec_capa;
+   int num, ret;
+
+   num = rte_eth_fec_get_capability(port_id, capa, RTE_DIM(capa));
+   if (num > 0)
+       printf("FEC capa 0x%x at speed %u\n", capa[0].capa, capa[0].speed);
+
+   ret = rte_eth_fec_get(port_id, &fec_capa);
+   if (ret == 0)
+       printf("Current FEC capa 0x%x\n", fec_capa);
+
+   ret = rte_eth_fec_set(port_id, RTE_ETH_FEC_MODE_CAPA_MASK(RS));
+   if (ret)
+       printf("FEC set failed: %s\n", rte_strerror(-ret));
+
 Limitations
 -----------
 
diff --git a/doc/guides/nics/features/cnxk.ini b/doc/guides/nics/features/cnxk.ini
index 2de156c695..dc75947d86 100644
--- a/doc/guides/nics/features/cnxk.ini
+++ b/doc/guides/nics/features/cnxk.ini
@@ -31,6 +31,7 @@ Congestion management = Y
 Traffic manager      = Y
 Inline protocol      = Y
 Flow control         = Y
+FEC                  = Y
 Scattered Rx         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 7ae16186c6..4c3d906e16 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2138,6 +2138,9 @@ struct eth_dev_ops cnxk_eth_dev_ops = {
 	.cman_config_set = cnxk_nix_cman_config_set,
 	.cman_config_get = cnxk_nix_cman_config_get,
 	.eth_tx_descriptor_dump = cnxk_nix_tx_descriptor_dump,
+	.fec_get_capability = cnxk_nix_fec_get_capability,
+	.fec_get = cnxk_nix_fec_get,
+	.fec_set = cnxk_nix_fec_set,
 };
 
 void
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index ea6a2be30e..4a8fb1b974 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -664,6 +664,12 @@ int cnxk_nix_tm_mark_ip_dscp(struct rte_eth_dev *eth_dev, int mark_green,
 int cnxk_nix_tx_descriptor_dump(const struct rte_eth_dev *eth_dev, uint16_t qid, uint16_t offset,
 				uint16_t num, FILE *file);
 
+/* FEC */
+int cnxk_nix_fec_get_capability(struct rte_eth_dev *eth_dev,
+				struct rte_eth_fec_capa *speed_fec_capa, unsigned int num);
+int cnxk_nix_fec_get(struct rte_eth_dev *eth_dev, uint32_t *fec_capa);
+int cnxk_nix_fec_set(struct rte_eth_dev *eth_dev, uint32_t fec_capa);
+
 /* MTR */
 int cnxk_nix_mtr_ops_get(struct rte_eth_dev *dev, void *ops);
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 460ffa32b6..0ea3d7e89f 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -1414,3 +1414,97 @@ cnxk_nix_tx_descriptor_dump(const struct rte_eth_dev *eth_dev, uint16_t qid, uin
 
 	return roc_nix_sq_desc_dump(nix, qid, offset, num, file);
 }
+
+static uint32_t
+cnxk_roc_fec_to_ethdev_capa(int roc_fec)
+{
+	switch (roc_fec) {
+	case ROC_FEC_BASER:
+		return RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
+	case ROC_FEC_RS:
+		return RTE_ETH_FEC_MODE_CAPA_MASK(RS);
+	default:
+		return RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
+	}
+}
+
+static int
+cnxk_ethdev_fec_to_roc(uint32_t fec_capa)
+{
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(RS))
+		return ROC_FEC_RS;
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(BASER))
+		return ROC_FEC_BASER;
+	return ROC_FEC_NONE;
+}
+
+static uint32_t
+cnxk_fec_capa_from_supported(uint64_t supported_fec)
+{
+	uint32_t capa = RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) | RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+
+	if (supported_fec & (1ULL << ROC_FEC_BASER))
+		capa |= RTE_ETH_FEC_MODE_CAPA_MASK(BASER);
+	if (supported_fec & (1ULL << ROC_FEC_RS))
+		capa |= RTE_ETH_FEC_MODE_CAPA_MASK(RS);
+
+	return capa;
+}
+
+int
+cnxk_nix_fec_get_capability(struct rte_eth_dev *eth_dev, struct rte_eth_fec_capa *speed_fec_capa,
+			    unsigned int num)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_nix *nix = &dev->nix;
+	struct roc_nix_link_info link_info;
+	uint64_t supported_fec = 0;
+	int rc;
+
+	rc = roc_nix_mac_fec_supported_get(nix, &supported_fec);
+	if (rc == 0 && supported_fec != 0) {
+		rc = roc_nix_mac_link_info_get(nix, &link_info);
+		if (rc)
+			return rc;
+
+		if (speed_fec_capa == NULL || num == 0)
+			return 1;
+
+		speed_fec_capa[0].speed = link_info.speed;
+		speed_fec_capa[0].capa = cnxk_fec_capa_from_supported(supported_fec);
+		return 1;
+	}
+
+	return rc;
+}
+
+int
+cnxk_nix_fec_get(struct rte_eth_dev *eth_dev, uint32_t *fec_capa)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_nix *nix = &dev->nix;
+	struct roc_nix_link_info link_info;
+	int rc;
+
+	rc = roc_nix_mac_link_info_get(nix, &link_info);
+	if (rc)
+		return rc;
+
+	*fec_capa = cnxk_roc_fec_to_ethdev_capa(link_info.fec);
+	return 0;
+}
+
+int
+cnxk_nix_fec_set(struct rte_eth_dev *eth_dev, uint32_t fec_capa)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_nix *nix = &dev->nix;
+	int roc_fec;
+
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(AUTO))
+		roc_fec = ROC_FEC_RS;
+	else
+		roc_fec = cnxk_ethdev_fec_to_roc(fec_capa);
+
+	return roc_nix_mac_fec_set(nix, roc_fec);
+}
-- 
2.25.1

