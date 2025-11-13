Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF40CCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:39:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 347E240E96;
	Thu, 13 Nov 2025 05:39:46 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 616C740E42
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:39:44 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD0ZsvT1254507 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 lHdbbUSqn2mUdoEWZ08p/248TCQtJ1k+pOWhzaFRH0=; b=EtM33p27UP9acyb0D
 jyxPgG3mlVYdclsuQVoKD4dmlCip9zJuF/Lq5esjXXkejjIl6MC0tqz1QoCWPdNJ
 xb9BgMSkkUV2yMaKOU7ZSFT+qJ94rk0+1JmxdK+nsOp+mMXH5V8cVaCvRZz+UYPv
 nLLioan2Hzqoe/lzFoh74PEu3H3uej9iMuaYiFcz/OpAr4NfzBEQokOOLxL768bO
 7f9PO25hyMExCqHA8158loF1x3SDj9MzN6i+GrV2yNS1UtEm/eL4AZ23s/CFWi9o
 pOnzPAZab/z06KbSjPgxt5KRvi28bKaP+QlnpGI7UXND894aYY+zFov/J7Zt4sbU
 s/vvg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ad4x7rfc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:39:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:39:42 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 521DB3F7076;
 Wed, 12 Nov 2025 20:39:37 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v5 15/23] common/cnxk: resolve klocwork issues
Date: Thu, 13 Nov 2025 10:08:00 +0530
Message-ID: <20251113043808.1180851-15-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX2t1pI/weVHy6
 wbulAVD9lGK7pdBY0RCGtuukadaOwzmEsSz+eiftVLSkM5ooWW1KjMEuaDLCGrAIodu88u8WjCW
 L1qQTeLl2qIsfUT1cwaJRWBBSDuj2stuxarQeWFlWs26R+Ja+mCqyBswBQo7f0T1SWzBj8zvuyU
 8QJbPOLmzL0wFQ2sOHUuG95XqHhNyYT2cXLQhiVGnivChA9AYuFlQrngTvuUkjb4G77fUX3FnZ9
 EILDrXAb87hOjOjuXi2wLB2TYIuBteB3zrsySuy4m91QfIB8x0iJn0KQk5yHwF131pc9ix0azrE
 cUE4pBNJkJA3avDXeaB0L3zacCxrgNOpgWqrtAZqoGWfk5ajMuWpnKFijdTEOYgyuAF3GLU6gzL
 EFmAtKdrOdX7qkaUyb/FJTa/ToACdA==
X-Authority-Analysis: v=2.4 cv=EfnFgfmC c=1 sm=1 tr=0 ts=6915610f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=G8DdwVB4TRNb03k8HkUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 2kOj11gr2Y1nXHYXsUoGb7shU1-7ZqgQ
X-Proofpoint-ORIG-GUID: 2kOj11gr2Y1nXHYXsUoGb7shU1-7ZqgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Fix klockwork for NULL pointer dereference

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_nix_queue.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 2c7fce1067..c7e37abf32 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -112,6 +112,11 @@ roc_nix_sq_ena_dis(struct roc_nix_sq *sq, bool enable)
 {
 	int rc = 0;
 
+	if (!sq) {
+		rc = NIX_ERR_PARAM;
+		goto done;
+	}
+
 	rc = roc_nix_tm_sq_aura_fc(sq, enable);
 	if (rc)
 		goto done;
@@ -2163,9 +2168,9 @@ nix_sqb_mem_dyn_free(uint64_t aura_handle, uint16_t count)
 int
 roc_nix_sq_fini(struct roc_nix_sq *sq)
 {
-	struct roc_nix *roc_nix = sq->roc_nix;
-	bool sq_resize_ena = roc_nix->sq_resize_ena;
 	struct ndc_sync_op *ndc_req;
+	struct roc_nix *roc_nix;
+	bool sq_resize_ena;
 	struct mbox *mbox;
 	struct nix *nix;
 	uint16_t qid;
@@ -2174,6 +2179,9 @@ roc_nix_sq_fini(struct roc_nix_sq *sq)
 	if (sq == NULL)
 		return NIX_ERR_PARAM;
 
+	roc_nix = sq->roc_nix;
+	sq_resize_ena = roc_nix->sq_resize_ena;
+
 	nix = roc_nix_to_nix_priv(roc_nix);
 	mbox = (&nix->dev)->mbox;
 
@@ -2228,7 +2236,7 @@ sqb_aura_dyn_expand(struct roc_nix_sq *sq, uint16_t count)
 	int i;
 
 	blk_sz = nix->sqb_size;
-	sqbs = calloc(1, count * sizeof(uint64_t *));
+	sqbs = calloc(1, count * sizeof(uint64_t));
 	if (!sqbs)
 		return -ENOMEM;
 
@@ -2300,7 +2308,7 @@ sqb_aura_dyn_contract(struct roc_nix_sq *sq, uint16_t count)
 	cycles = (timeout * 10 * plt_tsc_hz()) / (uint64_t)1E6;
 	cycles += plt_tsc_cycles();
 
-	sqbs = calloc(1, count * sizeof(uint64_t *));
+	sqbs = calloc(1, count * sizeof(uint64_t));
 	if (!sqbs)
 		return -ENOMEM;
 
-- 
2.34.1

