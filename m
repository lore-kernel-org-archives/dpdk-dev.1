Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA87CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36F0540684;
	Fri,  7 Nov 2025 11:48:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 903DC4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:36 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A7AKn142930256 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 eb98/Rvc0nVX6Ay41I2rQyJr/iPWPahsvJqWvi9/vw=; b=kRsl2E4iRKQ7GEpso
 mcVKgjiZnteqpObJNhHUEFGvmcUpkhj0u5HkdLuUJQiRvXiK/zU+2uA5sAMOlZQr
 Zbx4SoYUt7A2ZQ4ccuX+pgl8yUaIPyPwW+XQLmcXsI39LVDbSm9n2W1wMj1CEfW7
 dQpTVF7lEVstu7W86FVy1A4776Z39v4q06cYeC17PxaYgasSE2CM/UGIyF6pKre5
 kGGw+n6X9uEgqrSqBtQZsvsfzF3nw9HdXgUqt7axnnDM0kioEAngtxxjpD9cBJe3
 71dLINLMdkurIcqBYMW+ULN4DyWLSMDtSzXj6cgblP5f29O/AuKHfSxYzf8tMT+3
 Re4+A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9excg2cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:35 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:46 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id BF23C3F70CB;
 Fri,  7 Nov 2025 02:48:32 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 14/23] common/cnxk: increase Tx schedular count
Date: Fri, 7 Nov 2025 16:17:38 +0530
Message-ID: <20251107104747.1131008-14-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfXxHVOR7BHF9A+
 YbrleQAAaCRwDQX66VnrvQX9TM7o/CNLMRTDccGuPo826ZLtyRMvC5+UpLato8AfqsLQ0TtF+3c
 5x10bZ6Xd7AFQFlA1hWL/ZVgzphPTS97bSeZQLpX5SiKqkW8FsOS18wq3KieCT6kCmpi6WHcH2J
 F+y0qEyKLQ+YH/yIujlQHD150IlRnf+3EaOj81g5/ymgWnGbuyzFuBfpD2jtJAvEFV4/vtlE7QX
 zUSUjEZwfFokFl72N9LUwoYh4wcajjRPY6uLA68aUszttzpGDL27xh7U2blsIK/08GEhARS4Qig
 a636HYHmWlVIIiF7cV1X6B6Qfl6YFXQYdo/vFKc1RY8ayjBYI8R1HGr8iqjJGY1/qUGcxBIlT+c
 gzsm4SLIoe0IOQQ5U7rGaqWBok8/lw==
X-Proofpoint-ORIG-GUID: Bttd4D7i2I54FpEGBcdn24WxUAUvvq23
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=690dce83 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=9znxC1Y1qzjyv-Gufa4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Bttd4D7i2I54FpEGBcdn24WxUAUvvq23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

