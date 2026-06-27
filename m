Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A6C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Jun 2026 00:23:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 932CE402C1;
	Sat, 27 Jun 2026 02:23:33 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id DA31E40272
 for <dev@dpdk.org>; Sat, 27 Jun 2026 02:23:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YhTi0Jd80tJEvRCpOgL8dUGE7EpvVE3Cxj0ycpwysjU=;
 b=Vy6lLSJlSZdPf+NPKOy8ZNXtbp8xFe3D0iPHL1c9PCamsZ8AXzMhXbkTbHb5Q2ocou54H4Qx9
 RRM9PUUA7NVRWosS8Ej2JGguVljg38EWg1R8W+81U9SzJyYvpxehOTFASu6TXYVCmF54/1ODNYC
 ZIWcs23rq+6TlTGwpQi8sUM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gnCj11BLkz1T4Fw;
 Sat, 27 Jun 2026 08:14:45 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id B15724048F;
 Sat, 27 Jun 2026 08:23:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 27 Jun 2026 08:23:29 +0800
Message-ID: <4c75c27e-6f02-49c5-aa26-b2495739d93c@huawei.com>
Date: Sat, 27 Jun 2026 08:23:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dma/ae4dma: add data path operations
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
References: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-1-raghavendra.ningoji@amd.com>
 <20260625184728.1678328-4-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260625184728.1678328-4-raghavendra.ningoji@amd.com>
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
> Implement the dmadev fast path for the AMD AE4DMA PMD.
> 
> This commit adds:
>  - copy enqueue (rte_dma_copy): write an AE4DMA descriptor for a
>    memory-to-memory transfer; on RTE_DMA_OP_FLAG_SUBMIT the doorbell
>    is rung immediately.
>  - submit (rte_dma_submit): advance the per-queue write_idx
>    register to expose pending descriptors to the hardware.
>  - completion (rte_dma_completed / rte_dma_completed_status):
>    completion is detected via the hardware's per-queue read_idx
>    register, which the engine advances as it processes descriptors.
>    The descriptor status / err_code bytes are read only to classify
>    each drained slot as success or failure, and HW error codes are
>    translated to the dmadev RTE_DMA_STATUS_* enumeration.
>  - burst capacity (rte_dma_burst_capacity): report the number of
>    free descriptor slots, taking into account the one slot reserved
>    to distinguish full from empty on the power-of-two ring.

I don't think it's necessary to write in such detail because the ops
implemented are defined by the framework. If needed, you can supplement
by explaining what special features this driver has.

