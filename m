Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC67DCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:07:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC9C2402B8;
	Mon, 22 Jun 2026 14:07:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B12FE40144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782130032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+45aZbaosrD7LWenqIsXQZ8PKuXxoP0JuJcVlLXgSA=;
 b=FHGYCUzc3m2MHj/XupMWmx5wtdvgOc+u9XOrHB7238EC8xHX9v75qnWpkL0BUafWQrNMK3
 4IT+MmVc+vtv/tktUb7NIYMvADZnXR614Xq5yYmU0CnMlVGz2ErGFGaTesujhUkKn5BDjD
 c/QtogVstrkeD2ad6nl3ZNWJo89NMOA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-ZDPi3qV_PdeOmYqMHEtHyQ-1; Mon, 22 Jun 2026 08:07:10 -0400
X-MC-Unique: ZDPi3qV_PdeOmYqMHEtHyQ-1
X-Mimecast-MFC-AGG-ID: ZDPi3qV_PdeOmYqMHEtHyQ_1782130029
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-399770df190so26069761fa.2
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782130029; x=1782734829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7+45aZbaosrD7LWenqIsXQZ8PKuXxoP0JuJcVlLXgSA=;
 b=pg4vvJ9wOKmfyspBPjMmDuGsyh0CiDlxv98ncgvijNe9bqq8LJpvYPF/IBygwdEUuN
 7YkhzJp+E+7c9UZ+tqTT8OHGdGURSE8YfHKeoIaiyuAz+duN3oNN7bYX+Hr5dpC+5/yG
 W2BDOioO7uwewhPLaXwMqD0Y1PQa6b5fk7ZT6NTPPynwdNSPfrIitc8GOpKTAzqwfzLn
 ZakKVdLYWQ53enZDMaDn+9LJ25BfEYFaSzHtZfnS//hYlCCiHeSTZFFYF54QqtlOhPBL
 0xXtO2SEVMTm0mx8hQNaTos8cshZTKXM3piS6YOZ7O3/h0PPgkYHZhClneDkPZIjl+HJ
 +GGg==
X-Gm-Message-State: AOJu0YxWck4/zPkV8nVgKcApgrGIOKFbe8a6jL2hskdyKOCkYPu4u3EF
 zThTkto5z55KpraGQrN9TK0Y2wmbGzgXbUff10x2T/UTUvAOVFXFuk1CT8AidTrJg91Yjdoa/Tf
 qQpr5uSlHGo76YkrreQvB/AyCt/N5zXFd5v2dOfph8OYQsDQ2kvfgb+d9MWenX8iuqGhdW4vriD
 chPFFHboY8SKN5QL6NUyQ=
X-Gm-Gg: AfdE7cn15GIjM8Nq9K41li0UCJWUGQj6b1rdC5uBzstI3iBZO1iZ2CT83jClIKRArXq
 CdIYIHT/UnEfXMyjB/C2NXcfrMiumh9NlNcr1o/VLUzMucp5pGmMsBPK5UREp032P55KRkf1xN8
 cXIZPF2ZRdr4MZfgFtcW+udrRHubLOOn4cN2n8Lv3ZQacothRIHGjPCoS7D8PElIelSGnCNKstp
 Dz77CmDlBsUqCavUspDjytrjFsAaFc7VBNxpQ4wlGRm8rOe62pcQ35V9sA=
X-Received: by 2002:a2e:bd09:0:b0:38e:8102:cbdd with SMTP id
 38308e7fff4ca-3998a0f486amr36135041fa.3.1782130028485; 
 Mon, 22 Jun 2026 05:07:08 -0700 (PDT)
X-Received: by 2002:a2e:bd09:0:b0:38e:8102:cbdd with SMTP id
 38308e7fff4ca-3998a0f486amr36134841fa.3.1782130027732; Mon, 22 Jun 2026
 05:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
