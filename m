Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40320CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:22:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CDE2432B8;
	Thu, 11 Jun 2026 16:22:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 36D38432CC
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:22:18 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXnim2103969 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:22:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 4cwv6uJXpoWwCdcRU4mvaIJN0ymHOoy66cz4IMP1YM=; b=Wrt1xbnGioJBlJiHH
 Xi/ACUFy3DmTMGoeH4Tubh2j5dJ7SUb7tSsiXYpqfE3futLVaoJpVD3a/BPtWoKW
 RNvJ0TPUm5v12sQghETCIL1x3D2ISDFtttW0Cz8pzGb8aVwEfSw1azJTrrfkC4Fy
 VG/aKRUBLNx16BNvFcsktF6Boov+tCLyN4/ciggVoBQ5L654851yFn6y0gDCh0OA
 b8uol8kauPYUW9d9lIF+/eLwZPRTxFxgYj9dSZ2sGZ0PKn1os2CLnSwGXSgnzS4e
 fS+z8Yd2AoGqBXfTZiVZRLqDWf2UDHnNR2du70+BqIbo81qUvTliwm6VORm7FanN
 7ukug==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r37hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:22:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:22:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:22:16 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 537895B6976;
 Thu, 11 Jun 2026 07:22:13 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 19/22] net/cnxk: add FEC get set and capability ops
Date: Thu, 11 Jun 2026 19:50:26 +0530
Message-ID: <20260611142029.3351415-19-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX9+/glfbRhMmI
 Tsy7pLd4VfDEh7DDcrp0yXaWblsist124T2ZBp2sZV8dsnV+K1waCu7Is9OvWyunmXe31oX6SqJ
 FHVptMu5x/b55LXVyR3D9OPrcJo0/YQ=
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a2ac499 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=dnu02KUg3aPT7m2vTZUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5kFUt8cs3W_ZJ5-wjBHF__ReaJrmyMQN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX5d6/cMD25EuO
 7q3r/pGk2QAWHLYj91A+Ko3ejAt1REGw0R7je10oF63dDO9drLYD369a7O0VDKw3+bmIJbb5Mco
 P4lkRqrqS4IBEVMEA1nkVyw6G7JDujA0FWUGWtRxeBS07u18A9FI4f6OTsdlBgjntxEp+CJ1iQb
 Qt/A2eTa+AMhs5t8LinoXB5gov7fWOn8su7uk+8HYb10agzyOpj1JHsQBwnxJntcFFEQGFoeTCS
 db/Q5zUDhaAzAw06PxKKceq/q6Io0Md6yGxU2zuV6Ib/855hcfqeV/qpXRDHsf240/uBa453FrG
 zLME/C/zmdqbUGhazhRM73zbKE6afUIHdHSFMANsTRVPIDv1d4qiDmvoeBGr2P2dll0dHN7Xmo6
 61X6xP7PgDe6xWn0eng2CBKoA5RVaj5Wj3pBddvvsRDlLdUlR57SeEo7huLlBqjUbeVnADfN4rg
 /TsDPDcV6VXtfms/6oQ==
X-Proofpoint-ORIG-GUID: 5kFUt8cs3W_ZJ5-wjBHF__ReaJrmyMQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

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
Changes in v2: No change.

 drivers/net/cnxk/cnxk_ethdev.c     |  3 +
 drivers/net/cnxk/cnxk_ethdev.h     |  5 ++
 drivers/net/cnxk/cnxk_ethdev_ops.c | 94 ++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index a21e170229..f3f5035947 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2137,6 +2137,9 @@ struct eth_dev_ops cnxk_eth_dev_ops = {
 	.cman_config_set = cnxk_nix_cman_config_set,
 	.cman_config_get = cnxk_nix_cman_config_get,
 	.eth_tx_descriptor_dump = cnxk_nix_tx_descriptor_dump,
+	.fec_get_capability = cnxk_nix_fec_get_capability,
+	.fec_get = cnxk_nix_fec_get,
+	.fec_set = cnxk_nix_fec_set,
 };

 void
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 6686fdba31..9429a81ee8 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -667,6 +667,11 @@ int cnxk_nix_tm_mark_ip_dscp(struct rte_eth_dev *eth_dev, int mark_green,
 int cnxk_nix_tx_descriptor_dump(const struct rte_eth_dev *eth_dev, uint16_t qid, uint16_t offset,
 				uint16_t num, FILE *file);

+/* FEC */
+int cnxk_nix_fec_get_capability(struct rte_eth_dev *eth_dev,
+				struct rte_eth_fec_capa *speed_fec_capa, unsigned int num);
+int cnxk_nix_fec_get(struct rte_eth_dev *eth_dev, uint32_t *fec_capa);
+int cnxk_nix_fec_set(struct rte_eth_dev *eth_dev, uint32_t fec_capa);
 /* MTR */
 int cnxk_nix_mtr_ops_get(struct rte_eth_dev *dev, void *ops);

diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 49e77e49a6..a45721d414 100644
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
2.34.1

