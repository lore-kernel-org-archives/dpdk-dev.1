Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB61CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 18:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49BBD40659;
	Mon, 25 May 2026 20:43:37 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0]) by mails.dpdk.org (Postfix) with ESMTP id 4152A4065B
 for <dev@dpdk.org>; Mon, 25 May 2026 20:43:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVdBlvwe8yI8yhSPRMC93Qfl5VgyQM4nCZPfBSELwFncQU/Y1JOw4+exW1VK/lew9NnzhAFcimz5Q/HQtaDDb27FCzgYuwuNnICH9Du2qkk0aglz0tOfOukwPd3Cblr64oXLyZpMxl2V7SXs9d7cHkzn0/1/mg4mGccyhXrhWvA6tsstS5pkBLy+Ms1xxV8HzE5gzOiM+dR/pf8HUs+jD7W8YN1FNI/zN3b6RGfQxIb44FlJcCxWpTJvogIWoG4gFqnfMQSxk50Pg343iOfu4NbW5ffoBd3S/CqhukMh60mOpUGXgcaGUacbtQSisR+2LTTNzrae4pEP/fWcFNScXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnOPTc6DJrLbAHwpQxYZpMKgcsiBrZ4vfOd8+2tcads=;
 b=bxqWsfzCyEctZkfS416DfsdNJ+rR11Jhw/GkmpOwV0Nu77mIRtC0Jd8kipOe7M8s+E/8vDA6+aOI8N7ha5R3nON2UJOC2NRUKbrhfRfQSS90HLvxsXuSLRqHSf+qG6KRVZbzdimS6aYRwrFR8Ql/vURRXadKzk57GEuXUJQhzkowsNMaAGCoxrT6R6WefbxLraXZfYD1e8JwB5V69R+yibPgoqt3lhSZ/G5c/2xn+by5XFZRR0MoqYwIYLoEr62TxfJyVCdBlcVFG2puRiIpt7b09qUtKiHqFo+wvEh1mstRLwJUn65hiIvHM9kpvzHpk7ggwojmwZvkP2r7OGvsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnOPTc6DJrLbAHwpQxYZpMKgcsiBrZ4vfOd8+2tcads=;
 b=l6zJYodfYIkEX/UCj4TqX3xO4ulgSQ/O78Xerf5Aa9HqWPb2VKcf1cwYHHsvZyTep8IMwG3vaNGtL1lqkP6sht+bOZjUXGkAThjOtJN7q4TztSltOkk3MI4aUSOb74BmKidSjfrT2xN1/OuSLfKJuPe9lxJXxGz2PUoHfhMkFbQ=
Received: from CH0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:610:e6::22)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 18:43:30 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::d) by CH0PR03CA0287.outlook.office365.com
 (2603:10b6:610:e6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:43:30 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 13:43:27 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>, <david.marchand@redhat.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2 3/3] dma/ae4dma: add data path operations