> 
> The fast path entry points are wired through fp_obj in
> ae4dma_dmadev_create(). The fill capability is not advertised;
> fp_obj->fill is left zero-initialised.
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  doc/guides/dmadevs/ae4dma.rst      |  22 +++
>  drivers/dma/ae4dma/ae4dma_dmadev.c | 287 +++++++++++++++++++++++++++++
>  2 files changed, 309 insertions(+)
> 
> diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
> index a85c1d92ca..37a2096ccf 100644
> --- a/doc/guides/dmadevs/ae4dma.rst
> +++ b/doc/guides/dmadevs/ae4dma.rst
> @@ -51,3 +51,25 @@ On probe the PMD performs the following steps for each PCI function:
>    IOVA-contiguous memory, programs the queue base address and ring
>    depth into the per-queue registers, and enables the queue.
>  * Interrupts are masked; completion is polled by the application.
> +
> +Usage
> +-----
> +
> +Once a dmadev has been started, copies are submitted with
> +``rte_dma_copy()`` and completions are reaped with ``rte_dma_completed()``
> +or ``rte_dma_completed_status()``. See the
> +:ref:`Enqueue / Dequeue API <dmadev_enqueue_dequeue>` section of the
> +dmadev library documentation for details.
> +
> +Limitations
> +-----------
> +
> +* Only memory-to-memory copies are supported. Fill, scatter-gather and
> +  any other operation types are not advertised in
> +  ``rte_dma_info::dev_capa``.
> +* The maximum number of descriptors per virtual channel is fixed by
> +  hardware at 32. The PMD rounds the requested ring size up to a
> +  power of two and clamps it to 32.
> +* Only a single virtual channel per dmadev is supported; use the 16
> +  per-PCI-function dmadevs to obtain channel-level parallelism.
> +* Interrupt-driven completion is not supported.
> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
> index 607f288623..da3ec42233 100644
> --- a/drivers/dma/ae4dma/ae4dma_dmadev.c
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -158,6 +158,72 @@ ae4dma_dev_close(struct rte_dma_dev *dev)
>  	return 0;
>  }
>  
> +/* trigger h/w to process enqued desc:doorbell - by next_write */
> +static inline void
> +__submit(struct ae4dma_dmadev *ae4dma)
> +{
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t write_idx = cmd_q->next_write;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, write_idx);
> +	if (nb != 0)
> +		cmd_q->stats.submitted += (uint16_t)((cmd_q->next_write - cmd_q->last_write +
> +				nb) % nb);
> +	cmd_q->last_write = cmd_q->next_write;
> +}
> +
> +static int
> +ae4dma_submit(void *dev_private, uint16_t vchan __rte_unused)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev_private;
> +
> +	__submit(ae4dma);
> +	return 0;
> +}
> +
> +/* Write descriptor for enqueue (copy only). */
> +static inline int
> +__write_desc_copy(void *dev_private, rte_iova_t src, rte_iova_t dst,
> +		uint32_t len, uint64_t flags)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	struct ae4dma_desc *dma_desc;
> +	uint16_t ret;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +	uint16_t write = cmd_q->next_write;
> +
> +	if (nb == 0)
> +		return -EINVAL;
> +
> +	/* Reserve one slot to distinguish full from empty (power-of-two ring). */
> +	if ((uint32_t)cmd_q->ring_buff_count >= (uint32_t)(nb - 1))
> +		return -ENOSPC;
> +
> +	dma_desc = &cmd_q->qbase_desc[write];
> +	memset(dma_desc, 0, sizeof(*dma_desc));
> +	dma_desc->length = len;
> +	dma_desc->src_hi = upper_32_bits(src);
> +	dma_desc->src_lo = lower_32_bits(src);
> +	dma_desc->dst_hi = upper_32_bits(dst);
> +	dma_desc->dst_lo = lower_32_bits(dst);
> +	cmd_q->ring_buff_count++;
> +	cmd_q->next_write = (uint16_t)((write + 1) % nb);

the next_write is [0, nb_desc-1], and it will as return value as copy,
but the dmadev framework expect as [0, 0xFFFF], I doubt your drvier was
not passed in any DMA test (e.g. dpdk-test, dpdk-dma-perf or examples/dma)

