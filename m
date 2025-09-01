Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3752CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6CD940671;
	Mon,  1 Sep 2025 09:32:09 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 141D14068E
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:32:07 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5817VRM5013921
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:32:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 eb98/Rvc0nVX6Ay41I2rQyJr/iPWPahsvJqWvi9/vw=; b=I90/59ZCo/GPtW/NF
 pb+vwHdg2tOqTXhjhdE+tA14iQ2x8rnRruf9ONRt21jvont0kEVeZGMtELAAt3qd
 g3NwWkyJR7fZzdeH1ZSvvz3l5LSMakcwPIhfvxv6TvNtuh+4vokldavv6ALjgtur
 t2nM0zLB01c7KWOO5rPJtpIhzjb6KS+ZjBJhc4/sds0EjWN94vZnXD+ad4StyHws
 ajVyhRr7vRrEj3fiGYleNIjV4SUbw50N2+vI6jyj6CJgDpgNsqiLgAyFNT7UrrgK
 joLKXosc6ZNMD/H1zywEyXXRR477xEbvNptkYDc0fDyJCTyXP9y9QLgaDOaRMhoC
 YMKEg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48w75y806t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:32:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:32:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:32:06 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id DB4B43F70B1;
 Mon,  1 Sep 2025 00:32:03 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 14/19] common/cnxk: increase Tx schedular count
Date: Mon, 1 Sep 2025 13:00:30 +0530
Message-ID: <20250901073036.1381560-14-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDA3OSBTYWx0ZWRfX/vsARvNFiROy
 uJL3BGx3ObZ5h+T8I2Cy1cQxMm/if5+WKfr2c5kCAJui8nwcYVGSZjc/eoHV9c9YYymru1PGhVf
 x2lSsQ8dDGlxNGQmDQvPLzoEUQif+ZHpFn6qII7+Q/HRm84y0Q7SXwQtOXpHBwDsyiUNPHQTBVG
 LEhA5tlU90P6axKrxKlqedb+c3tp90EP7P9B0m8bdzSE04za31zDu/pO2w6uaeAZfgbVMeePhJz
 5J5Cmph9sqlFl5SMW3NBDj8tY01YoFm6WTldT/hZEVv+HZegL3g51Koz7n6bSveHz8ed/0H/Uj2
 RNLDM78KS3gpe+QueTTQSkDjBLBoVSOGsYrA6NE0yBhwGN0DgChoojTIV0S2kcZrCPlE8OshSIf
 kjXwrMNl
X-Proofpoint-GUID: SMWNgKOhG5dD_MJ3GFomFH21-ul31Yvc
X-Authority-Analysis: v=2.4 cv=D9BHKuRj c=1 sm=1 tr=0 ts=68b54bf7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=9znxC1Y1qzjyv-Gufa4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SMWNgKOhG5dD_MJ3GFomFH21-ul31Yvc
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

CN10K platform supports Tx schedulars up to 2K.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index dc61a55d1b..b5553223cd 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -41,7 +41,7 @@ struct nix_qint {
 };
 
 /* Traffic Manager */
-#define NIX_TM_MAX_HW_TXSCHQ 1024
+#define NIX_TM_MAX_HW_TXSCHQ 2048
 #define NIX_TM_HW_ID_INVALID UINT32_MAX
 #define NIX_TM_CHAN_INVALID UINT16_MAX
 
-- 
2.34.1