Date: Tue, 26 May 2026 00:12:44 +0530
Message-ID: <20260525184244.1758825-4-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a00895-ea67-4417-c44b-08deba8d8426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003|4143699003|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: wvKybJj0X+gmyzq8NC5tnqI+kRW64RhKgXtRuj6GNmnaY6fOu1BCouscbPdo1TSaNcy4GWXAayR/+JLAx6ab7LJLOghnL9sQECY3O8W3LnGPPnfi8qxL9iTylMI79gKt2IhI/BXDviy6S8wwiWf2sBssLopgM4hF4tP6mXiWSLxg/7lE1rJEQ5Mlu5tJfWIwQwCEJmJ8tdAFJqRofgNgDVTo/vOmZ0imEdPYVtuCpjdYne6s3YPbvmwUWkHjbtI+VUo3hjAcDiRGJEcBTxXZxi96GK5XRIw3uMS8z+HR3+A1mNOBaBDTzbmUg5MgX+DD2uql1BGveoHowXK90tOKsI0L3nZevhtpBaTgmCXw4VszCk0SoFekD3j2GZl6mJIxQ+1lHGg9j9XJbJ20gS8q4qeWNqTPPBbHZ1jRpi7oHYmaM6FersOhMm1/tc7uNtOdBAsEyuBHbHNPP20RjNuKb/eENG8dsktQIfQrCqyKfXWUKdvgYVVxdNoD0W1kkspdEfqXCX6e5zzfxV0fwVom02HVdFg0EWGwUvKISNkXsVieZ1RdE+aeOpz9umFOsSI0KMl01FFayO+7gatWSSYudlS64LM8nZg+K4FftnVd2dQvx0i2u5QTm3oOAlzFfqYjw7TYuoZtstlb7TCHT6l0C65VRyxOIfb75lQntGPWtVp+3b9o0Ql0g5h1Cn+Xey3iMHzSKc3aMpyTx7n/fVS4NfL7GWqGOI5D7Mv01QLgxXY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003)(4143699003)(6133799003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v6n0Ypn89fHsaCwLMIiZQ9lEQ9K1saXjgmb5/VZhvSh5SFcE+4c/+fYhF5iM5u1e/MXi8Uz2C/l1vnSAvRo/mM9PDd4VsnyaRjiip19gXzVFDOhBGhF0hC83tcWHLbeh3FyISqiAAWuKFk886CE5M/PNbw4+SrRfO+XjdBPrrq9SAIY3CEW1Hu6qDTYufFsMSuH0yjE5l0kU76P3AlhLM5oKYEpMntKPzFMmjen1EPGYjylyTtLaqL2K8Ci7V6PWoTqnSy8lhkkZSyKzaEKb6xovN4fRajH2Eal6fy5137WxysU8uNjcYTD1PTDpgRlM0NfSKpXY5BM7w5vG3JUjTtRyS0y52yas67w/XWtz5yLU2BSZSdMc3MPXG42wusoLlWmh/ZjfFaqyLfKnDrKLmBfXUdxlFbHCxvbv8Ob1IqMT/7gXuwikV+eHFh3whq1Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:43:30.2790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a00895-ea67-4417-c44b-08deba8d8426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
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

Implement the dmadev fast path for the AMD AE4DMA PMD.

This commit adds:
 - copy enqueue (rte_dma_copy): write an AE4DMA descriptor for a
   memory-to-memory transfer; on RTE_DMA_OP_FLAG_SUBMIT the doorbell
   is rung immediately.
 - submit (rte_dma_submit): advance the per-queue write_idx
   register to expose pending descriptors to the hardware.
 - completion (rte_dma_completed / rte_dma_completed_status):
   completion is detected via the hardware's per-queue read_idx
   register, which the engine advances as it processes descriptors.
   The descriptor status / err_code bytes are read only to classify
   each drained slot as success or failure, and HW error codes are
   translated to the dmadev RTE_DMA_STATUS_* enumeration.
 - burst capacity (rte_dma_burst_capacity): report the number of
   free descriptor slots, taking into account the one slot reserved
   to distinguish full from empty on the power-of-two ring.

The fast path entry points are wired through fp_obj in
ae4dma_dmadev_create(). The fill capability is not advertised;
fp_obj->fill is left zero-initialised.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/dmadevs/ae4dma.rst      |  22 +++
 drivers/dma/ae4dma/ae4dma_dmadev.c | 288 +++++++++++++++++++++++++++++
 2 files changed, 310 insertions(+)

diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
index a85c1d92ca..37a2096ccf 100644
--- a/doc/guides/dmadevs/ae4dma.rst
+++ b/doc/guides/dmadevs/ae4dma.rst
@@ -51,3 +51,25 @@ On probe the PMD performs the following steps for each PCI function:
   IOVA-contiguous memory, programs the queue base address and ring
   depth into the per-queue registers, and enables the queue.
 * Interrupts are masked; completion is polled by the application.
+
+Usage
+-----
+
+Once a dmadev has been started, copies are submitted with
+``rte_dma_copy()`` and completions are reaped with ``rte_dma_completed()``
+or ``rte_dma_completed_status()``. See the
+:ref:`Enqueue / Dequeue API <dmadev_enqueue_dequeue>` section of the
+dmadev library documentation for details.
+
+Limitations
+-----------
+
+* Only memory-to-memory copies are supported. Fill, scatter-gather and
+  any other operation types are not advertised in
+  ``rte_dma_info::dev_capa``.
+* The maximum number of descriptors per virtual channel is fixed by
+  hardware at 32. The PMD rounds the requested ring size up to a
+  power of two and clamps it to 32.
+* Only a single virtual channel per dmadev is supported; use the 16
+  per-PCI-function dmadevs to obtain channel-level parallelism.
+* Interrupt-driven completion is not supported.
diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
index dfda723c13..0f223fc40c 100644
--- a/drivers/dma/ae4dma/ae4dma_dmadev.c
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -167,6 +167,73 @@ ae4dma_dev_close(struct rte_dma_dev *dev)
 	cmd_q->qbase_phys_addr = 0;
 	return 0;
 }