> +	ret = write;
> +	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
> +		__submit(ae4dma);
> +	return ret;
> +}
> +
> +/* Enqueue a copy operation onto the ae4dma device. */
> +static int
> +ae4dma_enqueue_copy(void *dev_private, uint16_t vchan __rte_unused,
> +		rte_iova_t src, rte_iova_t dst, uint32_t length, uint64_t flags)
> +{
> +	return __write_desc_copy(dev_private, src, dst, length, flags);
> +}
> +
>  static int
>  ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
>  {
> @@ -187,6 +253,220 @@ ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
>  		cmd_q->stats.errors);
>  	return 0;
>  }
> +
> +/* Translates AE4DMA ChanERRs to DMA error codes. */
> +static inline enum rte_dma_status_code
> +__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
> +{
> +	AE4DMA_PMD_DEBUG("ae4dma desc status = %d", status);
> +
> +	switch (status) {
> +	case AE4DMA_DMA_ERR_NO_ERR:
> +		return RTE_DMA_STATUS_SUCCESSFUL;
> +	case AE4DMA_DMA_ERR_INV_LEN:
> +		return RTE_DMA_STATUS_INVALID_LENGTH;
> +	case AE4DMA_DMA_ERR_INV_SRC:
> +		return RTE_DMA_STATUS_INVALID_SRC_ADDR;
> +	case AE4DMA_DMA_ERR_INV_DST:
> +		return RTE_DMA_STATUS_INVALID_DST_ADDR;
> +	case AE4DMA_DMA_ERR_INV_ALIGN:
> +		/* Name matches DPDK public enum spelling. */
> +		return RTE_DMA_STATUS_DATA_POISION;

Suggest add RTE_DMA_STATUS_INVALID_ALIGN enum in rte_dmadev.h

> +	case AE4DMA_DMA_ERR_INV_HEADER:
> +	case AE4DMA_DMA_ERR_INV_STATUS:
> +		return RTE_DMA_STATUS_ERROR_UNKNOWN;
> +	default:
> +		return RTE_DMA_STATUS_ERROR_UNKNOWN;
> +	}
> +}
> +
> +/*
> + * Scan HW queue for completed descriptors (non-blocking).
> + *
> + * The AE4DMA engine signals completion by advancing the per-queue
> + * `read_idx` register; it does not (reliably) write a status value
> + * back into the descriptor. We therefore use the HW `read_idx`
> + * register as the source of truth and only inspect the descriptor's
> + * `dw1.err_code` byte to classify each completion as success or
> + * failure.
> + *
> + * @param cmd_q
> + *   The AE4DMA command queue.
> + * @param max_ops
> + *   Maximum descriptors to process this call.
> + * @param[out] failed_count
> + *   Number of completed descriptors that did not report success.
> + * @return
> + *   Number of descriptors completed (success + failure), <= max_ops.
> + */
> +static inline uint16_t
> +ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, uint16_t max_ops,
> +		uint16_t *failed_count)
> +{
> +	volatile struct ae4dma_desc *hw_desc;
> +	uint16_t events_count = 0, fails = 0;
> +	uint16_t tail;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +	uint16_t mask;
> +	uint16_t hw_read_idx;
> +	uint16_t in_flight;
> +	uint16_t scan_cap;
> +
> +	if (nb == 0 || cmd_q->ring_buff_count == 0) {
> +		*failed_count = 0;
> +		return 0;
> +	}
> +	mask = nb - 1;
> +
> +	hw_read_idx = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx) & mask);
> +	tail = cmd_q->next_read;
> +
> +	/*
> +	 * Descriptors completed since our last visit live in the
> +	 * half-open ring range [tail, hw_read_idx). If HW hasn't
> +	 * moved we have nothing to do.
> +	 */
> +	in_flight = (uint16_t)((hw_read_idx - tail) & mask);
> +	if (in_flight == 0) {
> +		*failed_count = 0;
> +		return 0;
> +	}
> +
> +	scan_cap = max_ops;
> +	if (scan_cap > AE4DMA_DESCRIPTORS_PER_CMDQ)
> +		scan_cap = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +	if (scan_cap > in_flight)
> +		scan_cap = in_flight;
> +	if (scan_cap > cmd_q->ring_buff_count)
> +		scan_cap = (uint16_t)cmd_q->ring_buff_count;
> +
> +	while (events_count < scan_cap) {
> +		uint8_t hw_status;
> +		uint8_t hw_err;
> +
> +		hw_desc = &cmd_q->qbase_desc[tail];
> +		hw_status = hw_desc->dw1.status;
> +		hw_err = hw_desc->dw1.err_code;
> +
> +		/*
> +		 * read_idx advancing is the definitive completion
> +		 * signal. The per-descriptor status byte is informational
> +		 * and may not yet be written when we observe it:
> +		 *
> +		 *   AE4DMA_DMA_DESC_ERROR (4)
> +		 *     Hard failure - err_code names the precise cause.
> +		 *   AE4DMA_DMA_DESC_COMPLETED (3) or 0
> +		 *     Success.
> +		 *   AE4DMA_DMA_DESC_VALIDATED (1) / _PROCESSED (2)
> +		 *     Benign race: HW had not finished updating the
> +		 *     status byte at the instant we read it. Since
> +		 *     read_idx has moved past this slot, treat it as
> +		 *     success unless err_code says otherwise.
> +		 *
> +		 * A non-zero err_code is treated as a failure regardless
> +		 * of the observed status value.
> +		 */
> +		if (hw_status == AE4DMA_DMA_DESC_ERROR ||
> +				hw_err != AE4DMA_DMA_ERR_NO_ERR) {
> +			fails++;
> +			AE4DMA_PMD_WARN("Desc failed: status=%u err=%u",
> +					hw_status, hw_err);
> +		}
> +		cmd_q->status[events_count] = (enum ae4dma_dma_err)hw_err;
> +		cmd_q->ring_buff_count--;
> +		events_count++;
> +		tail = (tail + 1) & mask;
> +	}
> +
> +	cmd_q->stats.completed += events_count;
> +	cmd_q->stats.errors += fails;
> +	cmd_q->next_read = tail;
> +	*failed_count = fails;
> +	return events_count;
> +}
> +
> +/* Returns successful operations count and sets error flag if any errors. */
> +static uint16_t
> +ae4dma_completed(void *dev_private, uint16_t vchan __rte_unused,
> +		const uint16_t max_ops, uint16_t *last_idx, bool *has_error)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t cpl_count, sl_count;
> +	uint16_t err_count = 0;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +	*has_error = false;
> +
> +	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +	if (cpl_count > max_ops)
> +		cpl_count = max_ops;
> +
> +	if (cpl_count > 0 && last_idx != NULL)
> +		*last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);

