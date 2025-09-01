Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0716CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:31:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97EC2402DE;
	Mon,  1 Sep 2025 09:31:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 43BC4402DE
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:31:28 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5810vvQq011595
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 bclCcxYad4T/Irwi8e2xb93JNizHtZORI6YgmvCTAw=; b=afsKh+gua0b8MeZOC
 Cll9kGZxUqrOmAkz2/BwrjljTjsAmGJzWaX7B/QaBHZpTgyGydJWdrQpOvRu5SNX
 QDjzaAp5qJlPYOFzJzdYhXesUKM3EVzwcTDkW1D/8bv3QLnpitkvw5gdat0RDFSx
 aBlkd6MRYcdnAzJgZ3Kabuh/0UbelBO9wffhz2NMyTWes6rckrScB6A4gt1hwKvG
 hig51M3J2yBvSbehVaB61/MvTm1n9AR6jP7D4Hm7iB21AFp6DMzEWXoXHfseZS3m
 +M5H0qr9jAb1oG3Oj2wLS27Rk0rE5E505oX5gRY3Rx0O31G2VRe2kmqdTYRCqt7D
 cC51g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48vj28hd8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:31:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:31:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:31:26 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id BF3633F70AC;
 Mon,  1 Sep 2025 00:31:23 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 02/19] net/cnxk: new tree for SDP interface
Date: Mon, 1 Sep 2025 13:00:18 +0530
Message-ID: <20250901073036.1381560-2-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -1Pkl082NYhuJkAdIZL8XYpbR4LLnP9e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMxMDA3NyBTYWx0ZWRfX8j/qe5yXNJd7
 K1rg0kUSmJM+hD3RHDJcfP6BmsJ+76968urptEbXChE3jUlGWzpKme2dfc7LMzUw32scEyl+M0k
 uXVm6EPkOLsJEGWpkfmMz6n99swrWkdyC86LvZfNmYWrqUQ4JCX4DX7HT+fnp4uNVQiiwCGDO6n
 mRmeqMps/dTxuH7+GSMdemgUrouj8myza+B+TP/p2RKyI0gYmq9fS8LtUYoBFTRZBgAKyGoLqs7
 0fQW6qPdAlieDFX8SGMc3z1v8HFzxafOicBoRn/iS4lqiKxB85U75HTXlBfkxoBf6XH4jbwRKbi
 oKQgaCpO1KCEaXPwdZnmW0qOsOW5OePC2+WGuELAmVhSwRJjBRNBljH99o5jgRprzFPEr6xUdy+
 0jgBH1wb
X-Authority-Analysis: v=2.4 cv=OZGYDgTY c=1 sm=1 tr=0 ts=68b54bcf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=pDSVT7ON_-t1wQNCaMkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -1Pkl082NYhuJkAdIZL8XYpbR4LLnP9e
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

From: Satha Rao <skoteshwar@marvell.com>

Create a new default tree for the SDP interface if more than one TX
queue is requested. This helps to backpressure each queue independently
when they are created with separate channels.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 6c723c9cec..bfef06ae4a 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1451,7 +1451,10 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		goto free_nix_lf;
 	}
 
-	rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
+	if (roc_nix_is_sdp(&dev->nix) && nb_txq > 1)
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_SDP, false);
+	else
+		rc = roc_nix_tm_hierarchy_enable(nix, ROC_NIX_TM_DEFAULT, false);
 	if (rc) {
 		plt_err("Failed to enable default tm hierarchy, rc=%d", rc);
 		goto tm_fini;
-- 
2.34.1