+
+/* trigger h/w to process enqued desc:doorbell - by next_write */
+static inline void
+__submit(struct ae4dma_dmadev *ae4dma)
+{
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t write_idx = cmd_q->next_write;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, write_idx);
+	if (nb != 0)
+		cmd_q->stats.submitted += (uint16_t)((cmd_q->next_write - cmd_q->last_write +
+				nb) % nb);
+	cmd_q->last_write = cmd_q->next_write;
+}
+
+static int
+ae4dma_submit(void *dev_private, uint16_t vchan __rte_unused)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+
+	__submit(ae4dma);
+	return 0;
+}
+
+/* Write descriptor for enqueue (copy only). */
+static inline int
+__write_desc_copy(void *dev_private, rte_iova_t src, rte_iova_t dst,
+		uint32_t len, uint64_t flags)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	struct ae4dma_desc *dma_desc;
+	uint16_t ret;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t write = cmd_q->next_write;
+
+	if (nb == 0)
+		return -EINVAL;
+
+	/* Reserve one slot to distinguish full from empty (power-of-two ring). */
+	if ((uint32_t)cmd_q->ring_buff_count >= (uint32_t)(nb - 1))
+		return -ENOSPC;
+
+	dma_desc = &cmd_q->qbase_desc[write];
+	memset(dma_desc, 0, sizeof(*dma_desc));
+	dma_desc->length = len;
+	dma_desc->src_hi = upper_32_bits(src);
+	dma_desc->src_lo = lower_32_bits(src);
+	dma_desc->dst_hi = upper_32_bits(dst);
+	dma_desc->dst_lo = lower_32_bits(dst);
+	cmd_q->ring_buff_count++;
+	cmd_q->next_write = (uint16_t)((write + 1) % nb);
+	ret = write;
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
+		__submit(ae4dma);
+	return ret;
+}
+
+/* Enqueue a copy operation onto the ae4dma device. */
+static int
+ae4dma_enqueue_copy(void *dev_private, uint16_t vchan __rte_unused,
+		rte_iova_t src, rte_iova_t dst, uint32_t length, uint64_t flags)
+{
+	return __write_desc_copy(dev_private, src, dst, length, flags);
+}
+
 /* Dump DMA device info. */
 static int
 ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
@@ -197,6 +264,220 @@ ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
 		cmd_q->stats.errors);
 	return 0;
 }
