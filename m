Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F7CA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 06:19:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07F4940A8A;
	Fri, 12 Sep 2025 08:18:18 +0200 (CEST)
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
 by mails.dpdk.org (Postfix) with ESMTP id B55874066C
 for <dev@dpdk.org>; Fri, 12 Sep 2025 08:18:07 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.edSA7n1_1757657885 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 12 Sep 2025 14:18:05 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v8 10/17] net/nbl: add nbl coexistence mode for nbl
Date: Thu, 11 Sep 2025 23:17:45 -0700
Message-Id: <20250912061752.2091320-11-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912061752.2091320-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250912061752.2091320-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

NBL device support coexistence mode

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c     | 747 ++++++++++++++++++-
 drivers/net/nbl/nbl_common/nbl_userdev.h     |  11 +
 drivers/net/nbl/nbl_core.c                   |   3 +-
 drivers/net/nbl/nbl_core.h                   |   1 -
 drivers/net/nbl/nbl_hw/nbl_channel.c         | 184 ++++-
 drivers/net/nbl/nbl_hw/nbl_channel.h         |  11 +
 drivers/net/nbl/nbl_include/nbl_def_common.h |  63 ++
 drivers/net/nbl/nbl_include/nbl_include.h    |   2 +
 8 files changed, 1014 insertions(+), 8 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 87b943ccd7..d608899ca8 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -3,15 +3,738 @@
  */
 
 #include "nbl_userdev.h"
+#include <rte_vfio.h>
 
