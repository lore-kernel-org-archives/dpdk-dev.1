Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D82CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 14:28:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BB26402E0;
	Thu, 21 May 2026 16:28:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3CEF04042F
 for <dev@dpdk.org>; Thu, 21 May 2026 16:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779373730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6zWvb1PZRfbyJWL/aG/7SLzEpBTihGK9ia9c9U4Zrk=;
 b=Nh/fZbB4KkvCFsjNV7G69cihdAAJtOKzNFdtA9VYAP8WQrAhiGlTbB9URm94AzwFjMOssv
 39SqspTFv/IFG507Kt//EMhPzrtbddkXxIGM/0G9WuSOZcphX2ip1/K//SLZfbDsAjEeDo
 wEF3OpsLtug8ttCoeUROzCcdVU3xjU0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-7tIV74YqP8-UvJwrUxD2Rw-1; Thu, 21 May 2026 10:28:49 -0400
X-MC-Unique: 7tIV74YqP8-UvJwrUxD2Rw-1
X-Mimecast-MFC-AGG-ID: 7tIV74YqP8-UvJwrUxD2Rw_1779373728
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36629e48023so5899735a91.2
 for <dev@dpdk.org>; Thu, 21 May 2026 07:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779373728; x=1779978528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6zWvb1PZRfbyJWL/aG/7SLzEpBTihGK9ia9c9U4Zrk=;
 b=I9WH285F//wG8M2D3Ym3Wilbt8gsWEDfLcBETciCwiQYQt201jA3CGluRalZgqocUy
 8K+3VcHhBSaQaQ/b4OWdU+REFM7DOPofqIN6Hb9InLOvwa9dHHN5k235QGRtkKUcn+CX
 tBZwgterSVmd0HYEcTF4xk23N2ES6T0Am7ewY8P3bpM/kLmj72WaRgRzR6rR9KRU9tDd
 sCvR5tBLEuTdCI3ygHMR+EbxGY/eiQ+R7ZRC+MqjE6oT4haQFXMwGUEbpAyX/W/18OSh
 Ku55PAZiIEKECoZb0kKmulko1/+6+TelT1N3nT1K/YlW4EdKRhYxZrwN86bDJdMTpCsU
 pIuw==
X-Gm-Message-State: AOJu0Yyj/XJtC/6qIDEKs0PnL7Zj0p9KspewiHNZUtvYrr7IeNm4wvRy
 qhE3CCjrxX1/uGVIA7kR0jBnW3z2VGV+mfj+dRa3ev0Sg+El1X4u1qVdPch/RBMNDbN+0O55Kn6
 4rrXpGtX7bxUisZzW2YdAVrSY+VHP79vX4aswGY8VcTSOOVh1Bcnag+QRpEcpFWB6unVyiIhSJh
 yxhtp8Rkhd7PyxorRz0Po=
X-Gm-Gg: Acq92OHA3FoHnKKOxiWkhjSrpP5T0CFdo8CIXlQjs1fr3GeGJS5H+z9F1pNLb+l7PPq
 12j0ehnu4ruqS5mutTABnGxHqL3xM9e08p6Depsy+1tjMU/q0huQmOnG+OupXoiheeTUQ6dDgBn
 jRjgYrJcrewTUGrRvlGDr5TXhN5yUo9ZkzVrb93xKUJyBzL78MewsQ8Ifp/byihyaFuBwxvsukN
 BvGZYNGfKojQSx+XNOLUxgAolwj/su6oP8I9/RhU/Zg67IzCTc9GYDZi4g2YrnUOqT8SQ==
X-Received: by 2002:a17:90b:578e:b0:368:ac5f:d31b with SMTP id
 98e67ed59e1d1-36a456527fcmr3301060a91.24.1779373727508; 
 Thu, 21 May 2026 07:28:47 -0700 (PDT)
X-Received: by 2002:a17:90b:578e:b0:368:ac5f:d31b with SMTP id
 98e67ed59e1d1-36a456527fcmr3301021a91.24.1779373726897; Thu, 21 May 2026
 07:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