+
+/* Translates AE4DMA ChanERRs to DMA error codes. */
+static inline enum rte_dma_status_code
+__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
+{
+	AE4DMA_PMD_DEBUG("ae4dma desc status = %d", status);
+
+	switch (status) {
+	case AE4DMA_DMA_ERR_NO_ERR:
+		return RTE_DMA_STATUS_SUCCESSFUL;
+	case AE4DMA_DMA_ERR_INV_LEN:
+		return RTE_DMA_STATUS_INVALID_LENGTH;
+	case AE4DMA_DMA_ERR_INV_SRC:
+		return RTE_DMA_STATUS_INVALID_SRC_ADDR;
+	case AE4DMA_DMA_ERR_INV_DST:
+		return RTE_DMA_STATUS_INVALID_DST_ADDR;
+	case AE4DMA_DMA_ERR_INV_ALIGN:
+		/* Name matches DPDK public enum spelling. */
+		return RTE_DMA_STATUS_DATA_POISION;
+	case AE4DMA_DMA_ERR_INV_HEADER:
+	case AE4DMA_DMA_ERR_INV_STATUS:
+		return RTE_DMA_STATUS_ERROR_UNKNOWN;
+	default:
+		return RTE_DMA_STATUS_ERROR_UNKNOWN;
+	}
+}
+
+/*
+ * Scan HW queue for completed descriptors (non-blocking).
+ *
+ * The AE4DMA engine signals completion by advancing the per-queue
+ * `read_idx` register; it does not (reliably) write a status value
+ * back into the descriptor. We therefore use the HW `read_idx`
+ * register as the source of truth and only inspect the descriptor's
+ * `dw1.err_code` byte to classify each completion as success or
+ * failure.
+ *
+ * @param cmd_q
+ *   The AE4DMA command queue.
+ * @param max_ops
+ *   Maximum descriptors to process this call.
+ * @param[out] failed_count
+ *   Number of completed descriptors that did not report success.
+ * @return
+ *   Number of descriptors completed (success + failure), <= max_ops.
+ */
+static inline uint16_t
+ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, uint16_t max_ops,
+		uint16_t *failed_count)
+{
+	volatile struct ae4dma_desc *hw_desc;
+	uint16_t events_count = 0, fails = 0;
+	uint16_t tail;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t mask;
+	uint16_t hw_read_idx;
+	uint16_t in_flight;
+	uint16_t scan_cap;
+
+	if (nb == 0 || cmd_q->ring_buff_count == 0) {
+		*failed_count = 0;
+		return 0;
+	}
+	mask = nb - 1;
+
+	hw_read_idx = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx) & mask);
+	tail = cmd_q->next_read;
+
+	/*
+	 * Descriptors completed since our last visit live in the
+	 * half-open ring range [tail, hw_read_idx). If HW hasn't
+	 * moved we have nothing to do.
+	 */
+	in_flight = (uint16_t)((hw_read_idx - tail) & mask);
+	if (in_flight == 0) {
+		*failed_count = 0;
+		return 0;
+	}
+
+	scan_cap = max_ops;
+	if (scan_cap > AE4DMA_DESCRIPTORS_PER_CMDQ)
+		scan_cap = AE4DMA_DESCRIPTORS_PER_CMDQ;
+	if (scan_cap > in_flight)
+		scan_cap = in_flight;
+	if (scan_cap > cmd_q->ring_buff_count)
+		scan_cap = (uint16_t)cmd_q->ring_buff_count;
+
+	while (events_count < scan_cap) {
+		uint8_t hw_status;
+		uint8_t hw_err;
+
+		hw_desc = &cmd_q->qbase_desc[tail];
+		hw_status = hw_desc->dw1.status;
+		hw_err = hw_desc->dw1.err_code;
+
+		/*
+		 * read_idx advancing is the definitive completion
+		 * signal. The per-descriptor status byte is informational
+		 * and may not yet be written when we observe it:
+		 *
+		 *   AE4DMA_DMA_DESC_ERROR (4)
+		 *     Hard failure - err_code names the precise cause.
+		 *   AE4DMA_DMA_DESC_COMPLETED (3) or 0
+		 *     Success.
+		 *   AE4DMA_DMA_DESC_VALIDATED (1) / _PROCESSED (2)
+		 *     Benign race: HW had not finished updating the
+		 *     status byte at the instant we read it. Since
+		 *     read_idx has moved past this slot, treat it as
+		 *     success unless err_code says otherwise.
+		 *
+		 * A non-zero err_code is treated as a failure regardless
+		 * of the observed status value.
+		 */
+		if (hw_status == AE4DMA_DMA_DESC_ERROR ||
+				hw_err != AE4DMA_DMA_ERR_NO_ERR) {
+			fails++;
+			AE4DMA_PMD_WARN("Desc failed: status=%u err=%u",
+					hw_status, hw_err);
+		}
+		cmd_q->status[events_count] = (enum ae4dma_dma_err)hw_err;
+		cmd_q->ring_buff_count--;
+		events_count++;
+		tail = (tail + 1) & mask;
+	}
+
+	cmd_q->stats.completed += events_count;
+	cmd_q->stats.errors += fails;
+	cmd_q->next_read = tail;
+	*failed_count = fails;
+	return events_count;
+}
+
+/* Returns successful operations count and sets error flag if any errors. */
+static uint16_t
+ae4dma_completed(void *dev_private, uint16_t vchan __rte_unused,
+		const uint16_t max_ops, uint16_t *last_idx, bool *has_error)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t cpl_count, sl_count;
+	uint16_t err_count = 0;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	*has_error = false;
+
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	if (cpl_count > max_ops)
+		cpl_count = max_ops;
+
+	if (cpl_count > 0 && last_idx != NULL)
+		*last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
+
+	sl_count = cpl_count - err_count;
+	if (err_count)
+		*has_error = true;
+
+	return sl_count;
+}
+
+static uint16_t
+ae4dma_completed_status(void *dev_private, uint16_t vchan __rte_unused,
+		uint16_t max_ops, uint16_t *last_idx,
+		enum rte_dma_status_code *status)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t cpl_count;
+	uint16_t i;
+	uint16_t err_count = 0;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	if (cpl_count > max_ops)
+		cpl_count = max_ops;
+
+	if (cpl_count > 0 && last_idx != NULL)
+		*last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
+
+	if (likely(err_count == 0)) {
+		for (i = 0; i < cpl_count; i++)
+			status[i] = RTE_DMA_STATUS_SUCCESSFUL;
+	} else {
+		for (i = 0; i < cpl_count; i++)
+			status[i] = __translate_status_ae4dma_to_dma(cmd_q->status[i]);
+	}
+
+	return cpl_count;
+}
+
+/* Get the remaining capacity of the ring. */
+static uint16_t
+ae4dma_burst_capacity(const void *dev_private, uint16_t vchan __rte_unused)
+{
+	const struct ae4dma_dmadev *ae4dma = dev_private;
+	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t mask;
+	uint16_t read_idx = cmd_q->next_read;
+	uint16_t write_idx = cmd_q->next_write;
+	uint16_t used;
+
+	if (nb < 2 || !rte_is_power_of_2(nb))
+		return 0;
+
+	mask = nb - 1;
+	used = (uint16_t)((write_idx - read_idx) & mask);
+	/* One slot reserved (same rule as enqueue). */
+	if (used >= nb - 1)
+		return 0;
+	return (uint16_t)(nb - 1 - used);
+}
+
 /* Retrieve the generic stats of a DMA device. */
 static int
 ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
@@ -357,6 +638,13 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
 	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
 	dmadev->dev_ops = &ae4dma_dmadev_ops;
 
+	dmadev->fp_obj->burst_capacity = ae4dma_burst_capacity;
+	dmadev->fp_obj->completed = ae4dma_completed;
+	dmadev->fp_obj->completed_status = ae4dma_completed_status;
+	dmadev->fp_obj->copy = ae4dma_enqueue_copy;
+	dmadev->fp_obj->submit = ae4dma_submit;
+	/* fill capability not advertised: leave fp_obj->fill as zero-initialised. */
+
 	ae4dma = dmadev->data->dev_private;
 	ae4dma->dmadev = dmadev;
 	ae4dma->pci = dev;
-- 
2.34.1

