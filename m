Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD29AC982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1434A400D6;
	Thu, 17 Sep 2026 09:14:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 60635400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:14:24 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60hgs2243486 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 wBuGoW2JdIcIK2BjDbZbt36GmB0xspFR8a+eIHP2II=; b=CSpPf51pijEawnQj6
 pp+81w8p1lQ8PtAWaOhKqG1XuCKTxxQ+xbZMF9m1W4uKhipLNTwYtj4nxRL6ZRME
 ibJKEtOOBdDnU6Ql19lC8Rl3xRGKAHpJw0494WegFa5HDINULMuK9foQ7lNQia0h
 6Uz0CZOHXKFfwOOsV7OSmzdfdDsug+DkuJsw4PM4nfvdEvB7LQKH0sLUgjmdz0ND
 CnA+WTlwvcAcHuUyrYE+2Lc1MA0cKtO3JASUYu8HW7Wq5Y8ed6EM/AdWLkCfSTFb
 R0m4fmFMCrMMps6NhyQP1YpRKqlT8MGIBzIICJwESlbTqdWqwWVKqL00j2AurRbD
 Ejmjw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gr46023jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:23 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id A4A4D5C68E2;
 Thu, 17 Sep 2026 00:14:19 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH 04/14] common/cnxk: update channel mask for cn20k
Date: Thu, 17 Sep 2026 12:40:06 +0530
Message-ID: <20260917071016.2366467-4-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nhB3JIzxlI27ypyjjEM_Lozp5PjKCkpc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfXx+S0l2wt87WC
 X8qwfzdmm7j1D6CVZ4DOgWC46KklC6QU+NjbQDYykBMIftrsgXPY7Ka/0itquRRRg3rLvPAjWpx
 3gTnrpQgRpLlx0xPkoRwLmBMcg87L7A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfXw5d/rGjDZ3mN
 7va6ejZ+CVJIuv4MKOhK3Xf7mRKEI9tMTGPxfMY0+UJrt3Rlc06PnKScHVsePE4T1dwRBLQN7Gw
 l1/YJ8TpYgu6kqKuW0KsTr3Qwp2e+fKJRllQA7qe+MoJ/t8O2/MVEFUz6xJOR5iE24gYoay4d4D
 tSVthYYtxjUh1Dpjx3P033JXHP2bOSE7ocFmKRmzF210st+71fJ0mPocVD2HAP25pX3x+1dWlmh
 vRkaYf+cP8ssz+Qx0aT3+QMRZQo3gRVRcjBU+VmVcbxY7/1L3RjjMUOLodpzeeDshtuhlcs8DI9
 mQHzF86HpIrno95TCvWqPVtlyxH25cbuOiy8rZ8V9hzYtfHThR00BYcqpDDnAZlhPErTKNnb+rC
 2tpIMg+Kmt5KZ4uE6gViy9peiuqgjbC8DOPIaHqjulVm6d6eAoQMzDKlcfOLkL6oZUhVVO98Nhq
 Zvg9JDak8bc9wAdHvvQ==
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6aab934f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ebWO0A16uX1eok8QaxQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: nhB3JIzxlI27ypyjjEM_Lozp5PjKCkpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

update channel mask for cn20k platform as well.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_npc_mcam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index 34665f1bc3..613a443c7c 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -761,7 +761,7 @@ npc_mcam_set_channel(struct roc_npc_flow *flow, struct npc_cn20k_mcam_write_entr
 	chan = channel;
 	mask = chan_mask;
 
-	if (roc_model_runtime_is_cn10k()) {
+	if (roc_model_runtime_is_cn10k() || roc_model_is_cn20k()) {
 		if (is_second_pass) {
 			chan = (channel | NIX_CHAN_CPT_CH_START);
 			mask = (chan_mask | NIX_CHAN_CPT_CH_START);
-- 
2.34.1

