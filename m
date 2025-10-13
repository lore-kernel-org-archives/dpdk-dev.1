Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECBDCCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:00:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 122E640612;
	Mon, 13 Oct 2025 09:00:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CB1274060F
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:00:08 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D0SQfq024868
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 QQ3CtvWB+ZwurKL7A8IEGCdLV3VLoPb+Sct/qmZd+A=; b=YRGnDPcK8jETcd00C
 vaOtAj2a9PSeB8dibmfQ/Scp7JFz+P8wt7CxOswIt4JsubcPiH66xKDzwLw/4Nzb
 Fs6UsCKBrUZKU0H79WVSfRoajNnLH0d95ydI2rcBO+DEqWj6xzsuCCNc4bmnLOjd
 353ywGzPe6sIQsB8tcZy/e9L2T5oArYeYsed+RlMGMDH7avZw5PrsZQixYHNnIpp
 HAy4UJS94W/jHMJb5y2YHX4t4oR46cNtltv58qx3PijCMPCnsCFF0XNYcttNxeA4
 b8+sSrzoersq0msb7zQqRpAiG2YY0IMctMK3JoiDYqsbHCqcxmRUEqBYPQwADt6V
 n1s3A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1s8mcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:18 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 00FC83F70CD;
 Mon, 13 Oct 2025 00:00:03 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 04/19] net/cnxk: update scatter check as warning for SDP
Date: Mon, 13 Oct 2025 12:29:34 +0530
Message-ID: <20251013065949.200414-4-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4PNDrEMT1lG91toDeGZRdo9sk5dmSvyF
X-Authority-Analysis: v=2.4 cv=ENQLElZC c=1 sm=1 tr=0 ts=68eca377 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=GRh1LX0TW_9BVTnexCsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfXzcR8NxqP5f50
 wVTJaGrb8YcpRERqP5VUPvAaZitX+AQliXU+jmVnMiQ1JdFKXb7apQeRimVWWVXfnjkAFt6aCWT
 jlO4xJXKJEtguf8njveT1+Jjw/298CZf0rHiRqvgXdPNVwOwY+5V/vOIk6E+w/hx9EvILY3I12S
 Xd2gO4hGT8Rt69XIJ/EdkfoB0H8m/RUYu4cnHdH8UX4bzCLIse10nYIfG1gs2NB0e0pfxouFtMs
 zJciaMgeZohYxIbMmb8WcLjl4w8L0rNhe7SLfUZ724/uAKZZDYEWLcubx1BHCzmhxeELgr6GFg+
 UAtKCKSkCY1FLGiEG2h8Z3QuJCtKSEQduEkJZjXTCkOy4Pa69VBrcTVDH7w4Nt4RiEgGi0fwJ87
 +8lKCg47eQHLLNIhxVVjb8eLh9T/pw==
X-Proofpoint-GUID: 4PNDrEMT1lG91toDeGZRdo9sk5dmSvyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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

