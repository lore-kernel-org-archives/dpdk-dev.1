Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A4C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:56:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0DF640695;
	Mon,  6 Jul 2026 13:56:22 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by mails.dpdk.org (Postfix) with ESMTP id 605D8402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 13:56:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulxL9cuWyJtYA9nvzDtFrHh+MhwxcDJWxycvLGDzCxa53EwwsMiMfFbJ8MumCzQUwES5k+k2n8rF9raPNGjfzp3wdH7QQefuI79xLYGRmX1WT+NO86fTPO29izIVGDT2YkD3ULIsJFFzy7nUl7oIbDeFKooEwAsd8WkCCGjLSmEZMS4Pv4FFq9B1LnI3vQIiPnPK8jYywor4aNXRLEO/GfVEoBezxNfsOuDpjcBCF8aayVoQTFHbacsaoFYY0VUmolhLpzz8G/IHJv4+m5X8xkkZj/i4nHYTRvR+LoFvk2TFgBAg57SZafOK0ce9dw4MTY6LAAnt1YVEIAHqt6JQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtBz5LOI+Ol5VD8/C1lnkFSf6bo4nbLOZWLWgHysFNY=;
 b=QbCR40pP8tpa96RHQH0Ox0zLqoVzGww3cnDyxeFYwWGct8MW70GCNDX93dg8en2/Me3f/reQb7jIL6rQ5lcXuldwt8BuuHQJQXzfUYSjxW8KBAfVEtztnLah3Ks5NTIWmZtZB+xb4A+O/GT0onFzovE+L3R/VPYU3bT2apLZyCSoBFStbWixpYXdYouJ5QruVRyfeBmRUZ5QTHDAVcb8c0KuRmcBuVTM6uRM1TFeIj2T6u3wjPMDi3TAqbPSVyuEx2zGVfBRTEGJIPeLr/IgQhfQrpQ4EHFZzb3vzJ3JQp0BrCAxJ3InulLkLf4lbhes8twrisaPWaPF235C9kj+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtBz5LOI+Ol5VD8/C1lnkFSf6bo4nbLOZWLWgHysFNY=;
 b=Ftb0uBlVDv7b2xoFnQW/saE5bTQ/jhGHMSrN42HrFk79mm3jUI/MOclKimU7A4FoZYDgS7xUChjuFxrg3gj7wW+C5rLqvX4kuiB1OFEuqVqneuU8gemgh69bIAaXGd9QQf0KWjjaSabc71iayY0iR7ACyx2rlVmYUS+Ss0gTl2c=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 11:56:14 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::7c) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 11:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 11:56:13 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 06:56:10 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 3/4] dma/ae4dma: add data path operations
Date: Mon, 6 Jul 2026 17:25:32 +0530
Message-ID: <20260706115533.2937512-4-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
References: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 629211a6-7c51-4786-f818-08dedb559427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|5023799004|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: g2sN8julIrXtfhCDLPpWbwJJWz5J2BN3XpNS07CA0dj/jBg/RNIZB5sy08XUMq70lgB87w1LkL0YA/QCs7KlJlBFNQX1Il6nUSiKri5OPCAHGxaEW86GMohmxknIu/qpvb0eNF0S9aGrPGshyUygxYuF1j6aD/eWSTZMRuYnMZ8PsqLl8ZWegVvu9jyDyRPTsESqdCayBYZ5dJtuuWUJw3tL6uVUKqVCK1QROPFlWZMH10UsaireyiO9Tc26g1sMbB47anDqCzMHnvZq8DZt23Absge5ZbzVuiaTzBoiS/4m0XbDl0FRGb8/tfNO0vrlepPuDWwmrRseb5GqkuACuNRp/Qyf10W+phqyQVt8CcicNga/liYgPcXqVAIDe1rihfK//Ot2/GMG9BwPNLQngTSDTROv5hGUKz15XR0Km857z4AQdLTlADjt/GxsMXh7Z4LLeV3ZZ2o2Nw8gpnWRjJGR5u1lKa4Kpm3+FvQEwwB8ET89isCkl8JJl4hIFMJWd+aTSzKipfTqIeaWF1MUBfB5z7289U2KcshboduF5YWGXb55Yd9nIAzrO9GX0iNFKbGKFzvBZ3oeKR/L6QPLtydyOZny42MaUb+fXXaOB6qOzrOCUasdG4kfJS/rl9LnKjD0PXRQU371Pqp1DpiDQaxfCr/Byuo/g+dVLAjIr3JT8Bmpu34qi65/VqDX9Vnmwny+jYMhseJaFayhFxHh7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9iAAk2Abc8kQaXi75ljZtcWoi12gESIRbDjkmMh/9X+WY78YKeKOHHtog306dKFimd1K8F2StcRS5VXr6dmDOFVIkqjHemUX7drDPBIEeN7q4d5TYE8owCNJzFXsSAsaRG0uLoT91WkHoeP/d3dCVYioNw0Ta9YMH+J2+qo92Lhb9fmhT2wrF2iBf41DrlQnQlcnBRA+gnmJiUtKE1b1YxmVLvQu5Xyrt7rFqIXmfzi2W4J9rMDsVPTmUKBzcFeGNpFOWamryQtQ4qSTGHC6Bc9KApDzYvdwsbtcsFczSMt+z5kORfhHhzV2svA1N+VpyQxmcr9tim8gqZMHMFE3nqJvrgc1vhcjj8kKLCMN3wBteZGDylfpoDQHbSAecIDmPhyDimRWS9pxC1FpJrjhWAjkVx2P28stiVofWAsSy/L18cTVR8rLfip46uZ9Zvgb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:56:13.6008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629211a6-7c51-4786-f818-08dedb559427
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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

