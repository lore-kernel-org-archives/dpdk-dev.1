Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B494C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:36:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8315A406B7;
	Fri, 10 Jul 2026 09:36:45 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1557E4026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:36:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W856e77zhB/B4SmePawyOF+ptr+Or/ppLM+g7gimv8qpscQtHFtXVsQw2jv2Db6bN3WdAdgJmnpxj6oXmHS2nE0FnLUXsEqYLTt6d9bq4D2GekFAhUbPaAuCZeLDXaz6DKgM2hEy6cqzmfqJSEoNzGcyoSevNv5uQ6mB7074XHz9So+YiZ8yLGAH90nad7ACpl/cvs7PHCewDjRuKhhtL1e4tPK76hbYCEW9to4AVDW4XdD6ZnZAlAPKtmjOWl9Lw81bXYL5R0ZVsSz8FH6lWncFO10Akfx8W3jWjrC2jvQDVykqmDfuAUH7T6smsmXnafij8cPTlYe6HWASIPF7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE1TwWUISjQBqfaUWte3zxWu+KtFiKrtx7v7FBaafmc=;
 b=C4IwVnvU31s29sDDqdp+kY4744CyoJN0RPeOP+0t18PAVm2fTxYgZX86fkgkfkTwMn1EMTVCxWcv7vFqrz9TtwfaEO8KuMXf7QvmgYQS5/3OBOUUITcljiRmDD53DOHI8oLq3d1FL2KYAGuEc1o3QPbIpokt0vz0pPJirv/oIPA8vGYdkTEBjiInJqmmSUa3j4heFzoX1jiZxwG4BlXzPVGbCIj8zJ3SAU2KnGCUg+8KGilr4J92uGwCP5GZd7WMHvtYMCn119AUVcRq8+M9EJQCUIGhnOiqC5+TRbXVKmpQAwxKqEjQiqRqkhxx5/cYjCWf+40O5SLjvHpjdY7GuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE1TwWUISjQBqfaUWte3zxWu+KtFiKrtx7v7FBaafmc=;
 b=JtakvWII0Tgl2pSvxao5CKmcrLyJfqcOo0EbMQfyIGR/Tq2A1DIZSyzKoim9PnIKr6DjYMtAv1Q7+2q3Oq6FBw2+8jrFBHy4Ozw9ULzU0NjEW1Z6q2hvDqlHpYMSzYzxZltwfGGt54MEmfMPLeLiFjPosJoaT7NgnHaP1VX08Bc=
Received: from BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::22)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 10 Jul
 2026 07:36:36 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::6) by BL1P222CA0017.outlook.office365.com
 (2603:10b6:208:2c7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Fri,
 10 Jul 2026 07:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:36:35 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:36:32 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v5 2/4] dma/ae4dma: add control path operations
