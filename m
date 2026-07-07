Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC1C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 01:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F67E40264;
	Tue,  7 Jul 2026 03:19:39 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 5825B4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 03:19:38 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/smhdNxKVqT84xGLFijxhyG7QwKphKZPUE5n1W5HRFw=;
 b=U6lRI300VPjEkalHccrBvC6b8ad+YcS/Bz+EfKMoAeoSqjHo+l6aSOLzFL48Fs3G28255RTFF
 x4kIKSzFZ1Iah4MvMvf2ZwLxcgLnOJoPVtwXPTm7Z5/cdd0q67jNC741yxdhENeojc3BA9oD13q
 wAfQdEz4um41BwvkaBNBCdE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gvNTF58WCzpStr;
 Tue,  7 Jul 2026 09:10:57 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 8B89140537;
 Tue,  7 Jul 2026 09:19:35 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Jul 2026 09:19:35 +0800
Message-ID: <aa1b5a05-976f-4dfa-89bc-4cea18b56d33@huawei.com>
Date: Tue, 7 Jul 2026 09:19:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] dma/ae4dma: add data path operations
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
References: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
 <20260706115533.2937512-4-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260706115533.2937512-4-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

On 7/6/2026 7:55 PM, Raghavendra Ningoji wrote:
> Implement the dmadev fast path (copy, submit, completed,
> completed_status and burst_capacity) for the AMD AE4DMA PMD and wire
> the entry points through fp_obj in ae4dma_dmadev_create().
> 
> The framework-visible ring index is a free-running 16-bit value; the
> HW ring slot is derived as (hw_base + idx) & (nb_desc - 1), which is
> why the vchan ring depth is kept a power of two. completed() and
> completed_status() always report the last completed ring_idx via
> last_idx, even when no new op is reaped, as required by the dmadev
> API. Only memory-to-memory copy is advertised, so fp_obj->fill is
> left zero-initialised.
> 
> AE4DMA-specific completion handling: the engine reports completion by
> advancing the per-queue read_idx register rather than reliably writing
> a status word back, so the driver uses read_idx as the source of truth
> and only reads the descriptor err_code byte to flag failures.
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  doc/guides/dmadevs/ae4dma.rst      |  24 +++
>  drivers/dma/ae4dma/ae4dma_dmadev.c | 245 +++++++++++++++++++++++++++++
>  2 files changed, 269 insertions(+)
> 
> diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
> index eeed55c..10446ca 100644
> --- a/doc/guides/dmadevs/ae4dma.rst
> +++ b/doc/guides/dmadevs/ae4dma.rst
> @@ -51,3 +51,27 @@ On probe the PMD performs the following steps for each PCI function:
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
> +  hardware at 32, and the engine reserves one slot to distinguish a full
> +  ring from an empty one, so at most 31 operations can be outstanding
> +  (``rte_dma_burst_capacity()`` returns at most 31). The PMD rounds the
> +  requested ring size up to a power of two and clamps it to 32.
> +* Only a single virtual channel per dmadev is supported; use the 16
> +  per-PCI-function dmadevs to obtain channel-level parallelism.
> +* Interrupt-driven completion is not supported.
> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
> index 9910e11..8fcb0d5 100644
> --- a/drivers/dma/ae4dma/ae4dma_dmadev.c
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -162,6 +162,76 @@ ae4dma_dev_close(struct rte_dma_dev *dev)
>  	return 0;
>  }
>  
> +/* Ring the doorbell: publish all enqueued descriptors to the hardware. */
> +static inline void
> +__submit(struct ae4dma_dmadev *ae4dma)
> +{
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +	if (nb == 0)
> +		return;
> +
> +	/* The HW producer index is the ring slot of the next free descriptor. */
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx,
> +			(cmd_q->hw_base + cmd_q->next_write) & (nb - 1));
> +	cmd_q->stats.submitted += (uint16_t)(cmd_q->next_write - cmd_q->last_write);
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
> +/* Write a copy descriptor; returns the free-running ring_idx assigned to it. */
> +static inline int
> +__write_desc_copy(void *dev_private, rte_iova_t src, rte_iova_t dst,
> +		uint32_t len, uint64_t flags)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t ring_idx = cmd_q->next_write;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +	struct ae4dma_desc *dma_desc;
> +	uint16_t in_flight;
> +
> +	if (nb == 0)
> +		return -EINVAL;
> +
> +	/* Reserve one slot to distinguish full from empty on the ring. */
> +	in_flight = (uint16_t)(cmd_q->next_write - cmd_q->next_read);
> +	if (in_flight >= nb - 1)
> +		return -ENOSPC;
> +
> +	dma_desc = &cmd_q->qbase_desc[(cmd_q->hw_base + ring_idx) & (nb - 1)];
> +	memset(dma_desc, 0, sizeof(*dma_desc));
> +	dma_desc->length = len;
> +	dma_desc->src_hi = upper_32_bits(src);
> +	dma_desc->src_lo = lower_32_bits(src);
> +	dma_desc->dst_hi = upper_32_bits(dst);
> +	dma_desc->dst_lo = lower_32_bits(dst);
> +
> +	cmd_q->next_write++;
> +	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
> +		__submit(ae4dma);
> +
> +	/* dmadev ring_idx is a free-running 16-bit value, not a ring slot. */
> +	return ring_idx;
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
> @@ -192,6 +262,174 @@ ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
>  	return 0;
>  }
>  
> +/* Translate an AE4DMA descriptor error code to the dmadev status code. */
> +static inline enum rte_dma_status_code
> +__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
> +{
> +	switch (status) {
> +	case AE4DMA_DMA_ERR_NO_ERR:
> +		return RTE_DMA_STATUS_SUCCESSFUL;
> +	case AE4DMA_DMA_ERR_INV_LEN:
> +		return RTE_DMA_STATUS_INVALID_LENGTH;
> +	case AE4DMA_DMA_ERR_INV_SRC:
> +		return RTE_DMA_STATUS_INVALID_SRC_ADDR;
> +	case AE4DMA_DMA_ERR_INV_DST:
> +		return RTE_DMA_STATUS_INVALID_DST_ADDR;
> +	default:
> +		return RTE_DMA_STATUS_ERROR_UNKNOWN;
> +	}
> +}
> +
> +/*
> + * Scan the HW queue for completed descriptors (non-blocking).
> + *
> + * The AE4DMA engine signals completion by advancing the per-queue
> + * read_idx register; it does not (reliably) write a status value back
> + * into the descriptor. We therefore use the HW read_idx register as the
> + * source of truth and only inspect the descriptor dw1.err_code byte to
> + * classify each completion as success or failure.
> + *
> + * next_read/next_write are free-running 16-bit indices; the HW ring slot
> + * is ((hw_base + idx) & mask) and the number of in-flight ops is
> + * (next_write - next_read), both relying on nb_desc being a power of two.
> + */
> +static inline uint16_t
> +ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, uint16_t max_ops,
> +		uint16_t *failed_count)
> +{
> +	volatile struct ae4dma_desc *hw_desc;
> +	uint16_t events_count = 0, fails = 0;
> +	uint16_t nb = cmd_q->qcfg.nb_desc;
> +	uint16_t hw_read_pos, tail_pos;
> +	uint16_t newly_done, in_flight;
> +	uint16_t scan_cap, mask;
> +
> +	*failed_count = 0;
> +	if (nb == 0)
> +		return 0;
> +	mask = nb - 1;
> +
> +	in_flight = (uint16_t)(cmd_q->next_write - cmd_q->next_read);
> +	if (in_flight == 0)
> +		return 0;
> +
> +	/* Descriptors HW has consumed since our last visit: [tail, read). */
> +	hw_read_pos = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx) & mask);
> +	tail_pos = (uint16_t)((cmd_q->hw_base + cmd_q->next_read) & mask);
> +	newly_done = (uint16_t)((hw_read_pos - tail_pos) & mask);
> +	if (newly_done == 0)
> +		return 0;
> +
> +	scan_cap = newly_done;
> +	if (scan_cap > in_flight)
> +		scan_cap = in_flight;
> +	if (scan_cap > max_ops)
> +		scan_cap = max_ops;
> +
> +	while (events_count < scan_cap) {
> +		uint16_t slot = (cmd_q->hw_base + cmd_q->next_read + events_count) & mask;
> +		uint8_t hw_status, hw_err;
> +
> +		hw_desc = &cmd_q->qbase_desc[slot];
> +		hw_status = hw_desc->dw1.status;
> +		hw_err = hw_desc->dw1.err_code;
> +
> +		/*
> +		 * read_idx advancing is the definitive completion signal.
> +		 * The per-descriptor status byte is informational and may
> +		 * not yet be written when we observe it, so a slot is only
> +		 * a failure if the HW flagged DESC_ERROR or set err_code.
> +		 */
> +		if (hw_status == AE4DMA_DMA_DESC_ERROR ||
> +				hw_err != AE4DMA_DMA_ERR_NO_ERR) {
> +			fails++;
> +			AE4DMA_PMD_WARN("Desc failed: status=%u err=%u",
> +					hw_status, hw_err);
> +		}
> +		cmd_q->status[events_count] = (enum ae4dma_dma_err)hw_err;
> +		events_count++;
> +	}
> +
> +	cmd_q->next_read += events_count;
> +	cmd_q->stats.completed += events_count;
> +	cmd_q->stats.errors += fails;
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
> +	uint16_t err_count = 0;
> +	uint16_t cpl_count;
> +
> +	*has_error = false;
> +	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +	/*
> +	 * last_idx always reports the ring_idx of the most recently completed
> +	 * op, even when this call reaps nothing (matches the dmadev contract
> +	 * and the ioat/idxd drivers).
> +	 */
> +	if (last_idx != NULL)
> +		*last_idx = (uint16_t)(cmd_q->next_read - 1);

