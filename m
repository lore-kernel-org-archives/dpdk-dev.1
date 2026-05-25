Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340CCD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 18:43:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6475F4064F;
	Mon, 25 May 2026 20:43:30 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by mails.dpdk.org (Postfix) with ESMTP id A2C0B4065B
 for <dev@dpdk.org>; Mon, 25 May 2026 20:43:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6G1ysllZEIhi3zbnxb0MThb1h1W5+8i3HgoK6iB+X8Ll2oh56CbPTH6YXSCEXueJy27sQQUtG+drZjZfhu49OxruJSGX6ih1WCl2vHhs1M6mDNDKDuTWF35LbfgU0EXglvESWmYOL7eLIc6LXKovlWbBH8QTacmoFJ1YfOyk+X8UQp7PRipvzqQ02GiBx3aQrzkuXiie/SZvfWqMlDtLg+irpkXMH1uMDj2NqEPTSYt5/piZccYMWEq3zbuchgSPYQdr2SZ/7kjcDKUk63MhWP5LsvzTt2r2k+/Drok08JGvfrUw/lkPawFaH08YjTXLUe3lF4PtQG68JPkKCTSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Mpj8s7WjNtYXcpcidbxQ6wJ9rxbYBrD/Ei020NRiig=;
 b=bsGC1lurIQCQjXQuT8kGVbJ0pIUgrcDV7Jqt1MbHUjDA4rWQMN5grZ6Jd6KYErfBkgzHd+EedamwTdsyAVVw5qvvBGoB7ED/2iaRgYgqCWtpvJDZ4I+K8EGCeAvRuqo9hZHlozYFt766OcVjG0rA/2LlfjKNM20HyVXSWa/E31xgg6H1P4jiAUHPT4ydPt+vyNFdYikc8jE/QlrH3AZxRrQqGsl8IUwNwyr1naW8rz7+aa9ebS1LNiO0g8PiI+sgjqm0hHCn4dnF78ORb0/9ldd+gHOS29o+bPsD0QAVTd/FU1jOQaEntnKgt9uLbLG/DxDmUIGUtzOcvYtkc6TsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mpj8s7WjNtYXcpcidbxQ6wJ9rxbYBrD/Ei020NRiig=;
 b=YIXuiQF2if0gAi+QHkQTHTlGLodMT5ETlvgH/hrsp+ZZ1fTTHJZIvcZyavePD2dFZk6YpPinwQi9xDAdY/LuZG94YeefailzTAuzfvnfk8UQOO5m7JoVNUdFG/5wZa+OO9edHgxqDR+2nD5bk72eGpeeHUg6qSnMtI/lmvsh+Mo=
Received: from DS7PR03CA0184.namprd03.prod.outlook.com (2603:10b6:5:3b6::9) by
 SA1PR12MB999109.namprd12.prod.outlook.com (2603:10b6:806:4a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 18:43:25 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::30) by DS7PR03CA0184.outlook.office365.com
 (2603:10b6:5:3b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:43:24 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 13:43:22 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>, <david.marchand@redhat.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2 2/3] dma/ae4dma: add control path operations
