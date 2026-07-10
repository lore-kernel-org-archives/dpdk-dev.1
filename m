Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76220C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:36:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A61440A71;
	Fri, 10 Jul 2026 09:36:46 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by mails.dpdk.org (Postfix) with ESMTP id 093744026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:36:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAvzNS/0qggWVhB9NkSZCDcpLoohuAU19n1l+y7lykPa4vBoiHPOzHJzSRNCA9fFm1qWQa5kghvlwqrgSHxfraEWteh/TWN9kHAKdDbJRLlO7V3cDQyDYy46pKpXenFn1Wf17EcXZ7jFsad/nz9TsvoiSwQVvgoS2w4KG78pcI/NGrx3Wv0NbOAOhkZA8/nZUffFYQhTO1zzszu51bXjNgaWkzS2wPNF7+hoYCABoET4sSYec2lcRN3G+/gPVt/QMVof0hGmwFJzHgyANF2eb8A6CNVyzI6i2fjMHIIMUXePU8QGOGIBZKYdcYeTX1JV4s+wA4YC3JnAv+LF8FaojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvDeDfh5pEZwmulMRsVQeg9KyfjkoXpSOtEnBlBlLeo=;
 b=G24RJetj4xUkKmgJtZst6QOKinA41KjJLdtODdRC35VP/uNUEMiuP0adWEKf41alViwBjbrpQ/bpDnkyG1Gc2sftrnKCLasF+2CPXPjdtNwH+MseuloaHiZFmXb6pNjyt/r19FNUrgIu49yF8UV15H7s2Mc5UvxAGwKqq1FWVQetq/GuSSg/cIJh9RpeQQT32PX2U/2HQCjFSOanY22VB7D8Kd2GsFT0cIsrCncjSIq+y7JrnVSlDupNAilQBYTCP9Gv1rEMfih3QqD7tny1oD2HugW+VTWy1vt/BKLIQSGYbXTPcXcBlTlq7gi6B8NSGiz0gzjo1nkhfANLiyXoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvDeDfh5pEZwmulMRsVQeg9KyfjkoXpSOtEnBlBlLeo=;
 b=FJN1+vIauWzfe6FUNoEf+j84D2bfv5yhsrpZC5I5zhYrFZ4OKCiVq63GjB6xnt/32nOkUuq7hOE9EN3g0EH+2vMtkV4UvpJhbJDplQPIQ/TCmff8w5l5oJAFPqsUWJkrHQ0WlwDoiIayth6C7izMBtSFdcTWqhs/XHH66VTO1G0=
Received: from BL1PR13CA0415.namprd13.prod.outlook.com (2603:10b6:208:2c2::30)
 by IA5PR12MB999324.namprd12.prod.outlook.com (2603:10b6:208:609::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 07:36:38 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ab) by BL1PR13CA0415.outlook.office365.com
 (2603:10b6:208:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Fri, 10
 Jul 2026 07:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:36:38 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:36:35 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v5 3/4] dma/ae4dma: add data path operations
Date: Fri, 10 Jul 2026 13:06:07 +0530
Message-ID: <20260710073608.3034898-4-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
References: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|IA5PR12MB999324:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c4a0c2-ebad-40e1-81de-08dede55fa22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|5023799004|11063799006|22082099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: RyPfSrwDbKFpUltW8o1PjqRNbvAxmcH3Om8M1tifq+5o+0uJNYop43gsxLg/hIsJfE4tsjWHTok2OzoH7hWsFBCy58spW5GqS4aQ8ACVNnoHLqTpGSgZBGk3jLe0uY1jU8oci2EGJAmT14c9Rvx9BfeTYVWc22hiBt10Ll7Y1QBOYvQg61X96wF1xH8xsYdoAj7jRhyB3JN+9TZZ+bQ6lvz2TuR6lLXGvNRUbvHgOst4CThiKhMy9pGsBUr7QnyZ808NQjzS32SSx8szlXN1esYD4fsF5Tw2803xXCzaIPtTBgg0iTalb2ecU7PAzGAvtPt/K9VyC2jlcKi837tHMb3nlK+1vi2ZzApp6DjAS5alQ+AdQ9x2cLaJGE0jhJcIi8cDm4uLgeUSTPygbm8Ml5yK+pwa7B7eCdO8AH+Ij3ez8UtvSlnEM2h5Zhi1svokWETXyTFVkFmf6gfOqRKDOo8x5B6+SKMO3HBGywmoFf1F4buOJo+VC8sM2teQvllNPgZpTsVB79psOWnQYFGLmVcqV7HyPPNnuoNndX5LlqSJxKzf76J69cyQlKW97CjhoHSCOCFtB/dUm/TTzPd6WYcj6WB86dL7PuxtqmirvMtThlYtEoCKXo/uk2eQK+SpFSr4BxWQ2YtCP8W2UIDWb8zGR4RWe2jfFP6jFYej1oyo+eFaXd5o5Zd/i3PDca2e7ATetVTpbMBaKl3215mLGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(5023799004)(11063799006)(22082099003)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: keMAMsSiA+J7F3JU5HlKN22tM/iq/pfh5qZP1gwmbGC3gy2Xu1MPTdU3OEwKPEqGQcEBzfqQmihh56Yps8zePzDu0+Iam4pKNlHkQ77HLxjaKxygziNXrNbSk/la+GnZqJGQJye0YBohBilqdOa+9KUVdbenpS3c9zWlYy0EiBKe1rvyjTlDClJSK5yUb8Vgq8+5KullE3p4lpoZ8k1SNwdZBS4myWmMRH/Ndr3r1LMbFCxmCg2CApclLHRsq7VcEvZVtPX20wDNWGkPfEHhj3RGma7GUal9uWeT06etoKEf3bgmLRnQ0Vhq37tGVG1KcjHcFZi79yW/ravYtHmCW351Mx8ywFJfJIdPFt1JCjMC5Ia3+jcYDEsDj7XtwCl/hCT72H4plVc65CfWIQ3L66yIPke4M/udDwFeHlFqm+RpiZKL/DB8uBnOxMJPWZPG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:36:38.2979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c4a0c2-ebad-40e1-81de-08dede55fa22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999324
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
 drivers/dma/ae4dma/ae4dma_dmadev.c | 249 +++++++++++++++++++++++++++++
 2 files changed, 273 insertions(+)

diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
index eeed55c283..10446ca2e8 100644
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
index 9910e115b2..70c7c21ddf 100644
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
@@ -192,6 +262,178 @@ ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
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
+/* True if the descriptor at ring slot has been flagged as failed by HW. */
+static inline bool
+ae4dma_desc_failed(volatile struct ae4dma_desc *hw_desc)
+{
+	/*
+	 * read_idx advancing is the definitive completion signal. The
+	 * per-descriptor status byte is informational and may not yet be
+	 * written when we observe it, so a slot is only a failure if the
+	 * HW flagged DESC_ERROR or set a non-zero err_code.
+	 */
+	return hw_desc->dw1.status == AE4DMA_DMA_DESC_ERROR ||
+			hw_desc->dw1.err_code != AE4DMA_DMA_ERR_NO_ERR;
+}
+
+/*
+ * Number of descriptors the HW has completed since our last reap, without
+ * consuming them (non-blocking, no state change).
+ *
+ * The AE4DMA engine signals completion by advancing the per-queue read_idx
+ * register; it does not (reliably) write a status word back into the
+ * descriptor. We therefore use the HW read_idx register as the source of
+ * truth for how many ops are done.
+ *
+ * next_read/next_write are free-running 16-bit indices; the HW ring slot is
+ * ((hw_base + idx) & mask) and the number of in-flight ops is
+ * (next_write - next_read), both relying on nb_desc being a power of two.
+ */
+static inline uint16_t
+ae4dma_pending(struct ae4dma_cmd_queue *cmd_q)
+{
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t hw_read_pos, tail_pos;
+	uint16_t newly_done, in_flight;
+	uint16_t mask;
+
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
+
+	return RTE_MIN(newly_done, in_flight);
+}
+
+/*
+ * Report ops that completed successfully, stopping at the first failure.
+ *
+ * Per the dmadev contract, this reaps only the run of successful ops at the
+ * head of the completed region and stops as soon as it meets a failed one.
+ * The failed op is left in place (not consumed) and *has_error is set so the
+ * application switches to rte_dma_completed_status() to retrieve its status.
+ * last_idx is the ring_idx of the last successfully completed op.
+ */
+static uint16_t
+ae4dma_completed(void *dev_private, uint16_t vchan __rte_unused,
+		const uint16_t max_ops, uint16_t *last_idx, bool *has_error)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t mask = cmd_q->qcfg.nb_desc - 1;
+	uint16_t ready, count;
+
+	*has_error = false;
+
+	ready = ae4dma_pending(cmd_q);
+	if (ready > max_ops)
+		ready = max_ops;
+
+	for (count = 0; count < ready; count++) {
+		uint16_t slot = (cmd_q->hw_base + cmd_q->next_read + count) & mask;
+
+		if (ae4dma_desc_failed(&cmd_q->qbase_desc[slot])) {
+			*has_error = true;
+			break;
+		}
+	}
+
+	cmd_q->next_read += count;
+	cmd_q->stats.completed += count;
+	*last_idx = (uint16_t)(cmd_q->next_read - 1);
+
+	return count;
+}
+
+/*
+ * Report per-op status for all completed ops, including failures.
+ *
+ * Unlike ae4dma_completed(), this consumes failed ops too so the application
+ * can drain past an error. last_idx is the ring_idx of the last op reported.
+ */
+static uint16_t
+ae4dma_completed_status(void *dev_private, uint16_t vchan __rte_unused,
+		uint16_t max_ops, uint16_t *last_idx,
+		enum rte_dma_status_code *status)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t mask = cmd_q->qcfg.nb_desc - 1;
+	uint16_t ready, fails = 0;
+	uint16_t i;
+
+	ready = ae4dma_pending(cmd_q);
+	if (ready > max_ops)
+		ready = max_ops;
+
+	for (i = 0; i < ready; i++) {
+		uint16_t slot = (cmd_q->hw_base + cmd_q->next_read + i) & mask;
+		volatile struct ae4dma_desc *hw_desc = &cmd_q->qbase_desc[slot];
+
+		if (ae4dma_desc_failed(hw_desc)) {
+			status[i] = __translate_status_ae4dma_to_dma(
+					(enum ae4dma_dma_err)hw_desc->dw1.err_code);
+			AE4DMA_PMD_WARN("Desc failed: status=%u err=%u",
+					hw_desc->dw1.status, hw_desc->dw1.err_code);
+			fails++;
+		} else {
+			status[i] = RTE_DMA_STATUS_SUCCESSFUL;
+		}
+	}
+
+	cmd_q->next_read += ready;
+	cmd_q->stats.completed += ready;
+	cmd_q->stats.errors += fails;
+	*last_idx = (uint16_t)(cmd_q->next_read - 1);
+
+	return ready;
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
@@ -339,6 +581,13 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
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

