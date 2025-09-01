Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B34CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:32:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95FA140665;
	Mon,  1 Sep 2025 09:31:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DF63940658
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:31:47 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VNhgV4032695
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:31:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 g3t6i888jM1znbMAvXnyh2tOcerRydyiEO40Y9+r0Y=; b=Zy9vTlweizANFBdtR
 CrnAew+ZT1Aen3Lu62MgrVfxuxwp4ZXaLad54gS3YQue7GcljGKfvB1XGqD3+T7j
 0Mekzd1QpB1StNo83MhWAYKgLRHZndzeJadMSgldWGgKNBLs3K+Ab5McIJQI5UC/
 7kiG7RQMEtIfr6AboPo5M6AnFQkwMuVfX0smgfXry8XGdDtWMbIh/ZU8oGxE/MMf
 zPFSWFB3DPitCt3bSs4crEp7aY30dtdh53m/ZIzbXUt/KQMyxUIeo8U/9Cu6jHFp
 cpRqIRnci265r5BekWfIxAZwdzjNtrClZc8GVAG0SoyfDfo1VPt+J7DpxN5qBtXM
 a0WZw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48v0thadb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:31:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:31:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:31:46 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id E66A63F70AC;
 Mon,  1 Sep 2025 00:31:43 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 08/19] common/cnxk: update DF flag in IPv4 fragments
Date: Mon, 1 Sep 2025 13:00:24 +0530
Message-ID: <20250901073036.1381560-8-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ty6mPxjgFe84_MZ4ZL9S-JVFSwJa1eL2
X-Proofpoint-ORIG-GUID: ty6mPxjgFe84_MZ4ZL9S-JVFSwJa1eL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDEyMCBTYWx0ZWRfX8IksyrngAf6U
 gXo6FFp2fDDtS38vpAQUwAkre6IzVfmaAAqhp+q/XqWOllcIJt36/aeHPkxYMf+VsoWB+G3YebV
 F/v0SxwDuWWJ//PwicyI8sZYq+P5YvwaWc9ehhXBdkGWSLZ/XHLfGyI+3Qa7lo1gZ/+ABot8Mtb
 ZGX9wzVVddSaOw8UTE1tOTGBvcmQ7ULkx+Ucv1ModUBreRATdD7t31H9/OtD/euJTtd1+UD5o2p
 nFwm40ZGvFLK0+j/LzvJrv9v9+pkhERAzAa7cifW3ViYar/zswCCSonrGyGOByT5N5wT29omNrD
 ck527ZSJ2iau8//S8sSehmHO7IpusmWlO0QbdSDf7ywDvxqsPxmjwzKVLbeTHjibjBrSsy+knGh
 c4JmSOfg
X-Authority-Analysis: v=2.4 cv=N44pF39B c=1 sm=1 tr=0 ts=68b54be3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=shHwveO5flH-z4HOgfUA:9
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

From: Satha Rao <skoteshwar@marvell.com>

While performing IPv4 fragmentation, consider the DF flag from the
original packet header instead of setting it to zero.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 138090317a..12a12c6e35 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -240,11 +240,11 @@ nix_lso_ipv4(struct roc_nix *roc_nix)
 	/* First get flags profile to update v4 flags */
 	memset(&alt_flags, 0, sizeof(alt_flags));
 	alt_flags.s.alt_fsf_set = 0x2000;
-	alt_flags.s.alt_fsf_mask = 0x1FFF;
+	alt_flags.s.alt_fsf_mask = 0x5FFF;
 	alt_flags.s.alt_msf_set = 0x2000;
-	alt_flags.s.alt_msf_mask = 0x1FFF;
+	alt_flags.s.alt_msf_mask = 0x5FFF;
 	alt_flags.s.alt_lsf_set = 0x0000;
-	alt_flags.s.alt_lsf_mask = 0x1FFF;
+	alt_flags.s.alt_lsf_mask = 0x5FFF;
 	flag_idx = roc_nix_lso_alt_flags_profile_setup(roc_nix, &alt_flags);
 	if (flag_idx < 0)
 		return rc;
-- 
2.34.1