In-Reply-To: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 21 May 2026 16:28:33 +0200
X-Gm-Features: AVHnY4LoKvmHSBnTeoQjJeHTcNfwNilV84UKEsO8eviDTmIv7eC-mK6PPtO_kOc
Message-ID: <CAJFAV8yt4r2by_aNi2ciR_YFdmTdfaj2wCeeNTmWBKsZN42z7A@mail.gmail.com>
Subject: Re: [PATCH] dma/ae4dma: add AMD AE4DMA DMA PMD
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, thomas@monjalon.net, rjarry@redhat.com, 
 Bhagyada.Modali@amd.com, Selwin.Sebastian@amd.com, 
 Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uV-bSJHXis-KDiHx4-rhnqpk8anAekqW5yIbgZKz-Rk_1779373728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Mon, 18 May 2026 at 20:19, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> Add a new dmadev poll-mode driver for the AMD AE4DMA hardware DMA
> engine.  An AE4DMA engine exposes 16 hardware command queues, each
> with a 32-entry descriptor ring; the PMD maps each hardware channel
> to its own dmadev with a single virtual channel, so a PCI function
> appears as 16 dmadevs named "<pci-bdf>-ch0" .. "<pci-bdf>-ch15".
>
> Driver characteristics:
>
>  - Memory-to-memory copy operations only (RTE_DMA_CAPA_MEM_TO_MEM).
>  - Completion is detected via the hardware's per-queue read_idx
>    register, which the engine advances as it processes descriptors.
>    The descriptor status / err_code bytes are read only to classify
>    each drained slot as success or failure.
>  - vchan_status reports IDLE/ACTIVE based on HW read_idx vs write_idx
>    and HALTED_ERROR when the queue is not enabled.
>  - depends on bus_pci and dmadev.
>
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>

Cc: Chengwen Feng (DMAdev maintainer)

- The patch is big, splitting it into logical patches introducing one
feature at a time would help.
See for example how the latest DMA driver was submitted:

5a9c32a89c - dma/hisi_acc: introduce HiSilicon SoC accelerator driver
(7 months ago) <Chengwen Feng>
2557ad8f8a - dma/hisi_acc: add control path operations (7 months ago)
<Chengwen Feng>
b58c4435ea - dma/hisi_acc: add data path operations (7 months ago)
<Chengwen Feng>


- Please fix the below warnings raised by checkpatches.sh, and run
this script before submitting a new revision.

### [PATCH] dma/ae4dma: add AMD AE4DMA DMA PMD

