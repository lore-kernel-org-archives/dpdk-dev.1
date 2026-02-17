Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36787E83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC7894068E;
	Tue, 17 Feb 2026 06:44:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BCE4B4066B;
 Tue, 17 Feb 2026 06:44:21 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1sWbw3270078; Mon, 16 Feb 2026 21:44:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 Gq6Bv16UznuBMLHgAYyQpkAlMzkfC5E2FQX+XlOego=; b=SgRNaiKpG0JEleuUg
 4tNiHYWv3d/PfEvu7y2uta4qGNpYSqnjdXUKQliO8mAv2TBWTadCm3MBeDCAFedx
 rxHDKzMzCOd+CuycTpifZCo1XMdoZVeQHsbBydMS1fKlYMkPDQMglj7EYJ7Ui6Zy
 H+3W2yEosj3zem1E/RiOIXfOVVCfSsjEn5dmIWBZm7JGut5MrH1rU8DAL5u3Mc2f
 ya2CYleryDJ8UM44nxqhNoIdeeIlqUhrAOYT2G2rFgthq41BhMf8yXRnvMmcpAlR
 91J5dqP9dVBx9/ACl1enS/9CACi5iozNQQcpDc6xes+Ygw1yYVRalfmfolrnAdGZ
 e7RjA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4casenm836-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 21:44:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:36 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id BC0265B696D;
 Mon, 16 Feb 2026 21:44:16 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 07/18] net/cnxk: fix security flag for custom inbound SA
Date: Tue, 17 Feb 2026 11:13:34 +0530
Message-ID: <20260217054345.2759687-7-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2c6lFZps7PSqTaW1uaN6tD2QpYjWqJzF
X-Proofpoint-ORIG-GUID: 2c6lFZps7PSqTaW1uaN6tD2QpYjWqJzF
X-Authority-Analysis: v=2.4 cv=SumdKfO0 c=1 sm=1 tr=0 ts=69940035 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=yN1LRFIggoRtjEjFKAsA:9 a=zZCYzV9kfG8A:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfXzf6OyjriMXjw
 Ew0ul3cU4bqsSb1uqrHY3j1TGP8vGg2x6uoO0oBr2weUgvTeTBCJYY6N2X1G5YaueQ28i3deb8C
 nqrhDRexBBGocGrBt+pOPF9fHcZkYSzaJ11rcGavdfBdY0M9DQ89BsWT7YJqbFR0jo+ijcCDjqF
 Pa9Cg2SB1Td7+Fbf0Bzp1Bs/3ijRdvcEC4FdGGjJO47rDUhev39TKXLTeZzd8LPeHaHQYCGJpoB
 86iTSq6Z/TvwZYMRMksG/Eg5LDtDU63JDK+bYmclLhFwIvWjNDK8yp5+y1h6i8uP4CRr2sPy+CJ
 Aa7VXqJ0thL/wYc7tVnDRmgqd8TPeruB+X5g/h3+wHDHeiAShe4d8za8tTBM7KeFs9zq64yjktK
 lI0c6YVxUbubSj8k6oSgUjvTsOH1ilZVGZcpW2DlhUXLiOfXzQjQWcsNf4cqWWxiML97pArXsn8
 rCf34oyGjbqT02kFGSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

Avoid NIX_RX_OFFLOAD_SECURITY_F fast path flag for
custom_inb_sa config.

Fixes: 7eaa499dd0c2 ("net/cnxk: support CN20K inline IPsec session")
Cc: stable@dpdk.org

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated commit message.

 drivers/net/cnxk/cn20k_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index a7ef1dd386..20be35c0e0 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -35,7 +35,7 @@ nix_rx_offload_flags(struct rte_eth_dev *eth_dev)
 	if (!dev->ptype_disable)
 		flags |= NIX_RX_OFFLOAD_PTYPE_F;

-	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY)
+	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY && !dev->nix.custom_inb_sa)
 		flags |= NIX_RX_OFFLOAD_SECURITY_F;

 	return flags;
--
2.34.1

