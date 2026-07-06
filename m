Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BFEC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:56:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6C0A40698;
	Mon,  6 Jul 2026 13:56:14 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47]) by mails.dpdk.org (Postfix) with ESMTP id F3FAB40698
 for <dev@dpdk.org>; Mon,  6 Jul 2026 13:56:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0PUTjyH7a0jLegXfUovGL2PDEgI8/c6tOEzamNyiq1BI+TehcgulAKuvU5XBIJ7HdLjNwA3Gi2nm3BnzIX87w2wdaqgbBbPnJbdSUoKsiJ9mNokq+7lqTz65lUdqP1Al8qQ4IDX/InMQ8qQaV6anqrtsnLQkHrYUu4VkEAQVCCK7BVgbJmIUqU7IYQzyplEEHjNfok/9G1sbQRQAGIR3wl/3Aidqj+APL2K2rHXiGK2cY7r42XMZFH1xvf5ikv977sxPXTOzocUp0NJxCPFXiexD3AmN63Pj4oXmGGuQ4WNwKjnHUpUJsCYE9p8sXRg6ufvMyZTQzOa1ILIbIaiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihHN5vJzLLJKCzMGn6sq+V+/NJnyYotIgVymDunaQjk=;
 b=i3NeKbHiNp52NzOK1fLlwXDy6vASr4WZfXM6TmDHaldGraiJx5cEGFORHlgX4v9DWPgnN4F2L0rbOmYbBjZGYdcgULc2pnhtEyhVKR87klRePhd7u5rG9toY8riMLp/DwLPTL+JiQAecLoh2AbBX2QeeeyxJQvRpuVdA9C/pw6w3HK50XvfrvFg0i+RU9cD9ufS4QUbUWIpXpElK996VcFEtWWWroJ2bnEduRef/sdsequ9dIMZmzCAFqH9GYXNd9S9h7208XDEmGXVRH+Tawz3IXBNfCn/nBgJhj6iM8TEyVhk9Ltrlxgg4FpnhIMXx/r8cTZ+5wrBdl9Yq1Z3nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihHN5vJzLLJKCzMGn6sq+V+/NJnyYotIgVymDunaQjk=;
 b=iZ6UC+FCEt8vlq6hND6jv5quNlfAS0l2A3sRPl8Oagg0pvyH8C1zDOlOlWVUR3dzYu2Hff6N5s+4irTwabFPcJeNqOb1yv0O0bBSfRqGH2eI5GOOosVKIyuF6vrMAAs1PZ3STY7IgoPx1YIN21r4gpIGdWj3fYoPmV18NWc1uAI=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 11:56:09 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::4c) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon, 6
 Jul 2026 11:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 11:56:08 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 06:56:05 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 2/4] dma/ae4dma: add control path operations
Date: Mon, 6 Jul 2026 17:25:31 +0530
Message-ID: <20260706115533.2937512-3-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aac5e48-8034-4690-369a-08dedb559123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|56012099006|6133799003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: VCqLIy4VEEQpoRiqrqpgL9MBoANZ/Rurs3orooNWd7o3onCXeCdrLLnQQesM+WAvLR0X3ANlMKvK1STQpbXi3JM+adam9xqJLVUoJitXd55sfBvswEC3efYhjtaqIIzqwqxEUonQ2XY1iHJU8HRnDaAmZj6Y/wr/lPWUuEDWhyRwixCqWsmt+Kbb9DASNrDCz+4YPEWIrVCRnW0jDIWcGv7VtnVrLp4JeDRk2uk5RkkpduCHHiLrviCpTHDbkcswfcUL4kunNkmc50tsew1+1aRSVnPeQm7EcN2CsRZi/+lzpNzFjs/rUtwAN6ZiHyAZrYjc0pXsXPxKH7YCODJfaXzE+Z1Tn0GDkbclacf/5N/nUQ1lAbd0VfuyFaOyIRj1DNsOv+Vh5aVUe58XgWWuboJFo7Y+0J9uh2y2w6kWbyC7M9/rHNOiTPU3+ddpWIarQvaSmbxqqIEXn+6BW9nh59tLwIJ/5W26mJNit2+DbZJJq+UUNKn3AllG0YTlYnWNxqVRPB0neU5fnV+qAhHpnPpAptjYXrVah2jPW9uhRmbBiLNEbZn6sXUO2jQdoHVLGBkY26HftxsPwxrqGprOPq8iV+4Aq7ZoBY2pzFPQRn7sc3MnMcdqmuUDSE3nugpxA6AoqTqu/UndcjriVAKPMNIcUykKgrWwfGA1HIRcKxrXay8KhIGbWGUCjNMA+u/H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(6133799003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DecLZjKXN4cBHlmcJIsxZ+glYjQihlvdk80pOqUYqa+cZSrievOlcpMXiihmLSi7c6YC9BSsz5jZnbXyC8hOaclJZEkLXCY+o9NJIlaWxGbSdKYhOj11AlHAUOvpPQg97w/qZgiLoRAxXmWyC/YBW7/+5IUp7ihGepc4JIbmC/Rq5A0yXnWhdWn0mHa1dJbQC2EfOGfvSXYBc6zrIjYfnE4UFJut4o2u3qhmQD7WipBCpN+7dD2LwHH5qOWF9oAsRcD6sWB7pZEUtmWPv6Eer74QYzZ7QQCA/zhC5ANJ07nk1Nfo/cer8d0SLi1pxmdJ+8JZSsRSWEvfAF4+SH/jcX46FPleEoK5waHH07FOF9FQiO4p3AAW5kvwnGxgoY/kV50pCFS/7yEU4Bq2NOQatBOgHCxiWAL0R5XehSLY6ExAR0o/ub9U44zyU506+nAU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:56:08.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aac5e48-8034-4690-369a-08dedb559123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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
index bf0d3bb..9910e11 100644
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