In-Reply-To: <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Jun 2026 14:06:55 +0200
X-Gm-Features: AVVi8CcZKrZhxpBRZsKmuvJ5Eilpyqw_8WCNmO7wUDOG3FydJWv2mo-Zvj1iFEU
Message-ID: <CAJFAV8w_67sp9iGW9+Gpwxx0ZkDYc4Zc2JKDtsPFFccU0UHePg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bhagyada Modali <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 Selwin.Sebastian@amd.com, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UxkFjrJAGMGXPK_gVJgubDstsof1IAI0ipZXK16o1-o_1782130029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 25 May 2026 at 20:43, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> Add the skeleton of a new dmadev poll-mode driver for the AMD AE4DMA
> hardware DMA engine, providing only PCI probe/remove and per-queue
> hardware initialisation. An AE4DMA engine exposes 16 hardware command
> queues, each with a 32-entry descriptor ring; the PMD maps each
> hardware channel to its own dmadev with a single virtual channel,
> so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
> "<pci-bdf>-ch15".

I am not familiar with DMA drivers, I am not sure it is something acceptabl=
e.
@Chengwen for info.


>
> This patch only registers the PCI driver, allocates the dmadev
> objects, reserves the per-queue descriptor rings and programs the
> hardware queue base addresses. Control and data path operations are
> added in subsequent patches.
>
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>

Here is a superficial review.

Many places are fishy when it comes to integer/pointer casts: I only
raised a few comments on this topic.


[snip]

> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4d=
ma_dmadev.c
> new file mode 100644
> index 0000000000..76de2cde45
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -0,0 +1,227 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
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
> +static_assert(sizeof(struct ae4dma_hwq_regs) =3D=3D 32,
> +               "ae4dma_hwq_regs stride changed; per-queue offset math wi=
ll break");
> +
> +RTE_LOG_REGISTER_DEFAULT(ae4dma_pmd_logtype, INFO);
> +
> +#define AE4DMA_PMD_NAME dmadev_ae4dma
> +
> +static const struct rte_memzone *
> +ae4dma_queue_dma_zone_reserve(const char *queue_name,
> +               uint32_t queue_size, int socket_id)
> +{
> +       const struct rte_memzone *mz;
> +
> +       mz =3D rte_memzone_lookup(queue_name);
> +       if (mz !=3D NULL) {
> +               if (((size_t)queue_size <=3D mz->len) &&
> +                               ((socket_id =3D=3D SOCKET_ID_ANY) ||
> +                                (socket_id =3D=3D mz->socket_id))) {
> +                       AE4DMA_PMD_INFO("reuse memzone already "
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
> +static int
> +ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn, const char *pci_=
name)
> +{
> +       uint32_t dma_addr_lo, dma_addr_hi;
> +       struct ae4dma_cmd_queue *cmd_q;
> +       const struct rte_memzone *q_mz;
> +
> +       dev->io_regs =3D dev->pci->mem_resource[AE4DMA_PCIE_BAR].addr;
> +
> +       cmd_q =3D &dev->cmd_q;
> +       cmd_q->id =3D qn;
> +       cmd_q->qidx =3D 0;
> +       cmd_q->qsize =3D AE4DMA_QUEUE_SIZE(AE4DMA_QUEUE_DESC_SIZE);
> +       cmd_q->hwq_regs =3D (volatile struct ae4dma_hwq_regs *)dev->io_re=
gs + (qn + 1);
> +
> +       /*
> +        * Memzone name must be globally unique. Embed PCI BDF so multipl=
e
> +        * PCI functions probed concurrently don't collide.
> +        */
> +       snprintf(cmd_q->memz_name, sizeof(cmd_q->memz_name),
> +                       "ae4dma_%s_q%u", pci_name, (unsigned int)qn);
> +
> +       q_mz =3D ae4dma_queue_dma_zone_reserve(cmd_q->memz_name,
> +                       cmd_q->qsize, rte_socket_id());
> +       if (q_mz =3D=3D NULL) {
> +               AE4DMA_PMD_ERR("memzone reserve failed for %s", cmd_q->me=
mz_name);
> +               return -ENOMEM;
> +       }

I see no tracking of q_mz, so I suspect this memzone is leaked on
device probing failure, and/or unplugging.


> +
> +       cmd_q->qbase_addr =3D (void *)q_mz->addr;
> +       cmd_q->qbase_desc =3D (struct ae4dma_desc *)q_mz->addr;
> +       cmd_q->qbase_phys_addr =3D q_mz->iova;
> +
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, AE4DMA_DESCRIPTORS_PE=
R_CMDQ);
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +                       AE4DMA_CMD_QUEUE_ENABLE);
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->intr_status_reg.intr_status_ra=
w,
> +                       AE4DMA_DISABLE_INTR);
> +       cmd_q->next_write =3D (uint16_t)AE4DMA_READ_REG(&cmd_q->hwq_regs-=
>write_idx);
> +       cmd_q->next_read =3D (uint16_t)AE4DMA_READ_REG(&cmd_q->hwq_regs->=
read_idx);

Strange that you need to cast.


> +       cmd_q->ring_buff_count =3D 0;
> +
> +       dma_addr_lo =3D low32_value(cmd_q->qbase_phys_addr);
> +       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_lo, dma_addr_lo);
> +       dma_addr_hi =3D high32_value(cmd_q->qbase_phys_addr);
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

This is a general comment for the patch: let's avoid Lapalissade /
trivial comments that adds nothing.
The function name is self explanatory.


> +static int
> +ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8=
_t qn)
> +{
> +       struct rte_dma_dev *dmadev =3D NULL;
> +       struct ae4dma_dmadev *ae4dma =3D NULL;

Those variables do not need any explicit setting to NULL, since there
are set at their first use.


> +       char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
> +
> +       if (!name) {

Such check will only confuse AI tools or other static code analysers,
as those tools will assume the function *may* be called with a NULL
pointer.
This is a static helper called internally from a single location,
remove the check.


> +               AE4DMA_PMD_ERR("Invalid name of the device!");
> +               return -EINVAL;
> +       }
> +       memset(hwq_dev_name, 0, sizeof(hwq_dev_name));
> +       ae4dma_channel_dev_name(hwq_dev_name, sizeof(hwq_dev_name), name,=
 qn);
> +
> +       dmadev =3D rte_dma_pmd_allocate(hwq_dev_name, dev->device.numa_no=
de,
> +                       sizeof(struct ae4dma_dmadev));
> +       if (dmadev =3D=3D NULL) {
> +               AE4DMA_PMD_ERR("Unable to allocate dma device");
> +               return -ENOMEM;
> +       }
> +       dmadev->device =3D &dev->device;
> +       dmadev->fp_obj->dev_private =3D dmadev->data->dev_private;
> +
> +       ae4dma =3D dmadev->data->dev_private;
> +       ae4dma->dmadev =3D dmadev;

Such a back reference looks odd to me (how could you end with only a
reference to the priv pointer, which is in general deduced from the
dmadev pointer?).
And, in the end, this field is never used in the series.

Please remove.


> +       ae4dma->pci =3D dev;

dev is already a rte_pci_device pointer, and you only need to pass it
to ae4dma_add_queue as an argument.
By doing this change, there is no user of this field in the series,
please remove.


One note on this topic, you have a reference to the rte_device in the
dmadev object.
On the principle, the pci device can be resolved via
RTE_BUS_DEVICE(dmadev->device, struct rte_pci_device), or
RTE_BUS_DEVICE(dmadev->device, *pci_dev).
See other drivers for examples.


> +
> +       if (ae4dma_add_queue(ae4dma, qn, name) !=3D 0)
> +               goto init_error;
> +       return 0;
> +
> +init_error:
> +       AE4DMA_PMD_ERR("driver %s(): failed", __func__);

__func__ is already part of AE4DMA_PMD_LOG.


> +       rte_dma_pmd_release(hwq_dev_name);
> +       return -ENOMEM;
> +}
> +
> +/* Probe DMA device. */
> +static int
> +ae4dma_dmadev_probe(struct rte_pci_driver *drv, struct rte_pci_device *d=
ev)
> +{
> +       char name[32];
> +       char chname[RTE_DEV_NAME_MAX_LEN];
> +       void *mmio_base;
> +       uint32_t q_per_eng;
> +       int ret =3D 0;
> +       uint8_t i;
> +
> +       rte_pci_device_name(&dev->addr, name, sizeof(name));
> +       AE4DMA_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa=
_node);
> +       dev->device.driver =3D &drv->driver;

