Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD68C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Jun 2026 00:09:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6028440272;
	Sat, 27 Jun 2026 02:09:15 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 4042740265
 for <dev@dpdk.org>; Sat, 27 Jun 2026 02:09:13 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=i1dKGPwj3P6W51Jp7r5ykRZRdYTDvurYKjGRPsw6rgM=;
 b=yZpp0pJrXfT378q1Ua4JhYasmRbC+J7HU6osWnvZ91E9SW16NAkEvp0Q76Ypv3Q051OJ+i7eD
 4Kmghq57dp3jgWIYP57ROAnkkhmyAgjJ+w/p5uPQgGR/l/MHmKZU7udVmQY0hE7ogcqI9N+5hre
 bdObtwGGvQ8WQ8unHMB0xMQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gnCNT69XLz1T4Ff;
 Sat, 27 Jun 2026 08:00:25 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 5FE8540561;
 Sat, 27 Jun 2026 08:09:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 27 Jun 2026 08:09:09 +0800
Message-ID: <6db5bccd-f82a-4a31-ab4c-b3addbcbcc94@huawei.com>
Date: Sat, 27 Jun 2026 08:09:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dma/ae4dma: add control path operations
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
References: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-3-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260625184728.1678328-3-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

On 6/26/2026 2:47 AM, Raghavendra Ningoji wrote:
> Implement the dmadev control path for the AMD AE4DMA PMD.
> 
> This commit adds:
>  - dev_configure / vchan_setup: accept a single virtual channel per
>    dmadev and clamp the requested ring size to the hardware maximum
>    of 32 descriptors (rounded up to a power of two).
>  - dev_start / dev_stop / dev_close: program the per-queue control
>    register to enable/disable the hardware queue and release the
>    descriptor ring memzone on close.
>  - dev_info_get: advertise RTE_DMA_CAPA_MEM_TO_MEM and the fixed
>    ring depth.

It seemed declare support 2~32 depth, not fixed

>  - dev_dump: print the queue identifiers, ring layout and software
>    completion counters.
>  - stats_get / stats_reset: expose submitted / completed / errors
>    counters maintained by the driver.
>  - vchan_status: report IDLE / ACTIVE based on hardware read_idx vs
>    write_idx, and HALTED_ERROR when the queue is not enabled.
> 
> The dmadev framework is wired through dev_ops in ae4dma_dmadev_create().
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  drivers/dma/ae4dma/ae4dma_dmadev.c | 211 +++++++++++++++++++++++++++++
>  1 file changed, 211 insertions(+)
> 
> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
> index 3d82f86906..607f288623 100644
> --- a/drivers/dma/ae4dma/ae4dma_dmadev.c
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -53,6 +53,203 @@ ae4dma_queue_dma_zone_reserve(const char *queue_name,
>  			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
>  }
>  
> +static int
> +ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
> +		const struct rte_dma_conf *dev_conf,
> +		uint32_t conf_sz)
> +{
> +	if (sizeof(struct rte_dma_conf) != conf_sz)
> +		return -EINVAL;

This may break ABI compatible

> +
> +	if (dev_conf->nb_vchans != 1)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/* Setup a virtual channel for AE4DMA, only 1 vchan is supported per dmadev. */
> +static int
> +ae4dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
> +		const struct rte_dma_vchan_conf *qconf, uint32_t qconf_sz)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t max_desc = qconf->nb_desc;
> +
> +	if (sizeof(struct rte_dma_vchan_conf) != qconf_sz)
> +		return -EINVAL;

This may break ABI compatible

> +
> +	if (max_desc < 2)
> +		return -EINVAL;

No need to do this because rte_dma_vchan_setup already do it.

> +
> +	if (!rte_is_power_of_2(max_desc))
> +		max_desc = rte_align32pow2(max_desc);
> +
> +	if (max_desc > AE4DMA_DESCRIPTORS_PER_CMDQ) {
> +		AE4DMA_PMD_DEBUG("DMA dev %u nb_desc clamped to %u",
> +				dev->data->dev_id, AE4DMA_DESCRIPTORS_PER_CMDQ);
> +		max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +	}

No need to do this because rte_dma_vchan_setup already do it.

