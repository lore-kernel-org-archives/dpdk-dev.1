Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD58CCD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E339B4300B;
	Thu, 11 Jun 2026 16:21:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3980E42F01
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:21:15 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXniX2103969 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 1iIezMOpHyMHi6ovgYhvTT0Yjjh8I15W2bRqp4wHuc=; b=WRI2Sa7DNLUCkGUkv
 d57b0kLWliSdW7bd+7DsIzQcL04n61NRn9C575mVonjuNlnaQdCQd8r/x+U5Ur/u
 GMe8gFsCSSpwd4DRaEBaR4nJgMRKLWQH6tk21pOVtG92yaPmp9R9xPQqXt/gchAD
 K8Foch4YU8+Q6t/p+dCnU77kPBI9HVoVcFObmODeZKo8J/uF2/vSyfQwNDqYwiI8
 ugWyL1NvbcF7uRXxoBfY5M1r4MYeNzwlqlEOnDk7OE0ii2GbGFbobeE8uyp1gerP
 jfr5fZJyWg/fOp3TH4Rnwn2zdwJOdzL9Szxe0qoUQQyV57AOrFRcBAaDLhusDcyx
 phEgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r37bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:13 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id C57B85B6974;
 Thu, 11 Jun 2026 07:21:10 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH v2 06/22] net/cnxk: reserve memory for lookup mem at probe
Date: Thu, 11 Jun 2026 19:50:13 +0530
Message-ID: <20260611142029.3351415-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX+kTfRsALdPTH
 +0vWxu/Lt2GbFafP7KN9hW9NeIBFz8grEnF1UdisEDjPodUfoHq+n0VHXXi90RvxBpTfIZBiruD
 y1TAEYzwx1jRMBY2Ga0hCRwp8bZUQ8E=
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a2ac45a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ycIEUdTOxP0xdqTo3GYA:9
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: QWUbW8mNYplB43ey1aFuqiIk43NiR1Cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXxqkVboFc9a8z
 6pxDRDaOFdwzNSuBMpOn40IWIANWyFLNG8yB+O5nvFch7rhfQbS111V0EFL9q1jEMaVukYfec1C
 tUPWPZc4e19yB6lCFR+m0XQl2o5QWXSsnKy4ONkkGFxqNnUOPXg/JgXMDZXHx9zKFomVXjQdSvU
 68RzSN91KAC2MQdLAjMi1FTVB9g+r7WU55eliGk8JIy/AXhTJB8smO7hfzlnTBzT9tlTrEvrytS
 9KzvLZCZV2BLxG4YcXTOIhmYqrBvBh64D/CL070Agn1F6SU9m9ZKOlmfCgKRcr98w9jZ3ZxO8kw
 VP6omhBv48zsRH+HssxRcf7X40SYTRjRBT4SIGxMbPqNL/RD50LCgQCKQ1866pkju7d/cgyw0nK
 mui4b/gfWVDa+/s+T9LqM5oixFMLkku5u8Gi+TvMoSCCpyoJAhvcza/5WQiyb3ZW42iznaJKSH8
 qPYtybirTo9LixfPxKQ==
X-Proofpoint-ORIG-GUID: QWUbW8mNYplB43ey1aFuqiIk43NiR1Cd
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Reserve memory for lookup mem at probe that is global for
all cnxk ethdev devices to avoid race at later stage.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
Changes in v2: No change.

 drivers/net/cnxk/cnxk_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 06d1c9b362..c782dc51a8 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2220,6 +2220,12 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
 	/* Register callback for inline meta pool create 1:N pool:aura */
 	roc_nix_inl_custom_meta_pool_cb_register(cnxk_nix_inl_custom_meta_pool_cb);

+	/* Reserve memory for lookup_memory */
+	if (!cnxk_nix_fastpath_lookup_mem_get()) {
+		plt_err("Failed to reserve lookup memory rc=%d", rc);
+		goto dev_fini;
+	}
+
 	dev->eth_dev = eth_dev;
 	dev->configured = 0;
 	dev->ptype_disable = 0;
--
2.34.1

