Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6802BF3028C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9591B4025E;
	Mon, 16 Mar 2026 07:16:44 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 52547400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 07:16:42 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62FKuehx3105073 for <dev@dpdk.org>; Sun, 15 Mar 2026 23:16:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=ZUKPN09wFy1bC6eUVGgLekr
 ZazmQnZNnVq3l4XzLbeU=; b=FhOiuHnDeYxJgw6TCQmdhIKCYHV6CyZAwXTcMgg
 w9kqbjoEGDzwaT47PfIvgF2gw5AtI333YNgikfWwDfPOiXCstwLIWLgZdt1bYGAN
 rSxpw1i1+pusjF6HFrSG7AizJVpyHuK93qNGNzNZg5cZYNcTzfIlWuXGaw31OOC3
 ZjNld6uf43rv1qvyV8WOCo3NBwqqCicWHUcd06gc7hlGZQ4ziMV1It7I08A/mta1
 T0dk8yel4u0gEd0MfwrRgr/rcKHSR1PpwV/z9IBnMXil77SXxvf7/vyddCCMqst3
 clx69Vv67jrPF4auQB2lWMLMdWIIbMflQKXuUkdBr9T5PeQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cx02r14vc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 15 Mar 2026 23:16:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Mar 2026 23:16:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 15 Mar 2026 23:16:41 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 27A4C3F7091;
 Sun, 15 Mar 2026 23:16:37 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Ashwin Sekhar T K" <asekhar@marvell.com>
CC: <jerinj@marvell.com>, Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH 1/1] common/cnxk: fix width of dpc set field
Date: Mon, 16 Mar 2026 11:46:31 +0530
Message-ID: <20260316061635.4178854-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8Z5Y2iFmQ1AhbPsDzFLbWPK7Te0qqbuC
X-Proofpoint-GUID: 8Z5Y2iFmQ1AhbPsDzFLbWPK7Te0qqbuC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0NSBTYWx0ZWRfX8CskO+kjAyro
 AfQAr2vunCt7d5lr1XfEgCnCZuwgQo658XRL/zS4YCLTVjBTD8zRPjCx+Fy7MIEzOLYjAIthE++
 h4u3C68tYjkiFGV5WrH5GxUI1OMVQE1nHrroDinOB/s6CsCi92cQiiLxPv/p/K2N/3uC5tWhstF
 T7jWF6CroSzo5btAACIzbWqj1rxx3Hbl0y6WEP1PJQpOoB5V2nqStj1Czl77oJ0awh06pj7eQcS
 hRDvDu/yqskRgxgghqxWlt4wzE/gKFGaZPZH5n2nPOccZVrV4RFEbzZKVjhhbo74L1JqhB0k+Q5
 WJ8ASNdUCrCpAvZ5aovltviTaHrCVB0sAXELYMEjnUVPDdCA+Sis/xmzahXAofTMWnpZWKzHetZ
 uisPXRJAbGOC5UxKWqqQnA2Oocmc8Po0QyJ7M2n/myqBV4NyqDhkXom4Q1/frzHM9c0OaDL12S0
 BlGuSAJy047LR+e5nBg==
X-Authority-Analysis: v=2.4 cv=RvvI7SmK c=1 sm=1 tr=0 ts=69b7a049 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=MlpC_pbAKLnuYwlk51UA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
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

Fixed width od op_dpc_set member of npa_cn20k_pool_s and
npa_cn20k_aura_s.

Fixes: 143a419edf35 ("common/cnxk: use new NPA aq enq mbox for CN20K")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/hw/npa.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/hw/npa.h b/drivers/common/cnxk/hw/npa.h
index e421c70e01..0c7a8923df 100644
--- a/drivers/common/cnxk/hw/npa.h
+++ b/drivers/common/cnxk/hw/npa.h
@@ -375,7 +375,8 @@ struct npa_cn20k_aura_s {
 	uint64_t fc_msh_dst : 11;
 	uint64_t rsvd_438_435 : 4;
 	uint64_t op_dpc_ena : 1;
-	uint64_t op_dpc_set : 6;
+	uint64_t op_dpc_set : 5;
+	uint64_t rsvd_637_637 : 1;
 	uint64_t stream_ctx : 1;
 	uint64_t unified_ctx : 1;
 	uint64_t rsvd_511_448 : 64; /* W7 */
@@ -446,7 +447,8 @@ struct npa_cn20k_pool_s {
 	uint64_t fc_msh_dst : 11;
 	uint64_t rsvd_630_627 : 4;
 	uint64_t op_dpc_ena : 1;
-	uint64_t op_dpc_set : 6;
+	uint64_t op_dpc_set : 5;
+	uint64_t rsvd_637_637 : 1;
 	uint64_t stream_ctx : 1;
 	uint64_t rsvd_639 : 1;
 	uint64_t rsvd_703_640 : 64;  /* W10 */
-- 
2.48.1