WARNING:TYPO_SPELLING: 're-use' may be misspelled - perhaps 'reuse'?
#199: FILE: drivers/dma/ae4dma/ae4dma_dmadev.c:42:
+            AE4DMA_PMD_INFO("re-use memzone already "
                              ^^^^^^

total: 0 errors, 1 warnings, 1160 lines checked

Warning in drivers/dma/ae4dma/ae4dma_internal.h:
Prefer RTE_LOG_LINE/RTE_LOG_DP_LINE

Warning in drivers/dma/ae4dma/ae4dma_internal.h:
Do not use variadic argument pack in macros

Please use __rte_cache_aligned only for struct or union types alignment.


- Please also checks the copyright years.
For new code (from upstream pov), this should be 2026.


- Globally in those changes, rte_iova_t should probably be used
instead of phys_addr_t.


> ---
>  MAINTAINERS                            |   5 +
>  doc/guides/dmadevs/ae4dma.rst          |  75 +++
>  doc/guides/dmadevs/index.rst           |   1 +
>  doc/guides/rel_notes/release_26_07.rst |   7 +
>  drivers/dma/ae4dma/ae4dma_dmadev.c     | 742 +++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma_hw_defs.h    | 164 ++++++
>  drivers/dma/ae4dma/ae4dma_internal.h   | 117 ++++
>  drivers/dma/ae4dma/meson.build         |   7 +
>  drivers/dma/meson.build                |   1 +
>  usertools/dpdk-devbind.py              |   5 +-
>  10 files changed, 1123 insertions(+), 1 deletion(-)
>  create mode 100644 doc/guides/dmadevs/ae4dma.rst
>  create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
>  create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
>  create mode 100644 drivers/dma/ae4dma/meson.build
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9143d028bc..0b5a6e08d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1361,6 +1361,11 @@ F: doc/guides/compressdevs/features/zsda.ini
>  DMAdev Drivers
>  --------------
>
> +AMD AE4DMA
> +M: Bhagyada Modali <Bhagyada.Modali@amd.com>

No capital letter in the mail address section.


> +F: drivers/dma/ae4dma/
> +F: doc/guides/dmadevs/ae4dma.rst
> +
>  Intel IDXD - EXPERIMENTAL
>  M: Bruce Richardson <bruce.richardson@intel.com>
>  M: Kevin Laatz <kevin.laatz@intel.com>

Please also add an entry in the .mailmap file as it is your first contribution.


> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
> new file mode 100644
> index 0000000000..eb6ea88f55
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -0,0 +1,742 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2021-2025 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <rte_bus_pci.h>
> +#include <bus_pci_driver.h>
> +#include <rte_dmadev_pmd.h>
> +#include <rte_malloc.h>
> +
> +#include "ae4dma_internal.h"
> +
> +/*
> + * One dmadev per AE4DMA hardware channel; each dmadev has exactly one
> + * virtual channel. The HW's per-queue register block must be densely
> + * packed right after the engine-common config register at BAR0+0; the
> + * build-time check below catches an accidental layout change.
> + */
> +static_assert(sizeof(struct ae4dma_hwq_regs) == 32,
> +               "ae4dma_hwq_regs stride changed; per-queue offset math will break");
> +
> +RTE_LOG_REGISTER_DEFAULT(ae4dma_pmd_logtype, INFO);
> +
> +#define AE4DMA_PMD_NAME dmadev_ae4dma
> +#define AE4DMA_PMD_NAME_STR RTE_STR(AE4DMA_PMD_NAME)

AE4DMA_PMD_NAME_STR is not used at all.
Avoid introducing the macro AE4DMA_PMD_NAME, the value is not supposed
to change.


> +
> +static const struct rte_memzone *
> +ae4dma_queue_dma_zone_reserve(const char *queue_name,
> +               uint32_t queue_size, int socket_id)
> +{
> +       const struct rte_memzone *mz;
> +
> +       mz = rte_memzone_lookup(queue_name);
> +       if (mz != 0) {

mz != NULL

> +               if (((size_t)queue_size <= mz->len) &&
> +                               ((socket_id == SOCKET_ID_ANY) ||
> +                                (socket_id == mz->socket_id))) {
> +                       AE4DMA_PMD_INFO("re-use memzone already "
> +                                       "allocated for %s", queue_name);
> +                       return mz;
> +               }
> +               AE4DMA_PMD_ERR("Incompatible memzone already "
> +                               "allocated %s, size %u, socket %d. "
> +                               "Requested size %u, socket %u",
> +                               queue_name, (uint32_t)mz->len,
> +                               mz->socket_id, queue_size, socket_id);
> +               return NULL;
> +       }
> +       return rte_memzone_reserve_aligned(queue_name, queue_size,
> +                       socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
> +}
> +
> +/* Configure a device. */
> +static int
> +ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
> +               const struct rte_dma_conf *dev_conf,
> +               uint32_t conf_sz)
> +{
> +       if (sizeof(struct rte_dma_conf) != conf_sz)
> +               return -EINVAL;
> +
> +       if (dev_conf->nb_vchans != 1)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +/* Setup a virtual channel for AE4DMA, only 1 vchan is supported per dmadev. */
> +static int
> +ae4dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
> +               const struct rte_dma_vchan_conf *qconf, uint32_t qconf_sz)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t max_desc = qconf->nb_desc;
> +
> +       if (sizeof(struct rte_dma_vchan_conf) != qconf_sz)
> +               return -EINVAL;
> +
> +       if (max_desc < 2)
> +               return -EINVAL;
> +
> +       if (!rte_is_power_of_2(max_desc))
> +               max_desc = rte_align32pow2(max_desc);
> +
> +       if (max_desc > AE4DMA_DESCRIPTORS_PER_CMDQ) {
> +               AE4DMA_PMD_DEBUG("DMA dev %u nb_desc clamped to %u",
> +                               dev->data->dev_id, AE4DMA_DESCRIPTORS_PER_CMDQ);
> +               max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +       }
> +
> +       cmd_q->qcfg = *qconf;
> +       cmd_q->qcfg.nb_desc = max_desc;
> +
> +       /* Ensure all counters are reset, if reconfiguring/restarting device. */
> +       memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
> +       return 0;
> +}
> +
> +/* Start a configured device. */
> +static int
> +ae4dma_dev_start(struct rte_dma_dev *dev)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +       if (nb == 0)
> +               return -EBUSY;
> +
> +       /* Program ring depth expected by hardware. */
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, nb);
> +       return 0;
> +}
> +
> +/* Stop a configured device. */
> +static int
> +ae4dma_dev_stop(struct rte_dma_dev *dev)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +       if (cmd_q->hwq_regs != NULL)
> +               AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +                               AE4DMA_CMD_QUEUE_DISABLE);
> +       return 0;
> +}
> +
> +/* Get device information of a device. */
> +static int
> +ae4dma_dev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *info,
> +               uint32_t size)
> +{
> +       if (size < sizeof(*info))
> +               return -EINVAL;
> +       info->dev_name = dev->device->name;
> +       info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;
> +       info->max_vchans = 1;
> +       info->min_desc = 2;
> +       info->max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +       info->nb_vchans = 1;
> +       return 0;
> +}
> +
> +/* Close a configured device. */
> +static int
> +ae4dma_dev_close(struct rte_dma_dev *dev)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +       if (cmd_q->hwq_regs != NULL)
> +               AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +                               AE4DMA_CMD_QUEUE_DISABLE);
> +
> +       if (cmd_q->memz_name[0] != '\0') {
> +               const struct rte_memzone *mz = rte_memzone_lookup(cmd_q->memz_name);
> +
> +               if (mz != NULL)
> +                       rte_memzone_free(mz);
> +       }
> +       cmd_q->qbase_desc = NULL;
> +       cmd_q->qbase_addr = NULL;
> +       cmd_q->qbase_phys_addr = 0;
> +       return 0;
> +}
> +
> +/* trigger h/w to process enqued desc:doorbell - by next_write */
> +static inline void
> +__submit(struct ae4dma_dmadev *ae4dma)
> +{
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t write_idx = cmd_q->next_write;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, write_idx);
> +       if (nb != 0)
> +               cmd_q->stats.submitted += (uint16_t)((cmd_q->next_write - cmd_q->last_write +
> +                               nb) % nb);
> +       cmd_q->last_write = cmd_q->next_write;
> +}
> +
> +static int
> +ae4dma_submit(void *dev_private, uint16_t vchan __rte_unused)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev_private;
> +
> +       __submit(ae4dma);
> +       return 0;
> +}
> +
> +/* Write descriptor for enqueue (copy only). */
> +static inline int
> +__write_desc_copy(void *dev_private, rte_iova_t src, phys_addr_t dst,
> +               uint32_t len, uint64_t flags)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       struct ae4dma_desc *dma_desc;
> +       uint16_t ret;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +       uint16_t write = cmd_q->next_write;
> +
> +       if (nb == 0)
> +               return -EINVAL;
> +
> +       /* Reserve one slot to distinguish full from empty (power-of-two ring). */
> +       if ((uint32_t)cmd_q->ring_buff_count >= (uint32_t)(nb - 1))
> +               return -ENOSPC;
> +
> +       dma_desc = &cmd_q->qbase_desc[write];
> +       memset(dma_desc, 0, sizeof(*dma_desc));
> +       dma_desc->length = len;
> +       dma_desc->src_hi = upper_32_bits(src);
> +       dma_desc->src_lo = lower_32_bits(src);
> +       dma_desc->dst_hi = upper_32_bits(dst);
> +       dma_desc->dst_lo = lower_32_bits(dst);
> +       cmd_q->ring_buff_count++;
> +       cmd_q->next_write = (uint16_t)((write + 1) % nb);
> +       ret = write;
> +       if (flags & RTE_DMA_OP_FLAG_SUBMIT)
> +               __submit(ae4dma);
> +       return ret;
> +}
> +
> +/* Enqueue a copy operation onto the ae4dma device. */
> +static int
> +ae4dma_enqueue_copy(void *dev_private, uint16_t vchan __rte_unused,
> +               rte_iova_t src, rte_iova_t dst, uint32_t length, uint64_t flags)
> +{
> +       return __write_desc_copy(dev_private, src, dst, length, flags);
> +}
> +
> +/* Dump DMA device info. */
> +static int
> +ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q;
> +       void *ae4dma_mmio_base_addr = (uint8_t *)ae4dma->io_regs;
> +
> +       cmd_q = &ae4dma->cmd_q;
> +       fprintf(f, "cmd_q->id              = %" PRIx64 "\n", cmd_q->id);
> +       fprintf(f, "cmd_q->qidx            = %" PRIx64 "\n", cmd_q->qidx);
> +       fprintf(f, "cmd_q->qsize           = %" PRIx64 "\n", cmd_q->qsize);
> +       fprintf(f, "mmio_base_addr      = %p\n", ae4dma_mmio_base_addr);
> +       fprintf(f, "queues per ae4dma engine     = %d\n", AE4DMA_READ_REG_OFFSET(
> +                               ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET));
> +       fprintf(f, "== Private Data ==\n");
> +       fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
> +       fprintf(f, "  Ring virt: %p\tphys: %#" PRIx64 "\n",
> +                       (void *)cmd_q->qbase_desc,
> +                       (uint64_t)cmd_q->qbase_phys_addr);
> +       fprintf(f, "  Next write: %u\n", cmd_q->next_write);
> +       fprintf(f, "  Next read: %u\n", cmd_q->next_read);
> +       fprintf(f, "  current queue depth: %u\n", cmd_q->ring_buff_count);
> +       fprintf(f, "  }\n");
> +       fprintf(f, "  Key Stats { submitted: %" PRIu64 ", comp: %" PRIu64 ", failed: %" PRIu64 " }\n",
> +               cmd_q->stats.submitted,
> +               cmd_q->stats.completed,
> +               cmd_q->stats.errors);
> +       return 0;
> +}
> +
> +/* Translates AE4DMA ChanERRs to DMA error codes. */
> +static inline enum rte_dma_status_code
> +__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
> +{
> +       AE4DMA_PMD_DEBUG("ae4dma desc status = %d", status);
> +
> +       switch (status) {
> +       case AE4DMA_DMA_ERR_NO_ERR:
> +               return RTE_DMA_STATUS_SUCCESSFUL;
> +       case AE4DMA_DMA_ERR_INV_LEN:
> +               return RTE_DMA_STATUS_INVALID_LENGTH;
> +       case AE4DMA_DMA_ERR_INV_SRC:
> +               return RTE_DMA_STATUS_INVALID_SRC_ADDR;
> +       case AE4DMA_DMA_ERR_INV_DST:
> +               return RTE_DMA_STATUS_INVALID_DST_ADDR;
> +       case AE4DMA_DMA_ERR_INV_ALIGN:
> +               /* Name matches DPDK public enum spelling. */
> +               return RTE_DMA_STATUS_DATA_POISION;
> +       case AE4DMA_DMA_ERR_INV_HEADER:
> +       case AE4DMA_DMA_ERR_INV_STATUS:
> +               return RTE_DMA_STATUS_ERROR_UNKNOWN;
> +       default:
> +               return RTE_DMA_STATUS_ERROR_UNKNOWN;
> +       }
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
> +               uint16_t *failed_count)
> +{
> +       volatile struct ae4dma_desc *hw_desc;
> +       uint16_t events_count = 0, fails = 0;
> +       uint16_t tail;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +       uint16_t mask;
> +       uint16_t hw_read_idx;
> +       uint16_t in_flight;
> +       uint16_t scan_cap;
> +
> +       if (nb == 0 || cmd_q->ring_buff_count == 0) {
> +               *failed_count = 0;
> +               return 0;
> +       }
> +       mask = nb - 1;
> +
> +       hw_read_idx = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx) & mask);
> +       tail = cmd_q->next_read;
> +
> +       /*
> +        * Descriptors completed since our last visit live in the
> +        * half-open ring range [tail, hw_read_idx). If HW hasn't
> +        * moved we have nothing to do.
> +        */
> +       in_flight = (uint16_t)((hw_read_idx - tail) & mask);
> +       if (in_flight == 0) {
> +               *failed_count = 0;
> +               return 0;
> +       }
> +
> +       scan_cap = max_ops;
> +       if (scan_cap > AE4DMA_DESCRIPTORS_PER_CMDQ)
> +               scan_cap = AE4DMA_DESCRIPTORS_PER_CMDQ;
> +       if (scan_cap > in_flight)
> +               scan_cap = in_flight;
> +       if (scan_cap > cmd_q->ring_buff_count)
> +               scan_cap = (uint16_t)cmd_q->ring_buff_count;
> +
> +       while (events_count < scan_cap) {
> +               uint8_t hw_status;
> +               uint8_t hw_err;
> +
> +               hw_desc = &cmd_q->qbase_desc[tail];
> +               hw_status = hw_desc->dw1.status;
> +               hw_err = hw_desc->dw1.err_code;
> +
> +               /*
> +                * read_idx advancing is the definitive completion
> +                * signal. The per-descriptor status byte is informational
> +                * and may not yet be written when we observe it:
> +                *
> +                *   AE4DMA_DMA_DESC_ERROR (4)
> +                *     Hard failure - err_code names the precise cause.
> +                *   AE4DMA_DMA_DESC_COMPLETED (3) or 0
> +                *     Success.
> +                *   AE4DMA_DMA_DESC_VALIDATED (1) / _PROCESSED (2)
> +                *     Benign race: HW had not finished updating the
> +                *     status byte at the instant we read it. Since
> +                *     read_idx has moved past this slot, treat it as
> +                *     success unless err_code says otherwise.
> +                *
> +                * A non-zero err_code is treated as a failure regardless
> +                * of the observed status value.
> +                */
> +               if (hw_status == AE4DMA_DMA_DESC_ERROR ||
> +                               hw_err != AE4DMA_DMA_ERR_NO_ERR) {
> +                       fails++;
> +                       AE4DMA_PMD_WARN("Desc failed: status=%u err=%u",
> +                                       hw_status, hw_err);
> +               }
> +               cmd_q->status[events_count] = (enum ae4dma_dma_err)hw_err;
> +               cmd_q->ring_buff_count--;
> +               events_count++;
> +               tail = (tail + 1) & mask;
> +       }
> +
> +       cmd_q->stats.completed += events_count;
> +       cmd_q->stats.errors += fails;
> +       cmd_q->next_read = tail;
> +       *failed_count = fails;
> +       return events_count;
> +}
> +
> +/* Returns successful operations count and sets error flag if any errors. */
> +static uint16_t
> +ae4dma_completed(void *dev_private, uint16_t vchan __rte_unused,
> +               const uint16_t max_ops, uint16_t *last_idx, bool *has_error)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t cpl_count, sl_count;
> +       uint16_t err_count = 0;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +       *has_error = false;
> +
> +       cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +       if (cpl_count > max_ops)
> +               cpl_count = max_ops;
> +
> +       if (cpl_count > 0 && last_idx != NULL)
> +               *last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
> +
> +       sl_count = cpl_count - err_count;
> +       if (err_count)
> +               *has_error = true;
> +
> +       return sl_count;
> +}
> +
> +static uint16_t
> +ae4dma_completed_status(void *dev_private, uint16_t vchan __rte_unused,
> +               uint16_t max_ops, uint16_t *last_idx,
> +               enum rte_dma_status_code *status)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t cpl_count;
> +       uint16_t i;
> +       uint16_t err_count = 0;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +
> +       cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
> +
> +       if (cpl_count > max_ops)
> +               cpl_count = max_ops;
> +
> +       if (cpl_count > 0 && last_idx != NULL)
> +               *last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
> +
> +       if (likely(err_count == 0)) {
> +               for (i = 0; i < cpl_count; i++)
> +                       status[i] = RTE_DMA_STATUS_SUCCESSFUL;
> +       } else {
> +               for (i = 0; i < cpl_count; i++)
> +                       status[i] = __translate_status_ae4dma_to_dma(cmd_q->status[i]);
> +       }
> +
> +       return cpl_count;
> +}
> +
> +/* Get the remaining capacity of the ring. */
> +static uint16_t
> +ae4dma_burst_capacity(const void *dev_private, uint16_t vchan __rte_unused)
> +{
> +       const struct ae4dma_dmadev *ae4dma = dev_private;
> +       const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint16_t nb = cmd_q->qcfg.nb_desc;
> +       uint16_t mask;
> +       uint16_t read_idx = cmd_q->next_read;
> +       uint16_t write_idx = cmd_q->next_write;
> +       uint16_t used;
> +
> +       if (nb < 2 || !rte_is_power_of_2(nb))
> +               return 0;
> +
> +       mask = nb - 1;
> +       used = (uint16_t)((write_idx - read_idx) & mask);
> +       /* One slot reserved (same rule as enqueue). */
> +       if (used >= nb - 1)
> +               return 0;
> +       return (uint16_t)(nb - 1 - used);
> +}
> +
> +/* Retrieve the generic stats of a DMA device. */
> +static int
> +ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
> +               struct rte_dma_stats *rte_stats, uint32_t size)
> +{
> +       const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       const struct rte_dma_stats *stats = &cmd_q->stats;
> +
> +       if (size < sizeof(*rte_stats))
> +               return -EINVAL;
> +       if (rte_stats == NULL)
> +               return -EINVAL;
> +
> +       *rte_stats = *stats;
> +       return 0;
> +}
> +
> +/* Reset the generic stat counters for the DMA device. */
> +static int
> +ae4dma_stats_reset(struct rte_dma_dev *dev, uint16_t vchan __rte_unused)
> +{
> +       struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +
> +       memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
> +       return 0;
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
> +               enum rte_dma_vchan_status *status)
> +{
> +       const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
> +       const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
> +       uint32_t ctrl, hw_read, hw_write;
> +
> +       if (cmd_q->hwq_regs == NULL) {
> +               *status = RTE_DMA_VCHAN_HALTED_ERROR;
> +               return 0;
> +       }
> +
> +       ctrl = AE4DMA_READ_REG(&cmd_q->hwq_regs->control_reg.control_raw);
> +       if ((ctrl & AE4DMA_CMD_QUEUE_ENABLE) == 0) {
> +               *status = RTE_DMA_VCHAN_HALTED_ERROR;
> +               return 0;
> +       }
> +
> +       hw_read  = AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
> +       hw_write = AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
> +
> +       *status = (hw_read == hw_write) ? RTE_DMA_VCHAN_IDLE
> +                                       : RTE_DMA_VCHAN_ACTIVE;
> +       return 0;
> +}
> +
> +static int
> +ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn, const char *pci_name)
> +{
> +       uint32_t dma_addr_lo, dma_addr_hi;
> +       struct ae4dma_cmd_queue *cmd_q;
> +       const struct rte_memzone *q_mz;
> +
> +       if (dev == NULL)
> +               return -EINVAL;

dev can't be NULL.
The only caller passes a pointer that was already dereferenced.

> +
> +       dev->io_regs = dev->pci->mem_resource[AE4DMA_PCIE_BAR].addr;
> +
> +       cmd_q = &dev->cmd_q;
> +       cmd_q->id = qn;
> +       cmd_q->qidx = 0;
> +       cmd_q->qsize = AE4DMA_QUEUE_SIZE(AE4DMA_QUEUE_DESC_SIZE);
> +       cmd_q->hwq_regs = (volatile struct ae4dma_hwq_regs *)dev->io_regs + (qn + 1);
> +
> +       /*
> +        * Memzone name must be globally unique. Embed PCI BDF so multiple
> +        * PCI functions probed concurrently don't collide.
> +        */
> +       snprintf(cmd_q->memz_name, sizeof(cmd_q->memz_name),
> +                       "ae4dma_%s_q%u", pci_name, (unsigned int)qn);
> +
> +       q_mz = ae4dma_queue_dma_zone_reserve(cmd_q->memz_name,
> +                       cmd_q->qsize, rte_socket_id());
> +       if (q_mz == NULL) {
> +               AE4DMA_PMD_ERR("memzone reserve failed for %s", cmd_q->memz_name);
> +               return -ENOMEM;
> +       }
> +
> +       cmd_q->qbase_addr = (void *)q_mz->addr;
> +       cmd_q->qbase_desc = (struct ae4dma_desc *)q_mz->addr;
> +       cmd_q->qbase_phys_addr = q_mz->iova;
> +
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, AE4DMA_DESCRIPTORS_PER_CMDQ);
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +                       AE4DMA_CMD_QUEUE_ENABLE);
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->intr_status_reg.intr_status_raw,
> +                       AE4DMA_DISABLE_INTR);
> +       cmd_q->next_write = (uint16_t)AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
> +       cmd_q->next_read = (uint16_t)AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
> +       cmd_q->ring_buff_count = 0;
> +
> +       dma_addr_lo = low32_value(cmd_q->qbase_phys_addr);
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_lo, dma_addr_lo);
> +       dma_addr_hi = high32_value(cmd_q->qbase_phys_addr);
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_hi, dma_addr_hi);
> +
> +       return 0;
> +}
> +
> +static void
> +ae4dma_channel_dev_name(char *out, size_t outlen, const char *pci_name,
> +               unsigned int ch)
> +{
> +       snprintf(out, outlen, "%s-ch%u", pci_name, ch);
> +}
> +
> +/* Create a dmadev(dpdk DMA device) */
> +static int
> +ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
> +{
> +       static const struct rte_dma_dev_ops ae4dma_dmadev_ops = {
> +               .dev_close = ae4dma_dev_close,
> +               .dev_configure = ae4dma_dev_configure,
> +               .dev_dump = ae4dma_dev_dump,
> +               .dev_info_get = ae4dma_dev_info_get,
> +               .dev_start = ae4dma_dev_start,
> +               .dev_stop = ae4dma_dev_stop,
> +               .stats_get = ae4dma_stats_get,
> +               .stats_reset = ae4dma_stats_reset,
> +               .vchan_status = ae4dma_vchan_status,
> +               .vchan_setup = ae4dma_vchan_setup,
> +       };
> +
> +       struct rte_dma_dev *dmadev = NULL;
> +       struct ae4dma_dmadev *ae4dma = NULL;
> +       char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
> +
> +       if (!name) {
> +               AE4DMA_PMD_ERR("Invalid name of the device!");
> +               return -EINVAL;
> +       }
> +       memset(hwq_dev_name, 0, sizeof(hwq_dev_name));
> +       ae4dma_channel_dev_name(hwq_dev_name, sizeof(hwq_dev_name), name, qn);
> +
> +       dmadev = rte_dma_pmd_allocate(hwq_dev_name, dev->device.numa_node,
> +                       sizeof(struct ae4dma_dmadev));
> +       if (dmadev == NULL) {
> +               AE4DMA_PMD_ERR("Unable to allocate dma device");
> +               return -ENOMEM;
> +       }
> +       dmadev->device = &dev->device;
> +       dmadev->fp_obj->dev_private = dmadev->data->dev_private;
> +       dmadev->dev_ops = &ae4dma_dmadev_ops;
> +
> +       dmadev->fp_obj->burst_capacity = ae4dma_burst_capacity;
> +       dmadev->fp_obj->completed = ae4dma_completed;
> +       dmadev->fp_obj->completed_status = ae4dma_completed_status;
> +       dmadev->fp_obj->copy = ae4dma_enqueue_copy;
> +       dmadev->fp_obj->submit = ae4dma_submit;
> +       /* fill capability not advertised: leave fp_obj->fill as zero-initialised. */
> +
> +       ae4dma = dmadev->data->dev_private;
> +       ae4dma->dmadev = dmadev;
> +       ae4dma->pci = dev;
> +
> +       if (ae4dma_add_queue(ae4dma, qn, name) != 0)
> +               goto init_error;
> +       return 0;
> +
> +init_error:
> +       AE4DMA_PMD_ERR("driver %s(): failed", __func__);
> +       rte_dma_pmd_release(hwq_dev_name);
> +       return -EFAULT;

ENOMEM or the value returned from ae4dma_add_queue.


> +}
> +