the last_idx should be in range of [0, 0xFFFF]

> +
> +	sl_count = cpl_count - err_count;
> +	if (err_count)
> +		*has_error = true;
> +
> +	return sl_count;
> +}
> +
> +static uint16_t
> +ae4dma_completed_status(void *dev_private, uint16_t vchan __rte_unused,
> +		uint16_t max_ops, uint16_t *last_idx,
> +		enum rte_dma_status_code *status)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t cpl_count;
> +	uint16_t i;
> +	uint16_t err_count = 0;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +	if (cpl_count > max_ops)
> +		cpl_count = max_ops;
> +
> +	if (cpl_count > 0 && last_idx != NULL)
> +		*last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
> +
> +	if (likely(err_count == 0)) {
> +		for (i = 0; i < cpl_count; i++)
> +			status[i] = RTE_DMA_STATUS_SUCCESSFUL;
> +	} else {
> +		for (i = 0; i < cpl_count; i++)
> +			status[i] = __translate_status_ae4dma_to_dma(cmd_q->status[i]);
> +	}
> +
> +	return cpl_count;
> +}
> +
> +/* Get the remaining capacity of the ring. */
> +static uint16_t
> +ae4dma_burst_capacity(const void *dev_private, uint16_t vchan __rte_unused)
> +{
> +	const struct ae4dma_dmadev *ae4dma = dev_private;
> +	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +	uint16_t mask;
> +	uint16_t read_idx = cmd_q->next_read;
> +	uint16_t write_idx = cmd_q->next_write;
> +	uint16_t used;
> +
> +	if (nb < 2 || !rte_is_power_of_2(nb))
> +		return 0;

No need to check this

> +
> +	mask = nb - 1;
> +	used = (uint16_t)((write_idx - read_idx) & mask);
> +	/* One slot reserved (same rule as enqueue). */
> +	if (used >= nb - 1)
> +		return 0;
> +	return (uint16_t)(nb - 1 - used);
> +}
> +
>  static int
>  ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
>  		struct rte_dma_stats *rte_stats, uint32_t size)
> @@ -342,6 +622,13 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
>  	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
>  	dmadev->dev_ops = &ae4dma_dmadev_ops;
>  
> +	dmadev->fp_obj->burst_capacity = ae4dma_burst_capacity;
> +	dmadev->fp_obj->completed = ae4dma_completed;
> +	dmadev->fp_obj->completed_status = ae4dma_completed_status;
> +	dmadev->fp_obj->copy = ae4dma_enqueue_copy;
> +	dmadev->fp_obj->submit = ae4dma_submit;
> +	/* fill capability not advertised: leave fp_obj->fill as zero-initialised. */
> +
>  	ae4dma = dmadev->data->dev_private;
>  
>  	if (ae4dma_add_queue(ae4dma, dev, qn, name) != 0)