Date: Fri, 10 Jul 2026 13:06:06 +0530
Message-ID: <20260710073608.3034898-3-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d52ae0-2200-43d4-bd1f-08dede55f885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: YynX9+yMp493DtNHryEVrq72llqhwY1yOHpmB1c2N92WlW0K2n/+6FUUDoyfDIgXuEmA2nRxDvpTbTkupL210fFL5H6rukyHzg3cKz+yA3pmUoh1VyV/ZFyf4Yt8RWNmv84IR99OknLJHzszvHGKQx1jYhWspnkvbgn4bJJk3ulcr/4HHpxpk6LRlfl1JKLMqbpjHO++fL/nNUL+aEnIpZs8tvDU8epqTdUDk0yIFCXLSu9yRLb2trXHPO01Goglgzjxqa3hv7gnUDpHEndW4tU7lYOKDGeYeUfejayZAJVAohNVwixn1mfmC3L6Kn7TrUSVJqdV2GgXmlfWztYnDf74rjhpEOaD7zYm/thHoOl/zh5mRjMIy8/n/dW+1UMwhw/1KRvawGmVnZ/sqfn9DvhJesCxIlEjNLPWidNzbuQM+apHXpzk1CiKDqixdLu5E6zEJXf6dyRH2CfOC0Lu8S4N9T58zOGDmQD58qHdkwmSRWu2DTSPF67TILoOGwtwy4MNgQWSBgl+ioypCZv5M1GVNv0W1TaTtLCPPdSUwTaveG2DNTwAhSO/bIifj8XIGz89Jd8dRInF9GxAFuK3KraXkaBEbJIgHJUACRV4EnV9yvSrOFgNP5mcGozQgQ+jb5GkIWOYVekChmefx3qAqTiP33z5CrlsvRXs1VOLGGeQZZDpqUtM/0MZMhnlIg1Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GhjFMdoR549lqMbMMu8QkjcGT/3cHLwdhjHb7KtlFR5I/rqWY1faB2zZFw6Jh4szS+fp/Vbt4GGQgEzhtwmyqR1sd+KdZkuGP1TrfTm1AVoqXoWjs90L1GuLUrWTUzWahGwW3qDX+OQurY3uKJg7P0HESZ3XBfEbW1Y5mhDjKbAVYwjVMHHoCgN+kXUenhxMMs5X1+5Si9m+AfEMAjqj0UHmW69ztH60WBorFnSq+0YEo/A3Sz8QYJzwRqNRzeiGO3peLWabTZOd4cUvZUZVPbGOS7/iY0b/NhfSaQoQScCRJ5iJJLgbN7iCWv7hCDU+LC6fWobZyA+NUpqEKNfb/WAJc6/MZQ1sThVinPrVuu4C1R1p6wAzoQ3SIqcHzbxl1BtVn3IOPJyHQEyt24qncRVyHWhtUg7UJ0tuZo09mgOaWni+eO4uHiOnLxBpS3xj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:36:35.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d52ae0-2200-43d4-bd1f-08dede55f885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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
   dmadev and a ring size of 2 to 32 descriptors (rounded up to a
   power of two so the ring slot can be derived by masking). vchan_setup
   also resets the free-running ring indices.
 - dev_start / dev_stop / dev_close: enable the hardware queue and reset
   the ring indices on start (read_idx is HW-owned, so index 0 is
   anchored to the current HW consumer slot), disable the queue on stop,
   and release the descriptor ring memzone on close.
 - dev_info_get: advertise RTE_DMA_CAPA_MEM_TO_MEM and
   RTE_DMA_CAPA_OPS_COPY, the single virtual channel and the 2 to 32
   descriptor range.
 - dev_dump: print the queue identifiers, ring layout and software
   completion counters.
 - stats_get / stats_reset: expose submitted / completed / errors
   counters maintained by the driver.
 - vchan_status: report IDLE / ACTIVE based on hardware read_idx vs
   write_idx, and HALTED_ERROR when the queue is not enabled.

The dmadev framework is wired through dev_ops in ae4dma_dmadev_create().

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/dma/ae4dma/ae4dma_dmadev.c | 228 +++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
index bf0d3bb2bd..9910e115b2 100644
--- a/drivers/dma/ae4dma/ae4dma_dmadev.c
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -35,6 +35,220 @@ ae4dma_queue_dma_zone_reserve(const char *queue_name,
 			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
 }
 
