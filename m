Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F776C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 03:03:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7B3040671;
	Mon,  9 Jun 2025 05:03:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7853D40670
 for <dev@dpdk.org>; Mon,  9 Jun 2025 05:03:23 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5590TrJG019916;
 Sun, 8 Jun 2025 20:03:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 32YOtBqZFlWq80QLz4lw2rCEy+Mt5RxHEkyyYmduRc=; b=h2IDiG5ubbj8zCbVo
 WCtLQoZtqeYMBGpPNow2DebAINS2MdvB5MrlZ181nraAOnq6W1NydWSIQDu6H8mB
 vjo4FvczuJ6dR77ZFzRyMxRTFfW/2iLpl2aUqvGxLyQGxn/q8PPtjk7YkgMRD6h4
 Je0ltrkLIPOxdV2gOMz3x/emNz7OaEAPxrnczlH7tXjydxVHVC/lU0E+Di6dxx9a
 lIozGTrOaNhNkcXm+aovPblEu92wsT3QJEYMbG2Iwyno/OMIdD6Zmo0ihE6nkWz4
 Oi6on43ZxQg/yTVXTkIEDgIWqU23ym/SemL8UVBCw55nNky/G6LRuLhEdEBwPvxm
 fOTbA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475mbfr8rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 20:03:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 8 Jun 2025 20:03:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 8 Jun 2025 20:03:21 -0700
Received: from localhost.localdomain (unknown [10.28.36.179])
 by maili.marvell.com (Postfix) with ESMTP id 41A4D3F707B;
 Sun,  8 Jun 2025 20:03:18 -0700 (PDT)
From: Vidya Sagar Velumuri <vvelumuri@marvell.com>
To: Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <gakhil@marvell.com>, <jerinj@marvell.com>, <anoobj@marvell.com>,
 <vvelumuri@marvell.com>, <asasidharan@marvell.com>, <dev@dpdk.org>, "Amit
 Prakash Shukla" <amitprakashs@marvell.com>
Subject: [PATCH v4 1/2] test/dma: update the sg test to verify wrap around case
Date: Sun, 8 Jun 2025 20:03:13 -0700
Message-ID: <20250609030314.4098409-1-vvelumuri@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250606094031.2961842-1-vvelumuri@marvell.com>
References: <20250606094031.2961842-1-vvelumuri@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tYlXvaA3brJWpu0SsgOywAFHLfDHqMqY
X-Authority-Analysis: v=2.4 cv=a5sw9VSF c=1 sm=1 tr=0 ts=68464efa cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=iHgLnrOxfg0iJxBGLQYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAyNCBTYWx0ZWRfX+QjjVgGCSMtD
 pkzqZPoWbZC7yXDAwzMlf/KYlMeR1tqUem/cV5fvuJEV50PMW3e1c4WUA5Yw3m0+cA4ylwsAClA
 7eYonG4afwQRMTBnEJ2DcX5hQPhMS+tFSUWpo0rTCJKawaWpLU4SpMIRgJGM60T9TpeYxhbS7ZA
 zIcTKFmtRKr8o7qBoI4sXNqYoHOK81a/Tt6MI2HjsAAT0vOv+lvENRcIqjAWfLKm7WnJcvu7ZUY
 GYftILPJOwgRmblZ766pGVHF6puEA3eVAWOB9KhCXMoxF+Flhxoc+25GWPjGt5G3Lmb2BeJLxpk
 27M4r5S16uQL5+67Z3sYNswK74ehWVuAfwKt1j8afnNhsyOET72y9wul4GA686KiLuVjjzexv7X
 iVcI2VLcKGBqf2m5FcoyEoDXszCdv2f6J2h6ZBAfZWpqZprqDZVWNc9R7v4CcasCvJ82l3DX
X-Proofpoint-GUID: tYlXvaA3brJWpu0SsgOywAFHLfDHqMqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_01,2025-06-05_01,2025-03-28_01
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

Run the sg test in a loop to verify wrap around case.
Total number commands submitted to be more than the number descriptors
allocated to verify the scenario.

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 9cbb9a6552..88c3d02fd6 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -393,36 +393,28 @@ test_stop_start(int16_t dev_id, uint16_t vchan)
 }
 
 static int
