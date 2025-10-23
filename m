Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D35CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C051440650;
	Thu, 23 Oct 2025 19:27:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2ADC1402F1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:27:52 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3d0H8022499
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 QQ3CtvWB+ZwurKL7A8IEGCdLV3VLoPb+Sct/qmZd+A=; b=HJoFPOOEwlLaqR1Np
 /RPHV5CSUCTHv0haCF2V8oGme0DAAgUQtv+49Y+W8ktMvJ25tlSYw8ppLtzFcGHb
 a5mxA6/5WB+DfZTc/u2heI0X4KhD22aW1TJxTaFo2i4gCXwHSNcUCqE1CEzet4Oj
 9i7CgpeGSdF5GlsCL0aOadj2mudhRY+RiaEhOaJq5rxEfRnHgm+1DuzXanPHYnJH
 WNsV0iR5LJ++6W16lu2yLEl2w5sRrIhwmAnBa7GL9wcOj6vb82ZV5iaMQwyGK6SW
 cd02ah0AmaPYemYqTFNNGw/2cTVT6seelIMIGSSASZEpRbTfY02bgcuPZyxmTd4t
 C/YQA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:27:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:27:42 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id C287C3F7068;
 Thu, 23 Oct 2025 10:27:40 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 04/19] net/cnxk: update scatter check as warning for SDP
Date: Thu, 23 Oct 2025 22:57:12 +0530
Message-ID: <20251023172728.770661-4-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aoM-fSS0zGnALgXmqR1jz3csSm-2UpZA
X-Proofpoint-GUID: aoM-fSS0zGnALgXmqR1jz3csSm-2UpZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX+oNWn8wN5K2M
 d/Mtj4o+ll5HPjMDs+wfi45O+zgKgGg9hfE0nOTbPCIsUevdQalfko3G35e+FHKcj4h3dAsSV/r
 ndnK41vttiITrKOdQX7SJ8kGlVit6oTDMK149r8VadsK5uX40oZQcPw4Ynqytuyn0NhPHkXCJZ4
 On/qtuasErqGRmeVS18DF5nh0RVjEOO3epCXRbOqhnRFPPienospfaQ6z/fEQbphoM+IiWmnNKM
 1l9PAF9sE51k1ZTG+qfQXuhKxcRemvu54+Y8cDUEHeqO7FUAWIPedzQMviWR73XqQ29Q2dsmI2x
 ZCAmtMcJpjTQA/0aMWXyvXr1/yERjcnyd4/GRiD64aKzN3hfFNOhRv2qs7axD4fIka/FSBnfE+d
 2ePTk2io679fjaA4VGCdwd4ZbW0G6Q==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa6597 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=GRh1LX0TW_9BVTnexCsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