-int nbl_pci_map_device(struct nbl_adapter *adapter)
+#define NBL_USERDEV_EVENT_CLB_NAME	"nbl_userspace_mem_event_clb"
+#define NBL_USERDEV_BAR0_SIZE		65536
+#define NBL_USERDEV_DMA_LIMIT		0xFFFFFFFFFFFF
+
+/* Size of the buffer to receive kernel messages */
+#define NBL_NL_BUF_SIZE (32 * 1024)
+/* Send buffer size for the Netlink socket */
+#define NBL_SEND_BUF_SIZE 32768
+/* Receive buffer size for the Netlink socket */
+#define NBL_RECV_BUF_SIZE 32768
+
+struct nbl_userdev_map_record {
+	TAILQ_ENTRY(nbl_userdev_map_record) next;
+	u64 vaddr;
+	u64 iova;
+	u64 len;
+};
+
+static int nbl_default_container = -1;
+static int nbl_group_count;
+
+TAILQ_HEAD(nbl_adapter_list_head, nbl_adapter);
+static struct nbl_adapter_list_head nbl_adapter_list =
+	TAILQ_HEAD_INITIALIZER(nbl_adapter_list);
+
+TAILQ_HEAD(nbl_userdev_map_record_head, nbl_userdev_map_record);
+static struct nbl_userdev_map_record_head nbl_map_list =
+	TAILQ_HEAD_INITIALIZER(nbl_map_list);
+
+static int
+nbl_userdev_dma_mem_map(int devfd, uint64_t vaddr, uint64_t iova, uint64_t len)
 {
-	struct rte_pci_device *pci_dev = adapter->pci_dev;
+	struct nbl_dev_user_dma_map dma_map;
 	int ret = 0;
 
-	ret = rte_pci_map_device(pci_dev);
+	memset(&dma_map, 0, sizeof(dma_map));
+	dma_map.argsz = sizeof(struct nbl_dev_user_dma_map);
+	dma_map.vaddr = vaddr;
+	dma_map.size = len;
+	dma_map.iova = iova;
+	dma_map.flags = NBL_DEV_USER_DMA_MAP_FLAG_READ |
+			NBL_DEV_USER_DMA_MAP_FLAG_WRITE;
+
+	ret = ioctl(devfd, NBL_DEV_USER_MAP_DMA, &dma_map);
+	if (ret) {
+		/**
+		 * In case the mapping was already done EEXIST will be
+		 * returned from kernel.
+		 */
+		if (errno == EEXIST) {
+			NBL_LOG(ERR,
+				"nbl container Memory segment is already mapped, skipping");
+			ret = 0;
+		} else {
+			NBL_LOG(ERR,
+				"nbl container cannot set up DMA remapping, error %i (%s), ret %d",
+				errno, strerror(errno), ret);
+		}
+	}
+
+	return ret;
+}
+
+static int
+nbl_vfio_dma_mem_map(int vfio_container_fd, uint64_t vaddr, uint64_t len, int do_map)
+{
+	struct vfio_iommu_type1_dma_map dma_map;
+	struct vfio_iommu_type1_dma_unmap dma_unmap;
+	int ret;
+
+	if (do_map != 0) {
+		memset(&dma_map, 0, sizeof(dma_map));
+		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
+		dma_map.vaddr = vaddr;
+		dma_map.size = len;
+		dma_map.iova = vaddr;
+		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
+				VFIO_DMA_MAP_FLAG_WRITE;
+
+		ret = ioctl(vfio_container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+		if (ret) {
+			/**
+			 * In case the mapping was already done EEXIST will be
+			 * returned from kernel.
+			 */
+			if (errno == EEXIST) {
+				NBL_LOG(ERR,
+					"Memory segment is already mapped, skipping");
+			} else {
+				NBL_LOG(ERR,
+					"cannot set up DMA remapping, error %i (%s)",
+					errno, strerror(errno));
+				return -1;
+			}
+		}
+	} else {
+		memset(&dma_unmap, 0, sizeof(dma_unmap));
+		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+		dma_unmap.size = len;
+		dma_unmap.iova = vaddr;
+
+		ret = ioctl(vfio_container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
+		if (ret) {
+			NBL_LOG(ERR, "cannot clear DMA remapping, error %i (%s)",
+				errno, strerror(errno));
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int
+vfio_map_contig(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
+		size_t len, void *arg)
+{
+	struct nbl_userdev_map_record *record;
+	int *vfio_container_fd = arg;
+	int ret;
+
+	if (msl->external)
+		return 0;
+
+	ret = nbl_vfio_dma_mem_map(*vfio_container_fd, ms->addr_64, len, 1);
 	if (ret)
-		NBL_LOG(ERR, "device %s uio or vfio map failed", pci_dev->device.name);
+		goto vfio_dma_mem_map_fail;
+
+	record = malloc(sizeof(*record));
+	if (!record) {
+		ret = -ENOMEM;
+		goto malloc_fail;
+	}
+
+	record->vaddr = ms->addr_64;
+	record->iova = ms->iova;
+	record->len = len;
+	TAILQ_INSERT_TAIL(&nbl_map_list, record, next);
+
+	return 0;
+
+malloc_fail:
+	nbl_vfio_dma_mem_map(*vfio_container_fd, ms->addr_64, len, 0);
+vfio_dma_mem_map_fail:
+	return ret;
+}
+
+static int
+vfio_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms, void *arg)
+{
+	struct nbl_userdev_map_record *record;
+	int *vfio_container_fd = arg;
+	int ret;
+
+	/* skip external memory that isn't a heap */
+	if (msl->external && !msl->heap)
+		return 0;
+
+	/* skip any segments with invalid IOVA addresses */
+	if (ms->iova == RTE_BAD_IOVA)
+		return 0;
+
+	/* if IOVA mode is VA, we've already mapped the internal segments */
+	if (!msl->external && rte_eal_iova_mode() == RTE_IOVA_VA)
+		return 0;
+
+	ret = nbl_vfio_dma_mem_map(*vfio_container_fd, ms->addr_64, ms->len, 1);
+	if (ret)
+		goto vfio_dma_mem_map_fail;
+
+	record = malloc(sizeof(*record));
+	if (!record) {
+		ret = -ENOMEM;
+		goto malloc_fail;
+	}
+
+	record->vaddr = ms->addr_64;
+	record->iova = ms->iova;
+	record->len = ms->len;
+	TAILQ_INSERT_TAIL(&nbl_map_list, record, next);
+
+	return 0;
+
+malloc_fail:
+	nbl_vfio_dma_mem_map(*vfio_container_fd, ms->addr_64, ms->len, 0);
+vfio_dma_mem_map_fail:
+	return ret;
+}
+
+static int nbl_userdev_vfio_dma_map(int vfio_container_fd)
+{
+	if (rte_eal_iova_mode() == RTE_IOVA_VA) {
+		/**
+		 * with IOVA as VA mode, we can get away with mapping contiguous
+		 * chunks rather than going page-by-page.
+		 */
+		int ret = rte_memseg_contig_walk(vfio_map_contig,
+				&vfio_container_fd);
+		if (ret)
+			return ret;
+		/**
+		 * we have to continue the walk because we've skipped the
+		 * external segments during the config walk.
+		 */
+	}
+	return rte_memseg_walk(vfio_map, &vfio_container_fd);
+}
+
+static int nbl_userdev_dma_map(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+	struct nbl_userdev_map_record *record;
+	rte_iova_t iova;
+
+	rte_mcfg_mem_read_lock();
+	TAILQ_FOREACH(record, &nbl_map_list, next) {
+		iova = record->iova;
+		if (common->dma_set_msb)
+			iova |= (1UL << common->dma_limit_msb);
+		nbl_userdev_dma_mem_map(common->devfd, record->vaddr, iova, record->len);
+	}
+	TAILQ_INSERT_TAIL(&nbl_adapter_list, adapter, next);
+	rte_mcfg_mem_read_unlock();
+
+	return 0;
+}
+
+static void *nbl_userdev_mmap(int devfd, __rte_unused int bar_index, size_t size)
+{
+	void *addr;
+
+	addr = rte_mem_map(NULL, size, RTE_PROT_READ | RTE_PROT_WRITE,
+			   RTE_MAP_SHARED, devfd, 0);
+	if (!addr)
+		NBL_LOG(ERR, "usermap mmap bar failed");
+
+	return addr;
+}
+
+static int nbl_userdev_add_record(u64 vaddr, u64 iova, u64 len)
+{
+	struct nbl_userdev_map_record *record;
+	struct nbl_adapter *adapter;
+	u64 dma_iova;
+	int ret;
+
+	record = malloc(sizeof(*record));
+	if (!record)
+		return -ENOMEM;
+
+	ret = nbl_vfio_dma_mem_map(nbl_default_container, vaddr, len, 1);
+	if (ret) {
+		free(record);
+		return ret;
+	}
+
+	record->iova = iova;
+	record->len = len;
+	record->vaddr = vaddr;
+
+	TAILQ_INSERT_TAIL(&nbl_map_list, record, next);
+	TAILQ_FOREACH(adapter, &nbl_adapter_list, next) {
+		dma_iova = record->iova;
+		if (adapter->common.dma_set_msb)
+			dma_iova |= (1UL << adapter->common.dma_limit_msb);
+		nbl_userdev_dma_mem_map(adapter->common.devfd, record->vaddr,
+					dma_iova, record->len);
+	}
+
+	return 0;
+}
+
+static int nbl_userdev_free_record(u64 vaddr, u64 iova __rte_unused, u64 len __rte_unused)
+{
+	struct nbl_userdev_map_record *record, *tmp_record;
+
+	RTE_TAILQ_FOREACH_SAFE(record, &nbl_map_list, next, tmp_record) {
+		if (record->vaddr != vaddr)
+			continue;
+		nbl_vfio_dma_mem_map(nbl_default_container, vaddr, record->len, 0);
+		TAILQ_REMOVE(&nbl_map_list, record, next);
+		free(record);
+	}
+
+	return 0;
+}
+
+static void nbl_userdev_dma_free(void)
+{
+	struct nbl_userdev_map_record *record, *tmp_record;
+
+	RTE_TAILQ_FOREACH_SAFE(record, &nbl_map_list, next, tmp_record) {
+		TAILQ_REMOVE(&nbl_map_list, record, next);
+		free(record);
+	}
+}
+
+static void
+nbl_userdev_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
+			       void *arg __rte_unused)
+{
+	rte_iova_t iova_start, iova_expected;
+	struct rte_memseg_list *msl;
+	struct rte_memseg *ms;
+	size_t cur_len = 0;
+	u64 va_start;
+	u64 vfio_va;
+
+	if (!nbl_group_count)
+		return;
+
+	msl = rte_mem_virt2memseg_list(addr);
+
+	/* for IOVA as VA mode, no need to care for IOVA addresses */
+	if (rte_eal_iova_mode() == RTE_IOVA_VA && msl->external == 0) {
+		vfio_va = (u64)(uintptr_t)addr;
+		if (type == RTE_MEM_EVENT_ALLOC)
+			nbl_userdev_add_record(vfio_va, vfio_va, len);
+		else
+			nbl_userdev_free_record(vfio_va, vfio_va, len);
+		return;
+	}
+
+	/* memsegs are contiguous in memory */
+	ms = rte_mem_virt2memseg(addr, msl);
+
+	/**
+	 * This memory is not guaranteed to be contiguous, but it still could
+	 * be, or it could have some small contiguous chunks. Since the number
+	 * of VFIO mappings is limited, and VFIO appears to not concatenate
+	 * adjacent mappings, we have to do this ourselves.
+	 * So, find contiguous chunks, then map them.
+	 */
+	va_start = ms->addr_64;
+	iova_start = ms->iova;
+	iova_expected = ms->iova;
+	while (cur_len < len) {
+		bool new_contig_area = ms->iova != iova_expected;
+		bool last_seg = (len - cur_len) == ms->len;
+		bool skip_last = false;
+
+		/* only do mappings when current contiguous area ends */
+		if (new_contig_area) {
+			if (type == RTE_MEM_EVENT_ALLOC)
+				nbl_userdev_add_record(va_start, iova_start,
+						       iova_expected - iova_start);
+			else
+				nbl_userdev_free_record(va_start, iova_start,
+							iova_expected - iova_start);
+			va_start = ms->addr_64;
+			iova_start = ms->iova;
+		}
+		/* some memory segments may have invalid IOVA */
+		if (ms->iova == RTE_BAD_IOVA) {
+			NBL_LOG(DEBUG, "Memory segment at %p has bad IOVA, skipping",
+				ms->addr);
+			skip_last = true;
+		}
+		iova_expected = ms->iova + ms->len;
+		cur_len += ms->len;
+		++ms;
+
+		/**
+		 * don't count previous segment, and don't attempt to
+		 * dereference a potentially invalid pointer.
+		 */
+		if (skip_last && !last_seg) {
+			iova_expected = ms->iova;
+			iova_start = ms->iova;
+			va_start = ms->addr_64;
+		} else if (!skip_last && last_seg) {
+			/* this is the last segment and we're not skipping */
+			if (type == RTE_MEM_EVENT_ALLOC)
+				nbl_userdev_add_record(va_start, iova_start,
+						       iova_expected - iova_start);
+			else
+				nbl_userdev_free_record(va_start, iova_start,
+							iova_expected - iova_start);
+		}
+	}
+}
+
+static int nbl_mdev_map_device(struct nbl_adapter *adapter)
+{
+	const struct rte_pci_device *pci_dev = adapter->pci_dev;
+	struct nbl_common_info *common = &adapter->common;
+	char dev_name[RTE_DEV_NAME_MAX_LEN] = {0};
+	char pathname[PATH_MAX];
+	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
+	struct vfio_group_status group_status = {
+			.argsz = sizeof(group_status)
+	};
+	u64 dma_limit = NBL_USERDEV_DMA_LIMIT;
+	int ret, container_create = 0, container_set = 0;
+	int vfio_group_fd, container = nbl_default_container;
+
+	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
+	snprintf(pathname, sizeof(pathname),
+		 "%s/%s/", rte_pci_get_sysfs_path(), dev_name);
+
+	ret = rte_vfio_get_group_num(pathname, dev_name, &common->iommu_group_num);
+	if (ret <= 0) {
+		NBL_LOG(ERR, "nbl vfio group number failed");
+		return -1;
+	}
+
+	NBL_LOG(DEBUG, "nbl vfio group number %d", common->iommu_group_num);
+	/* vfio_container */
+	if (nbl_default_container < 0) {
+		container = rte_vfio_container_create();
+		container_create = 1;
+
+		if (container < 0) {
+			NBL_LOG(ERR, "nbl vfio container create failed");
+			return -1;
+		}
+	}
+
+	NBL_LOG(DEBUG, "nbl vfio container %d", container);
+	vfio_group_fd = rte_vfio_container_group_bind(container, common->iommu_group_num);
+	if (vfio_group_fd < 0) {
+		NBL_LOG(ERR, "nbl vfio group bind failed, %d", vfio_group_fd);
+		goto free_container;
+	}
+
+	/* check if the group is viable */
+	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_STATUS, &group_status);
+	if (ret) {
+		NBL_LOG(ERR, "%s cannot get group status,error %i (%s)", dev_name,
+			errno, strerror(errno));
+		goto free_group;
+	} else if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
+		NBL_LOG(ERR, "%s VFIO group is not viable!", dev_name);
+		goto free_group;
+	}
+
+	if (!(group_status.flags & VFIO_GROUP_FLAGS_CONTAINER_SET)) {
+		/* add group to a container */
+		ret = ioctl(vfio_group_fd, VFIO_GROUP_SET_CONTAINER, &container);
+		if (ret) {
+			NBL_LOG(ERR, "%s cannot add VFIO group to container, error %i (%s)",
+				dev_name, errno, strerror(errno));
+			goto free_group;
+		}
+
+		nbl_group_count++;
+		container_set = 1;
+		/* set an IOMMU type for container */
+
+		if (container_create || nbl_group_count == 1) {
+			if (ioctl(container, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
+				ret = ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1v2_IOMMU);
+				if (ret) {
+					NBL_LOG(ERR, "Failed to setup VFIO iommu");
+					goto unset_container;
+				}
+			} else {
+				NBL_LOG(ERR, "No supported IOMMU available");
+				goto unset_container;
+			}
+
+			rte_mcfg_mem_read_lock();
+			ret = nbl_userdev_vfio_dma_map(container);
+			if (ret) {
+				rte_mcfg_mem_read_unlock();
+				NBL_LOG(WARNING, "nbl vfio container dma map failed, %d", ret);
+				goto free_dma_map;
+			}
+			ret = rte_mem_event_callback_register(NBL_USERDEV_EVENT_CLB_NAME,
+							      nbl_userdev_mem_event_callback, NULL);
+			rte_mcfg_mem_read_unlock();
+			if (ret && rte_errno != ENOTSUP) {
+				NBL_LOG(WARNING, "nbl vfio mem event register callback failed, %d",
+					ret);
+				goto free_dma_map;
+			}
+		}
+	}
+
+	/* get a file descriptor for the device */
+	common->devfd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD, dev_name);
+	if (common->devfd < 0) {
+		/* if we cannot get a device fd, this implies a problem with
+		 * the VFIO group or the container not having IOMMU configured.
+		 */
+
+		NBL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed, %d",
+			dev_name, common->devfd);
+		goto unregister_mem_event;
+	}
+
+	if (container_create)
+		nbl_default_container = container;
+
+	common->specific_dma = true;
+	if (rte_eal_iova_mode() == RTE_IOVA_PA)
+		common->dma_set_msb = true;
+	ioctl(common->devfd, NBL_DEV_USER_GET_DMA_LIMIT, &dma_limit);
+	common->dma_limit_msb = rte_fls_u64(dma_limit) - 1;
+	if (common->dma_limit_msb < 38) {
+		NBL_LOG(ERR, "iommu dma limit msb %u, low 3-level page table",
+			common->dma_limit_msb);
+		goto close_fd;
+	}
+
+	nbl_userdev_dma_map(adapter);
+
+	return 0;
+
+close_fd:
+	close(common->devfd);
+unregister_mem_event:
+	if (nbl_group_count == 1) {
+		rte_mcfg_mem_read_lock();
+		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
+		rte_mcfg_mem_read_unlock();
+	}
+free_dma_map:
+	if (nbl_group_count == 1) {
+		rte_mcfg_mem_read_lock();
+		nbl_userdev_dma_free();
+		rte_mcfg_mem_read_unlock();
+	}
+unset_container:
+	if (container_set) {
+		ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &container);
+		nbl_group_count--;
+	}
+free_group:
+	close(vfio_group_fd);
+	rte_vfio_clear_group(vfio_group_fd);
+free_container:
+	if (container_create)
+		rte_vfio_container_destroy(container);
+	return -1;
+}
+
+static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
+{
+	struct nbl_common_info *common = &adapter->common;
+	int vfio_group_fd, ret;
+
+	close(common->devfd);
+	rte_mcfg_mem_read_lock();
+	vfio_group_fd = rte_vfio_container_group_bind(nbl_default_container,
+						      common->iommu_group_num);
+	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
+	ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
+	if (ret)
+		NBL_LOG(ERR, "unset container, error %i (%s) %d",
+			errno, strerror(errno), ret);
+	nbl_group_count--;
+	ret = rte_vfio_container_group_unbind(nbl_default_container, common->iommu_group_num);
+	if (ret)
+		NBL_LOG(ERR, "vfio container group unbind failed %d", ret);
+	if (!nbl_group_count) {
+		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
+		nbl_userdev_dma_free();
+	}
+	rte_mcfg_mem_read_unlock();
+
+	return 0;
+}
+
+static int nbl_userdev_get_ifindex(int devfd)
+{
+	int ifindex = -1, ret;
+
+	ret = ioctl(devfd, NBL_DEV_USER_GET_IFINDEX, &ifindex);
+	if (ret)
+		NBL_LOG(ERR, "get ifindex failed %d", ret);
+
+	NBL_LOG(DEBUG, "get ifindex %d", ifindex);
+
+	return ifindex;
+}
+
+static int nbl_userdev_nl_init(int protocol)
+{
+	int fd;
+	int sndbuf_size = NBL_SEND_BUF_SIZE;
+	int rcvbuf_size = NBL_RECV_BUF_SIZE;
+	struct sockaddr_nl local = {
+		.nl_family = AF_NETLINK,
+	};
+	int ret;
+
+	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, protocol);
+	if (fd == -1) {
+		rte_errno = errno;
+		return -rte_errno;
+	}
+	ret = setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, sizeof(int));
+	if (ret == -1) {
+		rte_errno = errno;
+		goto error;
+	}
+	ret = setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeof(int));
+	if (ret == -1) {
+		rte_errno = errno;
+		goto error;
+	}
+	ret = bind(fd, (struct sockaddr *)&local, sizeof(local));
+	if (ret == -1) {
+		rte_errno = errno;
+		goto error;
+	}
+	return fd;
+error:
+	close(fd);
+	return -rte_errno;
+}
+
+int nbl_userdev_port_config(struct nbl_adapter *adapter, int start)
+{
+	struct nbl_common_info *common = &adapter->common;
+	int ret;
+
+	if (NBL_IS_NOT_COEXISTENCE(common))
+		return 0;
+
+	if (common->isolate)
+		return 0;
+
+	ret = ioctl(common->devfd, NBL_DEV_USER_SWITCH_NETWORK, &start);
+	if (ret) {
+		NBL_LOG(ERR, "userspace switch network ret %d", ret);
+		return ret;
+	}
+
+	common->curr_network = start;
+	return ret;
+}
+
+int nbl_userdev_port_isolate(struct nbl_adapter *adapter, int set, struct rte_flow_error *error)
+{
+	struct nbl_common_info *common = &adapter->common;
+	int ret = 0, stat = !set;
+
+	if (NBL_IS_NOT_COEXISTENCE(common)) {
+		/* special use for isolate: offload mode ignore isolate when pf is in vfio/uio */
+		rte_flow_error_set(error, EREMOTEIO,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "nbl isolate switch failed.");
+		return -EREMOTEIO;
+	}
+
+	if (common->curr_network != stat)
+		ret = ioctl(common->devfd, NBL_DEV_USER_SWITCH_NETWORK, &stat);
+
+	if (ret) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "nbl isolate switch failed.");
+		return ret;
+	}
+
+	common->curr_network = !set;
+	common->isolate = set;
+
+	return ret;
+}
+
+int nbl_pci_map_device(struct nbl_adapter *adapter)
+{
+	struct rte_pci_device *pci_dev = adapter->pci_dev;
+	const struct rte_pci_addr *loc = &pci_dev->addr;
+	struct nbl_common_info *common = &adapter->common;
+	char pathname[PATH_MAX];
+	int ret = 0, fd;
+	enum rte_iova_mode iova_mode;
+	size_t bar_size = NBL_USERDEV_BAR0_SIZE;
+
+	NBL_USERDEV_INIT_COMMON(common);
+	iova_mode = rte_eal_iova_mode();
+	if (iova_mode == RTE_IOVA_PA) {
+		/* check iommu disable */
+		snprintf(pathname, sizeof(pathname),
+			 "/dev/nbl_userdev/" PCI_PRI_FMT, loc->domain,
+			 loc->bus, loc->devid, loc->function);
+		common->devfd = open(pathname, O_RDWR);
+		if (common->devfd >= 0)
+			goto mmap;
+
+		NBL_LOG(ERR, "%s char device open failed", pci_dev->device.name);
+	}
+
+	/* check iommu translate mode */
+	ret = nbl_mdev_map_device(adapter);
+	if (ret) {
+		ret = rte_pci_map_device(pci_dev);
+		if (ret)
+			NBL_LOG(ERR, "uio/vfio %s map device failed", pci_dev->device.name);
+		return ret;
+	}
+
+mmap:
+	fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (fd < 0) {
+		NBL_LOG(ERR, "nbl userdev get event fd failed");
+		ret = -1;
+		goto close_fd;
+	}
+
+	ret = ioctl(common->devfd, NBL_DEV_USER_SET_EVENTFD, &fd);
+	if (ret) {
+		NBL_LOG(ERR, "nbl userdev set event fd failed");
+		goto close_eventfd;
+	}
+
+	common->eventfd = fd;
+	ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
+
+	if (!ret) {
+		pci_dev->mem_resource[0].addr = nbl_userdev_mmap(common->devfd, 0, bar_size);
+		pci_dev->mem_resource[0].phys_addr = 0;
+		pci_dev->mem_resource[0].len = bar_size;
+		pci_dev->mem_resource[2].addr = 0;
+
+		common->ifindex = nbl_userdev_get_ifindex(common->devfd);
+		common->nl_socket_route = nbl_userdev_nl_init(NETLINK_ROUTE);
+	}
+
+	return ret;
+
+close_eventfd:
+	close(fd);
+close_fd:
+	if (common->specific_dma)
+		nbl_mdev_unmap_device(adapter);
+	else
+		close(common->devfd);
 
 	return ret;
 }