-test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
+test_enqueue_sg(int16_t dev_id, uint16_t vchan, unsigned int n_sge, unsigned int test_len)
 {
-	unsigned int src_len, dst_len, n_sge, len, i, j, k;
 	char orig_src[COPY_LEN], orig_dst[COPY_LEN];
-	struct rte_dma_info info = { 0 };
+	unsigned int src_len, dst_len, i, j, k;
 	enum rte_dma_status_code status;
 	uint16_t id, n_src, n_dst;
 
-	if (rte_dma_info_get(dev_id, &info) < 0)
-		ERR_RETURN("Failed to get dev info");
-
-	if (info.max_sges < 2)
-		ERR_RETURN("Test needs minimum 2 SG pointers");
-
-	n_sge = info.max_sges;
-
 	for (n_src = 1; n_src <= n_sge; n_src++) {
 		for (n_dst = 1; n_dst <= n_sge; n_dst++) {
 			/* Normalize SG buffer lengths */
-			len = COPY_LEN;
-			len -= (len % (n_src * n_dst));
-			dst_len = len / n_dst;
-			src_len = len / n_src;
-
 			struct rte_dma_sge *sg_src = alloca(sizeof(struct rte_dma_sge) * n_sge);
 			struct rte_dma_sge *sg_dst = alloca(sizeof(struct rte_dma_sge) * n_sge);
 			struct rte_mbuf **src = alloca(sizeof(struct rte_mbuf *) * n_sge);
 			struct rte_mbuf **dst = alloca(sizeof(struct rte_mbuf *) * n_sge);
 			char **src_data = alloca(sizeof(char *) * n_sge);
 			char **dst_data = alloca(sizeof(char *) * n_sge);
+			unsigned int len = test_len - (test_len % (n_src * n_dst));
+
+			dst_len = len / n_dst;
+			src_len = len / n_src;
+			if (dst_len == 0 || src_len == 0)
+				continue;
 
 			for (i = 0 ; i < len; i++)
 				orig_src[i] = rte_rand() & 0xFF;
@@ -514,6 +506,27 @@ test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
 	return 0;
 }
 
+static int
+test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
+{
+	struct rte_dma_info info = { 0 };
+	unsigned int n_sge, len;
+	int loop_count = 0;
+
+	if (rte_dma_info_get(dev_id, &info) < 0)
+		ERR_RETURN("Failed to get dev info");
+
+	n_sge = RTE_MIN(info.max_sges, TEST_SG_MAX);
+	len = COPY_LEN;
+
+	do {
+		test_enqueue_sg(dev_id, vchan, n_sge, len);
+		loop_count++;
+	} while (loop_count * n_sge * n_sge < TEST_RINGSIZE * 3);
+
+	return 0;
+}
+
 /* Failure handling test cases - global macros and variables for those tests*/
 #define COMP_BURST_SZ	16
 #define OPT_FENCE(idx) ((fence && idx == 8) ? RTE_DMA_OP_FLAG_FENCE : 0)
diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
index fb49fcb56b..c38c4c1f49 100644
--- a/app/test/test_dmadev_api.c
+++ b/app/test/test_dmadev_api.c
@@ -16,7 +16,6 @@ extern int test_dma_api(uint16_t dev_id);
 
 #define TEST_MEMCPY_SIZE	1024
 #define TEST_WAIT_US_VAL	50000
-#define TEST_SG_MAX		64
 
 static int16_t test_dev_id;
 static int16_t invalid_dev_id;
diff --git a/app/test/test_dmadev_api.h b/app/test/test_dmadev_api.h
index 33fbc5bd41..a03f7acd4f 100644
--- a/app/test/test_dmadev_api.h
+++ b/app/test/test_dmadev_api.h
@@ -2,4 +2,6 @@
  * Copyright(c) 2021 HiSilicon Limited
  */
 
+#define TEST_SG_MAX		64
+
 int test_dma_api(uint16_t dev_id);
-- 
2.25.1