1\ the last_idx always non-NULL for driver, so no need for 'if (last_idx != NULL)'
2\ last_idx should be the last success completed index

> +
> +	if (err_count != 0)
> +		*has_error = true;
> +
> +	return cpl_count - err_count;

Consider four reqests, the hardware mark each request as following:
    req1   success
    req2   err
    req3   success
    req4   err

the cpl_count will be 4, and err_count will be 2

It will return 2 in current impl, and last_idx will be the req4's
But in this function, it should return 1, and last_idx should be req1's

Thanks

> +}
> +
> +static uint16_t
> +ae4dma_completed_status(void *dev_private, uint16_t vchan __rte_unused,
> +		uint16_t max_ops, uint16_t *last_idx,
> +		enum rte_dma_status_code *status)
> +{
> +	struct ae4dma_dmadev *ae4dma = dev_private;
> +	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +	uint16_t err_count = 0;
> +	uint16_t cpl_count;
> +	uint16_t i;
> +
> +	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +	if (last_idx != NULL)
> +		*last_idx = (uint16_t)(cmd_q->next_read - 1);
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
> +	uint16_t in_flight;
> +
> +	if (nb == 0)
> +		return 0;
> +
> +	/* One slot reserved to distinguish full from empty. */
> +	in_flight = (uint16_t)(cmd_q->next_write - cmd_q->next_read);
> +	if (in_flight >= nb - 1)
> +		return 0;
> +	return (uint16_t)(nb - 1 - in_flight);
> +}
> +
>  static int
>  ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
>  		struct rte_dma_stats *rte_stats, uint32_t size __rte_unused)
> @@ -339,6 +577,13 @@ ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
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