Implement the dmadev fast path (copy, submit, completed,
completed_status and burst_capacity) for the AMD AE4DMA PMD and wire
the entry points through fp_obj in ae4dma_dmadev_create().

The framework-visible ring index is a free-running 16-bit value; the
HW ring slot is derived as (hw_base + idx) & (nb_desc - 1), which is
why the vchan ring depth is kept a power of two. completed() and
completed_status() always report the last completed ring_idx via
last_idx, even when no new op is reaped, as required by the dmadev
API. Only memory-to-memory copy is advertised, so fp_obj->fill is
left zero-initialised.

AE4DMA-specific completion handling: the engine reports completion by
advancing the per-queue read_idx register rather than reliably writing
a status word back, so the driver uses read_idx as the source of truth
and only reads the descriptor err_code byte to flag failures.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/dmadevs/ae4dma.rst      |  24 +++
 drivers/dma/ae4dma/ae4dma_dmadev.c | 245 +++++++++++++++++++++++++++++
 2 files changed, 269 insertions(+)

diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
index eeed55c..10446ca 100644
--- a/doc/guides/dmadevs/ae4dma.rst
+++ b/doc/guides/dmadevs/ae4dma.rst
@@ -51,3 +51,27 @@ On probe the PMD performs the following steps for each PCI function:
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
+  hardware at 32, and the engine reserves one slot to distinguish a full
+  ring from an empty one, so at most 31 operations can be outstanding
+  (``rte_dma_burst_capacity()`` returns at most 31). The PMD rounds the
+  requested ring size up to a power of two and clamps it to 32.
+* Only a single virtual channel per dmadev is supported; use the 16
+  per-PCI-function dmadevs to obtain channel-level parallelism.
+* Interrupt-driven completion is not supported.
diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
index 9910e11..8fcb0d5 100644
--- a/drivers/dma/ae4dma/ae4dma_dmadev.c
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -162,6 +162,76 @@ ae4dma_dev_close(struct rte_dma_dev *dev)
 	return 0;
 }
 
+/* Ring the doorbell: publish all enqueued descriptors to the hardware. */
+static inline void
+__submit(struct ae4dma_dmadev *ae4dma)
+{
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	if (nb == 0)
+		return;
+
+	/* The HW producer index is the ring slot of the next free descriptor. */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx,
+			(cmd_q->hw_base + cmd_q->next_write) & (nb - 1));
+	cmd_q->stats.submitted += (uint16_t)(cmd_q->next_write - cmd_q->last_write);
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
+/* Write a copy descriptor; returns the free-running ring_idx assigned to it. */
+static inline int
+__write_desc_copy(void *dev_private, rte_iova_t src, rte_iova_t dst,
+		uint32_t len, uint64_t flags)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t ring_idx = cmd_q->next_write;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	struct ae4dma_desc *dma_desc;
+	uint16_t in_flight;
+
+	if (nb == 0)
+		return -EINVAL;
+
+	/* Reserve one slot to distinguish full from empty on the ring. */
+	in_flight = (uint16_t)(cmd_q->next_write - cmd_q->next_read);
+	if (in_flight >= nb - 1)
+		return -ENOSPC;
+
+	dma_desc = &cmd_q->qbase_desc[(cmd_q->hw_base + ring_idx) & (nb - 1)];
+	memset(dma_desc, 0, sizeof(*dma_desc));
+	dma_desc->length = len;
+	dma_desc->src_hi = upper_32_bits(src);
+	dma_desc->src_lo = lower_32_bits(src);
+	dma_desc->dst_hi = upper_32_bits(dst);
+	dma_desc->dst_lo = lower_32_bits(dst);
+
+	cmd_q->next_write++;
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
+		__submit(ae4dma);
+
+	/* dmadev ring_idx is a free-running 16-bit value, not a ring slot. */
+	return ring_idx;
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
 static int
 ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
 {
@@ -192,6 +262,174 @@ ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
 	return 0;
 }
 
