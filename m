Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A7CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 18:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D7C740674;
	Thu, 25 Jun 2026 20:48:05 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11]) by mails.dpdk.org (Postfix) with ESMTP id 6CFF140674
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:48:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ3QSuI/HL04TXErLwUiK/eoaogs2yoz+mppH9mRcQ5o0OrSAkUG4zT0a/Brz34MNUucIgK5sV7Wcb7XUnwu20Y6VWX63McGzv4si5YRMsZ0zNg5U/SxoD3AujfPr7EXdw/xT7pQsdSX8AHHxT3bEz8MBZigQjIsAndTgMMYTZQ2/f6SF3+LB8COcyqgcHSvrJVfkE96kZnlD2gUbQe7TobuVoSeWy+I7LBScltR5G5uD8z5najWo8/ibz/K6iTpXe0556gsgK6s7U+TgSveprJnz1tOlRtPNBeryGxrIq4ckY/eisQDxdhlpJPtxtTt9i/3F94NzHWb6i5IPDwTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7sfw1cE4k8ROXvv5JzpgJRIMPFkRcZW8VmfcUJ6Pgk=;
 b=Kqyo/gEObhT8aAh+PVPbze9WQbXRJ3IGG35yoXbRo9m1Cl9Frb3V9fSN5B4Qg5abAMpXNrsLwHdYvqaoOvphvsuvUkoqh6sIHIifBl/I1Y5hUFDPFDdhjkvoeHGDQuAnh7geVynUMu7rndtsb/IivUHr3wigUAayrbi6gUYxENJwQw3ZdK/p+exj+YVlqjTLgkAv/+Exknp5XxlDWqZNuc71HcimM/WvbBotnMf+4NHT+2IrejKPyXdab/wmRgGP0Ciqddz/W+VWDi6KEZPtr+a5lJNwo3JKFICjjjrNMz2u+3zz3MyIear09GiBtsBIoO9wm5rWRwgCrpdCNZP+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7sfw1cE4k8ROXvv5JzpgJRIMPFkRcZW8VmfcUJ6Pgk=;
 b=0ylnbcUJu+m+J7OZ6pfu2K3SzJcO7bJ9oNDNA1UEd820KPgET+Pw9KNAYVzvwBtBp1xj9BdqUHppHQn8E1c6C8Tw/i/mivvzYre9tDLYwEIZ7mW5zmhECu5h0LI3Ur6H8sfN5YWO9GN/TliRpSMQSD48ZbQDkMfVH004EcfjlRg=
Received: from DM6PR07CA0125.namprd07.prod.outlook.com (2603:10b6:5:330::7) by
 LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 18:47:59 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::37) by DM6PR07CA0125.outlook.office365.com
 (2603:10b6:5:330::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 18:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 18:47:57 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 13:47:54 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <fengchengwen@huawei.com>, <Selwin.Sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v3 2/3] dma/ae4dma: add control path operations
Date: Fri, 26 Jun 2026 00:17:27 +0530
Message-ID: <20260625184728.1678328-3-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625184728.1678328-1-raghavendra.ningoji@amd.com>
References: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7942671a-d548-4ad7-1508-08ded2ea467b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: q9GoG5GLjcs/Z0/a2TLAXTabSmR8/e1rBQ4fD6oucz1dRiSLgXviIEPGJ8mVp30Ruh+f5LVDQEaaQ1mxdkSML28dL+iouHzRJOusW9t2urNqnxETrSVIzKrG95V9dfCTqWUM1v4XdTFRnJ1ZRi8O3QyoRmIPV0AhU55LrLAJtZi6d7tfAdxobzKpnwbekrfDYZW2xn0CXPFc4puYpXnc5RL/8eUwHZYvpcv8SnOQm8HbH9h+XyZuMf0zQ/YokTyrsDuqW8hR5OYywD8xwjZ/kSaRzxnHrPMUvUi++f72jpLbMZezjydPgIK0fjsl1sZkrsoKrG0GrLxDK75ywtaP7dRNmw/HKGZdst8IvE5B7C5SjPS3t64rbIxBqEpzicJ3wQIiALUqpBqoS+zy/nd2fOjWJVSKba2ZZZH6O2ZywidEASRU0rvCodCMW2JnCoJgVRsqC9Hj1hq/uIkOQxm6H5kxWjO5u+IPbhZGfG2j319lbwon3RFkmeIcPCQ7ZRox6eBOF6BF7cC5epNAEgE9V+v4VK0B5UxlCwU/Th5AsmhaUy2seL6IHfDXqzkLNn3FVbvN9Lm0B7DrovpHVSpBQuiC+QEw50YUH3XVlerDUqp39UTXn7o5YBznnvV6kIsyv8vPXvCKlaGoIxRN6XN8z6KICASwnZk2uLirO2tWyGNvVBtYSHRVwvRaBXcV/07A
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YOdAsAnZOCvyjUokVTw+p0Geob8hfrlyTonRW5GCSSZwoZQvhCPNkkyCUcSb/IIXTpWJEs9kTJsn0t+tF0dLpKrLQl2FVd2ku0scPgyrG1rIfWu5GDUzPUqFPj+vTQH6eWZAl+YNTd1oQpssz9gYU/EEt1SAUKmC1pQiDhVLiNuv+O7C1gpFW9tNx5BmpJG1AeZdF9isln0ccX6lT1UDrMvhuD7uQe2NH0WzANr2utaFiNLcKDmYZhOHoOXG4jJHo7bbZ+MAMDKxv6bsMtdDDgUF5aV+FE3pzwJkSUsdBA44c89a8zTO2XV66DS7riVR5ZB+aUPoP9lEJfgOmH9rY2apWT03qYqq1LO1BfzVYS8rKi+r5onshf8cagIjqMFIOgmQvDUHZee4IddeQqPw8XHKolGYtQ8hZOnxRo03OcykwyowunFhAypvYOTKFTp8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:47:57.9295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7942671a-d548-4ad7-1508-08ded2ea467b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
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

