Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D973BCD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AE6940669;
	Mon, 15 Jun 2026 18:26:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 71C05400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:03 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFc6NA1125356 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 iHFIZB4HhRnmEKhP2p/H9y7y0clfGj4Q58XytF9nJQ=; b=Y/yyJFZkRxopRDjpo
 xrtfEPxPU9Sv7QJo1zVKGoJSyCOv/bEjWX4QfcXSGGZMZYxffx1LfSIJzw7Ol/Po
 BmJENpPkhXNawNZlc4DOmQkZmX989xf/1WsuI5p24ca8p1Xj21phDiNQ1gWKCD7s
 pOmMyAJVQ0BUYfHPmd/kpbWzLfo7UBqgCNJeDqYv/9+4YNq6W5MXO3P33WOOnCXP
 z6Vl1TNJVckwtp4SK2Pr6kpTnFiM5KJJqklmxnyRf7jpNr3cSER69FGlOeNoWg/3
 0Y5T978dAdsr0j2FW0fyCh+ntPnMqG7r2Ybq//HwFRPhYzxjaaD3qZ7R2olSpaja
 gkcAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk05yp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:01 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 355C73F7063;
 Mon, 15 Jun 2026 09:25:57 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 02/20] common/cnxk: add API of SA valid for cn20k platform
Date: Mon, 15 Jun 2026 21:54:28 +0530
Message-ID: <20260615162446.578336-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UaCSPbdAdpFEY_LPO_oWim-cu96851Au
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a30279a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=fwZZ1n-ia9gD9N035NoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3MiBTYWx0ZWRfX10aPc54P+/Ym
 mM9Y4LhV4fxsBIqAXCvUr8/e7nc8l+qIodxvKxdI4nYnfXc7siHdMxpNS3UyRLKgxhSJGUw6zEq
 W6u0c4RyBHhgCyo/XAolgbk/Hj800O8=
X-Proofpoint-GUID: UaCSPbdAdpFEY_LPO_oWim-cu96851Au
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3MiBTYWx0ZWRfX0NrBvbqe2+co
 xJkSw7myDnrCKuijdKFm9H5k+UnhlJuM5bBCtUs7VVIrWUm5oioMg4Qxmn9A3LslR6JBQpXlN0S
 zE6iBPlzaSvfge1XySXfp0VE9YTaSSe4WQta+OGzUcwgQ9X3nBP/F1vMfyhA/A5p9rZhB2aONYv
 nG196HooAZzla2Kb4yHRh2YE0TKmel/rK+stYueB4qplvIkurRDaPumf2iSR1vI9iZMtFOHpvVk
 YZeQ6K/FQt/6mBvVRWNM/4oGcethN8jWw4Q4dwZxPIQ0fMB2Dr8inIyZC2hqMQzFN4gnDHhL6tm
 UjWsNa4JhK5tb6Qdhv1DYaj26ygy+GQDr0nDNGkdDP6ABrULqzlIU9Ay4++QeHjQDhJIkARiHmc
 RBuKm4JUDea9vKKg5TKTkN1iihHtIb4SdhDNCRpGawbtoYPmlLC1x8UgIqT1tDoUAa7m0YOowIY
 AmPGsVLrza045zfCABg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

Add API to get SA valid configuration for cn20k platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/common/cnxk/cnxk_security.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 6b51055100..6f46ad3276 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -606,6 +606,20 @@ cnxk_ot_ipsec_outb_sa_valid(struct roc_ot_ipsec_outb_sa *sa)
 	return !!sa->w2.s.valid;
 }

+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_inb_sa_valid)
+bool
+cnxk_ow_ipsec_inb_sa_valid(struct roc_ow_ipsec_inb_sa *sa)
+{
+	return !!sa->w2.s.valid;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_outb_sa_valid)
+bool
+cnxk_ow_ipsec_outb_sa_valid(struct roc_ow_ipsec_outb_sa *sa)
+{
+	return !!sa->w2.s.valid;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_ivlen_get)
 uint8_t
 cnxk_ipsec_ivlen_get(enum rte_crypto_cipher_algorithm c_algo,
--
2.34.1

