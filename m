Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB9BC5B559
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 09:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1825C40674;
	Fri,  6 Jun 2025 11:41:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 330E440265
 for <dev@dpdk.org>; Fri,  6 Jun 2025 11:41:26 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555NTTTx028692;
 Fri, 6 Jun 2025 02:41:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 32YOtBqZFlWq80QLz4lw2rCEy+Mt5RxHEkyyYmduRc=; b=Fwrm1m922JB3yQPbp
 27E/2XUSuq7cJSLC82UWOnaGuf4La4lt+B6TpugK0B1e6SuPX6wIuNhAJGuTk+pj
 cUPhYJN7nUDTAtHSHU057XWiOyBfT/YyrnplFzVcatu9ZtZAiggLgYHSXkKcMpXy
 PNw4JkuLt1bwcCkr0KsuJgjm7tqc3w2PgTV2QAOX3Ft1ts9xq7wPtott7CwINylW
 zInZDQzfsgPiAenxGTRrrVFAdx571HK3dFRElbEeZM0jwmEkKwTu8NRsNYaSVtrv
 OfNG43bfl0rNZKxPOHd7E9AEKXXag8jxpQWvrWmqyOfNBHiTI57gyr2pI/zajmeP
 LfXYw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 473mxxgyth-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 02:41:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 6 Jun 2025 02:40:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 6 Jun 2025 02:40:53 -0700
Received: from localhost.localdomain (unknown [10.28.36.179])
 by maili.marvell.com (Postfix) with ESMTP id 1A69F3F7051;
 Fri,  6 Jun 2025 02:40:49 -0700 (PDT)
From: Vidya Sagar Velumuri <vvelumuri@marvell.com>
To: Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <gakhil@marvell.com>, <jerinj@marvell.com>, <anoobj@marvell.com>,
 <vvelumuri@marvell.com>, <asasidharan@marvell.com>, <dev@dpdk.org>, "Amit
 Prakash Shukla" <amitprakashs@marvell.com>
Subject: [PATCH v3 1/2] test/dma: update the sg test to verify wrap around case
Date: Fri, 6 Jun 2025 02:40:30 -0700
Message-ID: <20250606094031.2961842-1-vvelumuri@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419090734.43613-1-vvelumuri@marvell.com>
References: <20240419090734.43613-1-vvelumuri@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: f2Ky4DQ_uE410RegenGCIcTBo8a8l-69
X-Authority-Analysis: v=2.4 cv=Z7bsHGRA c=1 sm=1 tr=0 ts=6842b7ba cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=iHgLnrOxfg0iJxBGLQYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: f2Ky4DQ_uE410RegenGCIcTBo8a8l-69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA4NyBTYWx0ZWRfX5IEenPBBvSM1
 kak82T1fDePYO8iEYQMnppLPp2cMPQMK3ZH/5JfG2W/M6sy7DoCqC/NVG2c3J/ftFWGd7RupLKq
 ZDNJ/+I/7WI4cztm7alBJTRZt5NFAuzIme7cuP5UjnOYsYMcr1HwsJgOh1UwUxnLGVZYUaTMfOs
 ffEnoh+KDYLZ+Znmz+tUvTAI95Dp+DFw0dbWOgI2TXCeVCXBzG/pK/bQHI3RbDw9bNqNMXJHU59
 poNX+t2NtQcZecmAxfeAQzdrYI0Z2IXVF3BeeeXHNXQlnTNHGWEUwut+Jo01PSs9fAd2Uz3gkLe
 S/nLFy7vOeS+r19fB3pPN4aoCCPlZqt6wW6NMyQnRdQtWuBwihm7soH2wsjuthh9vAOhwSbUqla
 PEs3gNvaejzTcqrYPxb+cEjC/YGi01j7Qz7ibe3kzAnHpO3e93kIWrOvJA1t5GoZHGhwM12Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_03,2025-06-05_01,2025-03-28_01
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

