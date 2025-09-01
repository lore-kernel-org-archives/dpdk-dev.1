Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63885CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:33:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA09C4069F;
	Mon,  1 Sep 2025 09:32:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8CA134069F
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:32:21 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5812xP7v011791
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:32:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 D91RKqV+XB4Ac8v6yqmYCJ4gISD8UeM6REBuTBaDyw=; b=GNO8JFgdgwdpzTIrZ
 5dM6NbmZ8gvf4SpbzRz5YBiv7B0pxNobbit0WxnsKTioyxauGgW2fBBi+XtcBgSW
 N1Z9lBvONpjh2KrvKydLAlgBgffBGt9jQPmH1xh9bEhv4mdgnPsvDN8e4VHrJqZv
 UuKp/6NtQ2xccib4ojFGATgw1hznGbNPbTdsUdczb+dCivA4SXQrv67j41Am9VRj
 Gs6gjeZyFknK7yoevJ4P+rFEPHNQMVnv1rDm9rjcF7fDOl5RB2/wEw/f2re7R9kx
 vruC9giuqmtoEsw5JYAWgr9EkkPSNs4rm4D8oSnHn44if4wjf5G1QzwsVFhxufWP
 gGBVg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48vj28hdd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:32:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:32:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:32:20 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 911CB3F70AC;
 Mon,  1 Sep 2025 00:32:17 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 18/19] common/cnxk: fix error handling on inline inbound setup
Date: Mon, 1 Sep 2025 13:00:34 +0530
Message-ID: <20250901073036.1381560-18-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LLCM7yKcDWp9HrHSAadI715mBdrMOZ69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMxMDA3NyBTYWx0ZWRfX9UxoqWDhtGl+
 SzIf11FM1gfLVDDaJIbBznnzwYh66BPOmhmBn3VyAMSGCzUvV7pO8CxQ7+cBojzAfHtaOHhnDGV
 OOUC45ICtvrifiuJEx9nauxv3iWVsISYgiVgi+IX2ueXPzkwf84BOJXpL8B0TV0n7PreOHdWtBs
 HyYvui5dYPhdYzZ6b1qk+bupHc+FFevvfrcY0iwDoyLfVTyBxh1c4qCFj5s60H+dSaSLeFrnLKW
 zQsA6THs4xhJNNIOQVqLNLw93aBIH5czpIjHRRw7j1Pzd0XoBio/0UQjLvEfMAAiiyYjb6HkT8M
 kxouapEciefu21zT9WzwMMduFcBw5Fwn2TxTv21/x1EBcP8BpOpgAfygdc+qG+Sr4l81EkJpFQy
 oCkhYCSS
X-Authority-Analysis: v=2.4 cv=OZGYDgTY c=1 sm=1 tr=0 ts=68b54c04 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=41qjatK8hvuSD_SDovQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: LLCM7yKcDWp9HrHSAadI715mBdrMOZ69
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

Fix issue reported by kloc work.
Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 75d03c1077..38ff96334e 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -244,7 +244,7 @@ nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
 	if (!cpt_req) {
 		rc |= -ENOSPC;
 	} else {
-		nix_req->enable = false;
+		cpt_req->enable = 0;
 		rc |= mbox_process(mbox);
 	}
 cpt_cfg_fail:
-- 
2.34.1