> +
> +	cmd_q->qcfg = *qconf;
> +	cmd_q->qcfg.nb_desc = max_desc;
> +
> +	/* Ensure all counters are reset, if reconfiguring/restarting device. */
> +	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
> +	return 0;
> +}
> +
> +static int
> +ae4dma_dev_start(struct rte_dma_dev *dev)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +	if (nb == 0)
> +		return -EBUSY;
> +
> +	/* Program ring depth expected by hardware. */
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, nb);
> +	return 0;
> +}
> +
> +static int
> +ae4dma_dev_stop(struct rte_dma_dev *dev)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +	if (cmd_q->hwq_regs != NULL)
> +		AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +				AE4DMA_CMD_QUEUE_DISABLE);
> +	return 0;
> +}
> +
> +static int
> +ae4dma_dev_info_get(const struct rte_dma_dev *dev __rte_unused,
> +		struct rte_dma_info *info, uint32_t size)
> +{
> +	if (size < sizeof(*info))
> +		return -EINVAL;
> +	info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;

You need also decalre support RTE_DMA_CAP_OPS_COPY, please use dpdk-test dmadev_autotest
to test it.

The dpdk-dma-perf could also test dmadev.

> +	info->max_vchans = 1;
> +	info->min_desc = 2;
> +	info->max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +	info->nb_vchans = 1;
> +	return 0;
> +}
> +
> +static int
> +ae4dma_dev_close(struct rte_dma_dev *dev)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +	if (cmd_q->hwq_regs != NULL)
> +		AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +				AE4DMA_CMD_QUEUE_DISABLE);
> +
> +	rte_memzone_free(cmd_q->mz);
> +	cmd_q->mz = NULL;
> +	cmd_q->qbase_desc = NULL;
> +	cmd_q->qbase_addr = NULL;
> +	cmd_q->qbase_phys_addr = 0;
> +	return 0;
> +}
> +
> +static int
> +ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q;
> +	void *ae4dma_mmio_base_addr = (uint8_t *)ae4dma->io_regs;
> +
> +	cmd_q = &ae4dma->cmd_q;
> +	fprintf(f, "cmd_q->id              = %" PRIx64 "\n", cmd_q->id);
> +	fprintf(f, "cmd_q->qidx            = %" PRIx64 "\n", cmd_q->qidx);
> +	fprintf(f, "cmd_q->qsize           = %" PRIx64 "\n", cmd_q->qsize);
> +	fprintf(f, "mmio_base_addr	= %p\n", ae4dma_mmio_base_addr);
> +	fprintf(f, "queues per ae4dma engine     = %d\n", AE4DMA_READ_REG_OFFSET(
> +				ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET));
> +	fprintf(f, "== Private Data ==\n");
> +	fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
> +	fprintf(f, "  Ring virt: %p\tphys: %#" PRIx64 "\n",
> +			(void *)cmd_q->qbase_desc,
> +			(uint64_t)cmd_q->qbase_phys_addr);
> +	fprintf(f, "  Next write: %u\n", cmd_q->next_write);
> +	fprintf(f, "  Next read: %u\n", cmd_q->next_read);
> +	fprintf(f, "  current queue depth: %u\n", cmd_q->ring_buff_count);
> +	fprintf(f, "  }\n");
> +	fprintf(f, "  Key Stats { submitted: %" PRIu64 ", comp: %" PRIu64 ", failed: %" PRIu64 " }\n",
> +		cmd_q->stats.submitted,
> +		cmd_q->stats.completed,
> +		cmd_q->stats.errors);
> +	return 0;
> +}
> +static int
> +ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
> +		struct rte_dma_stats *rte_stats, uint32_t size)
> +{
> +	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	const struct rte_dma_stats *stats = &cmd_q->stats;
> +
> +	if (size < sizeof(*rte_stats))
> +		return -EINVAL;
> +	if (rte_stats == NULL)
> +		return -EINVAL;

No need to do this check because rte_dma_stats_get already check it
Please make such check on other ops.

> +
> +	*rte_stats = *stats;
> +	return 0;
> +}
> +
> +static int
> +ae4dma_stats_reset(struct rte_dma_dev *dev, uint16_t vchan __rte_unused)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
> +	return 0;
> +}
> +
> +/*
> + * Report channel state to the dmadev framework.
> + *
> + *   RTE_DMA_VCHAN_HALTED_ERROR - HW queue is disabled (never started, or
> + *                                stopped via dev_stop()).
> + *   RTE_DMA_VCHAN_IDLE         - HW has caught up: read_idx == write_idx,
> + *                                no descriptors in flight.
> + *   RTE_DMA_VCHAN_ACTIVE       - HW still has descriptors to process.
> + */
> +static int
> +ae4dma_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
> +		enum rte_dma_vchan_status *status)
> +{
> +	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint32_t ctrl, hw_read, hw_write;
> +
> +	if (cmd_q->hwq_regs == NULL) {
> +		*status = RTE_DMA_VCHAN_HALTED_ERROR;
> +		return 0;
> +	}
> +
> +	ctrl = AE4DMA_READ_REG(&cmd_q->hwq_regs->control_reg.control_raw);
> +	if ((ctrl & AE4DMA_CMD_QUEUE_ENABLE) == 0) {
> +		*status = RTE_DMA_VCHAN_HALTED_ERROR;
> +		return 0;
> +	}
> +
> +	hw_read  = AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
> +	hw_write = AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
> +
> +	*status = (hw_read == hw_write) ? RTE_DMA_VCHAN_IDLE
> +					: RTE_DMA_VCHAN_ACTIVE;
> +	return 0;
> +}
> +
>  static int
>  ae4dma_add_queue(struct ae4dma_dmadev *dev, struct rte_pci_device *pci,
>  		uint8_t qn, const char *pci_name)
> @@ -115,6 +312,19 @@ ae4dma_channel_dev_name(char *out, size_t outlen, const char *pci_name,
>  static int
>  ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
>  {
> +	static const struct rte_dma_dev_ops ae4dma_dmadev_ops = {
> +		.dev_close = ae4dma_dev_close,
> +		.dev_configure = ae4dma_dev_configure,
> +		.dev_dump = ae4dma_dev_dump,
> +		.dev_info_get = ae4dma_dev_info_get,
> +		.dev_start = ae4dma_dev_start,
> +		.dev_stop = ae4dma_dev_stop,
> +		.stats_get = ae4dma_stats_get,
> +		.stats_reset = ae4dma_stats_reset,
> +		.vchan_status = ae4dma_vchan_status,
> +		.vchan_setup = ae4dma_vchan_setup,
> +	};
> +
>  	struct rte_dma_dev *dmadev;
>  	struct ae4dma_dmadev *ae4dma;
>  	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
> @@ -130,6 +340,7 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
>  	}
>  	dmadev->device = &dev->device;
>  	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
> +	dmadev->dev_ops = &ae4dma_dmadev_ops;
>  
>  	ae4dma = dmadev->data->dev_private;
>  