Setting the driver pointer in the device object is not the driver
responsibility anymore with commit f282771a04ef ("bus: factorize
driver reference").
EAL will set this field on probe() success.


> +
> +       mmio_base =3D dev->mem_resource[AE4DMA_PCIE_BAR].addr;
> +       if (mmio_base =3D=3D NULL) {
> +               AE4DMA_PMD_ERR("%s: BAR%d not mapped", name, AE4DMA_PCIE_=
BAR);
> +               return -ENODEV;
> +       }
> +
> +       /* Program the per-engine HW queue count once. */
> +       AE4DMA_WRITE_REG_OFFSET(mmio_base, AE4DMA_COMMON_CONFIG_OFFSET,
> +                       AE4DMA_MAX_HW_QUEUES);
> +       q_per_eng =3D AE4DMA_READ_REG_OFFSET(mmio_base, AE4DMA_COMMON_CON=
FIG_OFFSET);
> +       AE4DMA_PMD_INFO("%s: AE4DMA queues per engine =3D %u", name, q_pe=
r_eng);
> +
> +       for (i =3D 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
> +               ret =3D ae4dma_dmadev_create(name, dev, i);
> +               if (ret !=3D 0) {
> +                       AE4DMA_PMD_ERR("%s create dmadev %u failed!", nam=
e, i);
> +                       while (i > 0) {
> +                               i--;
> +                               ae4dma_channel_dev_name(chname, sizeof(ch=
name), name, i);
> +                               rte_dma_pmd_release(chname);
> +                       }
> +                       break;
> +               }
> +       }
> +       return ret;
> +}
> +
> +/* Remove DMA device. */
> +static int
> +ae4dma_dmadev_remove(struct rte_pci_device *dev)
> +{
> +       char name[32];
> +       char chname[RTE_DEV_NAME_MAX_LEN];
> +       unsigned int i;
> +
> +       rte_pci_device_name(&dev->addr, name, sizeof(name));
> +
> +       AE4DMA_PMD_INFO("Closing %s on NUMA node %d",
> +                       name, dev->device.numa_node);
> +
> +       for (i =3D 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
> +               ae4dma_channel_dev_name(chname, sizeof(chname), name, i);
> +               rte_dma_pmd_release(chname);
> +       }
> +       return 0;
> +}
> +
> +static const struct rte_pci_id pci_id_ae4dma_map[] =3D {
> +       { RTE_PCI_DEVICE(AMD_VENDOR_ID, AE4DMA_DEVICE_ID) },
> +       { .vendor_id =3D 0, /* sentinel */ },
> +};
> +
> +static struct rte_pci_driver ae4dma_pmd_drv =3D {
> +       .id_table =3D pci_id_ae4dma_map,
> +       .drv_flags =3D RTE_PCI_DRV_NEED_MAPPING,
> +       .probe =3D ae4dma_dmadev_probe,
> +       .remove =3D ae4dma_dmadev_remove,
> +};
> +
> +RTE_PMD_REGISTER_PCI(AE4DMA_PMD_NAME, ae4dma_pmd_drv);
> +RTE_PMD_REGISTER_PCI_TABLE(AE4DMA_PMD_NAME, pci_id_ae4dma_map);
> +RTE_PMD_REGISTER_KMOD_DEP(AE4DMA_PMD_NAME, "* igb_uio | uio_pci_generic =
| vfio-pci");
> diff --git a/drivers/dma/ae4dma/ae4dma_hw_defs.h b/drivers/dma/ae4dma/ae4=
dma_hw_defs.h
> new file mode 100644
> index 0000000000..62b6a1b30b
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
> @@ -0,0 +1,160 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __AE4DMA_HW_DEFS_H__
> +#define __AE4DMA_HW_DEFS_H__
> +

Is this header autosufficient ?
I see references to uint32_t below, so this header probably depends on stdi=
nt.h.


> +#include <rte_bus_pci.h>
> +#include <rte_byteorder.h>
> +#include <rte_io.h>
> +#include <rte_pci.h>
> +#include <rte_memzone.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif

Do we really need C++ guards?

> +
> +#define AE4DMA_BIT(nr)                 (1UL << (nr))
> +
> +/* ae4dma device details */
> +#define AMD_VENDOR_ID  0x1022
> +#define AE4DMA_DEVICE_ID       0x149b
> +#define AE4DMA_PCIE_BAR 0
> +
> +/*
> + * An AE4DMA engine has 16 DMA queues. Each queue supports 32 descriptor=
s.
> + */
> +#define AE4DMA_MAX_HW_QUEUES        16
> +#define AE4DMA_QUEUE_START_INDEX    0
> +#define AE4DMA_CMD_QUEUE_ENABLE                0x1
> +#define AE4DMA_CMD_QUEUE_DISABLE       0x0
> +
> +/* Common to all queues */
> +#define AE4DMA_COMMON_CONFIG_OFFSET 0x00
> +
> +#define AE4DMA_DISABLE_INTR 0x01
> +
> +/* Descriptor status */
> +enum ae4dma_dma_status {
> +       AE4DMA_DMA_DESC_SUBMITTED =3D 0,
> +       AE4DMA_DMA_DESC_VALIDATED =3D 1,
> +       AE4DMA_DMA_DESC_PROCESSED =3D 2,
> +       AE4DMA_DMA_DESC_COMPLETED =3D 3,
> +       AE4DMA_DMA_DESC_ERROR =3D 4,
> +};
> +
> +/* Descriptor error-code */
> +enum ae4dma_dma_err {
> +       AE4DMA_DMA_ERR_NO_ERR =3D 0,
> +       AE4DMA_DMA_ERR_INV_HEADER =3D 1,
> +       AE4DMA_DMA_ERR_INV_STATUS =3D 2,
> +       AE4DMA_DMA_ERR_INV_LEN =3D 3,
> +       AE4DMA_DMA_ERR_INV_SRC =3D 4,
> +       AE4DMA_DMA_ERR_INV_DST =3D 5,
> +       AE4DMA_DMA_ERR_INV_ALIGN =3D 6,
> +       AE4DMA_DMA_ERR_UNKNOWN =3D 7,
> +};
> +
> +/* HW Queue status */
> +enum ae4dma_hwqueue_status {
> +       AE4DMA_HWQUEUE_EMPTY =3D 0,
> +       AE4DMA_HWQUEUE_FULL =3D 1,
> +       AE4DMA_HWQUEUE_NOT_EMPTY =3D 4

For consistency with other enums, add a comma.


> +};
> +/*
> + * descriptor for AE4DMA commands
> + * 8 32-bit words:
> + * word 0: source memory type; destination memory type ; control bits
> + * word 1: desc_id; error code; status
> + * word 2: length
> + * word 3: reserved
> + * word 4: upper 32 bits of source pointer
> + * word 5: low 32 bits of source pointer
> + * word 6: upper 32 bits of destination pointer
> + * word 7: low 32 bits of destination pointer
> + */
> +
> +/* AE4DMA Descriptor - DWORD0 - Controls bits: Reserved for future use *=
/
> +#define AE4DMA_DWORD0_STOP_ON_COMPLETION       AE4DMA_BIT(0)
> +#define AE4DMA_DWORD0_INTERRUPT_ON_COMPLETION  AE4DMA_BIT(1)
> +#define AE4DMA_DWORD0_START_OF_MESSAGE         AE4DMA_BIT(3)
> +#define AE4DMA_DWORD0_END_OF_MESSAGE           AE4DMA_BIT(4)
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE  RTE_GENMASK64(5, 4)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE      RTE_GENMASK64(7, 6)
> +
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_MEMORY    (0x0)
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_IOMEMORY  (1<<4)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_MEMORY    (0x0)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_IOMEMORY  (1<<6)
> +
> +struct ae4dma_desc_dword0 {
> +       uint8_t byte0;
> +       uint8_t byte1;
> +       uint16_t timestamp;
> +};
> +
> +struct ae4dma_desc_dword1 {
> +       uint8_t status;
> +       uint8_t err_code;
> +       uint16_t desc_id;
> +};
> +
> +struct ae4dma_desc {
> +       struct ae4dma_desc_dword0 dw0;
> +       struct ae4dma_desc_dword1 dw1;
> +       uint32_t length;
> +       uint32_t reserved;
> +       uint32_t src_lo;
> +       uint32_t src_hi;
> +       uint32_t dst_lo;
> +       uint32_t dst_hi;
> +};
> +
> +/*
> + * Registers for each queue :4 bytes length
> + * Effective address : offset + reg
> + */
> +struct ae4dma_hwq_regs {
> +       union {
> +               uint32_t control_raw;
> +               struct {
> +                       uint32_t queue_enable: 1;
> +                       uint32_t reserved_internal: 31;
> +               } control;
> +       } control_reg;
> +
> +       union {
> +               uint32_t status_raw;
> +               struct {
> +                       uint32_t reserved0: 1;
> +                       /* 0=E2=80=93empty, 1=E2=80=93full, 2=E2=80=93sto=
pped, 3=E2=80=93error , 4=E2=80=93Not Empty */
> +                       uint32_t queue_status: 2;
> +                       uint32_t reserved1: 21;
> +                       uint32_t interrupt_type: 4;
> +                       uint32_t reserved2: 4;
> +               } status;
> +       } status_reg;
> +
> +       uint32_t max_idx;
> +       uint32_t read_idx;
> +       uint32_t write_idx;
> +
> +       union {
> +               uint32_t intr_status_raw;
> +               struct {
> +                       uint32_t intr_status: 1;
> +                       uint32_t reserved: 31;
> +               } intr_status;
> +       } intr_status_reg;
> +
> +       uint32_t qbase_lo;
> +       uint32_t qbase_hi;
> +
> +};
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* AE4DMA_HW_DEFS_H */
> diff --git a/drivers/dma/ae4dma/ae4dma_internal.h b/drivers/dma/ae4dma/ae=
4dma_internal.h
> new file mode 100644
> index 0000000000..9892d6697f
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_internal.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef _AE4DMA_INTERNAL_H_
> +#define _AE4DMA_INTERNAL_H_
> +
> +#include <stdint.h>
> +
> +#include "ae4dma_hw_defs.h"
> +
> +/**

This is an internal header, we don't need doxygen style comments,
simple comments are enough.


> + * upper_32_bits - return bits 32-63 of a number
> + * @n: the number we're accessing
> + */
> +#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
> +
> +/**
> + * lower_32_bits - return bits 0-31 of a number
> + * @n: the number we're accessing
> + */
> +#define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
> +
> +/** Hardware ring depth (slots per queue); must be power of two. */
> +#define AE4DMA_DESCRIPTORS_PER_CMDQ    32
> +#define AE4DMA_QUEUE_DESC_SIZE         sizeof(struct ae4dma_desc)
> +#define AE4DMA_QUEUE_SIZE(n)           (AE4DMA_DESCRIPTORS_PER_CMDQ * (n=
))
> +
> +
> +/** AE4DMA registers Write/Read */
> +static inline void ae4dma_pci_reg_write(void *base, int offset,
> +               uint32_t value)
> +{
> +       volatile void *reg_addr =3D ((uint8_t *)base + offset);
> +
> +       rte_write32((rte_cpu_to_le_32(value)), reg_addr);
> +}
> +
> +static inline uint32_t ae4dma_pci_reg_read(void *base, int offset)
> +{
> +       volatile void *reg_addr =3D ((uint8_t *)base + offset);
> +
> +       return rte_le_to_cpu_32(rte_read32(reg_addr));
> +}
> +
> +#define AE4DMA_READ_REG_OFFSET(hw_addr, reg_offset) \
> +       ae4dma_pci_reg_read(hw_addr, reg_offset)
> +
> +#define AE4DMA_WRITE_REG_OFFSET(hw_addr, reg_offset, value) \
> +       ae4dma_pci_reg_write(hw_addr, reg_offset, value)
> +
> +
> +#define AE4DMA_READ_REG(hw_addr) \
> +       ae4dma_pci_reg_read((void *)(uintptr_t)(hw_addr), 0)
> +
> +#define AE4DMA_WRITE_REG(hw_addr, value) \
> +       ae4dma_pci_reg_write((void *)(uintptr_t)(hw_addr), 0, value)
> +
> +static inline uint32_t
> +low32_value(unsigned long addr)
> +{
> +       return ((uint64_t)addr) & 0xffffffffUL;
> +}
> +
> +static inline uint32_t
> +high32_value(unsigned long addr)
> +{
> +       return (uint32_t)(((uint64_t)addr) >> 32);
> +}
> +
> +/**
> + * A structure describing a AE4DMA command queue.
> + */
> +struct __rte_cache_aligned ae4dma_cmd_queue {
> +       char memz_name[RTE_MEMZONE_NAMESIZE];
> +       volatile struct ae4dma_hwq_regs *hwq_regs;
> +
> +       struct rte_dma_vchan_conf qcfg;
> +       struct rte_dma_stats stats;
> +       /* Queue address */
> +       struct ae4dma_desc *qbase_desc;
> +       void *qbase_addr;
> +       rte_iova_t qbase_phys_addr;
> +       enum ae4dma_dma_err status[AE4DMA_DESCRIPTORS_PER_CMDQ];
> +       /* Queue identifier */
> +       uint64_t id;    /**< queue id */
> +       uint64_t qidx;  /**< queue index */
> +       uint64_t qsize; /**< queue size */
> +       uint32_t ring_buff_count;
> +       unsigned short next_read;
> +       unsigned short next_write;
> +       unsigned short last_write; /* Used to compute submitted count. */
> +};
> +
> +/*
> + * One dmadev per AE4DMA hardware channel: probe creates AE4DMA_MAX_HW_Q=
UEUES
> + * dmadevs per PCI function, each owning a single HW command queue.
> + */
> +struct ae4dma_dmadev {
> +       struct rte_dma_dev *dmadev;
> +       void *io_regs;
> +       struct ae4dma_cmd_queue cmd_q; /**< single HW queue owned by this=
 dmadev */
> +       struct rte_pci_device *pci;    /**< owning PCI device (not owned)=
 */
> +};
> +
> +
> +extern int ae4dma_pmd_logtype;
> +#define RTE_LOGTYPE_AE4DMA_PMD ae4dma_pmd_logtype
> +
> +#define AE4DMA_PMD_LOG(level, ...) \
> +       RTE_LOG_LINE_PREFIX(level, AE4DMA_PMD, "%s(): ", __func__, __VA_A=
RGS__)
> +
> +#define AE4DMA_PMD_DEBUG(...)  AE4DMA_PMD_LOG(DEBUG, __VA_ARGS__)
> +#define AE4DMA_PMD_INFO(...)   AE4DMA_PMD_LOG(INFO, __VA_ARGS__)
> +#define AE4DMA_PMD_ERR(...)    AE4DMA_PMD_LOG(ERR, __VA_ARGS__)
> +#define AE4DMA_PMD_WARN(...)   AE4DMA_PMD_LOG(WARNING, __VA_ARGS__)
> +
> +#endif /* _AE4DMA_INTERNAL_H_ */


--=20
David Marchand