@@ -19,6 +742,20 @@ int nbl_pci_map_device(struct nbl_adapter *adapter)
 void nbl_pci_unmap_device(struct nbl_adapter *adapter)
 {
 	struct rte_pci_device *pci_dev = adapter->pci_dev;
+	struct nbl_common_info *common = &adapter->common;
+
+	if (NBL_IS_NOT_COEXISTENCE(common))
+		return rte_pci_unmap_device(pci_dev);
+
+	rte_mem_unmap(pci_dev->mem_resource[0].addr, pci_dev->mem_resource[0].len);
+	ioctl(common->devfd, NBL_DEV_USER_CLEAR_EVENTFD, 0);
+	close(common->eventfd);
+	close(common->nl_socket_route);
+
+	if (!common->specific_dma) {
+		close(common->devfd);
+		return;
+	}
 
-	return rte_pci_unmap_device(pci_dev);
+	nbl_mdev_unmap_device(adapter);
 }
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.h b/drivers/net/nbl/nbl_common/nbl_userdev.h
index 11cc29999c..2221e19c67 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.h
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.h
@@ -6,5 +6,16 @@
 #define _NBL_USERDEV_H_
 
 #include "nbl_ethdev.h"
+#include "nbl_common.h"
+
+#define NBL_USERDEV_INIT_COMMON(common) do {		\
+	typeof(common) _comm = (common);		\
+	_comm->devfd = -1;				\
+	_comm->eventfd = -1;				\
+	_comm->specific_dma = false;			\
+	_comm->dma_set_msb = false;			\
+	_comm->ifindex = -1;				\
+	_comm->nl_socket_route = -1;			\
+} while (0)
 
 #endif
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index ce6c09769b..2d95a76569 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -32,11 +32,12 @@ static void nbl_init_func_caps(const struct rte_pci_device *pci_dev, struct nbl_
 
 int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev)
 {
-	const struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
 	const struct nbl_product_core_ops *product_base_ops = NULL;
 	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
 	int ret = 0;
 
+	adapter->pci_dev = pci_dev;
 	common->eth_dev = eth_dev;
 	nbl_init_func_caps(pci_dev, &adapter->caps);
 
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 0ec7148e5a..0db4e77dac 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -51,7 +51,6 @@
 #define NBL_IS_NOT_COEXISTENCE(common)		({ typeof(common) _common = (common);	\
 						_common->nl_socket_route < 0 ||		\
 						_common->ifindex < 0; })
