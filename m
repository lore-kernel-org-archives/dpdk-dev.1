Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966D8CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F39B40F1A;
	Thu, 13 Nov 2025 05:40:13 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7F84240F1A
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:40:11 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACNRovX4031198 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 LhOISwReuGuypB9xILFBsA8VWCNKvGmORx0qa8jPL8=; b=KBsXSrzfp66M3wm2P
 m4D7iNSJgbYgJE3QuMs2mddmGXWdsUeFly7tp/KHzL5Zujfaz2kzYxYwjLRBDyNP
 O3ZvQnN/8bw2RqMlP2FpFpUji1b4hP66JYauP42ixJ44mhqJeFzh+GUbuIPltsHF
 LbaWljS1U1SpKSJRROJralJONqr97BE+o+fVZRwJ5iXP0nImfmgBXjjewtGTsRjP
 HlHjXHi/LzrzdWjbpks+A2s5/RFRTLXeZ+CWBWfp2l58ymbjm7k+ww+kpv0SG4I4
 driPYKYEz6Dq2ObczDXNaT+hAhblZLhMYnwgN+oYoA9pvIeVrrXZyy22p1pUpg8m
 wiB+g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad3xbgknn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:10 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:40:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:40:21 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id D30C33F7086;
 Wed, 12 Nov 2025 20:40:06 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v5 22/23] net/cnxk: fix illegal access of Rx inject LF
Date: Thu, 13 Nov 2025 10:08:07 +0530
Message-ID: <20251113043808.1180851-22-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Q-Rg7kwYHh_kKjRsKWklVxfbemIptXA9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX9iDtITREdQ02
 3675CDqdQO8cj7VHNNboI8eCFI2Pdie7MFjEVl2YpPSnaz+QEd8ogxkYbmVqViCMeIvmZI7wESM
 RfO3+wJh1srNUIs62LngfoedTI0tItWyKHv2kCHKWCIc4zBnJ28b4gvqCePsFR5VkdzgEUBCurX
 JjAk1vaXqmqd3G+sPWGvHdG22QKJ8Tb+hvojIgJekHEgFyEuurMBb1AAOqz6aUt941nHHeupoTx
 xjXZioaMNK4oOXcN0ksXva3/8CfOQBFWooisueyUXVflRiqGpn31LTDKns8Balu6UyonapUCDjn
 GybecMVtqQlOMUtXuqXxfIVHkupirtF9nxy6Cw0qlqPbA++cKuWRl9yvDfFeqDaA1lnR4q7cFSC
 mrjLI89xbluxewH9oZM75tKoUuXrzA==
X-Authority-Analysis: v=2.4 cv=Qq9THFyd c=1 sm=1 tr=0 ts=6915612a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=R85t8e4DdIUT_508euUA:9 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Q-Rg7kwYHh_kKjRsKWklVxfbemIptXA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Fix illegal access on error.

Fixes: 47cca253d605 ("net/cnxk: support Rx inject")
Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/net/cnxk/cn10k_ethdev_sec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index f26830637f..855bea1796 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -1336,6 +1336,8 @@ cn10k_eth_sec_rx_inject_config(void *device, uint16_t port_id, bool enable)
 	roc_idev_nix_rx_inject_set(port_id, enable);
 
 	inl_lf = roc_nix_inl_inb_inj_lf_get(nix);
+	if (!inl_lf)
+		return -ENOTSUP;
 	sa_base = roc_nix_inl_inb_sa_base_get(nix, dev->inb.inl_dev);
 
 	inj_cfg = &dev->inj_cfg;
-- 
2.34.1