+static int
+ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
+		const struct rte_dma_conf *dev_conf,
+		uint32_t conf_sz)
+{
+	if (conf_sz < sizeof(struct rte_dma_conf))
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
+	if (qconf_sz < sizeof(struct rte_dma_vchan_conf))
+		return -EINVAL;
+
+	/*
+	 * The framework already clamps nb_desc to the advertised [min_desc,
+	 * max_desc] range. The HW ring slot is computed by masking a
+	 * free-running 16-bit index, so the depth must be a power of two:
+	 * round up here when the application asks for a non-power-of-two size.
+	 */
+	if (!rte_is_power_of_2(max_desc))
+		max_desc = rte_align32pow2(max_desc);
+
+	cmd_q->qcfg = *qconf;
+	cmd_q->qcfg.nb_desc = max_desc;
+
+	/* Reset ring indices and stats when (re)configuring the vchan.
+	 * hw_base is (re)sampled from the HW consumer index in dev_start.
+	 */
+	cmd_q->next_write = 0;
+	cmd_q->next_read = 0;
+	cmd_q->last_write = 0;
+	cmd_q->hw_base = 0;
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
+	uint16_t hw_pos;
+
+	if (nb == 0)
+		return -EBUSY;
+
+	/* Program ring depth and (re)enable the HW queue. On HW that resets
+	 * the queue indices on enable, this must happen before we sample
+	 * read_idx below.
+	 */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, nb);
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
+			AE4DMA_CMD_QUEUE_ENABLE);
+
+	/*
+	 * The dmadev ring index is a free-running 16-bit counter that restarts
+	 * from 0 on every (re)start. read_idx is HW-owned (read-only), so we
+	 * cannot force it to 0; instead anchor index 0 to wherever the HW
+	 * consumer currently sits (hw_base) and derive the ring slot as
+	 * (hw_base + idx) & (nb - 1). write_idx is set equal to read_idx so the
+	 * queue starts empty without touching the read-only read_idx register.
+	 */
+	hw_pos = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx) & (nb - 1));
+	cmd_q->hw_base = hw_pos;
+	cmd_q->next_write = 0;
+	cmd_q->next_read = 0;
+	cmd_q->last_write = 0;
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, hw_pos);
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
+		struct rte_dma_info *info, uint32_t size __rte_unused)
+{
+	info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM | RTE_DMA_CAPA_OPS_COPY;
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
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	void *mmio = ae4dma->io_regs;
+
+	fprintf(f, "cmd_q->id              = %" PRIx64 "\n", cmd_q->id);
+	fprintf(f, "cmd_q->qidx            = %" PRIx64 "\n", cmd_q->qidx);
+	fprintf(f, "cmd_q->qsize           = %" PRIx64 "\n", cmd_q->qsize);
+	fprintf(f, "mmio_base_addr	= %p\n", mmio);
+	fprintf(f, "queues per ae4dma engine     = %d\n", AE4DMA_READ_REG_OFFSET(
+				mmio, AE4DMA_COMMON_CONFIG_OFFSET));
+	fprintf(f, "== Private Data ==\n");
+	fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
+	fprintf(f, "  Ring virt: %p\tphys: %#" PRIx64 "\n",
+			(void *)cmd_q->qbase_desc,
+			(uint64_t)cmd_q->qbase_phys_addr);
+	fprintf(f, "  Next write: %u\n", cmd_q->next_write);
+	fprintf(f, "  Next read: %u\n", cmd_q->next_read);
+	fprintf(f, "  current queue depth: %u\n",
+			(uint16_t)(cmd_q->next_write - cmd_q->next_read));
+	fprintf(f, "  }\n");
+	fprintf(f, "  Key Stats { submitted: %" PRIu64 ", comp: %" PRIu64 ", failed: %" PRIu64 " }\n",
+		cmd_q->stats.submitted,
+		cmd_q->stats.completed,
+		cmd_q->stats.errors);
+	return 0;
+}
+
+static int
+ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		struct rte_dma_stats *rte_stats, uint32_t size __rte_unused)
+{
+	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+
+	*rte_stats = cmd_q->stats;
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
@@ -96,6 +310,19 @@ ae4dma_channel_dev_name(char *out, size_t outlen, const char *pci_name,
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
 	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN] = {0};
 	struct ae4dma_dmadev *ae4dma;
 	struct rte_dma_dev *dmadev;
@@ -110,6 +337,7 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
 	}
 	dmadev->device = &dev->device;
 	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
+	dmadev->dev_ops = &ae4dma_dmadev_ops;
 
 	ae4dma = dmadev->data->dev_private;
 
-- 
2.34.1