-
 struct nbl_core {
 	void *hw_mgt;
 	void *res_mgt;
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index 5943ccb299..93d0014841 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -652,6 +652,181 @@ static struct nbl_channel_ops chan_ops = {
 	.notify_interrupt		= nbl_chan_notify_interrupt,
 };
 
+static int nbl_chan_userdev_send_msg(void *priv, struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_dev_user_channel_msg msg;
+	uint32_t *result;
+	int ret;
+
+	if (chan_mgt->state)
+		return -EIO;
+
+	msg.msg_type = chan_send->msg_type;
+	msg.dst_id = chan_send->dstid;
+	msg.arg_len = chan_send->arg_len;
+	msg.ack = chan_send->ack;
+	msg.ack_length = chan_send->resp_len;
+	memcpy(&msg.data, chan_send->arg, chan_send->arg_len);
+
+	ret = ioctl(common->devfd, NBL_DEV_USER_CHANNEL, &msg);
+	if (ret) {
+		NBL_LOG(ERR, "user mailbox failed, type %u, ret %d", msg.msg_type, ret);
+		return -1;
+	}
+
+	/* 4bytes align */
+	result = (uint32_t *)RTE_PTR_ALIGN(((unsigned char *)msg.data) + chan_send->arg_len, 4);
+	memcpy(chan_send->resp, result, RTE_MIN(chan_send->resp_len, msg.ack_length));
+
+	return msg.ack_err;
+}
+
+static int nbl_chan_userdev_send_ack(void *priv, struct nbl_chan_ack_info *chan_ack)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_send_info chan_send;
+	u32 *tmp;
+	u32 len = 3 * sizeof(u32) + chan_ack->data_len;
+
+	tmp = rte_zmalloc("nbl_chan_send_tmp", len, 0);
+	if (!tmp) {
+		NBL_LOG(ERR, "Chan send ack data malloc failed");
+		return -ENOMEM;
+	}
+
+	tmp[0] = chan_ack->msg_type;
+	tmp[1] = chan_ack->msgid;
+	tmp[2] = (u32)chan_ack->err;
+	if (chan_ack->data && chan_ack->data_len)
+		memcpy(&tmp[3], chan_ack->data, chan_ack->data_len);
+
+	NBL_CHAN_SEND(chan_send, chan_ack->dstid, NBL_CHAN_MSG_ACK, tmp, len, NULL, 0, 0);
+	nbl_chan_userdev_send_msg(chan_mgt, &chan_send);
+	rte_free(tmp);
+
+	return 0;
+}
+
+static void nbl_chan_userdev_eventfd_handler(void *cn_arg)
+{
+	size_t page_size = rte_mem_page_size();
+	char *bak_buf = malloc(page_size);
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)cn_arg;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	char *data = (char *)chan_info->userdev.shm_msg_ring + 8;
+	char *payload;
+	u64 buf;
+	int nbytes __rte_unused;
+	u32 total_len;
+	u32 *head = (u32 *)chan_info->userdev.shm_msg_ring;
+	u32 *tail = (u32 *)chan_info->userdev.shm_msg_ring + 1, tmp_tail;
+	u32 shmmsgbuf_size = page_size - 8;
+
+	if (!bak_buf) {
+		NBL_LOG(ERR, "nbl chan handler malloc failed");
+		return;
+	}
+	tmp_tail = *tail;
+	nbytes = read(chan_info->userdev.eventfd, &buf, sizeof(buf));
+
+	while (*head != tmp_tail) {
+		total_len = *(u32 *)(data + tmp_tail);
+		if (tmp_tail + total_len > shmmsgbuf_size) {
+			u32 copy_len;
+
+			copy_len = shmmsgbuf_size - tmp_tail;
+			memcpy(bak_buf, data + tmp_tail, copy_len);
+			memcpy(bak_buf + copy_len, data, total_len - copy_len);
+			payload = bak_buf;
+
+		} else {
+			payload  = (data + tmp_tail);
+		}
+
+		nbl_chan_recv_msg(chan_mgt, payload + 4);
+		tmp_tail += total_len;
+		if (tmp_tail >= shmmsgbuf_size)
+			tmp_tail -= shmmsgbuf_size;
+	}
+
+	free(bak_buf);
+	*tail = tmp_tail;
+}
+
+static int nbl_chan_userdev_setup_queue(void *priv)
+{
+	size_t page_size = rte_mem_page_size();
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	int ret;
+
+	if (common->devfd < 0 || common->eventfd < 0)
+		return -EINVAL;
+
+	chan_info->userdev.eventfd = common->eventfd;
+	chan_info->userdev.intr_handle.fd = common->eventfd;
+	chan_info->userdev.intr_handle.type = RTE_INTR_HANDLE_EXT;
+
+	ret = rte_intr_callback_register(&chan_info->userdev.intr_handle,
+					 nbl_chan_userdev_eventfd_handler, chan_mgt);
+
+	if (ret) {
+		NBL_LOG(ERR, "channel userdev event handler register failed, %d", ret);
+		return ret;
+	}
+
+	chan_info->userdev.shm_msg_ring = rte_mem_map(NULL, page_size,
+						      RTE_PROT_READ | RTE_PROT_WRITE,
+						      RTE_MAP_SHARED, common->devfd,
+						      NBL_DEV_USER_INDEX_TO_OFFSET
+						      (NBL_DEV_SHM_MSG_RING_INDEX));
+	if (!chan_info->userdev.shm_msg_ring) {
+		rte_intr_callback_unregister(&chan_info->userdev.intr_handle,
+					     nbl_chan_userdev_eventfd_handler, chan_mgt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nbl_chan_userdev_teardown_queue(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+
+	rte_mem_unmap(chan_info->userdev.shm_msg_ring, rte_mem_page_size());
+	rte_intr_callback_unregister(&chan_info->userdev.intr_handle,
+				     nbl_chan_userdev_eventfd_handler, chan_mgt);
+
+	return 0;
+}
+
+static int nbl_chan_userdev_register_msg(void *priv, uint16_t msg_type, nbl_chan_resp func,
+					 void *callback_priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	int ret, type;
+
+	type = msg_type;
+	nbl_chan_register_msg(priv, msg_type, func, callback_priv);
+	ret = ioctl(common->devfd, NBL_DEV_USER_SET_LISTENER, &type);
+
+	return ret;
+}
+
+static struct nbl_channel_ops userdev_ops = {
+	.send_msg			= nbl_chan_userdev_send_msg,
+	.send_ack			= nbl_chan_userdev_send_ack,
+	.register_msg			= nbl_chan_userdev_register_msg,
+	.setup_queue			= nbl_chan_userdev_setup_queue,
+	.teardown_queue			= nbl_chan_userdev_teardown_queue,
+	.set_state			= nbl_chan_set_state,
+};
+
 static int nbl_chan_init_state_bitmap(void *priv)
 {
 	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
@@ -714,6 +889,7 @@ static int nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
 		goto alloc_mailbox_fail;
 
 	NBL_CHAN_MGT_TO_CHAN_INFO(&(*chan_mgt_leonis)->chan_mgt) = mailbox;
+	NBL_CHAN_MGT_TO_COMMON(&(*chan_mgt_leonis)->chan_mgt) = &adapter->common;
 
 	ret = nbl_chan_init_state_bitmap(*chan_mgt_leonis);
 	if (ret)
@@ -745,11 +921,17 @@ static void nbl_chan_remove_ops(struct nbl_channel_ops_tbl **chan_ops_tbl)
 static int nbl_chan_setup_ops(struct nbl_channel_ops_tbl **chan_ops_tbl,
 			      struct nbl_channel_mgt_leonis *chan_mgt_leonis)
 {
+	struct nbl_common_info *common;
+
 	*chan_ops_tbl = calloc(1, sizeof(struct nbl_channel_ops_tbl));
 	if (!*chan_ops_tbl)
 		return -ENOMEM;
 
-	NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &chan_ops;
+	common = NBL_CHAN_MGT_TO_COMMON(&chan_mgt_leonis->chan_mgt);
+	if (NBL_IS_NOT_COEXISTENCE(common))
+		NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &chan_ops;
+	else
+		NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &userdev_ops;
 	NBL_CHAN_OPS_TBL_TO_PRIV(*chan_ops_tbl) = chan_mgt_leonis;
 
 	chan_mgt_leonis->chan_mgt.msg_handler[NBL_CHAN_MSG_ACK].func = nbl_chan_recv_ack_msg;
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.h b/drivers/net/nbl/nbl_hw/nbl_channel.h
index ec46412a29..1f7d34461c 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.h
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.h
@@ -7,6 +7,10 @@
 
 #include "nbl_ethdev.h"
 
+#define NBL_CHAN_MAX_PAGE_SIZE			(64 * 1024)
+
+#define NBL_CHAN_MGT_TO_COMMON(chan_mgt)	((chan_mgt)->common)
+#define NBL_CHAN_MGT_TO_DEV(chan_mgt)		NBL_COMMON_TO_DEV(NBL_CHAN_MGT_TO_COMMON(chan_mgt))
 #define NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)	((chan_mgt)->hw_ops_tbl)
 #define NBL_CHAN_MGT_TO_HW_OPS(chan_mgt)	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->ops)
 #define NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt)	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->priv)
@@ -94,6 +98,12 @@ union nbl_chan_info {
 		rte_thread_t tid;
 		int fd[2];
 	} mailbox;
+
+	struct {
+		struct rte_intr_handle intr_handle;
+		void *shm_msg_ring;
+		int eventfd;
+	} userdev;
 };
 
 struct nbl_chan_msg_handler {
@@ -103,6 +113,7 @@ struct nbl_chan_msg_handler {
 
 struct nbl_channel_mgt {
 	uint32_t mode;
+	struct nbl_common_info *common;
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	union nbl_chan_info *chan_info;
 	struct nbl_chan_msg_handler msg_handler[NBL_CHAN_MSG_MAX];
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index 1ab9295d47..45db1e7413 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -18,6 +18,67 @@
 #define NBL_TWO_ETHERNET_MAX_MAC_NUM		(512)
 #define NBL_FOUR_ETHERNET_MAX_MAC_NUM		(1024)
 
+#define NBL_DEV_USER_TYPE	('n')
+#define NBL_DEV_USER_DATA_LEN	(2044)
+
+#define NBL_DEV_USER_PCI_OFFSET_SHIFT		40
+#define NBL_DEV_USER_OFFSET_TO_INDEX(off)	((off) >> NBL_DEV_USER_PCI_OFFSET_SHIFT)
+#define NBL_DEV_USER_INDEX_TO_OFFSET(index)	((u64)(index) << NBL_DEV_USER_PCI_OFFSET_SHIFT)
+#define NBL_DEV_SHM_MSG_RING_INDEX		(6)
+
+struct nbl_dev_user_channel_msg {
+	u16 msg_type;
+	u16 dst_id;
+	u32 arg_len;
+	u32 ack_err;
+	u16 ack_length;
+	u16 ack;
+	u32 data[NBL_DEV_USER_DATA_LEN];
+};
+
+#define NBL_DEV_USER_CHANNEL		_IO(NBL_DEV_USER_TYPE, 0)
+
+struct nbl_dev_user_dma_map {
+	uint32_t	argsz;
+	uint32_t	flags;
+#define NBL_DEV_USER_DMA_MAP_FLAG_READ (RTE_BIT64(0))		/* readable from device */
+#define NBL_DEV_USER_DMA_MAP_FLAG_WRITE (RTE_BIT64(1))	/* writable from device */
+	uint64_t	vaddr;				/* Process virtual address */
+	uint64_t	iova;				/* IO virtual address */
+	uint64_t	size;				/* Size of mapping (bytes) */
+};
+
+#define NBL_DEV_USER_MAP_DMA		_IO(NBL_DEV_USER_TYPE, 1)
+
+struct nbl_dev_user_dma_unmap {
+	uint32_t	argsz;
+	uint32_t	flags;
+	uint64_t	vaddr;				/* Process virtual address */
+	uint64_t	iova;				/* IO virtual address */
+	uint64_t	size;				/* Size of mapping (bytes) */
+};
+
+#define NBL_DEV_USER_UNMAP_DMA		_IO(NBL_DEV_USER_TYPE, 2)
+
+#define NBL_KERNEL_NETWORK			0
+#define NBL_USER_NETWORK			1
+
+#define NBL_DEV_USER_SWITCH_NETWORK	_IO(NBL_DEV_USER_TYPE, 3)
+#define NBL_DEV_USER_GET_IFINDEX	_IO(NBL_DEV_USER_TYPE, 4)
+
+struct nbl_dev_user_link_stat {
+	u8 state;
+	u8 flush;
+};
+
+#define NBL_DEV_USER_SET_EVENTFD	_IO(NBL_DEV_USER_TYPE, 5)
+#define NBL_DEV_USER_CLEAR_EVENTFD	_IO(NBL_DEV_USER_TYPE, 6)
+#define NBL_DEV_USER_SET_LISTENER	_IO(NBL_DEV_USER_TYPE, 7)
+#define NBL_DEV_USER_GET_BAR_SIZE	_IO(NBL_DEV_USER_TYPE, 8)
+#define NBL_DEV_USER_GET_DMA_LIMIT	_IO(NBL_DEV_USER_TYPE, 9)
+#define NBL_DEV_USER_SET_PROMISC_MODE	_IO(NBL_DEV_USER_TYPE, 10)
+#define NBL_DEV_USER_SET_MCAST_MODE	_IO(NBL_DEV_USER_TYPE, 11)
+
 struct nbl_dma_mem {
 	void *va;
 	uint64_t pa;
@@ -40,6 +101,8 @@ void *nbl_alloc_dma_mem(struct nbl_dma_mem *mem, uint32_t size);
 void nbl_free_dma_mem(struct nbl_dma_mem *mem);
 
 struct nbl_adapter;
+int nbl_userdev_port_config(struct nbl_adapter *adapter, int start);
+int nbl_userdev_port_isolate(struct nbl_adapter *adapter, int set, struct rte_flow_error *error);
 int nbl_pci_map_device(struct nbl_adapter *adapter);
 void nbl_pci_unmap_device(struct nbl_adapter *adapter);
 
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index d29d6fe7e6..eb4be89f11 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -36,6 +36,8 @@
 #include <rte_spinlock.h>
 #include <rte_stdatomic.h>
 #include <rte_bitmap.h>
+#include <rte_eal_paging.h>
+#include <eal_interrupts.h>
 
 #include "nbl_logs.h"
 
-- 
2.34.1

