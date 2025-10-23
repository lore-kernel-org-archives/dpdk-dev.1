Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E914CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:28:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C1FF4066E;
	Thu, 23 Oct 2025 19:28:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 064E24065A
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:28:14 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3cppg021903
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 eb98/Rvc0nVX6Ay41I2rQyJr/iPWPahsvJqWvi9/vw=; b=M/C8RZ5QiF3eKIOUy
 C/MnGCVJqzXt+VwiZvgIojm1gPdJpp4QwSNreGLxDKVsB00d3uYYaa3AyoJczHtR
 vzEXER0BrTvWQjUK8CVjNZZlsd8Dl+CZeaUKVh1KW+cSk1O6m2mXDojaZyny+vA2
 BPWU1HP63uKdNFnBkLwIvGTwG8wmPgdfUZ5PyVQNOO/rDrR9yQrvOjKvtf+0VV/I
 0GqyOUCOgpniMMPC4CnGOn2hrshstlhZfWiE/bNtAyE6qNw7lYsYST5utVFbp5IQ
 cjqnYrJbsU5+20lSg45k/dBHNygwpGBbSH2RtWEXfZdLXCYZUmYG2oGekOPAuyQZ
 nbVew==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:28:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:28:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:28:22 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 31D983F7068;
 Thu, 23 Oct 2025 10:28:10 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 14/19] common/cnxk: increase Tx schedular count
Date: Thu, 23 Oct 2025 22:57:22 +0530
Message-ID: <20251023172728.770661-14-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XKPecdVlir9XIsh_riRgr6AM0mEUR8Tv
X-Proofpoint-GUID: XKPecdVlir9XIsh_riRgr6AM0mEUR8Tv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX0diDutjYqWsF
 EtOqw1/dTmzyYYqNNXjhp3OFUdm5RS3KLTckJFNrW6Q3+GiVEq/RHk3cEEoDH3BraFFD1B0M8Z3
 5gUIQkt0h3ATwn+P+CCgtcyN4QqriqxOy6hZBStjsi2zk0xQzqDUUTgqH122N90KMxW9U9ITSS0
 XlBN3irK6OI2dT/Ck+028tPTnPkY8HCT1LAR3ysknaqczHTqZWWMlepLRMlE2eXnSsL/P+36yPH
 /l7uIMgywCGFZ8DZeAnZk/hY+MOshxu5Grl652hk6c8nLkAznqfhZtrWBc9rYFCvoeRmShEM+H4
 /C/j9FvOkKdQEqjnUP+waf9pes8HDj8jvf2AiTauca/OkOf+mARCB5W12ybvyc0HMLWIZVmmBeF
 Wye+MXleZStfblE/YT9Sd4hjSk/4dw==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa65ae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=9znxC1Y1qzjyv-Gufa4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
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