+/* Translate an AE4DMA descriptor error code to the dmadev status code. */
+static inline enum rte_dma_status_code
+__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
+{
+	switch (status) {
+	case AE4DMA_DMA_ERR_NO_ERR:
+		return RTE_DMA_STATUS_SUCCESSFUL;
+	case AE4DMA_DMA_ERR_INV_LEN:
+		return RTE_DMA_STATUS_INVALID_LENGTH;
+	case AE4DMA_DMA_ERR_INV_SRC:
+		return RTE_DMA_STATUS_INVALID_SRC_ADDR;
+	case AE4DMA_DMA_ERR_INV_DST:
+		return RTE_DMA_STATUS_INVALID_DST_ADDR;
+	default:
+		return RTE_DMA_STATUS_ERROR_UNKNOWN;
+	}
+}
+
+/*
+ * Scan the HW queue for completed descriptors (non-blocking).
+ *
+ * The AE4DMA engine signals completion by advancing the per-queue
+ * read_idx register; it does not (reliably) write a status value back
+ * into the descriptor. We therefore use the HW read_idx register as the
+ * source of truth and only inspect the descriptor dw1.err_code byte to
+ * classify each completion as success or failure.
+ *
+ * next_read/next_write are free-running 16-bit indices; the HW ring slot
+ * is ((hw_base + idx) & mask) and the number of in-flight ops is
+ * (next_write - next_read), both relying on nb_desc being a power of two.
+ */
+static inline uint16_t
+ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, uint16_t max_ops,
+		uint16_t *failed_count)
+{
+	volatile struct ae4dma_desc *hw_desc;
+	uint16_t events_count = 0, fails = 0;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t hw_read_pos, tail_pos;
+	uint16_t newly_done, in_flight;
+	uint16_t scan_cap, mask;
+
+	*failed_count = 0;
+	if (nb == 0)
+		return 0;
+	mask = nb - 1;
+
+	in_flight = (uint16_t)(cmd_q->next_write - cmd_q->next_read);
+	if (in_flight == 0)
+		return 0;
+
+	/* Descriptors HW has consumed since our last visit: [tail, read). */
+	hw_read_pos = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx) & mask);
+	tail_pos = (uint16_t)((cmd_q->hw_base + cmd_q->next_read) & mask);
+	newly_done = (uint16_t)((hw_read_pos - tail_pos) & mask);
+	if (newly_done == 0)
+		return 0;
+
+	scan_cap = newly_done;
+	if (scan_cap > in_flight)
+		scan_cap = in_flight;
+	if (scan_cap > max_ops)
+		scan_cap = max_ops;
+
+	while (events_count < scan_cap) {
+		uint16_t slot = (cmd_q->hw_base + cmd_q->next_read + events_count) & mask;
+		uint8_t hw_status, hw_err;
+
+		hw_desc = &cmd_q->qbase_desc[slot];
+		hw_status = hw_desc->dw1.status;
+		hw_err = hw_desc->dw1.err_code;
+
+		/*
+		 * read_idx advancing is the definitive completion signal.
+		 * The per-descriptor status byte is informational and may
+		 * not yet be written when we observe it, so a slot is only
+		 * a failure if the HW flagged DESC_ERROR or set err_code.
+		 */
+		if (hw_status == AE4DMA_DMA_DESC_ERROR ||
+				hw_err != AE4DMA_DMA_ERR_NO_ERR) {
+			fails++;
+			AE4DMA_PMD_WARN("Desc failed: status=%u err=%u",
+					hw_status, hw_err);
+		}
+		cmd_q->status[events_count] = (enum ae4dma_dma_err)hw_err;
+		events_count++;
+	}
+
+	cmd_q->next_read += events_count;
+	cmd_q->stats.completed += events_count;
+	cmd_q->stats.errors += fails;
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
+	uint16_t err_count = 0;
+	uint16_t cpl_count;
+
+	*has_error = false;
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	/*
+	 * last_idx always reports the ring_idx of the most recently completed
+	 * op, even when this call reaps nothing (matches the dmadev contract
+	 * and the ioat/idxd drivers).
+	 */
+	if (last_idx != NULL)
+		*last_idx = (uint16_t)(cmd_q->next_read - 1);
+
+	if (err_count != 0)
+		*has_error = true;
+
+	return cpl_count - err_count;
+}
+
+static uint16_t
+ae4dma_completed_status(void *dev_private, uint16_t vchan __rte_unused,
+		uint16_t max_ops, uint16_t *last_idx,
+		enum rte_dma_status_code *status)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t err_count = 0;
+	uint16_t cpl_count;
+	uint16_t i;
+
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	if (last_idx != NULL)
+		*last_idx = (uint16_t)(cmd_q->next_read - 1);
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
+	uint16_t in_flight;
+
+	if (nb == 0)
+		return 0;
+
+	/* One slot reserved to distinguish full from empty. */
+	in_flight = (uint16_t)(cmd_q->next_write - cmd_q->next_read);
+	if (in_flight >= nb - 1)
+		return 0;
+	return (uint16_t)(nb - 1 - in_flight);
+}
+
 static int
 ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
 		struct rte_dma_stats *rte_stats, uint32_t size __rte_unused)
@@ -339,6 +577,13 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
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
 
 	if (ae4dma_add_queue(ae4dma, dev, qn, name) != 0)
-- 
2.34.1