[snip]

> diff --git a/drivers/dma/ae4dma/ae4dma_hw_defs.h b/drivers/dma/ae4dma/ae4dma_hw_defs.h
> new file mode 100644
> index 0000000000..235819778e
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
> @@ -0,0 +1,164 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __AE4DMA_HW_DEFS_H__
> +#define __AE4DMA_HW_DEFS_H__
> +
> +#include <rte_bus_pci.h>
> +#include <rte_byteorder.h>
> +#include <rte_io.h>
> +#include <rte_pci.h>
> +#include <rte_memzone.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#define AE4DMA_BIT(nr)                 (1UL << (nr))
> +
> +#define AE4DMA_BITS_PER_LONG   (__SIZEOF_LONG__ * 8)
> +#define AE4DMA_GENMASK(h, l) \
> +       (((~0UL) << (l)) & (~0UL >> (AE4DMA_BITS_PER_LONG - 1 - (h))))

We have rte_bitops.h macros for bit manipulations, please reuse.


> +
> +/* ae4dma device details */
> +#define AMD_VENDOR_ID  0x1022
> +#define AE4DMA_DEVICE_ID       0x149b
> +#define AE4DMA_PCIE_BAR 0
> +

[snip]


> diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
> index 93f2383dff..ec6d6713b4 100755
> --- a/usertools/dpdk-devbind.py
> +++ b/usertools/dpdk-devbind.py
> @@ -86,6 +86,9 @@
>  cn9k_ree = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4',
>              'SVendor': None, 'SDevice': None}
>
> +amd_ae4dma = {'Class': '08', 'Vendor': '1022', 'Device': '149b',
> +                 'SVendor': None, 'SDevice': None}
> +

Indent looks odd.


>  virtio_blk = {'Class': '01', 'Vendor': "1af4", 'Device': '1001,1042',
>                'SVendor': None, 'SDevice': None}
>
> @@ -95,7 +98,7 @@
>  network_devices = [network_class, cavium_pkx, avp_vnic, ifpga_class]
>  baseband_devices = [acceleration_class]
>  crypto_devices = [encryption_class, intel_processor_class]
> -dma_devices = [cnxk_dma, hisilicon_dma,
> +dma_devices = [amd_ae4dma, cnxk_dma, hisilicon_dma,
>                 intel_idxd_gnrd, intel_idxd_dmr, intel_idxd_spr,
>                 intel_ioat_bdw, intel_ioat_icx, intel_ioat_skx,
>                 odm_dma]


-- 
David Marchand

