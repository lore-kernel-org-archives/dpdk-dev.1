Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC0C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDA184028C;
	Fri, 23 May 2025 15:51:28 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 67948400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 15:51:27 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9V42029877
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 ID+OeGZtbNNevou5zbNsxCA7KEHchVTlFMK3cj/PTc=; b=XT5y2maL3fr5Ct86D
 W7e9wGEebtJ/HYFWxhJPLweQzDhQbxiMNtjFaKmL1iIi2phig9ACEHyzcJk7YvLC
 N9JO2wLlzRZZaUjunxG/RK0ooKu7rRgyNSt7c5lqSYzfsVE4gYD6YoQDNJvocDsd
 hZLOREToGRvu5v8JLS5gre7BoP5q13qL9VDtSCauic69YVvRjPbPg9i0+pP+9uhJ
 CErdPOUWOgs//2lg9iuw4IT0Sc6cd6Q8shShrKXroxRZEKDF2tt3IQyEVD6Zs0Hq
 kiPekoqXdU00nE5mA1sW8gie9IeBaQDWIcEejlM3oly9oo/WYD7YzF5sb8WnjIp6
 8qnoA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:25 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 4B4E63F7041;
 Fri, 23 May 2025 06:51:22 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 03/40] crypto/cnxk: fix qp stats PMD API
Date: Fri, 23 May 2025 19:20:34 +0530
Message-ID: <20250523135111.2178408-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307d5e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=awJWYGnfD9vRpg5u9u8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXzivhS5XXdw+J
 BQ0onQ6xIHWN4wlon5ulQ5AEkM8dnxdPQGTp9NzGlWyb2aGNeWfefbzW5q0bS5dDrPmkltOCDCe
 Qxr9UjE8g0+D+8mhd78Zi1G+zVe0qu0+eHE4HEVL2dVO2xqBsIFJMth8KgrPj8m2ethMrqyLDTw
 DhPsqKy4dMP+ssXmgxk4NhFh4tQ7mBJ4DP7+xmHsoUQ+xkpvz6NDJGyyXWqBf1mjFud8qkGzgwB
 0otd/W75UzbZFURkoAqG1gl4PitBMCKJdG3u6JXlm724RoZJvyqjC1QWoUAad62Oy/o9TriF/ZJ
 287gauowc2wGt0qAo/Hf5xGbUiAzXqewOX1ETnOwomWMSY+pcgRxI3GJU8i99VLUFNUI3eZdrS4
 8z9VnirW65VuJ1gN1fXOw+FK9f7M1zop93RvIHtORvBXABMPkSlnu3OmfNQqL+cPyEcQTijD
X-Proofpoint-GUID: sbRXRYyC5HvwR2u2Jda4k8VdxLmMsnDV
X-Proofpoint-ORIG-GUID: sbRXRYyC5HvwR2u2Jda4k8VdxLmMsnDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

Fixing qp stats PMD API.

Fixes: bf52722b9377 ("crypto/cnxk: add PMD API to get queue stats")

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 613ce11ec1..61f3e135aa 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -1218,7 +1218,7 @@ rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
 
 	stats->ctx_enc_pkts = plt_read64(lf->rbase + CPT_LF_CTX_ENC_PKT_CNT);
 	stats->ctx_enc_bytes = plt_read64(lf->rbase + CPT_LF_CTX_ENC_BYTE_CNT);
-	stats->ctx_dec_bytes = plt_read64(lf->rbase + CPT_LF_CTX_DEC_BYTE_CNT);
+	stats->ctx_dec_pkts = plt_read64(lf->rbase + CPT_LF_CTX_DEC_PKT_CNT);
 	stats->ctx_dec_bytes = plt_read64(lf->rbase + CPT_LF_CTX_DEC_BYTE_CNT);
 
 	return 0;
-- 
2.25.1

