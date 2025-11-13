Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C34CCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:38:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2B7C40E1C;
	Thu, 13 Nov 2025 05:38:40 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B869340E17
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:38:39 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD0Zsut1254507 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 QQ3CtvWB+ZwurKL7A8IEGCdLV3VLoPb+Sct/qmZd+A=; b=aFkSAJrGQAluhkWby
 kH5/NQ/qhV1dvo28od6+31hqEBNz6u6XC1Sp5VDfEUsWw46eOwyq+hlvM/8iqYQp
 /yYDI9n+KmobEX064jGHuiXRYKUbTCB5Kp80/sKYDHtFZPBYr1psucmZwFcoKWuv
 6TZpBEiM1wZNcBFkb06rZf8vGy3UVUlCD6KjItrxg0/+vKsWSOI0LWnPCcH5oMF/
 U61RV7Qt7t0iChEPhfGs9ugEZFB3Cp+FPqqhVJl9GaV/8+2qSQV9QkXHQnRLKg/h
 zn/fLxd34jrOSOrh+fBADOosLDVX4GxBrmvRcqKflAzKnc6BxrnYKJhfNv5XaZ5D
 qK5mg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad4x7rf1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:38:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:38:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:38:49 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 4A7243F7076;
 Wed, 12 Nov 2025 20:38:31 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v5 04/23] net/cnxk: update scatter check as warning for SDP
Date: Thu, 13 Nov 2025 10:07:49 +0530
Message-ID: <20251113043808.1180851-4-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX3dC5xgctEwB2
 JF4SjvvyZ/Hi8BticvU1slPu3iILGAodUVtHoXv4lkbSsD9Ycxg1kQDIDUQ7J3sX6eAAknIemZe
 YunP5c7Xfy7gxBNz3zmtYO6A25JtYW5aHDGmv90Cs5ooyk90rSE1iXyx6Pn5a+QSXbO7lxdki5i
 dhVyUD2JXLDQg4qTR/DadON9wz1T1mcJ5mPlhp7Y9UyCIfl8IZmjLdZf5lwcEVLGYHhxRB0Epd+
 O35cTrR7Q40laEtseHdudRL5dZnD37oX6PRrjrKwYpukbeGXug3WJrjmEfELyHE43Z0OZLsZkjW
 eqetM297Ps+sFHxmREPDZlOMGwcVPq+fHziLV90SLN9/eta95xLQMiYJ7FI7tLzbmTzxLBe147s
 1FKkJCxcz2SR6xhMNPR0WNrEFwNhag==
X-Authority-Analysis: v=2.4 cv=EfnFgfmC c=1 sm=1 tr=0 ts=691560ce cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=GRh1LX0TW_9BVTnexCsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: crCjcPyvfeSBZOwfa0cL1OVreFxEWDnV
X-Proofpoint-ORIG-GUID: crCjcPyvfeSBZOwfa0cL1OVreFxEWDnV
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

Update scatter check as warning for SDP interfaces instead of error
to support cases where host application is already aware for the max
buf size.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev_ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 7a8ddb4c9b..49e77e49a6 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -613,8 +613,11 @@ cnxk_nix_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
 	 */
 	if (data->dev_started && frame_size > buffsz &&
 	    !(dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SCATTER)) {
-		plt_err("Scatter offload is not enabled for mtu");
-		goto exit;
+		if (!roc_nix_is_sdp(nix)) {
+			plt_err("Scatter offload is not enabled for mtu");
+			goto exit;
+		}
+		plt_warn("Scatter offload is not enabled for mtu on SDP interface");
 	}
 
 	/* Check <seg size> * <max_seg>  >= max_frame */
-- 
2.34.1

