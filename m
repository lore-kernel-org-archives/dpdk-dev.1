Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C935CC3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4453940E16;
	Wed, 28 May 2025 13:52:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 990DA40DD5
 for <dev@dpdk.org>; Wed, 28 May 2025 13:52:04 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5qxwj006107
 for <dev@dpdk.org>; Wed, 28 May 2025 04:52:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
 QGHMKBWzbCjvpBZkSjVoQPCm5VzuSlYSn/caY2APMY=; b=EZd+Pyudp8wd6KiuX
 vMCVwf11HlVvg6GHtb2Osu12dTRq8huHMcZFGYzIlhou2vEirvG5uz24e9Cwodti
 85IiQJqEuCOzw+z736uYh/x38tX7pNIjQr2z68Sk3k0NHt5avZhKhgTCVdbHDz+L
 BQv1CLgxFruih+ElXIylXo/3bgEIl7nRXOrX9G3FY9fLrwrvJDCTib6dzWuT6Hos
 fQ/+SchbNn5sVTxThFwkq84vWjI7XcQQ6ctJ3lrKm8JanL0H6FTs0GYG+1Ypl3Er
 CpzhyLSp6FXNjbx/tqMYm1fYmEu6MkCAkvoUWVcC3GRAaWQPKpjXbZyt8m7jazi0
 naT/A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46wu5agr7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 May 2025 04:52:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 04:52:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 04:52:03 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 377FA3F7060;
 Wed, 28 May 2025 04:51:59 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 6/7] net/cnxk: devarg option to disable xqe drop
Date: Wed, 28 May 2025 17:21:21 +0530
Message-ID: <20250528115122.24052-6-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528115122.24052-1-rbhansali@marvell.com>
References: <20250528115122.24052-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNCBTYWx0ZWRfX3v9d00ox7Zw/
 NUZZSFrk5WzgUvnkzUWlI35QEuVcYqzdavr0PgZ+c4bCeVJpCbGjrRbudZ3L11TwOUNP2Bcb7oY
 acCEFibESozyPr9xgq6gA84LdvYZYt3Zq+ADtUoNQqVTUeSYiU+2+LBVdsSCjHsWKoW8ZuWx2UB
 aDWPhr3Nv1mcz2KvQXBBgGSNIlbiJqLe04sZ9dYpiptVuz7LgjsYYpiXznwLCn7yuFCoDzDlZV+
 VNc3MMb6swfRENBQ1Kh+oMEnhjixxYo8u2/2uPWVBLA5PYxNNlqhLYBRvN4HqEMSsx4Qc06SsMl
 P+oGbkyvuG0TSwphVkbCpdmnoGwhhOoMkmaxjutZpMiv97WQv54FhMaTECK3EZrmlu1MRSVttnb
 3tF3bV+z++5c8WmyKcwGi8OC6UC5RKA2pL7BzQvZVAtV8pa+G3wlY3rLH8CK3IVvKcyyLkhD
X-Proofpoint-GUID: Eq60Y850-GYAPISuMIQK2OSF85zR-U2Y
X-Proofpoint-ORIG-GUID: Eq60Y850-GYAPISuMIQK2OSF85zR-U2Y
X-Authority-Analysis: v=2.4 cv=UahRSLSN c=1 sm=1 tr=0 ts=6836f8e3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=u2_Myz_QQJ34HghEGasA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

Provide devarg option to disable xqe drop in rq context.
It will be set as disable_xqe_drop=1 for nix device.

e.g.: 0002:02:00.0,disable_xqe_drop=1

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev_devargs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index 7013849ad3..e42344a2ec 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -282,6 +282,7 @@ parse_val_u16(const char *key, const char *value, void *extra_args)
 #define CNXK_CUSTOM_META_AURA_DIS "custom_meta_aura_dis"
 #define CNXK_CUSTOM_INB_SA	  "custom_inb_sa"
 #define CNXK_FORCE_TAIL_DROP	  "force_tail_drop"
+#define CNXK_DIS_XQE_DROP	  "disable_xqe_drop"
 
 int
 cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
@@ -308,6 +309,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint16_t custom_sa_act = 0;
 	uint16_t custom_inb_sa = 0;
 	struct rte_kvargs *kvlist;
+	uint8_t dis_xqe_drop = 0;
 	uint32_t meta_buf_sz = 0;
 	uint16_t lock_rx_ctx = 0;
 	uint16_t rx_inj_ena = 0;
@@ -367,6 +369,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 			   &custom_meta_aura_dis);
 	rte_kvargs_process(kvlist, CNXK_CUSTOM_INB_SA, &parse_flag, &custom_inb_sa);
 	rte_kvargs_process(kvlist, CNXK_FORCE_TAIL_DROP, &parse_flag, &force_tail_drop);
+	rte_kvargs_process(kvlist, CNXK_DIS_XQE_DROP, &parse_flag, &dis_xqe_drop);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
@@ -409,6 +412,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	if (roc_feature_nix_has_rx_inject())
 		dev->nix.rx_inj_ena = rx_inj_ena;
 	dev->nix.force_tail_drop = force_tail_drop;
+	dev->nix.dis_xqe_drop = !!dis_xqe_drop;
 	return 0;
 exit:
 	return -EINVAL;
@@ -434,4 +438,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_cnxk,
 			      CNXK_FLOW_AGING_POLL_FREQ "=<10-65535>"
 			      CNXK_NIX_RX_INJ_ENABLE "=1"
 			      CNXK_CUSTOM_META_AURA_DIS "=1"
-			      CNXK_FORCE_TAIL_DROP "=1");
+			      CNXK_FORCE_TAIL_DROP "=1"
+			      CNXK_DIS_XQE_DROP "=1");
-- 
2.25.1