Date: Tue, 26 May 2026 00:12:43 +0530
Message-ID: <20260525184244.1758825-3-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|SA1PR12MB999109:EE_
X-MS-Office365-Filtering-Correlation-Id: e57e1579-dc3e-444c-b7a4-08deba8d80e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 2pEYJ5x0yeaZ0xcT8NF2+wcLlulhDpjaNTH+5x9gH6DDCNomyOEzSkpF7LL4WweO6QDQ4MBP5c+/yNypaIr3wWwOK/oPt6opVN1g+0/9D1odrerqE51wUAXu12bQLMuXtR2PawRhlrun7dgs53hklb/kzih2e6IO2fyX9V0rAiHlgOLH9UMdqnnPrVQN6HaixS7kNhe405m4EdZmM/+7haoCPVwCMhKkvvn+K+SdEEHPum1oAPtA+jfjRZcvE+TVE5beCjmqC0OQvUx+wQWvpzyyS9kcltpX7/uKLV5rqr6TftSXt8mshmQnOdLQAE9Lwa8jWKuPWAwCrVeTWsAbsPMF3XLQ+/9F9czzJfvWE4RVcRaadlfBQf7N1gXyfiFlbNmcVzFQrI/GW7HznhgqYeT5mH1yCXp0XsgUttPCNIqWTcyKtoI9zhwiS/hEOA4CA5EFJmHHM1KOG2BbTiFI9/BaVShehGQRQTZp5cjoxzuDvTSiqA5ertlb0wRD3IVMQk00fUxYeX1a0o16pQzTYgKocjGKzFlDdx2Fq5r3S3pT+i9Ok9WKlcKoIZo5aR6aCr242OT8lttSXEXLiY+UuTWc+IDhETQGkfcxg9pFfr+zGyRmW4eQ/rcOHNB8aS5vF4ZJ3QLfsJpYpjT3Fcu5PImGCyflqFPNkyAb1sSzGbIBAlV/jA8DuFQZWV5yvqJm0yzxIPE1N83n+yKIUpT8udQRMw6QgLTws8SE+Agef1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hwk7lhwAuzYAsCtI9znpJwP08C1hVP7sVm/GzvUuhMGD6McQfRiK+RtyvgvB39+S9+cSBz0szgKJcevebBzTzEqSUXEaX5fjbMz+tiIATNM2LIi8AOV/oEl0yPEitHJHdb2KcM4jdU9rfZ39eKiuZWIEvTo6DACXU6Y+JKJf1kuQRVKevPNoSfS4kpQQ4bQydfwaRePQWtQ9WBZoVy3LI6MBESxJja0xuZyOxxbd89xZRsG4fVGWflkCRR8Q22KhZAlPgn/jCbm7GICjCF5kxdOMnZgR1K8SfULcEMAwtSG86a7JJTyBr2zZpDl1KRpYNEjroWNasRF2Sg8vsQJbRUItJ0i2Lp+0gJZqphD0QJdoTPIFTPhYsWEsyfP5sedmhSc5b1EdOrX0EUygqjdAl53U7t8wUKXtsVMkxQ7YcWisBRgU20CW8ghYGIEsgPtb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:43:24.8077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57e1579-dc3e-444c-b7a4-08deba8d80e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999109
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
 drivers/dma/ae4dma/ae4dma_dmadev.c | 223 +++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
index 76de2cde45..dfda723c13 100644
--- a/drivers/dma/ae4dma/ae4dma_dmadev.c
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -53,6 +53,215 @@ ae4dma_queue_dma_zone_reserve(const char *queue_name,
 			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
 }
 
+/* Configure a device. */
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
+/* Start a configured device. */
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
+/* Stop a configured device. */
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
+/* Get device information of a device. */
+static int
+ae4dma_dev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *info,
+		uint32_t size)
+{
+	if (size < sizeof(*info))
+		return -EINVAL;
+	info->dev_name = dev->device->name;
+	info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;
+	info->max_vchans = 1;
+	info->min_desc = 2;
+	info->max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
+	info->nb_vchans = 1;
+	return 0;
+}
+
+/* Close a configured device. */
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
+	if (cmd_q->memz_name[0] != '\0') {
+		const struct rte_memzone *mz = rte_memzone_lookup(cmd_q->memz_name);
+
+		if (mz != NULL)
+			rte_memzone_free(mz);
+	}
+	cmd_q->qbase_desc = NULL;
+	cmd_q->qbase_addr = NULL;
+	cmd_q->qbase_phys_addr = 0;
+	return 0;
+}
+/* Dump DMA device info. */
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
+/* Retrieve the generic stats of a DMA device. */
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
+/* Reset the generic stat counters for the DMA device. */
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
 ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn, const char *pci_name)
 {
@@ -114,6 +323,19 @@ ae4dma_channel_dev_name(char *out, size_t outlen, const char *pci_name,
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
 	struct rte_dma_dev *dmadev = NULL;
 	struct ae4dma_dmadev *ae4dma = NULL;
 	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
@@ -133,6 +355,7 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
 	}
 	dmadev->device = &dev->device;
 	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
+	dmadev->dev_ops = &ae4dma_dmadev_ops;
 
 	ae4dma = dmadev->data->dev_private;
 	ae4dma->dmadev = dmadev;
-- 
2.34.1

