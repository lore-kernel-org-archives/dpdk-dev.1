Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6935CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 10:29:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2D554028C;
	Mon,  3 Nov 2025 11:29:53 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6E16740281
 for <dev@dpdk.org>; Mon,  3 Nov 2025 11:29:52 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A2N1A9Z2903225; Mon, 3 Nov 2025 02:29:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=G3YIxuOvmUIMaG+5V8awv2X
 CH28T9f57PslWCe91Eyk=; b=bwkFBepHCKq1d1sEKgpnqi7YRR6KL3hWJ73d27a
 UxJXxVZVVwepwSjpzc5hX4Z+3HbZYgclOiLBETK935w1s0smpDy3Wfq+2Nc98/GQ
 u14z4dpFTGMPDpBdUEzvezT2w8xGwJrI1aPeUXfwgBryPmCIVpgjcZ77qYTsbC0D
 PrUDqETlvMDNDMP2cMYwEFE2LfPTubAdU5bvqY/5s/p3BrPpP/vZXaUK6xBeLPAL
 xQ286chymESGFssp7aCLnc/8wq2xce9xvC6wdUEFfKvp41+fVr1x3mrKI90+6waW
 FAkb1RqfAdWpX4Ldh0KCzB+r6pxRWyFHPyOtrtZvMf3d8fw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a5hqhutgf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 02:29:51 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 3 Nov 2025 02:30:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 3 Nov 2025 02:30:01 -0800
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 3EEB53F707A;
 Mon,  3 Nov 2025 02:29:49 -0800 (PST)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <vattunuru@marvell.com>
Subject: [PATCH v0 1/1] dmadev: add domain_id field to access group join API
Date: Mon, 3 Nov 2025 15:59:46 +0530
Message-ID: <20251103102946.2204883-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XPo9iAhE c=1 sm=1 tr=0 ts=6908841f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=qjn32rItXJ_V2gynzXoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BATBhw39eHINFbtsoimPdNg0RB2gFZ2s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NiBTYWx0ZWRfX1o57e0IeULSg
 J3LDzIzBPJeYgaiM2I5tmVHhY/vJPc13Ga+/9PD13GT/4ZuOpWRcPL4lIcz8EQVTRpbV8xMQ1Ea
 W9sAw4tClGfMTb7t3bq0vLbVhXT6z6DHBaWDKM8j727XK2fh5LJY+ZweSiCLGTG2spvXHcS89RP
 zDbnAKVNyGu2GtopQPIF+qEy2doz5ls+OMA22oSS7zhiwxJTGRSxSrdSvvR4p6vj8tIEh1o8GVG
 WyxSt3bCCuME40yd5ZJaE/OskVNZGISuN/Kh04Fo/y1mxafG2ZNeiW2vEu5+nhGqYO4/+3+4+xg
 L3tXC9kMN4FIn9GZhGwVMxRiLye2uvgwyQ92AaFxjqghG4j+4b7o6y2LXl1LZ5g/b8ALk/MX56P
 weLmmN7xdfXcTL9BgnHqcoOu1uPjhg==
X-Proofpoint-GUID: BATBhw39eHINFbtsoimPdNg0RB2gFZ2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Add domain_id field to access group join API, which is required
to retrieve handler information associated with the specified domain.
This enhancement ensures that domain-specific context is available
during group join operations, improving flexibility and traceability
in multi-domain environments.

It also aligns the parameters of access group create and join APIs
for consistency and clarity.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 lib/dmadev/rte_dmadev.c       |  6 +++---
 lib/dmadev/rte_dmadev.h       | 10 ++++++----
 lib/dmadev/rte_dmadev_pmd.h   |  4 ++--
 lib/dmadev/rte_dmadev_trace.h |  6 ++++--
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index c008e829db..b75b4f9bd1 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -875,8 +875,8 @@ rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id)
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dma_access_pair_group_join, 25.11)
 int
-rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
-			       rte_dma_access_pair_group_event_cb_t cb)
+rte_dma_access_pair_group_join(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+			       int16_t group_id, rte_dma_access_pair_group_event_cb_t cb)
 {
 	struct rte_dma_info dev_info;
 	struct rte_dma_dev *dev;
@@ -899,7 +899,7 @@ rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t toke
 
 	if (*dev->dev_ops->access_pair_group_join == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->access_pair_group_join)(dev, group_id, token, cb);
+	return (*dev->dev_ops->access_pair_group_join)(dev, domain_id, token, group_id, cb);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dma_access_pair_group_leave, 25.11)
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 0f4f10ec12..5287b0f32d 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -912,10 +912,12 @@ int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
  *
  * @param dev_id
  *   Identifier of the DMA device attempting to join the group.
- * @param group_id
- *   ID of the access group to join.
+ * @param domain_id
+ *   Unique identifier representing the process or OS domain.
  * @param token
  *   Authentication token used to validate group membership.
+ * @param group_id
+ *   ID of the access group to join.
  * @param cb
  *   Callback function to be invoked when the device leaves the group
  *   or when the group is destroyed due to some exception or failure.
@@ -925,8 +927,8 @@ int rte_dma_access_pair_group_destroy(int16_t dev_id, int16_t group_id);
  *   negative value on failure indicating the error code.
  */
 __rte_experimental
-int rte_dma_access_pair_group_join(int16_t dev_id, int16_t group_id, rte_uuid_t token,
-				   rte_dma_access_pair_group_event_cb_t cb);
+int rte_dma_access_pair_group_join(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+				   int16_t group_id, rte_dma_access_pair_group_event_cb_t cb);
 
 /**
  * Leave an access group, removing the device's entry from the group table
diff --git a/lib/dmadev/rte_dmadev_pmd.h b/lib/dmadev/rte_dmadev_pmd.h
index 16fd625c2d..8a6b0a9c98 100644
--- a/lib/dmadev/rte_dmadev_pmd.h
+++ b/lib/dmadev/rte_dmadev_pmd.h
@@ -75,8 +75,8 @@ typedef int (*rte_dma_access_pair_group_destroy_t)(const struct rte_dma_dev *dev
 						   int16_t group_id);
 
 /** @internal Used to join an access pair group for inter-process or inter-OS DMA transfers. */
-typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, int16_t group_id,
-						rte_uuid_t token,
+typedef int (*rte_dma_access_pair_group_join_t)(const struct rte_dma_dev *dev, rte_uuid_t domain_id,
+						rte_uuid_t token, int16_t group_id,
 						rte_dma_access_pair_group_event_cb_t cb);
 
 /** @internal Used to leave an access pair group, removing the device from the group. */
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index da80a8cb50..7ad00b5bfa 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -120,10 +120,12 @@ RTE_TRACE_POINT(
 
 RTE_TRACE_POINT(
 	rte_dma_trace_access_pair_group_join,
-	RTE_TRACE_POINT_ARGS(int16_t dev_id, int16_t group_id, rte_uuid_t token),
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, rte_uuid_t domain_id, rte_uuid_t token,
+			     int16_t group_id),
 	rte_trace_point_emit_i16(dev_id);
-	rte_trace_point_emit_i16(group_id);
+	rte_trace_point_emit_u8_ptr(&domain_id[0]);
 	rte_trace_point_emit_u8_ptr(&token[0]);
+	rte_trace_point_emit_i16(group_id);
 )
 
 RTE_TRACE_POINT(
-- 
2.34.1

