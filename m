Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE7C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 01:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05DD240264;
	Tue,  7 Jul 2026 03:24:45 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id BE6964025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 03:24:43 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=kabPW1ekbompeQuRtrgQagFYXcl22ycdoOrV86Yjgro=;
 b=wn6x7ByN53jh/oqhgZwGhQ/tz1rb1/CvmGqeQW/09vb6g+x/kubrk5V1QmZ7npX1S66QfLdk/
 kUntUTHptO5u8m7h5FRLh9qeUS4L/zN7fpLoFdfsN9dVxmqo4PbrIMzCfQ6QGxyRexJM4XFwIC7
 6/N2Ui0iQwzBXvMnEAlmGq0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gvNZL4jbkzmV7V;
 Tue,  7 Jul 2026 09:15:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 079BA40586;
 Tue,  7 Jul 2026 09:24:36 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Jul 2026 09:24:35 +0800
Message-ID: <30d17d21-5dc2-49e4-9104-61d8c475b6c7@huawei.com>
Date: Tue, 7 Jul 2026 09:24:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dma/ae4dma: introduce AMD AE4DMA DMA PMD
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>
References: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
 <20260706115533.2937512-2-raghavendra.ningoji@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260706115533.2937512-2-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
> Add the skeleton of a new dmadev poll-mode driver for the AMD AE4DMA
> hardware DMA engine, providing only PCI probe/remove and per-queue
> hardware initialisation. An AE4DMA engine exposes 16 hardware command
> queues, each with a 32-entry descriptor ring; the PMD maps each
> hardware channel to its own dmadev with a single virtual channel,
> so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
> "<pci-bdf>-ch15".
> 
> This patch only registers the PCI driver, allocates the dmadev
> objects, reserves the per-queue descriptor rings and programs the
> hardware queue base addresses. Control and data path operations are
> added in subsequent patches.
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  .mailmap                               |   1 +
>  MAINTAINERS                            |   5 +
>  doc/guides/dmadevs/ae4dma.rst          |  53 +++++++
>  doc/guides/dmadevs/index.rst           |   1 +
>  doc/guides/rel_notes/release_26_07.rst |   7 +
>  drivers/dma/ae4dma/ae4dma_dmadev.c     | 200 +++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma_hw_defs.h    | 151 +++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma_internal.h   | 114 ++++++++++++++
>  drivers/dma/ae4dma/meson.build         |  13 ++
>  drivers/dma/meson.build                |   1 +
>  usertools/dpdk-devbind.py              |   5 +-
>  11 files changed, 550 insertions(+), 1 deletion(-)
>  create mode 100644 doc/guides/dmadevs/ae4dma.rst
>  create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
>  create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
>  create mode 100644 drivers/dma/ae4dma/meson.build
> 
> diff --git a/.mailmap b/.mailmap
> index 89ba6ff..71a6256 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1329,6 +1329,7 @@ Radu Bulie <radu-andrei.bulie@nxp.com>
>  Radu Nicolau <radu.nicolau@intel.com>
>  Rafael Ávila de Espíndola <espindola@scylladb.com>
>  Rafal Kozik <rk@semihalf.com>
> +Raghavendra Ningoji <raghavendra.ningoji@amd.com>
>  Ragothaman Jayaraman <rjayaraman@caviumnetworks.com>
>  Rahul Bhansali <rbhansali@marvell.com>
>  Rahul Gupta <rahul.gupta@broadcom.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9143d02..2e27af4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1361,6 +1361,11 @@ F: doc/guides/compressdevs/features/zsda.ini
>  DMAdev Drivers
>  --------------
>  
> +AMD AE4DMA
> +M: Bhagyada Modali <bhagyada.modali@amd.com>
> +F: drivers/dma/ae4dma/
> +F: doc/guides/dmadevs/ae4dma.rst
> +
>  Intel IDXD - EXPERIMENTAL
>  M: Bruce Richardson <bruce.richardson@intel.com>
>  M: Kevin Laatz <kevin.laatz@intel.com>
> diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
> new file mode 100644
> index 0000000..eeed55c
> --- /dev/null
> +++ b/doc/guides/dmadevs/ae4dma.rst
> @@ -0,0 +1,53 @@
> +..  SPDX-License-Identifier: BSD-3-Clause
> +    Copyright(c) 2026 Advanced Micro Devices, Inc.
> +
> +.. include:: <isonum.txt>
> +
> +AMD AE4DMA DMA Device Driver
> +============================
> +
> +The ``ae4dma`` dmadev driver is a poll-mode driver (PMD) for the
> +AMD AE4DMA hardware DMA engine. The engine exposes 16 independent
> +hardware command queues, each with a ring of 32 descriptors. The PMD
> +maps each hardware command queue to a separate DPDK dmadev with a
> +single virtual channel, so a single PCI function appears as 16 dmadevs
> +named ``<pci-bdf>-ch0`` through ``<pci-bdf>-ch15``.
> +
> +The driver supports memory-to-memory copy operations only.
> +
> +Hardware Requirements
> +---------------------
> +
> +The ``dpdk-devbind.py`` script can be used to list AE4DMA devices on
> +the system::
> +
> +   dpdk-devbind.py --status-dev dma
> +
> +AE4DMA devices appear with vendor ID ``0x1022`` and device ID
> +``0x149b``.
> +
> +Compilation
> +-----------
> +
> +The driver is built as part of the standard DPDK build on x86 platforms
> +using ``meson`` and ``ninja``; no extra configuration is required.
> +
> +Device Setup
> +------------
> +
> +The AE4DMA device must be bound to a DPDK-compatible kernel module such
> +as ``vfio-pci`` before it can be used::
> +
> +   dpdk-devbind.py -b vfio-pci <pci-bdf>
> +
> +Initialization
> +~~~~~~~~~~~~~~
> +
> +On probe the PMD performs the following steps for each PCI function:
> +
> +* Reads BAR0 and programs the common configuration register with the
> +  number of hardware queues to enable (16).
> +* For each hardware queue it allocates a 32-entry descriptor ring in
> +  IOVA-contiguous memory, programs the queue base address and ring
> +  depth into the per-queue registers, and enables the queue.
> +* Interrupts are masked; completion is polled by the application.
> diff --git a/doc/guides/dmadevs/index.rst b/doc/guides/dmadevs/index.rst
> index 56beb17..9739959 100644
> --- a/doc/guides/dmadevs/index.rst
> +++ b/doc/guides/dmadevs/index.rst
> @@ -11,6 +11,7 @@ an application through DMA API.
>     :maxdepth: 1
>     :numbered:
>  
> +   ae4dma
>     cnxk
>     dpaa
>     dpaa2
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index f012d47..9a78a7e 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -63,6 +63,13 @@ New Features
>      ``rte_eal_init`` and the application is responsible for probing each device,
>    * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
>  
> +* **Added AMD AE4DMA DMA PMD.**
> +
> +  Added a new ``dma/ae4dma`` driver for the AMD AE4DMA hardware DMA engine.
> +  Each PCI function exposes 16 hardware command queues; the PMD registers one
> +  dmadev per channel with a single virtual channel and supports
> +  memory-to-memory copy operations.
> +
>  
>  Removed Items
>  -------------
> diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
> new file mode 100644
> index 0000000..bf0d3bb
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
> @@ -0,0 +1,200 @@
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
> +static_assert(sizeof(struct ae4dma_hwq_regs) == 32,
> +		"ae4dma_hwq_regs stride changed; per-queue offset math will break");
> +
> +RTE_LOG_REGISTER_DEFAULT(ae4dma_pmd_logtype, INFO);
> +
> +#define AE4DMA_PMD_NAME dmadev_ae4dma
> +
> +static const struct rte_memzone *
> +ae4dma_queue_dma_zone_reserve(const char *queue_name,
> +		uint32_t queue_size, int socket_id)
> +{
> +	return rte_memzone_reserve_aligned(queue_name, queue_size,
> +			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
> +}
> +
> +static int
> +ae4dma_add_queue(struct ae4dma_dmadev *dev, struct rte_pci_device *pci,
> +		uint8_t qn, const char *pci_name)
> +{
> +	const struct rte_memzone *q_mz;
> +	struct ae4dma_cmd_queue *cmd_q;
> +	uint32_t dma_addr_lo, dma_addr_hi;
> +
> +	dev->io_regs = pci->mem_resource[AE4DMA_PCIE_BAR].addr;
> +
> +	cmd_q = &dev->cmd_q;
> +	cmd_q->id = qn;
> +	cmd_q->qidx = 0;
> +	cmd_q->qsize = AE4DMA_QUEUE_SIZE(AE4DMA_QUEUE_DESC_SIZE);
> +	cmd_q->hwq_regs = (volatile struct ae4dma_hwq_regs *)dev->io_regs + (qn + 1);
> +
> +	/*
> +	 * Memzone name must be globally unique. Embed PCI BDF so multiple
> +	 * PCI functions probed concurrently don't collide.
> +	 */
> +	snprintf(cmd_q->memz_name, sizeof(cmd_q->memz_name),
> +			"ae4dma_%s_q%u", pci_name, (unsigned int)qn);
> +
> +	q_mz = ae4dma_queue_dma_zone_reserve(cmd_q->memz_name,
> +			cmd_q->qsize, rte_socket_id());
> +	if (q_mz == NULL) {
> +		AE4DMA_PMD_ERR("memzone reserve failed for %s", cmd_q->memz_name);
> +		return -ENOMEM;
> +	}
> +
> +	cmd_q->mz = q_mz;
> +	cmd_q->qbase_addr = q_mz->addr;
> +	cmd_q->qbase_desc = q_mz->addr;
> +	cmd_q->qbase_phys_addr = q_mz->iova;
> +
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, AE4DMA_DESCRIPTORS_PER_CMDQ);
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
> +			AE4DMA_CMD_QUEUE_ENABLE);
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->intr_status_reg.intr_status_raw,
> +			AE4DMA_DISABLE_INTR);
> +	cmd_q->next_write = AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
> +	cmd_q->next_read = AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
> +
> +	dma_addr_lo = lower_32_bits(cmd_q->qbase_phys_addr);
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_lo, dma_addr_lo);
> +	dma_addr_hi = upper_32_bits(cmd_q->qbase_phys_addr);
> +	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_hi, dma_addr_hi);
> +
> +	return 0;
> +}
> +
> +static void
> +ae4dma_channel_dev_name(char *out, size_t outlen, const char *pci_name,
> +		unsigned int ch)
> +{
> +	snprintf(out, outlen, "%s-ch%u", pci_name, ch);
> +}
> +
> +static int
> +ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
> +{
> +	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN] = {0};
> +	struct ae4dma_dmadev *ae4dma;
> +	struct rte_dma_dev *dmadev;
> +
> +	ae4dma_channel_dev_name(hwq_dev_name, sizeof(hwq_dev_name), name, qn);
> +
> +	dmadev = rte_dma_pmd_allocate(hwq_dev_name, dev->device.numa_node,
> +			sizeof(struct ae4dma_dmadev));
> +	if (dmadev == NULL) {
> +		AE4DMA_PMD_ERR("Unable to allocate dma device");
> +		return -ENOMEM;
> +	}
> +	dmadev->device = &dev->device;
> +	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
> +
> +	ae4dma = dmadev->data->dev_private;
> +
> +	if (ae4dma_add_queue(ae4dma, dev, qn, name) != 0)
> +		goto init_error;
> +	return 0;
> +
> +init_error:
> +	AE4DMA_PMD_ERR("Failed to create dmadev %s", hwq_dev_name);
> +	rte_dma_pmd_release(hwq_dev_name);
> +	return -ENOMEM;
> +}
> +
> +static int
> +ae4dma_dmadev_probe(struct rte_pci_driver *drv __rte_unused,
> +		struct rte_pci_device *dev)
> +{
> +	char chname[RTE_DEV_NAME_MAX_LEN];
> +	uint32_t q_per_eng;
> +	void *mmio_base;
> +	char name[32];
> +	int ret = 0;
> +	uint8_t i;
> +
> +	rte_pci_device_name(&dev->addr, name, sizeof(name));
> +	AE4DMA_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa_node);
> +
> +	mmio_base = dev->mem_resource[AE4DMA_PCIE_BAR].addr;
> +	if (mmio_base == NULL) {
> +		AE4DMA_PMD_ERR("%s: BAR%d not mapped", name, AE4DMA_PCIE_BAR);
> +		return -ENODEV;
> +	}
> +
> +	/* Program the per-engine HW queue count once. */
> +	AE4DMA_WRITE_REG_OFFSET(mmio_base, AE4DMA_COMMON_CONFIG_OFFSET,
> +			AE4DMA_MAX_HW_QUEUES);
> +	q_per_eng = AE4DMA_READ_REG_OFFSET(mmio_base, AE4DMA_COMMON_CONFIG_OFFSET);
> +	AE4DMA_PMD_INFO("%s: AE4DMA queues per engine = %u", name, q_per_eng);
> +
> +	for (i = 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
> +		ret = ae4dma_dmadev_create(name, dev, i);
> +		if (ret != 0) {
> +			AE4DMA_PMD_ERR("%s create dmadev %u failed!", name, i);
> +			while (i > 0) {
> +				i--;
> +				ae4dma_channel_dev_name(chname, sizeof(chname), name, i);
> +				rte_dma_pmd_release(chname);
> +			}
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int
> +ae4dma_dmadev_remove(struct rte_pci_device *dev)
> +{
> +	char chname[RTE_DEV_NAME_MAX_LEN];
> +	unsigned int i;
> +	char name[32];
> +
> +	rte_pci_device_name(&dev->addr, name, sizeof(name));
> +
> +	AE4DMA_PMD_INFO("Closing %s on NUMA node %d",
> +			name, dev->device.numa_node);
> +
> +	for (i = 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
> +		ae4dma_channel_dev_name(chname, sizeof(chname), name, i);
> +		rte_dma_pmd_release(chname);
> +	}
> +	return 0;
> +}
> +
> +static const struct rte_pci_id pci_id_ae4dma_map[] = {
> +	{ RTE_PCI_DEVICE(AMD_VENDOR_ID, AE4DMA_DEVICE_ID) },
> +	{ .vendor_id = 0, /* sentinel */ },
> +};
> +
> +static struct rte_pci_driver ae4dma_pmd_drv = {
> +	.id_table = pci_id_ae4dma_map,
> +	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
> +	.probe = ae4dma_dmadev_probe,
> +	.remove = ae4dma_dmadev_remove,
> +};
> +
> +RTE_PMD_REGISTER_PCI(AE4DMA_PMD_NAME, ae4dma_pmd_drv);
> +RTE_PMD_REGISTER_PCI_TABLE(AE4DMA_PMD_NAME, pci_id_ae4dma_map);
> +RTE_PMD_REGISTER_KMOD_DEP(AE4DMA_PMD_NAME, "* igb_uio | uio_pci_generic | vfio-pci");
> diff --git a/drivers/dma/ae4dma/ae4dma_hw_defs.h b/drivers/dma/ae4dma/ae4dma_hw_defs.h
> new file mode 100644
> index 0000000..278fe77
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef __AE4DMA_HW_DEFS_H__
> +#define __AE4DMA_HW_DEFS_H__
> +
> +#include <stdint.h>
> +
> +#include <rte_bitops.h>
> +
> +#define AE4DMA_BIT(nr)			(1UL << (nr))

Why not use RTE_BIT32() in rte_bitops.h which already included ?

> +
> +/* ae4dma device details */
> +#define AMD_VENDOR_ID	0x1022
> +#define AE4DMA_DEVICE_ID	0x149b
> +#define AE4DMA_PCIE_BAR 0
> +
> +/*
> + * An AE4DMA engine has 16 DMA queues. Each queue supports up to 32
> + * descriptors (31 outstanding).
> + */
> +#define AE4DMA_MAX_HW_QUEUES        16
> +#define AE4DMA_QUEUE_START_INDEX    0
> +#define AE4DMA_CMD_QUEUE_ENABLE		0x1
> +#define AE4DMA_CMD_QUEUE_DISABLE	0x0
> +
> +/* Common to all queues */
> +#define AE4DMA_COMMON_CONFIG_OFFSET 0x00
> +
> +#define AE4DMA_DISABLE_INTR 0x01
> +
> +/* Descriptor status */
> +enum ae4dma_dma_status {
> +	AE4DMA_DMA_DESC_SUBMITTED = 0,
> +	AE4DMA_DMA_DESC_VALIDATED = 1,
> +	AE4DMA_DMA_DESC_PROCESSED = 2,
> +	AE4DMA_DMA_DESC_COMPLETED = 3,
> +	AE4DMA_DMA_DESC_ERROR = 4,
> +};
> +
> +/* Descriptor error-code */
> +enum ae4dma_dma_err {
> +	AE4DMA_DMA_ERR_NO_ERR = 0,
> +	AE4DMA_DMA_ERR_INV_HEADER = 1,
> +	AE4DMA_DMA_ERR_INV_STATUS = 2,
> +	AE4DMA_DMA_ERR_INV_LEN = 3,
> +	AE4DMA_DMA_ERR_INV_SRC = 4,
> +	AE4DMA_DMA_ERR_INV_DST = 5,
> +	AE4DMA_DMA_ERR_INV_ALIGN = 6,
> +	AE4DMA_DMA_ERR_UNKNOWN = 7,
> +};
> +
> +/* HW Queue status */
> +enum ae4dma_hwqueue_status {
> +	AE4DMA_HWQUEUE_EMPTY = 0,
> +	AE4DMA_HWQUEUE_FULL = 1,
> +	AE4DMA_HWQUEUE_NOT_EMPTY = 4,
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
> +/* AE4DMA Descriptor - DWORD0 - Controls bits: Reserved for future use */
> +#define AE4DMA_DWORD0_STOP_ON_COMPLETION	AE4DMA_BIT(0)
> +#define AE4DMA_DWORD0_INTERRUPT_ON_COMPLETION	AE4DMA_BIT(1)
> +#define AE4DMA_DWORD0_START_OF_MESSAGE		AE4DMA_BIT(3)
> +#define AE4DMA_DWORD0_END_OF_MESSAGE		AE4DMA_BIT(4)
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE	RTE_GENMASK64(5, 4)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE	RTE_GENMASK64(7, 6)
> +
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_MEMORY    (0x0)
> +#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_IOMEMORY  (1<<4)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_MEMORY    (0x0)
> +#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_IOMEMORY  (1<<6)

How about use RTE_BIT32(6) ?

Thanks

> +
> +struct ae4dma_desc_dword0 {
> +	uint8_t byte0;
> +	uint8_t byte1;
> +	uint16_t timestamp;
> +};
> +
> +struct ae4dma_desc_dword1 {
> +	uint8_t status;
> +	uint8_t err_code;
> +	uint16_t desc_id;
> +};
> +
> +struct ae4dma_desc {
> +	struct ae4dma_desc_dword0 dw0;
> +	struct ae4dma_desc_dword1 dw1;
> +	uint32_t length;
> +	uint32_t reserved;
> +	uint32_t src_lo;
> +	uint32_t src_hi;
> +	uint32_t dst_lo;
> +	uint32_t dst_hi;
> +};
> +
> +/*
> + * Registers for each queue :4 bytes length
> + * Effective address : offset + reg
> + */
> +struct ae4dma_hwq_regs {
> +	union {
> +		uint32_t control_raw;
> +		struct {
> +			uint32_t queue_enable: 1;
> +			uint32_t reserved_internal: 31;
> +		} control;
> +	} control_reg;
> +
> +	union {
> +		uint32_t status_raw;
> +		struct {
> +			uint32_t reserved0: 1;
> +			/* 0–empty, 1–full, 2–stopped, 3–error , 4–Not Empty */
> +			uint32_t queue_status: 2;
> +			uint32_t reserved1: 21;
> +			uint32_t interrupt_type: 4;
> +			uint32_t reserved2: 4;
> +		} status;
> +	} status_reg;
> +
> +	uint32_t max_idx;
> +	uint32_t read_idx;
> +	uint32_t write_idx;
> +
> +	union {
> +		uint32_t intr_status_raw;
> +		struct {
> +			uint32_t intr_status: 1;
> +			uint32_t reserved: 31;
> +		} intr_status;
> +	} intr_status_reg;
> +
> +	uint32_t qbase_lo;
> +	uint32_t qbase_hi;
> +
> +};
> +
> +#endif /* AE4DMA_HW_DEFS_H */
> diff --git a/drivers/dma/ae4dma/ae4dma_internal.h b/drivers/dma/ae4dma/ae4dma_internal.h
> new file mode 100644
> index 0000000..1f1f30f
> --- /dev/null
> +++ b/drivers/dma/ae4dma/ae4dma_internal.h
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
> + */
> +
> +#ifndef _AE4DMA_INTERNAL_H_
> +#define _AE4DMA_INTERNAL_H_
> +
> +#include <stdint.h>
> +
> +#include <rte_byteorder.h>
> +#include <rte_dmadev.h>
> +#include <rte_io.h>
> +#include <rte_memzone.h>
> +
> +#include "ae4dma_hw_defs.h"
> +
> +/* Return bits 32-63 of a 64-bit number. */
> +#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
> +
> +/* Return bits 0-31 of a 64-bit number. */
> +#define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
> +
> +/*
> + * Hardware ring depth (slots per queue); fixed at 32 per the AE4DMA
> + * spec and must be a power of two. The engine reserves one slot to tell
> + * a full ring from an empty one (full when (write + 1) % max == read),
> + * so at most nb_desc - 1 (31) descriptors can be outstanding.
> + */
> +#define AE4DMA_DESCRIPTORS_PER_CMDQ	32
> +#define AE4DMA_QUEUE_DESC_SIZE		sizeof(struct ae4dma_desc)
> +#define AE4DMA_QUEUE_SIZE(n)		(AE4DMA_DESCRIPTORS_PER_CMDQ * (n))
> +
> +/* AE4DMA registers Write/Read */
> +static inline void ae4dma_pci_reg_write(void *base, int offset,
> +		uint32_t value)
> +{
> +	volatile void *reg_addr = ((uint8_t *)base + offset);
> +
> +	rte_write32((rte_cpu_to_le_32(value)), reg_addr);
> +}
> +
> +static inline uint32_t ae4dma_pci_reg_read(void *base, int offset)
> +{
> +	volatile void *reg_addr = ((uint8_t *)base + offset);
> +
> +	return rte_le_to_cpu_32(rte_read32(reg_addr));
> +}
> +
> +#define AE4DMA_READ_REG_OFFSET(hw_addr, reg_offset) \
> +	ae4dma_pci_reg_read(hw_addr, reg_offset)
> +
> +#define AE4DMA_WRITE_REG_OFFSET(hw_addr, reg_offset, value) \
> +	ae4dma_pci_reg_write(hw_addr, reg_offset, value)
> +
> +#define AE4DMA_READ_REG(hw_addr) \
> +	ae4dma_pci_reg_read((void *)(uintptr_t)(hw_addr), 0)
> +
> +#define AE4DMA_WRITE_REG(hw_addr, value) \
> +	ae4dma_pci_reg_write((void *)(uintptr_t)(hw_addr), 0, value)
> +
> +/* A structure describing an AE4DMA command queue. */
> +struct __rte_cache_aligned ae4dma_cmd_queue {
> +	char memz_name[RTE_MEMZONE_NAMESIZE];
> +	const struct rte_memzone *mz;
> +	volatile struct ae4dma_hwq_regs *hwq_regs;
> +
> +	struct rte_dma_vchan_conf qcfg;
> +	struct rte_dma_stats stats;
> +	/* Queue address */
> +	struct ae4dma_desc *qbase_desc;
> +	void *qbase_addr;
> +	rte_iova_t qbase_phys_addr;
> +	enum ae4dma_dma_err status[AE4DMA_DESCRIPTORS_PER_CMDQ];
> +	/* Queue identifier */
> +	uint64_t id;    /* queue id */
> +	uint64_t qidx;  /* queue index */
> +	uint64_t qsize; /* queue size */
> +	/*
> +	 * Free-running 16-bit ring indices (wrap at 2^16), as required by the
> +	 * dmadev API. The HW ring slot is derived as ((hw_base + idx) &
> +	 * (nb_desc - 1)), which is why nb_desc is rounded up to a power of two.
> +	 */
> +	uint16_t next_read;  /* ring_idx of the next completion to reap */
> +	uint16_t next_write; /* ring_idx assigned to the next enqueue */
> +	uint16_t last_write; /* next_write at last submit; for submitted stat */
> +	/*
> +	 * HW ring slot that free-running index 0 maps to. read_idx is HW-owned
> +	 * (read-only), so on start we anchor to wherever the HW consumer sits
> +	 * instead of forcing the HW indices to 0.
> +	 */
> +	uint16_t hw_base;
> +};
> +
> +/*
> + * One dmadev per AE4DMA hardware channel: probe creates AE4DMA_MAX_HW_QUEUES
> + * dmadevs per PCI function, each owning a single HW command queue.
> + */
> +struct ae4dma_dmadev {
> +	void *io_regs;
> +	struct ae4dma_cmd_queue cmd_q; /* single HW queue owned by this dmadev */
> +};
> +
> +extern int ae4dma_pmd_logtype;
> +#define RTE_LOGTYPE_AE4DMA_PMD ae4dma_pmd_logtype
> +
> +#define AE4DMA_PMD_LOG(level, ...) \
> +	RTE_LOG_LINE_PREFIX(level, AE4DMA_PMD, "%s(): ", __func__, __VA_ARGS__)
> +
> +#define AE4DMA_PMD_DEBUG(...)  AE4DMA_PMD_LOG(DEBUG, __VA_ARGS__)
> +#define AE4DMA_PMD_INFO(...)   AE4DMA_PMD_LOG(INFO, __VA_ARGS__)
> +#define AE4DMA_PMD_ERR(...)    AE4DMA_PMD_LOG(ERR, __VA_ARGS__)
> +#define AE4DMA_PMD_WARN(...)   AE4DMA_PMD_LOG(WARNING, __VA_ARGS__)
> +
> +#endif /* _AE4DMA_INTERNAL_H_ */
> diff --git a/drivers/dma/ae4dma/meson.build b/drivers/dma/ae4dma/meson.build
> new file mode 100644
> index 0000000..9f43141
> --- /dev/null
> +++ b/drivers/dma/ae4dma/meson.build
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright 2026 Advanced Micro Devices, Inc. All rights reserved.
> +
> +if not is_linux
> +    build = false
> +    reason = 'only supported on Linux'
> +    subdir_done()
> +endif
> +
> +build = dpdk_conf.has('RTE_ARCH_X86')
> +reason = 'only supported on x86'
> +sources = files('ae4dma_dmadev.c')
> +deps += ['bus_pci', 'dmadev']
> diff --git a/drivers/dma/meson.build b/drivers/dma/meson.build
> index e0d94db..c230ac5 100644
> --- a/drivers/dma/meson.build
> +++ b/drivers/dma/meson.build
> @@ -2,6 +2,7 @@
>  # Copyright 2021 HiSilicon Limited
>  
>  drivers = [
> +        'ae4dma',
>          'cnxk',
>          'dpaa',
>          'dpaa2',
> diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
> index 93f2383..7d09f15 100755
> --- a/usertools/dpdk-devbind.py
> +++ b/usertools/dpdk-devbind.py
> @@ -86,6 +86,9 @@ cnxk_npa = {'Class': '08', 'Vendor': '177d', 'Device': 'a0fb,a0fc',
>  cn9k_ree = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4',
>              'SVendor': None, 'SDevice': None}
>  
> +amd_ae4dma = {'Class': '08', 'Vendor': '1022', 'Device': '149b',
> +              'SVendor': None, 'SDevice': None}
> +
>  virtio_blk = {'Class': '01', 'Vendor': "1af4", 'Device': '1001,1042',
>                'SVendor': None, 'SDevice': None}
>  
> @@ -95,7 +98,7 @@ cnxk_ml = {'Class': '08', 'Vendor': '177d', 'Device': 'a092',
>  network_devices = [network_class, cavium_pkx, avp_vnic, ifpga_class]
>  baseband_devices = [acceleration_class]
>  crypto_devices = [encryption_class, intel_processor_class]
> -dma_devices = [cnxk_dma, hisilicon_dma,
> +dma_devices = [amd_ae4dma, cnxk_dma, hisilicon_dma,
>                 intel_idxd_gnrd, intel_idxd_dmr, intel_idxd_spr,
>                 intel_ioat_bdw, intel_ioat_icx, intel_ioat_skx,
>                 odm_dma]