Implement the dmadev control path for the AMD AE4DMA PMD.

This commit adds:
 - dev_configure / vchan_setup: accept a single virtual channel per
   dmadev and clamp the requested ring size to the hardware maximum
   of 32 descriptors (rounded up to a power of two).
 - dev_start / dev_stop / dev_close: program the per-queue control
   register to enable/disable the hardware queue and release the
   descriptor ring memzone on close.
 - dev_info_get: advertise RTE_DMA_CAPA_MEM_TO_MEM and the fixed
   ring depth.
 - dev_dump: print the queue identifiers, ring layout and software
   completion counters.
 - stats_get / stats_reset: expose submitted / completed / errors
   counters maintained by the driver.
 - vchan_status: report IDLE / ACTIVE based on hardware read_idx vs
   write_idx, and HALTED_ERROR when the queue is not enabled.

The dmadev framework is wired through dev_ops in ae4dma_dmadev_create().

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/dma/ae4dma/ae4dma_dmadev.c | 211 +++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
index 3d82f86906..607f288623 100644
--- a/drivers/dma/ae4dma/ae4dma_dmadev.c
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -53,6 +53,203 @@ ae4dma_queue_dma_zone_reserve(const char *queue_name,
 			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
 }
 
+static int
+ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
+		const struct rte_dma_conf *dev_conf,
+		uint32_t conf_sz)
+{
+	if (sizeof(struct rte_dma_conf) != conf_sz)
+		return -EINVAL;
+
+	if (dev_conf->nb_vchans != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Setup a virtual channel for AE4DMA, only 1 vchan is supported per dmadev. */
+static int
+ae4dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		const struct rte_dma_vchan_conf *qconf, uint32_t qconf_sz)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t max_desc = qconf->nb_desc;
+
+	if (sizeof(struct rte_dma_vchan_conf) != qconf_sz)
+		return -EINVAL;
+
+	if (max_desc < 2)
+		return -EINVAL;
+
+	if (!rte_is_power_of_2(max_desc))
+		max_desc = rte_align32pow2(max_desc);
+
+	if (max_desc > AE4DMA_DESCRIPTORS_PER_CMDQ) {
+		AE4DMA_PMD_DEBUG("DMA dev %u nb_desc clamped to %u",
+				dev->data->dev_id, AE4DMA_DESCRIPTORS_PER_CMDQ);
+		max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
+	}
+
+	cmd_q->qcfg = *qconf;
+	cmd_q->qcfg.nb_desc = max_desc;
+
+	/* Ensure all counters are reset, if reconfiguring/restarting device. */
+	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
+	return 0;
+}
+
+static int
+ae4dma_dev_start(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	if (nb == 0)
+		return -EBUSY;
+
+	/* Program ring depth expected by hardware. */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, nb);
+	return 0;
+}
+
+static int
+ae4dma_dev_stop(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+
+	if (cmd_q->hwq_regs != NULL)
+		AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
+				AE4DMA_CMD_QUEUE_DISABLE);
+	return 0;
+}
+
+static int
+ae4dma_dev_info_get(const struct rte_dma_dev *dev __rte_unused,
+		struct rte_dma_info *info, uint32_t size)
+{
+	if (size < sizeof(*info))
+		return -EINVAL;
+	info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;
+	info->max_vchans = 1;
+	info->min_desc = 2;
+	info->max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
+	info->nb_vchans = 1;
+	return 0;
+}
+
+static int
+ae4dma_dev_close(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+
+	if (cmd_q->hwq_regs != NULL)
+		AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
+				AE4DMA_CMD_QUEUE_DISABLE);
+
+	rte_memzone_free(cmd_q->mz);
+	cmd_q->mz = NULL;
+	cmd_q->qbase_desc = NULL;
+	cmd_q->qbase_addr = NULL;
+	cmd_q->qbase_phys_addr = 0;
+	return 0;
+}
+
+static int
+ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q;
+	void *ae4dma_mmio_base_addr = (uint8_t *)ae4dma->io_regs;
+
+	cmd_q = &ae4dma->cmd_q;
+	fprintf(f, "cmd_q->id              = %" PRIx64 "\n", cmd_q->id);
+	fprintf(f, "cmd_q->qidx            = %" PRIx64 "\n", cmd_q->qidx);
+	fprintf(f, "cmd_q->qsize           = %" PRIx64 "\n", cmd_q->qsize);
+	fprintf(f, "mmio_base_addr	= %p\n", ae4dma_mmio_base_addr);
+	fprintf(f, "queues per ae4dma engine     = %d\n", AE4DMA_READ_REG_OFFSET(
+				ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET));
+	fprintf(f, "== Private Data ==\n");
+	fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
+	fprintf(f, "  Ring virt: %p\tphys: %#" PRIx64 "\n",
+			(void *)cmd_q->qbase_desc,
+			(uint64_t)cmd_q->qbase_phys_addr);
+	fprintf(f, "  Next write: %u\n", cmd_q->next_write);
+	fprintf(f, "  Next read: %u\n", cmd_q->next_read);
+	fprintf(f, "  current queue depth: %u\n", cmd_q->ring_buff_count);
+	fprintf(f, "  }\n");
+	fprintf(f, "  Key Stats { submitted: %" PRIu64 ", comp: %" PRIu64 ", failed: %" PRIu64 " }\n",
+		cmd_q->stats.submitted,
+		cmd_q->stats.completed,
+		cmd_q->stats.errors);
+	return 0;
+}
+static int
+ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		struct rte_dma_stats *rte_stats, uint32_t size)
+{
+	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	const struct rte_dma_stats *stats = &cmd_q->stats;
+
+	if (size < sizeof(*rte_stats))
+		return -EINVAL;
+	if (rte_stats == NULL)
+		return -EINVAL;
+
+	*rte_stats = *stats;
+	return 0;
+}
+
+static int
+ae4dma_stats_reset(struct rte_dma_dev *dev, uint16_t vchan __rte_unused)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+
+	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
+	return 0;
+}
+
+/*
+ * Report channel state to the dmadev framework.
+ *
+ *   RTE_DMA_VCHAN_HALTED_ERROR - HW queue is disabled (never started, or
+ *                                stopped via dev_stop()).
+ *   RTE_DMA_VCHAN_IDLE         - HW has caught up: read_idx == write_idx,
+ *                                no descriptors in flight.
+ *   RTE_DMA_VCHAN_ACTIVE       - HW still has descriptors to process.
+ */
+static int
+ae4dma_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		enum rte_dma_vchan_status *status)
+{
+	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint32_t ctrl, hw_read, hw_write;
+
+	if (cmd_q->hwq_regs == NULL) {
+		*status = RTE_DMA_VCHAN_HALTED_ERROR;
+		return 0;
+	}
+
+	ctrl = AE4DMA_READ_REG(&cmd_q->hwq_regs->control_reg.control_raw);
+	if ((ctrl & AE4DMA_CMD_QUEUE_ENABLE) == 0) {
+		*status = RTE_DMA_VCHAN_HALTED_ERROR;
+		return 0;
+	}
+
+	hw_read  = AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
+	hw_write = AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
+
+	*status = (hw_read == hw_write) ? RTE_DMA_VCHAN_IDLE
+					: RTE_DMA_VCHAN_ACTIVE;
+	return 0;
+}
+
 static int
 ae4dma_add_queue(struct ae4dma_dmadev *dev, struct rte_pci_device *pci,
 		uint8_t qn, const char *pci_name)
@@ -115,6 +312,19 @@ ae4dma_channel_dev_name(char *out, size_t outlen, const char *pci_name,
 static int
 ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
 {
+	static const struct rte_dma_dev_ops ae4dma_dmadev_ops = {
+		.dev_close = ae4dma_dev_close,
+		.dev_configure = ae4dma_dev_configure,
+		.dev_dump = ae4dma_dev_dump,
+		.dev_info_get = ae4dma_dev_info_get,
+		.dev_start = ae4dma_dev_start,
+		.dev_stop = ae4dma_dev_stop,
+		.stats_get = ae4dma_stats_get,
+		.stats_reset = ae4dma_stats_reset,
+		.vchan_status = ae4dma_vchan_status,
+		.vchan_setup = ae4dma_vchan_setup,
+	};
+
 	struct rte_dma_dev *dmadev;
 	struct ae4dma_dmadev *ae4dma;
 	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
@@ -130,6 +340,7 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
 	}
 	dmadev->device = &dev->device;
 	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
+	dmadev->dev_ops = &ae4dma_dmadev_ops;
 
 	ae4dma = dmadev->data->dev_private;
 
-- 
2.34.1

