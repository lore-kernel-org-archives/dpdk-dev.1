Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3E0CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:31:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0847240431;
	Mon,  1 Sep 2025 09:31:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DC36440431
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:31:34 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5810Oig5002813
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:31:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
 Zv+gK0tpynkIubFlhl/Zfy4kykU0aRpI9bECRqvgkY=; b=QkUBRadQmUCpg3Vza
 79UIrBD7HVtJZw5aCiwr/hbfDKDeRqW41QTsR8AhLmYL71U/6wrobSSK77QsAYb/
 4cAGpncvkrDWEXyoEGifJj3hke5HO2jVKVWk8NaSsEV0ChIrVKBAd+k/IKU2ULlT
 FjTUOZySPnaztUqC23JpRIP5IwoyGDcTyDIBasbTgHUim+ygHwf8S5DXMqvZQaCw
 NMd7ZoEe1jPf1OZNWNYgVLSyKGJKD6RRx3uV0CrN8xnTisBUgnv5II2ME5cpJgRz
 sAIwlfneD+k7vJfcowGqL7eka4BX/AiLkqDHhtrXQT4GEO1lFz3jJzFdp9VAhsKs
 Ne8ZQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48v0thadag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:31:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:31:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:31:32 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 7060C3F70AD;
 Mon,  1 Sep 2025 00:31:30 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 04/19] net/cnxk: update scatter check as warning for SDP
Date: Mon, 1 Sep 2025 13:00:20 +0530
Message-ID: <20250901073036.1381560-4-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NBCEKyzJzkzPkSMRSg2r6fsbUopsYwb4
X-Proofpoint-ORIG-GUID: NBCEKyzJzkzPkSMRSg2r6fsbUopsYwb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDEyMCBTYWx0ZWRfXyuo0RSfReCKb
 ipR8dg3eObxwFWNGENeocol4KuEOHiYHIkRe5eoYx3vUit5gJEAV71lSkAI4xvX+RUBEgOResGs
 wYkxGZKeolIFK223UrbyE6BboXlA+3EbfGowOeLiVpmaYjNjjI3AlQMBMDPCOVH/eHXIwO4LY48
 Vq56bJJCnLW+1Z/CnWfsrYFMKUkRHCYQETBFWEzOdbBwuDUnFcc9w+u1hPXDnDAZf9ZiH69Zsqo
 olLM8iEKf5QYyHcxm45CQ6snGFUvDe+1+LKJXwQ4Zg9aIjwxTqgNeoGEgawN8RzkIvt+3yc+ajg
 v1iI4Ep4IjMlSKDaxd+l761nH3xPkokiMrTLWwfCWeiE/Rv9NFxi8n4ibotD34NXThkKRK70V1I
 /no1fYAL
X-Authority-Analysis: v=2.4 cv=N44pF39B c=1 sm=1 tr=0 ts=68b54bd6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=GRh1LX0TW_9BVTnexCsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
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
index 3921c38649..db1d583fd0 100644
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

