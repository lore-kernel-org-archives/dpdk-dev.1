Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3C7C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:41:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F209B41143;
	Fri, 21 Feb 2025 18:41:53 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id ED090410E6
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:41:51 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8OWoT019398;
 Fri, 21 Feb 2025 09:41:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 +NdRmxNJ33zT/KGmQ2YlKrhV3gz2zVfDccaXt3DS4c=; b=Fditlq4e8qkBKsL+j
 In8zXFlmiiTv1VAsdgIgOJY3DPaGlL4sYuYZ1zaibI41IRtIlN7vOsTz4PfkxWm2
 izfPL15repMe7bI2GEHzLPcZNLLUZ6jEcGgeTi/6tfqiJFoLpfbGeINWBuFP4A6q
 PVrc5m4nXGb0Z3UAivpivQlHXykcw04KMXEVHQIY1zJBGQ3TvfwhZxrqIqF+4OjF
 MTYBQiaN9Ls1FWCNdo/jnPEwUCijCkBk/nasIjpqqIDKfZC4vILJAvFLhLVB+S9i
 fCk/XNTITWsbb+HHSvJ5QBGvMyDs1yK0xaFZNf1Ib0aZ58t2RvpNfC8zj3m8nvGK
 7xKRw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xnxu92du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:41:50 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:41:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:41:49 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id A248C3F708C;
 Fri, 21 Feb 2025 09:41:46 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v3 4/6] crypto/virtio: add vDPA backend
Date: Fri, 21 Feb 2025 23:11:14 +0530
Message-ID: <78741e4cd1386665b24850874bc46bc4d6c9bb2b.1740156584.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156584.git.gmuthukrishn@marvell.com>
References: <cover.1740156584.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pbcxstK3R425yaeig-JVM27bwNEzIzO_
X-Proofpoint-ORIG-GUID: pbcxstK3R425yaeig-JVM27bwNEzIzO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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

Add vDPA backend to virtio_user crypto.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/virtio/meson.build             |   7 +
 drivers/crypto/virtio/virtio_cryptodev.c      |  57 +-
 drivers/crypto/virtio/virtio_cryptodev.h      |   3 +
 drivers/crypto/virtio/virtio_logs.h           |   6 +-
 drivers/crypto/virtio/virtio_pci.h            |   7 +
 drivers/crypto/virtio/virtio_ring.h           |   6 -
 drivers/crypto/virtio/virtio_user/vhost.h     |  90 ++
 .../crypto/virtio/virtio_user/vhost_vdpa.c    | 710 ++++++++++++++++
 .../virtio/virtio_user/virtio_user_dev.c      | 767 ++++++++++++++++++
 .../virtio/virtio_user/virtio_user_dev.h      |  85 ++
 drivers/crypto/virtio/virtio_user_cryptodev.c | 575 +++++++++++++
 11 files changed, 2283 insertions(+), 30 deletions(-)
 create mode 100644 drivers/crypto/virtio/virtio_user/vhost.h
 create mode 100644 drivers/crypto/virtio/virtio_user/vhost_vdpa.c
 create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.c
 create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.h
 create mode 100644 drivers/crypto/virtio/virtio_user_cryptodev.c

diff --git a/drivers/crypto/virtio/meson.build b/drivers/crypto/virtio/meson.build
index d2c3b3ad07..3763e86746 100644
--- a/drivers/crypto/virtio/meson.build
+++ b/drivers/crypto/virtio/meson.build
@@ -16,3 +16,10 @@ sources = files(
         'virtio_rxtx.c',
         'virtqueue.c',
 )
+
+if is_linux
+    sources += files('virtio_user_cryptodev.c',
+        'virtio_user/vhost_vdpa.c',
+        'virtio_user/virtio_user_dev.c')
+    deps += ['bus_vdev']
+endif
diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index 92fea557ab..bc737f1e68 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -544,24 +544,12 @@ virtio_crypto_init_device(struct rte_cryptodev *cryptodev,
 	return 0;
 }
 
-/*
- * This function is based on probe() function
- * It returns 0 on success.
- */
-static int
-crypto_virtio_create(const char *name, struct rte_pci_device *pci_dev,
-		struct rte_cryptodev_pmd_init_params *init_params)
+int
+crypto_virtio_dev_init(struct rte_cryptodev *cryptodev, uint64_t features,
+		struct rte_pci_device *pci_dev)
 {
-	struct rte_cryptodev *cryptodev;
 	struct virtio_crypto_hw *hw;
 
-	PMD_INIT_FUNC_TRACE();
-
-	cryptodev = rte_cryptodev_pmd_create(name, &pci_dev->device,
-					init_params);
-	if (cryptodev == NULL)
-		return -ENODEV;
-
 	cryptodev->driver_id = cryptodev_virtio_driver_id;
 	cryptodev->dev_ops = &virtio_crypto_dev_ops;
 
@@ -578,16 +566,41 @@ crypto_virtio_create(const char *name, struct rte_pci_device *pci_dev,
 	hw->dev_id = cryptodev->data->dev_id;
 	hw->virtio_dev_capabilities = virtio_capabilities;
 
-	VIRTIO_CRYPTO_INIT_LOG_DBG("dev %d vendorID=0x%x deviceID=0x%x",
-		cryptodev->data->dev_id, pci_dev->id.vendor_id,
-		pci_dev->id.device_id);
+	if (pci_dev) {
+		/* pci device init */
+		VIRTIO_CRYPTO_INIT_LOG_DBG("dev %d vendorID=0x%x deviceID=0x%x",
+			cryptodev->data->dev_id, pci_dev->id.vendor_id,
+			pci_dev->id.device_id);
 
-	/* pci device init */
-	if (vtpci_cryptodev_init(pci_dev, hw))
+		if (vtpci_cryptodev_init(pci_dev, hw))
+			return -1;
+	}
+
+	if (virtio_crypto_init_device(cryptodev, features) < 0)
 		return -1;
 
-	if (virtio_crypto_init_device(cryptodev,
-			VIRTIO_CRYPTO_PMD_GUEST_FEATURES) < 0)
+	return 0;
+}
+
+/*
+ * This function is based on probe() function
+ * It returns 0 on success.
+ */
+static int
+crypto_virtio_create(const char *name, struct rte_pci_device *pci_dev,
+		struct rte_cryptodev_pmd_init_params *init_params)
+{
+	struct rte_cryptodev *cryptodev;
+
+	PMD_INIT_FUNC_TRACE();
+
+	cryptodev = rte_cryptodev_pmd_create(name, &pci_dev->device,
+					init_params);
+	if (cryptodev == NULL)
+		return -ENODEV;
+
+	if (crypto_virtio_dev_init(cryptodev, VIRTIO_CRYPTO_PMD_GUEST_FEATURES,
+			pci_dev) < 0)
 		return -1;
 
 	rte_cryptodev_pmd_probing_finish(cryptodev);
diff --git a/drivers/crypto/virtio/virtio_cryptodev.h b/drivers/crypto/virtio/virtio_cryptodev.h
index f8498246e2..fad73d54a8 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.h
+++ b/drivers/crypto/virtio/virtio_cryptodev.h
@@ -76,4 +76,7 @@ uint16_t virtio_crypto_pkt_rx_burst(void *tx_queue,
 		struct rte_crypto_op **tx_pkts,
 		uint16_t nb_pkts);
 
+int crypto_virtio_dev_init(struct rte_cryptodev *cryptodev, uint64_t features,
+		struct rte_pci_device *pci_dev);
+
 #endif /* _VIRTIO_CRYPTODEV_H_ */
diff --git a/drivers/crypto/virtio/virtio_logs.h b/drivers/crypto/virtio/virtio_logs.h
index 988514919f..1cc51f7990 100644
--- a/drivers/crypto/virtio/virtio_logs.h
+++ b/drivers/crypto/virtio/virtio_logs.h
@@ -15,8 +15,10 @@ extern int virtio_crypto_logtype_init;
 
 #define PMD_INIT_FUNC_TRACE() PMD_INIT_LOG(DEBUG, " >>")
 
-extern int virtio_crypto_logtype_init;
-#define RTE_LOGTYPE_VIRTIO_CRYPTO_INIT virtio_crypto_logtype_init
+extern int virtio_crypto_logtype_driver;
+#define RTE_LOGTYPE_VIRTIO_CRYPTO_DRIVER virtio_crypto_logtype_driver
+#define PMD_DRV_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, VIRTIO_CRYPTO_DRIVER, "%s(): ", __func__, __VA_ARGS__)
 
 #define VIRTIO_CRYPTO_INIT_LOG_IMPL(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, VIRTIO_CRYPTO_INIT, "%s(): ", __func__, __VA_ARGS__)
diff --git a/drivers/crypto/virtio/virtio_pci.h b/drivers/crypto/virtio/virtio_pci.h
index 79945cb88e..c75777e005 100644
--- a/drivers/crypto/virtio/virtio_pci.h
+++ b/drivers/crypto/virtio/virtio_pci.h
@@ -20,6 +20,9 @@ struct virtqueue;
 #define VIRTIO_CRYPTO_PCI_VENDORID 0x1AF4
 #define VIRTIO_CRYPTO_PCI_DEVICEID 0x1054
 
+/* VirtIO device IDs. */
+#define VIRTIO_ID_CRYPTO  20
+
 /* VirtIO ABI version, this must match exactly. */
 #define VIRTIO_PCI_ABI_VERSION 0
 
@@ -56,8 +59,12 @@ struct virtqueue;
 #define VIRTIO_CONFIG_STATUS_DRIVER    0x02
 #define VIRTIO_CONFIG_STATUS_DRIVER_OK 0x04
 #define VIRTIO_CONFIG_STATUS_FEATURES_OK 0x08
+#define VIRTIO_CONFIG_STATUS_DEV_NEED_RESET	0x40
 #define VIRTIO_CONFIG_STATUS_FAILED    0x80
 
+/* The alignment to use between consumer and producer parts of vring. */
+#define VIRTIO_VRING_ALIGN 4096
+
 /*
  * Each virtqueue indirect descriptor list must be physically contiguous.
  * To allow us to malloc(9) each list individually, limit the number
diff --git a/drivers/crypto/virtio/virtio_ring.h b/drivers/crypto/virtio/virtio_ring.h
index c74d1172b7..4b418f6e60 100644
--- a/drivers/crypto/virtio/virtio_ring.h
+++ b/drivers/crypto/virtio/virtio_ring.h
@@ -181,12 +181,6 @@ vring_init_packed(struct vring_packed *vr, uint8_t *p, rte_iova_t iova,
 				sizeof(struct vring_packed_desc_event)), align);
 }
 
-static inline void
-vring_init(struct vring *vr, unsigned int num, uint8_t *p, unsigned long align)
-{
-	vring_init_split(vr, p, 0, align, num);
-}
-
 /*
  * The following is used with VIRTIO_RING_F_EVENT_IDX.
  * Assuming a given event_idx value from the other size, if we have
diff --git a/drivers/crypto/virtio/virtio_user/vhost.h b/drivers/crypto/virtio/virtio_user/vhost.h
new file mode 100644
index 0000000000..29cc1a14d4
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_user/vhost.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell
+ */
+
+#ifndef _VIRTIO_USER_VHOST_H
+#define _VIRTIO_USER_VHOST_H
+
+#include <stdint.h>
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#include <rte_errno.h>
+
+#include "../virtio_logs.h"
+
+struct vhost_vring_state {
+	unsigned int index;
+	unsigned int num;
+};
+
+struct vhost_vring_file {
+	unsigned int index;
+	int fd;
+};
+
+struct vhost_vring_addr {
+	unsigned int index;
+	/* Option flags. */
+	unsigned int flags;
+	/* Flag values: */
+	/* Whether log address is valid. If set enables logging. */
+#define VHOST_VRING_F_LOG 0
+
+	/* Start of array of descriptors (virtually contiguous) */
+	uint64_t desc_user_addr;
+	/* Used structure address. Must be 32 bit aligned */
+	uint64_t used_user_addr;
+	/* Available structure address. Must be 16 bit aligned */
+	uint64_t avail_user_addr;
+	/* Logging support. */
+	/* Log writes to used structure, at offset calculated from specified
+	 * address. Address must be 32 bit aligned.
+	 */
+	uint64_t log_guest_addr;
+};
+
+#ifndef VHOST_BACKEND_F_IOTLB_MSG_V2
+#define VHOST_BACKEND_F_IOTLB_MSG_V2 1
+#endif
+
+#ifndef VHOST_BACKEND_F_IOTLB_BATCH
+#define VHOST_BACKEND_F_IOTLB_BATCH 2
+#endif
+
+struct virtio_user_dev;
+
+struct virtio_user_backend_ops {
+	int (*setup)(struct virtio_user_dev *dev);
+	int (*destroy)(struct virtio_user_dev *dev);
+	int (*get_backend_features)(uint64_t *features);
+	int (*set_owner)(struct virtio_user_dev *dev);
+	int (*get_features)(struct virtio_user_dev *dev, uint64_t *features);
+	int (*set_features)(struct virtio_user_dev *dev, uint64_t features);
+	int (*set_memory_table)(struct virtio_user_dev *dev);
+	int (*set_vring_num)(struct virtio_user_dev *dev, struct vhost_vring_state *state);
+	int (*set_vring_base)(struct virtio_user_dev *dev, struct vhost_vring_state *state);
+	int (*get_vring_base)(struct virtio_user_dev *dev, struct vhost_vring_state *state);
+	int (*set_vring_call)(struct virtio_user_dev *dev, struct vhost_vring_file *file);
+	int (*set_vring_kick)(struct virtio_user_dev *dev, struct vhost_vring_file *file);
+	int (*set_vring_addr)(struct virtio_user_dev *dev, struct vhost_vring_addr *addr);
+	int (*get_status)(struct virtio_user_dev *dev, uint8_t *status);
+	int (*set_status)(struct virtio_user_dev *dev, uint8_t status);
+	int (*get_config)(struct virtio_user_dev *dev, uint8_t *data, uint32_t off, uint32_t len);
+	int (*set_config)(struct virtio_user_dev *dev, const uint8_t *data, uint32_t off,
+			uint32_t len);
+	int (*cvq_enable)(struct virtio_user_dev *dev, int enable);
+	int (*enable_qp)(struct virtio_user_dev *dev, uint16_t pair_idx, int enable);
+	int (*dma_map)(struct virtio_user_dev *dev, void *addr, uint64_t iova, size_t len);
+	int (*dma_unmap)(struct virtio_user_dev *dev, void *addr, uint64_t iova, size_t len);
+	int (*update_link_state)(struct virtio_user_dev *dev);
+	int (*server_disconnect)(struct virtio_user_dev *dev);
+	int (*server_reconnect)(struct virtio_user_dev *dev);
+	int (*get_intr_fd)(struct virtio_user_dev *dev);
+	int (*map_notification_area)(struct virtio_user_dev *dev);
+	int (*unmap_notification_area)(struct virtio_user_dev *dev);
+};
+
+extern struct virtio_user_backend_ops virtio_ops_vdpa;
+
+#endif
diff --git a/drivers/crypto/virtio/virtio_user/vhost_vdpa.c b/drivers/crypto/virtio/virtio_user/vhost_vdpa.c
new file mode 100644
index 0000000000..b5839875e6
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_user/vhost_vdpa.c
@@ -0,0 +1,710 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell
+ */
+
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <rte_memory.h>
+
+#include "vhost.h"
+#include "virtio_user_dev.h"
+#include "../virtio_pci.h"
+
+struct vhost_vdpa_data {
+	int vhostfd;
+	uint64_t protocol_features;
+};
+
+#define VHOST_VDPA_SUPPORTED_BACKEND_FEATURES		\
+	(1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2	|	\
+	1ULL << VHOST_BACKEND_F_IOTLB_BATCH)
+
+/* vhost kernel & vdpa ioctls */
+#define VHOST_VIRTIO 0xAF
+#define VHOST_GET_FEATURES _IOR(VHOST_VIRTIO, 0x00, __u64)
+#define VHOST_SET_FEATURES _IOW(VHOST_VIRTIO, 0x00, __u64)
+#define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
+#define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
+#define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
+#define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
+#define VHOST_SET_VRING_NUM _IOW(VHOST_VIRTIO, 0x10, struct vhost_vring_state)
+#define VHOST_SET_VRING_ADDR _IOW(VHOST_VIRTIO, 0x11, struct vhost_vring_addr)
+#define VHOST_SET_VRING_BASE _IOW(VHOST_VIRTIO, 0x12, struct vhost_vring_state)
+#define VHOST_GET_VRING_BASE _IOWR(VHOST_VIRTIO, 0x12, struct vhost_vring_state)
+#define VHOST_SET_VRING_KICK _IOW(VHOST_VIRTIO, 0x20, struct vhost_vring_file)
+#define VHOST_SET_VRING_CALL _IOW(VHOST_VIRTIO, 0x21, struct vhost_vring_file)
+#define VHOST_SET_VRING_ERR _IOW(VHOST_VIRTIO, 0x22, struct vhost_vring_file)
+#define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
+#define VHOST_VDPA_GET_DEVICE_ID _IOR(VHOST_VIRTIO, 0x70, __u32)
+#define VHOST_VDPA_GET_STATUS _IOR(VHOST_VIRTIO, 0x71, __u8)
+#define VHOST_VDPA_SET_STATUS _IOW(VHOST_VIRTIO, 0x72, __u8)
+#define VHOST_VDPA_GET_CONFIG _IOR(VHOST_VIRTIO, 0x73, struct vhost_vdpa_config)
+#define VHOST_VDPA_SET_CONFIG _IOW(VHOST_VIRTIO, 0x74, struct vhost_vdpa_config)
+#define VHOST_VDPA_SET_VRING_ENABLE _IOW(VHOST_VIRTIO, 0x75, struct vhost_vring_state)
+#define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
+#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
+
+/* no alignment requirement */
+struct vhost_iotlb_msg {
+	uint64_t iova;
+	uint64_t size;
+	uint64_t uaddr;
+#define VHOST_ACCESS_RO      0x1
+#define VHOST_ACCESS_WO      0x2
+#define VHOST_ACCESS_RW      0x3
+	uint8_t perm;
+#define VHOST_IOTLB_MISS           1
+#define VHOST_IOTLB_UPDATE         2
+#define VHOST_IOTLB_INVALIDATE     3
+#define VHOST_IOTLB_ACCESS_FAIL    4
+#define VHOST_IOTLB_BATCH_BEGIN    5
+#define VHOST_IOTLB_BATCH_END      6
+	uint8_t type;
+};
+
+#define VHOST_IOTLB_MSG_V2 0x2
+
+struct vhost_vdpa_config {
+	uint32_t off;
+	uint32_t len;
+	uint8_t buf[];
+};
+
+struct vhost_msg {
+	uint32_t type;
+	uint32_t reserved;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		uint8_t padding[64];
+	};
+};
+
+static int
+vhost_vdpa_ioctl(int fd, uint64_t request, void *arg)
+{
+	int ret;
+
+	ret = ioctl(fd, request, arg);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Vhost-vDPA ioctl %"PRIu64" failed (%s)",
+				request, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vhost_vdpa_set_owner(struct virtio_user_dev *dev)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_OWNER, NULL);
+}
+
+static int
+vhost_vdpa_get_protocol_features(struct virtio_user_dev *dev, uint64_t *features)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_GET_BACKEND_FEATURES, features);
+}
+
+static int
+vhost_vdpa_set_protocol_features(struct virtio_user_dev *dev, uint64_t features)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_BACKEND_FEATURES, &features);
+}
+
+static int
+vhost_vdpa_get_features(struct virtio_user_dev *dev, uint64_t *features)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+	int ret;
+
+	ret = vhost_vdpa_ioctl(data->vhostfd, VHOST_GET_FEATURES, features);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get features");
+		return -1;
+	}
+
+	/* Negotiated vDPA backend features */
+	ret = vhost_vdpa_get_protocol_features(dev, &data->protocol_features);
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR, "Failed to get backend features");
+		return -1;
+	}
+
+	data->protocol_features &= VHOST_VDPA_SUPPORTED_BACKEND_FEATURES;
+
+	ret = vhost_vdpa_set_protocol_features(dev, data->protocol_features);
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR, "Failed to set backend features");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vhost_vdpa_set_features(struct virtio_user_dev *dev, uint64_t features)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	/* WORKAROUND */
+	features |= 1ULL << VIRTIO_F_IOMMU_PLATFORM;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_FEATURES, &features);
+}
+
+static int
+vhost_vdpa_iotlb_batch_begin(struct virtio_user_dev *dev)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+	struct vhost_msg msg = {};
+
+	if (!(data->protocol_features & (1ULL << VHOST_BACKEND_F_IOTLB_BATCH)))
+		return 0;
+
+	if (!(data->protocol_features & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2))) {
+		PMD_DRV_LOG(ERR, "IOTLB_MSG_V2 not supported by the backend.");
+		return -1;
+	}
+
+	msg.type = VHOST_IOTLB_MSG_V2;
+	msg.iotlb.type = VHOST_IOTLB_BATCH_BEGIN;
+
+	if (write(data->vhostfd, &msg, sizeof(msg)) != sizeof(msg)) {
+		PMD_DRV_LOG(ERR, "Failed to send IOTLB batch begin (%s)",
+				strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vhost_vdpa_iotlb_batch_end(struct virtio_user_dev *dev)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+	struct vhost_msg msg = {};
+
+	if (!(data->protocol_features & (1ULL << VHOST_BACKEND_F_IOTLB_BATCH)))
+		return 0;
+
+	if (!(data->protocol_features & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2))) {
+		PMD_DRV_LOG(ERR, "IOTLB_MSG_V2 not supported by the backend.");
+		return -1;
+	}
+
+	msg.type = VHOST_IOTLB_MSG_V2;
+	msg.iotlb.type = VHOST_IOTLB_BATCH_END;
+
+	if (write(data->vhostfd, &msg, sizeof(msg)) != sizeof(msg)) {
+		PMD_DRV_LOG(ERR, "Failed to send IOTLB batch end (%s)",
+				strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vhost_vdpa_dma_map(struct virtio_user_dev *dev, void *addr,
+				  uint64_t iova, size_t len)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+	struct vhost_msg msg = {};
+
+	if (!(data->protocol_features & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2))) {
+		PMD_DRV_LOG(ERR, "IOTLB_MSG_V2 not supported by the backend.");
+		return -1;
+	}
+
+	msg.type = VHOST_IOTLB_MSG_V2;
+	msg.iotlb.type = VHOST_IOTLB_UPDATE;
+	msg.iotlb.iova = iova;
+	msg.iotlb.uaddr = (uint64_t)(uintptr_t)addr;
+	msg.iotlb.size = len;
+	msg.iotlb.perm = VHOST_ACCESS_RW;
+
+	PMD_DRV_LOG(DEBUG, "%s: iova: 0x%" PRIx64 ", addr: %p, len: 0x%zx",
+			__func__, iova, addr, len);
+
+	if (write(data->vhostfd, &msg, sizeof(msg)) != sizeof(msg)) {
+		PMD_DRV_LOG(ERR, "Failed to send IOTLB update (%s)",
+				strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vhost_vdpa_dma_unmap(struct virtio_user_dev *dev, __rte_unused void *addr,
+				  uint64_t iova, size_t len)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+	struct vhost_msg msg = {};
+
+	if (!(data->protocol_features & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2))) {
+		PMD_DRV_LOG(ERR, "IOTLB_MSG_V2 not supported by the backend.");
+		return -1;
+	}
+
+	msg.type = VHOST_IOTLB_MSG_V2;
+	msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
+	msg.iotlb.iova = iova;
+	msg.iotlb.size = len;
+
+	PMD_DRV_LOG(DEBUG, "%s: iova: 0x%" PRIx64 ", len: 0x%zx",
+			__func__, iova, len);
+
+	if (write(data->vhostfd, &msg, sizeof(msg)) != sizeof(msg)) {
+		PMD_DRV_LOG(ERR, "Failed to send IOTLB invalidate (%s)",
+				strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+vhost_vdpa_dma_map_batch(struct virtio_user_dev *dev, void *addr,
+				  uint64_t iova, size_t len)
+{
+	int ret;
+
+	if (vhost_vdpa_iotlb_batch_begin(dev) < 0)
+		return -1;
+
+	ret = vhost_vdpa_dma_map(dev, addr, iova, len);
+
+	if (vhost_vdpa_iotlb_batch_end(dev) < 0)
+		return -1;
+
+	return ret;
+}
+
+static int
+vhost_vdpa_dma_unmap_batch(struct virtio_user_dev *dev, void *addr,
+				  uint64_t iova, size_t len)
+{
+	int ret;
+
+	if (vhost_vdpa_iotlb_batch_begin(dev) < 0)
+		return -1;
+
+	ret = vhost_vdpa_dma_unmap(dev, addr, iova, len);
+
+	if (vhost_vdpa_iotlb_batch_end(dev) < 0)
+		return -1;
+
+	return ret;
+}
+
+static int
+vhost_vdpa_map_contig(const struct rte_memseg_list *msl,
+		const struct rte_memseg *ms, size_t len, void *arg)
+{
+	struct virtio_user_dev *dev = arg;
+
+	if (msl->external)
+		return 0;
+
+	return vhost_vdpa_dma_map(dev, ms->addr, ms->iova, len);
+}
+
+static int
+vhost_vdpa_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
+		void *arg)
+{
+	struct virtio_user_dev *dev = arg;
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
+	return vhost_vdpa_dma_map(dev, ms->addr, ms->iova, ms->len);
+}
+
+static int
+vhost_vdpa_set_memory_table(struct virtio_user_dev *dev)
+{
+	int ret;
+
+	if (vhost_vdpa_iotlb_batch_begin(dev) < 0)
+		return -1;
+
+	vhost_vdpa_dma_unmap(dev, NULL, 0, SIZE_MAX);
+
+	if (rte_eal_iova_mode() == RTE_IOVA_VA) {
+		/* with IOVA as VA mode, we can get away with mapping contiguous
+		 * chunks rather than going page-by-page.
+		 */
+		ret = rte_memseg_contig_walk_thread_unsafe(
+				vhost_vdpa_map_contig, dev);
+		if (ret)
+			goto batch_end;
+		/* we have to continue the walk because we've skipped the
+		 * external segments during the config walk.
+		 */
+	}
+	ret = rte_memseg_walk_thread_unsafe(vhost_vdpa_map, dev);
+
+batch_end:
+	if (vhost_vdpa_iotlb_batch_end(dev) < 0)
+		return -1;
+
+	return ret;
+}
+
+static int
+vhost_vdpa_set_vring_enable(struct virtio_user_dev *dev, struct vhost_vring_state *state)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_VDPA_SET_VRING_ENABLE, state);
+}
+
+static int
+vhost_vdpa_set_vring_num(struct virtio_user_dev *dev, struct vhost_vring_state *state)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_VRING_NUM, state);
+}
+
+static int
+vhost_vdpa_set_vring_base(struct virtio_user_dev *dev, struct vhost_vring_state *state)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_VRING_BASE, state);
+}
+
+static int
+vhost_vdpa_get_vring_base(struct virtio_user_dev *dev, struct vhost_vring_state *state)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_GET_VRING_BASE, state);
+}
+
+static int
+vhost_vdpa_set_vring_call(struct virtio_user_dev *dev, struct vhost_vring_file *file)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_VRING_CALL, file);
+}
+
+static int
+vhost_vdpa_set_vring_kick(struct virtio_user_dev *dev, struct vhost_vring_file *file)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_VRING_KICK, file);
+}
+
+static int
+vhost_vdpa_set_vring_addr(struct virtio_user_dev *dev, struct vhost_vring_addr *addr)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_SET_VRING_ADDR, addr);
+}
+
+static int
+vhost_vdpa_get_status(struct virtio_user_dev *dev, uint8_t *status)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_VDPA_GET_STATUS, status);
+}
+
+static int
+vhost_vdpa_set_status(struct virtio_user_dev *dev, uint8_t status)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	return vhost_vdpa_ioctl(data->vhostfd, VHOST_VDPA_SET_STATUS, &status);
+}
+
+static int
+vhost_vdpa_get_config(struct virtio_user_dev *dev, uint8_t *data, uint32_t off, uint32_t len)
+{
+	struct vhost_vdpa_data *vdpa_data = dev->backend_data;
+	struct vhost_vdpa_config *config;
+	int ret = 0;
+
+	config = malloc(sizeof(*config) + len);
+	if (!config) {
+		PMD_DRV_LOG(ERR, "Failed to allocate vDPA config data");
+		return -1;
+	}
+
+	config->off = off;
+	config->len = len;
+
+	ret = vhost_vdpa_ioctl(vdpa_data->vhostfd, VHOST_VDPA_GET_CONFIG, config);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get vDPA config (offset 0x%x, len 0x%x)", off, len);
+		ret = -1;
+		goto out;
+	}
+
+	memcpy(data, config->buf, len);
+out:
+	free(config);
+
+	return ret;
+}
+
+static int
+vhost_vdpa_set_config(struct virtio_user_dev *dev, const uint8_t *data, uint32_t off, uint32_t len)
+{
+	struct vhost_vdpa_data *vdpa_data = dev->backend_data;
+	struct vhost_vdpa_config *config;
+	int ret = 0;
+
+	config = malloc(sizeof(*config) + len);
+	if (!config) {
+		PMD_DRV_LOG(ERR, "Failed to allocate vDPA config data");
+		return -1;
+	}
+
+	config->off = off;
+	config->len = len;
+
+	memcpy(config->buf, data, len);
+
+	ret = vhost_vdpa_ioctl(vdpa_data->vhostfd, VHOST_VDPA_SET_CONFIG, config);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to set vDPA config (offset 0x%x, len 0x%x)", off, len);
+		ret = -1;
+	}
+
+	free(config);
+
+	return ret;
+}
+
+/**
+ * Set up environment to talk with a vhost vdpa backend.
+ *
+ * @return
+ *   - (-1) if fail to set up;
+ *   - (>=0) if successful.
+ */
+static int
+vhost_vdpa_setup(struct virtio_user_dev *dev)
+{
+	struct vhost_vdpa_data *data;
+	uint32_t did = (uint32_t)-1;
+
+	data = malloc(sizeof(*data));
+	if (!data) {
+		PMD_DRV_LOG(ERR, "(%s) Faidle to allocate backend data", dev->path);
+		return -1;
+	}
+
+	data->vhostfd = open(dev->path, O_RDWR);
+	if (data->vhostfd < 0) {
+		PMD_DRV_LOG(ERR, "Failed to open %s: %s",
+				dev->path, strerror(errno));
+		free(data);
+		return -1;
+	}
+
+	if (ioctl(data->vhostfd, VHOST_VDPA_GET_DEVICE_ID, &did) < 0 ||
+			did != VIRTIO_ID_CRYPTO) {
+		PMD_DRV_LOG(ERR, "Invalid vdpa device ID: %u", did);
+		close(data->vhostfd);
+		free(data);
+		return -1;
+	}
+
+	dev->backend_data = data;
+
+	return 0;
+}
+
+static int
+vhost_vdpa_destroy(struct virtio_user_dev *dev)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+
+	if (!data)
+		return 0;
+
+	close(data->vhostfd);
+
+	free(data);
+	dev->backend_data = NULL;
+
+	return 0;
+}
+
+static int
+vhost_vdpa_cvq_enable(struct virtio_user_dev *dev, int enable)
+{
+	struct vhost_vring_state state = {
+		.index = dev->max_queue_pairs,
+		.num   = enable,
+	};
+
+	return vhost_vdpa_set_vring_enable(dev, &state);
+}
+
+static int
+vhost_vdpa_enable_queue_pair(struct virtio_user_dev *dev,
+				uint16_t pair_idx,
+				int enable)
+{
+	struct vhost_vring_state state = {
+		.index = pair_idx,
+		.num   = enable,
+	};
+
+	if (dev->qp_enabled[pair_idx] == enable)
+		return 0;
+
+	if (vhost_vdpa_set_vring_enable(dev, &state))
+		return -1;
+
+	dev->qp_enabled[pair_idx] = enable;
+	return 0;
+}
+
+static int
+vhost_vdpa_get_backend_features(uint64_t *features)
+{
+	*features = 0;
+
+	return 0;
+}
+
+static int
+vhost_vdpa_update_link_state(struct virtio_user_dev *dev)
+{
+	/* TODO: It is W/A until a cleaner approach to find cpt status */
+	dev->crypto_status = VIRTIO_CRYPTO_S_HW_READY;
+	return 0;
+}
+
+static int
+vhost_vdpa_get_intr_fd(struct virtio_user_dev *dev __rte_unused)
+{
+	/* No link state interrupt with Vhost-vDPA */
+	return -1;
+}
+
+static int
+vhost_vdpa_get_nr_vrings(struct virtio_user_dev *dev)
+{
+	int nr_vrings = dev->max_queue_pairs;
+
+	return nr_vrings;
+}
+
+static int
+vhost_vdpa_unmap_notification_area(struct virtio_user_dev *dev)
+{
+	int i, nr_vrings;
+
+	nr_vrings = vhost_vdpa_get_nr_vrings(dev);
+
+	for (i = 0; i < nr_vrings; i++) {
+		if (dev->notify_area[i])
+			munmap(dev->notify_area[i], getpagesize());
+	}
+	free(dev->notify_area);
+	dev->notify_area = NULL;
+
+	return 0;
+}
+
+static int
+vhost_vdpa_map_notification_area(struct virtio_user_dev *dev)
+{
+	struct vhost_vdpa_data *data = dev->backend_data;
+	int nr_vrings, i, page_size = getpagesize();
+	uint16_t **notify_area;
+
+	nr_vrings = vhost_vdpa_get_nr_vrings(dev);
+
+	/* CQ is another vring */
+	nr_vrings++;
+
+	notify_area = malloc(nr_vrings * sizeof(*notify_area));
+	if (!notify_area) {
+		PMD_DRV_LOG(ERR, "(%s) Failed to allocate notify area array", dev->path);
+		return -1;
+	}
+
+	for (i = 0; i < nr_vrings; i++) {
+		notify_area[i] = mmap(NULL, page_size, PROT_WRITE, MAP_SHARED | MAP_FILE,
+					data->vhostfd, i * page_size);
+		if (notify_area[i] == MAP_FAILED) {
+			PMD_DRV_LOG(ERR, "(%s) Map failed for notify address of queue %d",
+					dev->path, i);
+			i--;
+			goto map_err;
+		}
+	}
+	dev->notify_area = notify_area;
+
+	return 0;
+
+map_err:
+	for (; i >= 0; i--)
+		munmap(notify_area[i], page_size);
+	free(notify_area);
+
+	return -1;
+}
+
+struct virtio_user_backend_ops virtio_crypto_ops_vdpa = {
+	.setup = vhost_vdpa_setup,
+	.destroy = vhost_vdpa_destroy,
+	.get_backend_features = vhost_vdpa_get_backend_features,
+	.set_owner = vhost_vdpa_set_owner,
+	.get_features = vhost_vdpa_get_features,
+	.set_features = vhost_vdpa_set_features,
+	.set_memory_table = vhost_vdpa_set_memory_table,
+	.set_vring_num = vhost_vdpa_set_vring_num,
+	.set_vring_base = vhost_vdpa_set_vring_base,
+	.get_vring_base = vhost_vdpa_get_vring_base,
+	.set_vring_call = vhost_vdpa_set_vring_call,
+	.set_vring_kick = vhost_vdpa_set_vring_kick,
+	.set_vring_addr = vhost_vdpa_set_vring_addr,
+	.get_status = vhost_vdpa_get_status,
+	.set_status = vhost_vdpa_set_status,
+	.get_config = vhost_vdpa_get_config,
+	.set_config = vhost_vdpa_set_config,
+	.cvq_enable = vhost_vdpa_cvq_enable,
+	.enable_qp = vhost_vdpa_enable_queue_pair,
+	.dma_map = vhost_vdpa_dma_map_batch,
+	.dma_unmap = vhost_vdpa_dma_unmap_batch,
+	.update_link_state = vhost_vdpa_update_link_state,
+	.get_intr_fd = vhost_vdpa_get_intr_fd,
+	.map_notification_area = vhost_vdpa_map_notification_area,
+	.unmap_notification_area = vhost_vdpa_unmap_notification_area,
+};
diff --git a/drivers/crypto/virtio/virtio_user/virtio_user_dev.c b/drivers/crypto/virtio/virtio_user/virtio_user_dev.c
new file mode 100644
index 0000000000..248df11ccc
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_user/virtio_user_dev.c
@@ -0,0 +1,767 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <sys/eventfd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <pthread.h>
+
+#include <rte_alarm.h>
+#include <rte_string_fns.h>
+#include <rte_eal_memconfig.h>
+#include <rte_malloc.h>
+#include <rte_io.h>
+
+#include "vhost.h"
+#include "virtio_logs.h"
+#include "cryptodev_pmd.h"
+#include "virtio_crypto.h"
+#include "virtio_cvq.h"
+#include "virtio_user_dev.h"
+#include "virtqueue.h"
+
+#define VIRTIO_USER_MEM_EVENT_CLB_NAME "virtio_user_mem_event_clb"
+
+const char * const crypto_virtio_user_backend_strings[] = {
+	[VIRTIO_USER_BACKEND_UNKNOWN] = "VIRTIO_USER_BACKEND_UNKNOWN",
+	[VIRTIO_USER_BACKEND_VHOST_VDPA] = "VHOST_VDPA",
+};
+
+static int
+virtio_user_uninit_notify_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
+{
+	if (dev->kickfds[queue_sel] >= 0) {
+		close(dev->kickfds[queue_sel]);
+		dev->kickfds[queue_sel] = -1;
+	}
+
+	if (dev->callfds[queue_sel] >= 0) {
+		close(dev->callfds[queue_sel]);
+		dev->callfds[queue_sel] = -1;
+	}
+
+	return 0;
+}
+
+static int
+virtio_user_init_notify_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
+{
+	/* May use invalid flag, but some backend uses kickfd and
+	 * callfd as criteria to judge if dev is alive. so finally we
+	 * use real event_fd.
+	 */
+	dev->callfds[queue_sel] = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK);
+	if (dev->callfds[queue_sel] < 0) {
+		PMD_DRV_LOG(ERR, "(%s) Failed to setup callfd for queue %u: %s",
+				dev->path, queue_sel, strerror(errno));
+		return -1;
+	}
+	dev->kickfds[queue_sel] = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK);
+	if (dev->kickfds[queue_sel] < 0) {
+		PMD_DRV_LOG(ERR, "(%s) Failed to setup kickfd for queue %u: %s",
+				dev->path, queue_sel, strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+virtio_user_destroy_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
+{
+	struct vhost_vring_state state;
+	int ret;
+
+	state.index = queue_sel;
+	ret = dev->ops->get_vring_base(dev, &state);
+	if (ret < 0) {
+		PMD_DRV_LOG(ERR, "(%s) Failed to destroy queue %u", dev->path, queue_sel);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+virtio_user_create_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
+{
+	/* Of all per virtqueue MSGs, make sure VHOST_SET_VRING_CALL come
+	 * firstly because vhost depends on this msg to allocate virtqueue
+	 * pair.
+	 */
+	struct vhost_vring_file file;
+	int ret;
+
+	file.index = queue_sel;
+	file.fd = dev->callfds[queue_sel];
+	ret = dev->ops->set_vring_call(dev, &file);
+	if (ret < 0) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to create queue %u", dev->path, queue_sel);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+virtio_user_kick_queue(struct virtio_user_dev *dev, uint32_t queue_sel)
+{
+	int ret;
+	struct vhost_vring_file file;
+	struct vhost_vring_state state;
+	struct vring *vring = &dev->vrings.split[queue_sel];
+	struct vring_packed *pq_vring = &dev->vrings.packed[queue_sel];
+	uint64_t desc_addr, avail_addr, used_addr;
+	struct vhost_vring_addr addr = {
+		.index = queue_sel,
+		.log_guest_addr = 0,
+		.flags = 0, /* disable log */
+	};
+
+	if (queue_sel == dev->max_queue_pairs) {
+		if (!dev->scvq) {
+			PMD_INIT_LOG(ERR, "(%s) Shadow control queue expected but missing",
+					dev->path);
+			goto err;
+		}
+
+		/* Use shadow control queue information */
+		vring = &dev->scvq->vq_split.ring;
+		pq_vring = &dev->scvq->vq_packed.ring;
+	}
+
+	if (dev->features & (1ULL << VIRTIO_F_RING_PACKED)) {
+		desc_addr = pq_vring->desc_iova;
+		avail_addr = desc_addr + pq_vring->num * sizeof(struct vring_packed_desc);
+		used_addr =  RTE_ALIGN_CEIL(avail_addr + sizeof(struct vring_packed_desc_event),
+						VIRTIO_VRING_ALIGN);
+
+		addr.desc_user_addr = desc_addr;
+		addr.avail_user_addr = avail_addr;
+		addr.used_user_addr = used_addr;
+	} else {
+		desc_addr = vring->desc_iova;
+		avail_addr = desc_addr + vring->num * sizeof(struct vring_desc);
+		used_addr = RTE_ALIGN_CEIL((uintptr_t)(&vring->avail->ring[vring->num]),
+					VIRTIO_VRING_ALIGN);
+
+		addr.desc_user_addr = desc_addr;
+		addr.avail_user_addr = avail_addr;
+		addr.used_user_addr = used_addr;
+	}
+
+	state.index = queue_sel;
+	state.num = vring->num;
+	ret = dev->ops->set_vring_num(dev, &state);
+	if (ret < 0)
+		goto err;
+
+	state.index = queue_sel;
+	state.num = 0; /* no reservation */
+	if (dev->features & (1ULL << VIRTIO_F_RING_PACKED))
+		state.num |= (1 << 15);
+	ret = dev->ops->set_vring_base(dev, &state);
+	if (ret < 0)
+		goto err;
+
+	ret = dev->ops->set_vring_addr(dev, &addr);
+	if (ret < 0)
+		goto err;
+
+	/* Of all per virtqueue MSGs, make sure VHOST_USER_SET_VRING_KICK comes
+	 * lastly because vhost depends on this msg to judge if
+	 * virtio is ready.
+	 */
+	file.index = queue_sel;
+	file.fd = dev->kickfds[queue_sel];
+	ret = dev->ops->set_vring_kick(dev, &file);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+err:
+	PMD_INIT_LOG(ERR, "(%s) Failed to kick queue %u", dev->path, queue_sel);
+
+	return -1;
+}
+
+static int
+virtio_user_foreach_queue(struct virtio_user_dev *dev,
+			int (*fn)(struct virtio_user_dev *, uint32_t))
+{
+	uint32_t i, nr_vq;
+
+	nr_vq = dev->max_queue_pairs;
+
+	for (i = 0; i < nr_vq; i++)
+		if (fn(dev, i) < 0)
+			return -1;
+
+	return 0;
+}
+
+int
+crypto_virtio_user_dev_set_features(struct virtio_user_dev *dev)
+{
+	uint64_t features;
+	int ret = -1;
+
+	pthread_mutex_lock(&dev->mutex);
+
+	/* Step 0: tell vhost to create queues */
+	if (virtio_user_foreach_queue(dev, virtio_user_create_queue) < 0)
+		goto error;
+
+	features = dev->features;
+
+	ret = dev->ops->set_features(dev, features);
+	if (ret < 0)
+		goto error;
+	PMD_DRV_LOG(INFO, "(%s) set features: 0x%" PRIx64, dev->path, features);
+error:
+	pthread_mutex_unlock(&dev->mutex);
+
+	return ret;
+}
+
+int
+crypto_virtio_user_start_device(struct virtio_user_dev *dev)
+{
+	int ret;
+
+	/*
+	 * XXX workaround!
+	 *
+	 * We need to make sure that the locks will be
+	 * taken in the correct order to avoid deadlocks.
+	 *
+	 * Before releasing this lock, this thread should
+	 * not trigger any memory hotplug events.
+	 *
+	 * This is a temporary workaround, and should be
+	 * replaced when we get proper supports from the
+	 * memory subsystem in the future.
+	 */
+	rte_mcfg_mem_read_lock();
+	pthread_mutex_lock(&dev->mutex);
+
+	/* Step 2: share memory regions */
+	ret = dev->ops->set_memory_table(dev);
+	if (ret < 0)
+		goto error;
+
+	/* Step 3: kick queues */
+	ret = virtio_user_foreach_queue(dev, virtio_user_kick_queue);
+	if (ret < 0)
+		goto error;
+
+	ret = virtio_user_kick_queue(dev, dev->max_queue_pairs);
+	if (ret < 0)
+		goto error;
+
+	/* Step 4: enable queues */
+	for (int i = 0; i < dev->max_queue_pairs; i++) {
+		ret = dev->ops->enable_qp(dev, i, 1);
+		if (ret < 0)
+			goto error;
+	}
+
+	dev->started = true;
+
+	pthread_mutex_unlock(&dev->mutex);
+	rte_mcfg_mem_read_unlock();
+
+	return 0;
+error:
+	pthread_mutex_unlock(&dev->mutex);
+	rte_mcfg_mem_read_unlock();
+
+	PMD_INIT_LOG(ERR, "(%s) Failed to start device", dev->path);
+
+	/* TODO: free resource here or caller to check */
+	return -1;
+}
+
+int crypto_virtio_user_stop_device(struct virtio_user_dev *dev)
+{
+	uint32_t i;
+	int ret;
+
+	pthread_mutex_lock(&dev->mutex);
+	if (!dev->started)
+		goto out;
+
+	for (i = 0; i < dev->max_queue_pairs; ++i) {
+		ret = dev->ops->enable_qp(dev, i, 0);
+		if (ret < 0)
+			goto err;
+	}
+
+	if (dev->scvq) {
+		ret = dev->ops->cvq_enable(dev, 0);
+		if (ret < 0)
+			goto err;
+	}
+
+	/* Stop the backend. */
+	if (virtio_user_foreach_queue(dev, virtio_user_destroy_queue) < 0)
+		goto err;
+
+	dev->started = false;
+
+out:
+	pthread_mutex_unlock(&dev->mutex);
+
+	return 0;
+err:
+	pthread_mutex_unlock(&dev->mutex);
+
+	PMD_INIT_LOG(ERR, "(%s) Failed to stop device", dev->path);
+
+	return -1;
+}
+
+static int
+virtio_user_dev_init_max_queue_pairs(struct virtio_user_dev *dev, uint32_t user_max_qp)
+{
+	int ret;
+
+	if (!dev->ops->get_config) {
+		dev->max_queue_pairs = user_max_qp;
+		return 0;
+	}
+
+	ret = dev->ops->get_config(dev, (uint8_t *)&dev->max_queue_pairs,
+			offsetof(struct virtio_crypto_config, max_dataqueues),
+			sizeof(uint16_t));
+	if (ret) {
+		/*
+		 * We need to know the max queue pair from the device so that
+		 * the control queue gets the right index.
+		 */
+		dev->max_queue_pairs = 1;
+		PMD_DRV_LOG(ERR, "(%s) Failed to get max queue pairs from device", dev->path);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+virtio_user_dev_init_cipher_services(struct virtio_user_dev *dev)
+{
+	struct virtio_crypto_config config;
+	int ret;
+
+	dev->crypto_services = RTE_BIT32(VIRTIO_CRYPTO_SERVICE_CIPHER);
+	dev->cipher_algo = 0;
+	dev->auth_algo = 0;
+	dev->akcipher_algo = 0;
+
+	if (!dev->ops->get_config)
+		return 0;
+
+	ret = dev->ops->get_config(dev, (uint8_t *)&config,	0, sizeof(config));
+	if (ret) {
+		PMD_DRV_LOG(ERR, "(%s) Failed to get crypto config from device", dev->path);
+		return ret;
+	}
+
+	dev->crypto_services = config.crypto_services;
+	dev->cipher_algo = ((uint64_t)config.cipher_algo_h << 32) |
+						config.cipher_algo_l;
+	dev->hash_algo = config.hash_algo;
+	dev->auth_algo = ((uint64_t)config.mac_algo_h << 32) |
+						config.mac_algo_l;
+	dev->aead_algo = config.aead_algo;
+	dev->akcipher_algo = config.akcipher_algo;
+	return 0;
+}
+
+static int
+virtio_user_dev_init_notify(struct virtio_user_dev *dev)
+{
+
+	if (virtio_user_foreach_queue(dev, virtio_user_init_notify_queue) < 0)
+		goto err;
+
+	if (dev->device_features & (1ULL << VIRTIO_F_NOTIFICATION_DATA))
+		if (dev->ops->map_notification_area &&
+				dev->ops->map_notification_area(dev))
+			goto err;
+
+	return 0;
+err:
+	virtio_user_foreach_queue(dev, virtio_user_uninit_notify_queue);
+
+	return -1;
+}
+
+static void
+virtio_user_dev_uninit_notify(struct virtio_user_dev *dev)
+{
+	virtio_user_foreach_queue(dev, virtio_user_uninit_notify_queue);
+
+	if (dev->ops->unmap_notification_area && dev->notify_area)
+		dev->ops->unmap_notification_area(dev);
+}
+
+static void
+virtio_user_mem_event_cb(enum rte_mem_event type __rte_unused,
+			const void *addr,
+			size_t len __rte_unused,
+			void *arg)
+{
+	struct virtio_user_dev *dev = arg;
+	struct rte_memseg_list *msl;
+	uint16_t i;
+	int ret = 0;
+
+	/* ignore externally allocated memory */
+	msl = rte_mem_virt2memseg_list(addr);
+	if (msl->external)
+		return;
+
+	pthread_mutex_lock(&dev->mutex);
+
+	if (dev->started == false)
+		goto exit;
+
+	/* Step 1: pause the active queues */
+	for (i = 0; i < dev->queue_pairs; i++) {
+		ret = dev->ops->enable_qp(dev, i, 0);
+		if (ret < 0)
+			goto exit;
+	}
+
+	/* Step 2: update memory regions */
+	ret = dev->ops->set_memory_table(dev);
+	if (ret < 0)
+		goto exit;
+
+	/* Step 3: resume the active queues */
+	for (i = 0; i < dev->queue_pairs; i++) {
+		ret = dev->ops->enable_qp(dev, i, 1);
+		if (ret < 0)
+			goto exit;
+	}
+
+exit:
+	pthread_mutex_unlock(&dev->mutex);
+
+	if (ret < 0)
+		PMD_DRV_LOG(ERR, "(%s) Failed to update memory table", dev->path);
+}
+
+static int
+virtio_user_dev_setup(struct virtio_user_dev *dev)
+{
+	if (dev->is_server) {
+		if (dev->backend_type != VIRTIO_USER_BACKEND_VHOST_USER) {
+			PMD_DRV_LOG(ERR, "Server mode only supports vhost-user!");
+			return -1;
+		}
+	}
+
+	switch (dev->backend_type) {
+	case VIRTIO_USER_BACKEND_VHOST_VDPA:
+		dev->ops = &virtio_crypto_ops_vdpa;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "(%s) Unknown backend type", dev->path);
+		return -1;
+	}
+
+	if (dev->ops->setup(dev) < 0) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to setup backend", dev->path);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+virtio_user_alloc_vrings(struct virtio_user_dev *dev)
+{
+	int i, size, nr_vrings;
+	bool packed_ring = !!(dev->device_features & (1ull << VIRTIO_F_RING_PACKED));
+
+	nr_vrings = dev->max_queue_pairs + 1;
+
+	dev->callfds = rte_zmalloc("virtio_user_dev", nr_vrings * sizeof(*dev->callfds), 0);
+	if (!dev->callfds) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to alloc callfds", dev->path);
+		return -1;
+	}
+
+	dev->kickfds = rte_zmalloc("virtio_user_dev", nr_vrings * sizeof(*dev->kickfds), 0);
+	if (!dev->kickfds) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to alloc kickfds", dev->path);
+		goto free_callfds;
+	}
+
+	for (i = 0; i < nr_vrings; i++) {
+		dev->callfds[i] = -1;
+		dev->kickfds[i] = -1;
+	}
+
+	if (packed_ring)
+		size = sizeof(*dev->vrings.packed);
+	else
+		size = sizeof(*dev->vrings.split);
+	dev->vrings.ptr = rte_zmalloc("virtio_user_dev", nr_vrings * size, 0);
+	if (!dev->vrings.ptr) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to alloc vrings metadata", dev->path);
+		goto free_kickfds;
+	}
+
+	if (packed_ring) {
+		dev->packed_queues = rte_zmalloc("virtio_user_dev",
+				nr_vrings * sizeof(*dev->packed_queues), 0);
+		if (!dev->packed_queues) {
+			PMD_INIT_LOG(ERR, "(%s) Failed to alloc packed queues metadata",
+					dev->path);
+			goto free_vrings;
+		}
+	}
+
+	dev->qp_enabled = rte_zmalloc("virtio_user_dev",
+			nr_vrings * sizeof(*dev->qp_enabled), 0);
+	if (!dev->qp_enabled) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to alloc QP enable states", dev->path);
+		goto free_packed_queues;
+	}
+
+	return 0;
+
+free_packed_queues:
+	rte_free(dev->packed_queues);
+	dev->packed_queues = NULL;
+free_vrings:
+	rte_free(dev->vrings.ptr);
+	dev->vrings.ptr = NULL;
+free_kickfds:
+	rte_free(dev->kickfds);
+	dev->kickfds = NULL;
+free_callfds:
+	rte_free(dev->callfds);
+	dev->callfds = NULL;
+
+	return -1;
+}
+
+static void
+virtio_user_free_vrings(struct virtio_user_dev *dev)
+{
+	rte_free(dev->qp_enabled);
+	dev->qp_enabled = NULL;
+	rte_free(dev->packed_queues);
+	dev->packed_queues = NULL;
+	rte_free(dev->vrings.ptr);
+	dev->vrings.ptr = NULL;
+	rte_free(dev->kickfds);
+	dev->kickfds = NULL;
+	rte_free(dev->callfds);
+	dev->callfds = NULL;
+}
+
+#define VIRTIO_USER_SUPPORTED_FEATURES   \
+	(1ULL << VIRTIO_CRYPTO_SERVICE_CIPHER     | \
+	 1ULL << VIRTIO_CRYPTO_SERVICE_HASH       | \
+	 1ULL << VIRTIO_CRYPTO_SERVICE_AKCIPHER   | \
+	 1ULL << VIRTIO_F_VERSION_1               | \
+	 1ULL << VIRTIO_F_IN_ORDER                | \
+	 1ULL << VIRTIO_F_RING_PACKED             | \
+	 1ULL << VIRTIO_F_NOTIFICATION_DATA       | \
+	 1ULL << VIRTIO_F_ORDER_PLATFORM)
+
+int
+crypto_virtio_user_dev_init(struct virtio_user_dev *dev, char *path, uint16_t queues,
+			int queue_size, int server)
+{
+	uint64_t backend_features;
+
+	pthread_mutex_init(&dev->mutex, NULL);
+	strlcpy(dev->path, path, PATH_MAX);
+
+	dev->started = 0;
+	dev->queue_pairs = 1; /* mq disabled by default */
+	dev->max_queue_pairs = queues; /* initialize to user requested value for kernel backend */
+	dev->queue_size = queue_size;
+	dev->is_server = server;
+	dev->frontend_features = 0;
+	dev->unsupported_features = 0;
+	dev->backend_type = VIRTIO_USER_BACKEND_VHOST_VDPA;
+	dev->hw.modern = 1;
+
+	if (virtio_user_dev_setup(dev) < 0) {
+		PMD_INIT_LOG(ERR, "(%s) backend set up fails", dev->path);
+		return -1;
+	}
+
+	if (dev->ops->set_owner(dev) < 0) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to set backend owner", dev->path);
+		goto destroy;
+	}
+
+	if (dev->ops->get_backend_features(&backend_features) < 0) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to get backend features", dev->path);
+		goto destroy;
+	}
+
+	dev->unsupported_features = ~(VIRTIO_USER_SUPPORTED_FEATURES | backend_features);
+
+	if (dev->ops->get_features(dev, &dev->device_features) < 0) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to get device features", dev->path);
+		goto destroy;
+	}
+
+	if (virtio_user_dev_init_max_queue_pairs(dev, queues)) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to get max queue pairs", dev->path);
+		goto destroy;
+	}
+
+	if (virtio_user_dev_init_cipher_services(dev)) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to get cipher services", dev->path);
+		goto destroy;
+	}
+
+	dev->frontend_features &= ~dev->unsupported_features;
+	dev->device_features &= ~dev->unsupported_features;
+
+	if (virtio_user_alloc_vrings(dev) < 0) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to allocate vring metadata", dev->path);
+		goto destroy;
+	}
+
+	if (virtio_user_dev_init_notify(dev) < 0) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to init notifiers", dev->path);
+		goto free_vrings;
+	}
+
+	if (rte_mem_event_callback_register(VIRTIO_USER_MEM_EVENT_CLB_NAME,
+				virtio_user_mem_event_cb, dev)) {
+		if (rte_errno != ENOTSUP) {
+			PMD_INIT_LOG(ERR, "(%s) Failed to register mem event callback",
+					dev->path);
+			goto notify_uninit;
+		}
+	}
+
+	return 0;
+
+notify_uninit:
+	virtio_user_dev_uninit_notify(dev);
+free_vrings:
+	virtio_user_free_vrings(dev);
+destroy:
+	dev->ops->destroy(dev);
+
+	return -1;
+}
+
+void
+crypto_virtio_user_dev_uninit(struct virtio_user_dev *dev)
+{
+	crypto_virtio_user_stop_device(dev);
+
+	rte_mem_event_callback_unregister(VIRTIO_USER_MEM_EVENT_CLB_NAME, dev);
+
+	virtio_user_dev_uninit_notify(dev);
+
+	virtio_user_free_vrings(dev);
+
+	if (dev->is_server)
+		unlink(dev->path);
+
+	dev->ops->destroy(dev);
+}
+
+#define CVQ_MAX_DATA_DESCS 32
+
+static inline void *
+virtio_user_iova2virt(struct virtio_user_dev *dev __rte_unused, rte_iova_t iova)
+{
+	if (rte_eal_iova_mode() == RTE_IOVA_VA)
+		return (void *)(uintptr_t)iova;
+	else
+		return rte_mem_iova2virt(iova);
+}
+
+static inline int
+desc_is_avail(struct vring_packed_desc *desc, bool wrap_counter)
+{
+	uint16_t flags = rte_atomic_load_explicit(&desc->flags, rte_memory_order_acquire);
+
+	return wrap_counter == !!(flags & VRING_PACKED_DESC_F_AVAIL) &&
+		wrap_counter != !!(flags & VRING_PACKED_DESC_F_USED);
+}
+
+int
+crypto_virtio_user_dev_set_status(struct virtio_user_dev *dev, uint8_t status)
+{
+	int ret;
+
+	pthread_mutex_lock(&dev->mutex);
+	dev->status = status;
+	ret = dev->ops->set_status(dev, status);
+	if (ret && ret != -ENOTSUP)
+		PMD_INIT_LOG(ERR, "(%s) Failed to set backend status", dev->path);
+
+	pthread_mutex_unlock(&dev->mutex);
+	return ret;
+}
+
+int
+crypto_virtio_user_dev_update_status(struct virtio_user_dev *dev)
+{
+	int ret;
+	uint8_t status;
+
+	pthread_mutex_lock(&dev->mutex);
+
+	ret = dev->ops->get_status(dev, &status);
+	if (!ret) {
+		dev->status = status;
+		PMD_INIT_LOG(DEBUG, "Updated Device Status(0x%08x):"
+			"\t-RESET: %u "
+			"\t-ACKNOWLEDGE: %u "
+			"\t-DRIVER: %u "
+			"\t-DRIVER_OK: %u "
+			"\t-FEATURES_OK: %u "
+			"\t-DEVICE_NEED_RESET: %u "
+			"\t-FAILED: %u",
+			dev->status,
+			(dev->status == VIRTIO_CONFIG_STATUS_RESET),
+			!!(dev->status & VIRTIO_CONFIG_STATUS_ACK),
+			!!(dev->status & VIRTIO_CONFIG_STATUS_DRIVER),
+			!!(dev->status & VIRTIO_CONFIG_STATUS_DRIVER_OK),
+			!!(dev->status & VIRTIO_CONFIG_STATUS_FEATURES_OK),
+			!!(dev->status & VIRTIO_CONFIG_STATUS_DEV_NEED_RESET),
+			!!(dev->status & VIRTIO_CONFIG_STATUS_FAILED));
+	} else if (ret != -ENOTSUP) {
+		PMD_INIT_LOG(ERR, "(%s) Failed to get backend status", dev->path);
+	}
+
+	pthread_mutex_unlock(&dev->mutex);
+	return ret;
+}
+
+int
+crypto_virtio_user_dev_update_link_state(struct virtio_user_dev *dev)
+{
+	if (dev->ops->update_link_state)
+		return dev->ops->update_link_state(dev);
+
+	return 0;
+}
diff --git a/drivers/crypto/virtio/virtio_user/virtio_user_dev.h b/drivers/crypto/virtio/virtio_user/virtio_user_dev.h
new file mode 100644
index 0000000000..9cd9856e5d
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_user/virtio_user_dev.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell.
+ */
+
+#ifndef _VIRTIO_USER_DEV_H
+#define _VIRTIO_USER_DEV_H
+
+#include <limits.h>
+#include <stdbool.h>
+
+#include "../virtio_pci.h"
+#include "../virtio_ring.h"
+
+extern struct virtio_user_backend_ops virtio_crypto_ops_vdpa;
+
+enum virtio_user_backend_type {
+	VIRTIO_USER_BACKEND_UNKNOWN,
+	VIRTIO_USER_BACKEND_VHOST_USER,
+	VIRTIO_USER_BACKEND_VHOST_VDPA,
+};
+
+struct virtio_user_queue {
+	uint16_t used_idx;
+	bool avail_wrap_counter;
+	bool used_wrap_counter;
+};
+
+struct virtio_user_dev {
+	struct virtio_crypto_hw hw;
+	enum virtio_user_backend_type backend_type;
+	bool		is_server;  /* server or client mode */
+
+	int		*callfds;
+	int		*kickfds;
+	uint16_t	max_queue_pairs;
+	uint16_t	queue_pairs;
+	uint32_t	queue_size;
+	uint64_t	features; /* the negotiated features with driver,
+				   * and will be sync with device
+				   */
+	uint64_t	device_features; /* supported features by device */
+	uint64_t	frontend_features; /* enabled frontend features */
+	uint64_t	unsupported_features; /* unsupported features mask */
+	uint8_t		status;
+	uint32_t	crypto_status;
+	uint32_t	crypto_services;
+	uint64_t	cipher_algo;
+	uint32_t	hash_algo;
+	uint64_t	auth_algo;
+	uint32_t	aead_algo;
+	uint32_t	akcipher_algo;
+	char		path[PATH_MAX];
+
+	union {
+		void			*ptr;
+		struct vring		*split;
+		struct vring_packed	*packed;
+	} vrings;
+
+	struct virtio_user_queue *packed_queues;
+	bool		*qp_enabled;
+
+	struct virtio_user_backend_ops *ops;
+	pthread_mutex_t	mutex;
+	bool		started;
+
+	bool			hw_cvq;
+	struct virtqueue	*scvq;
+
+	void *backend_data;
+
+	uint16_t **notify_area;
+};
+
+int crypto_virtio_user_dev_set_features(struct virtio_user_dev *dev);
+int crypto_virtio_user_start_device(struct virtio_user_dev *dev);
+int crypto_virtio_user_stop_device(struct virtio_user_dev *dev);
+int crypto_virtio_user_dev_init(struct virtio_user_dev *dev, char *path, uint16_t queues,
+			int queue_size, int server);
+void crypto_virtio_user_dev_uninit(struct virtio_user_dev *dev);
+int crypto_virtio_user_dev_set_status(struct virtio_user_dev *dev, uint8_t status);
+int crypto_virtio_user_dev_update_status(struct virtio_user_dev *dev);
+int crypto_virtio_user_dev_update_link_state(struct virtio_user_dev *dev);
+extern const char * const crypto_virtio_user_backend_strings[];
+#endif
diff --git a/drivers/crypto/virtio/virtio_user_cryptodev.c b/drivers/crypto/virtio/virtio_user_cryptodev.c
new file mode 100644
index 0000000000..6dfdb76268
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_user_cryptodev.c
@@ -0,0 +1,575 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell
+ */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include <rte_malloc.h>
+#include <rte_kvargs.h>
+#include <bus_vdev_driver.h>
+#include <rte_cryptodev.h>
+#include <cryptodev_pmd.h>
+#include <rte_alarm.h>
+#include <rte_cycles.h>
+#include <rte_io.h>
+
+#include "virtio_user/virtio_user_dev.h"
+#include "virtio_user/vhost.h"
+#include "virtio_cryptodev.h"
+#include "virtio_logs.h"
+#include "virtio_pci.h"
+#include "virtqueue.h"
+
+#define virtio_user_get_dev(hwp) container_of(hwp, struct virtio_user_dev, hw)
+
+static void
+virtio_user_read_dev_config(struct virtio_crypto_hw *hw, size_t offset,
+		     void *dst, int length __rte_unused)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+
+	if (offset == offsetof(struct virtio_crypto_config, status)) {
+		crypto_virtio_user_dev_update_link_state(dev);
+		*(uint32_t *)dst = dev->crypto_status;
+	} else if (offset == offsetof(struct virtio_crypto_config, max_dataqueues))
+		*(uint16_t *)dst = dev->max_queue_pairs;
+	else if (offset == offsetof(struct virtio_crypto_config, crypto_services))
+		*(uint32_t *)dst = dev->crypto_services;
+	else if (offset == offsetof(struct virtio_crypto_config, cipher_algo_l))
+		*(uint32_t *)dst = dev->cipher_algo & 0xFFFF;
+	else if (offset == offsetof(struct virtio_crypto_config, cipher_algo_h))
+		*(uint32_t *)dst = dev->cipher_algo >> 32;
+	else if (offset == offsetof(struct virtio_crypto_config, hash_algo))
+		*(uint32_t *)dst = dev->hash_algo;
+	else if (offset == offsetof(struct virtio_crypto_config, mac_algo_l))
+		*(uint32_t *)dst = dev->auth_algo & 0xFFFF;
+	else if (offset == offsetof(struct virtio_crypto_config, mac_algo_h))
+		*(uint32_t *)dst = dev->auth_algo >> 32;
+	else if (offset == offsetof(struct virtio_crypto_config, aead_algo))
+		*(uint32_t *)dst = dev->aead_algo;
+	else if (offset == offsetof(struct virtio_crypto_config, akcipher_algo))
+		*(uint32_t *)dst = dev->akcipher_algo;
+}
+
+static void
+virtio_user_write_dev_config(struct virtio_crypto_hw *hw, size_t offset,
+		      const void *src, int length)
+{
+	RTE_SET_USED(hw);
+	RTE_SET_USED(src);
+
+	PMD_DRV_LOG(ERR, "not supported offset=%zu, len=%d",
+		    offset, length);
+}
+
+static void
+virtio_user_reset(struct virtio_crypto_hw *hw)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+
+	if (dev->status & VIRTIO_CONFIG_STATUS_DRIVER_OK)
+		crypto_virtio_user_stop_device(dev);
+}
+
+static void
+virtio_user_set_status(struct virtio_crypto_hw *hw, uint8_t status)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+	uint8_t old_status = dev->status;
+
+	if (status & VIRTIO_CONFIG_STATUS_FEATURES_OK &&
+			~old_status & VIRTIO_CONFIG_STATUS_FEATURES_OK) {
+		crypto_virtio_user_dev_set_features(dev);
+		/* Feature negotiation should be only done in probe time.
+		 * So we skip any more request here.
+		 */
+		dev->status |= VIRTIO_CONFIG_STATUS_FEATURES_OK;
+	}
+
+	if (status & VIRTIO_CONFIG_STATUS_DRIVER_OK) {
+		if (crypto_virtio_user_start_device(dev)) {
+			crypto_virtio_user_dev_update_status(dev);
+			return;
+		}
+	} else if (status == VIRTIO_CONFIG_STATUS_RESET) {
+		virtio_user_reset(hw);
+	}
+
+	crypto_virtio_user_dev_set_status(dev, status);
+	if (status & VIRTIO_CONFIG_STATUS_DRIVER_OK && dev->scvq) {
+		if (dev->ops->cvq_enable(dev, 1) < 0) {
+			PMD_INIT_LOG(ERR, "(%s) Failed to start ctrlq", dev->path);
+			crypto_virtio_user_dev_update_status(dev);
+			return;
+		}
+	}
+}
+
+static uint8_t
+virtio_user_get_status(struct virtio_crypto_hw *hw)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+
+	crypto_virtio_user_dev_update_status(dev);
+
+	return dev->status;
+}
+
+#define VIRTIO_USER_CRYPTO_PMD_GUEST_FEATURES   \
+	(1ULL << VIRTIO_CRYPTO_SERVICE_CIPHER     | \
+	 1ULL << VIRTIO_CRYPTO_SERVICE_AKCIPHER   | \
+	 1ULL << VIRTIO_F_VERSION_1               | \
+	 1ULL << VIRTIO_F_IN_ORDER                | \
+	 1ULL << VIRTIO_F_RING_PACKED             | \
+	 1ULL << VIRTIO_F_NOTIFICATION_DATA       | \
+	 1ULL << VIRTIO_RING_F_INDIRECT_DESC      | \
+	 1ULL << VIRTIO_F_ORDER_PLATFORM)
+
+static uint64_t
+virtio_user_get_features(struct virtio_crypto_hw *hw)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+
+	/* unmask feature bits defined in vhost user protocol */
+	return (dev->device_features | dev->frontend_features) &
+		VIRTIO_USER_CRYPTO_PMD_GUEST_FEATURES;
+}
+
+static void
+virtio_user_set_features(struct virtio_crypto_hw *hw, uint64_t features)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+
+	dev->features = features & (dev->device_features | dev->frontend_features);
+}
+
+static uint8_t
+virtio_user_get_isr(struct virtio_crypto_hw *hw __rte_unused)
+{
+	/* rxq interrupts and config interrupt are separated in virtio-user,
+	 * here we only report config change.
+	 */
+	return VIRTIO_PCI_CAP_ISR_CFG;
+}
+
+static uint16_t
+virtio_user_set_config_irq(struct virtio_crypto_hw *hw __rte_unused,
+		    uint16_t vec __rte_unused)
+{
+	return 0;
+}
+
+static uint16_t
+virtio_user_set_queue_irq(struct virtio_crypto_hw *hw __rte_unused,
+			  struct virtqueue *vq __rte_unused,
+			  uint16_t vec)
+{
+	/* pretend we have done that */
+	return vec;
+}
+
+/* This function is to get the queue size, aka, number of descs, of a specified
+ * queue. Different with the VHOST_USER_GET_QUEUE_NUM, which is used to get the
+ * max supported queues.
+ */
+static uint16_t
+virtio_user_get_queue_num(struct virtio_crypto_hw *hw, uint16_t queue_id __rte_unused)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+
+	/* Currently, each queue has same queue size */
+	return dev->queue_size;
+}
+
+static void
+virtio_user_setup_queue_packed(struct virtqueue *vq,
+			       struct virtio_user_dev *dev)
+{
+	uint16_t queue_idx = vq->vq_queue_index;
+	struct vring_packed *vring;
+	uint64_t desc_addr;
+	uint64_t avail_addr;
+	uint64_t used_addr;
+	uint16_t i;
+
+	vring  = &dev->vrings.packed[queue_idx];
+	desc_addr = (uintptr_t)vq->vq_ring_virt_mem;
+	avail_addr = desc_addr + vq->vq_nentries *
+		sizeof(struct vring_packed_desc);
+	used_addr = RTE_ALIGN_CEIL(avail_addr +
+			   sizeof(struct vring_packed_desc_event),
+			   VIRTIO_VRING_ALIGN);
+	vring->num = vq->vq_nentries;
+	vring->desc_iova = vq->vq_ring_mem;
+	vring->desc = (void *)(uintptr_t)desc_addr;
+	vring->driver = (void *)(uintptr_t)avail_addr;
+	vring->device = (void *)(uintptr_t)used_addr;
+	dev->packed_queues[queue_idx].avail_wrap_counter = true;
+	dev->packed_queues[queue_idx].used_wrap_counter = true;
+	dev->packed_queues[queue_idx].used_idx = 0;
+
+	for (i = 0; i < vring->num; i++)
+		vring->desc[i].flags = 0;
+}
+
+static void
+virtio_user_setup_queue_split(struct virtqueue *vq, struct virtio_user_dev *dev)
+{
+	uint16_t queue_idx = vq->vq_queue_index;
+	uint64_t desc_addr, avail_addr, used_addr;
+
+	desc_addr = (uintptr_t)vq->vq_ring_virt_mem;
+	avail_addr = desc_addr + vq->vq_nentries * sizeof(struct vring_desc);
+	used_addr = RTE_ALIGN_CEIL(avail_addr + offsetof(struct vring_avail,
+							 ring[vq->vq_nentries]),
+				   VIRTIO_VRING_ALIGN);
+
+	dev->vrings.split[queue_idx].num = vq->vq_nentries;
+	dev->vrings.split[queue_idx].desc_iova = vq->vq_ring_mem;
+	dev->vrings.split[queue_idx].desc = (void *)(uintptr_t)desc_addr;
+	dev->vrings.split[queue_idx].avail = (void *)(uintptr_t)avail_addr;
+	dev->vrings.split[queue_idx].used = (void *)(uintptr_t)used_addr;
+}
+
+static int
+virtio_user_setup_queue(struct virtio_crypto_hw *hw, struct virtqueue *vq)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+
+	if (vtpci_with_packed_queue(hw))
+		virtio_user_setup_queue_packed(vq, dev);
+	else
+		virtio_user_setup_queue_split(vq, dev);
+
+	if (dev->notify_area)
+		vq->notify_addr = dev->notify_area[vq->vq_queue_index];
+
+	if (virtcrypto_cq_to_vq(hw->cvq) == vq)
+		dev->scvq = virtcrypto_cq_to_vq(hw->cvq);
+
+	return 0;
+}
+
+static void
+virtio_user_del_queue(struct virtio_crypto_hw *hw, struct virtqueue *vq)
+{
+	RTE_SET_USED(hw);
+	RTE_SET_USED(vq);
+}
+
+static void
+virtio_user_notify_queue(struct virtio_crypto_hw *hw, struct virtqueue *vq)
+{
+	struct virtio_user_dev *dev = virtio_user_get_dev(hw);
+	uint64_t notify_data = 1;
+
+	if (!dev->notify_area) {
+		if (write(dev->kickfds[vq->vq_queue_index], &notify_data,
+			  sizeof(notify_data)) < 0)
+			PMD_DRV_LOG(ERR, "failed to kick backend: %s",
+				    strerror(errno));
+		return;
+	} else if (!vtpci_with_feature(hw, VIRTIO_F_NOTIFICATION_DATA)) {
+		rte_write16(vq->vq_queue_index, vq->notify_addr);
+		return;
+	}
+
+	if (vtpci_with_packed_queue(hw)) {
+		/* Bit[0:15]: vq queue index
+		 * Bit[16:30]: avail index
+		 * Bit[31]: avail wrap counter
+		 */
+		notify_data = ((uint32_t)(!!(vq->vq_packed.cached_flags &
+				VRING_PACKED_DESC_F_AVAIL)) << 31) |
+				((uint32_t)vq->vq_avail_idx << 16) |
+				vq->vq_queue_index;
+	} else {
+		/* Bit[0:15]: vq queue index
+		 * Bit[16:31]: avail index
+		 */
+		notify_data = ((uint32_t)vq->vq_avail_idx << 16) |
+				vq->vq_queue_index;
+	}
+	rte_write32(notify_data, vq->notify_addr);
+}
+
+const struct virtio_pci_ops crypto_virtio_user_ops = {
+	.read_dev_cfg	= virtio_user_read_dev_config,
+	.write_dev_cfg	= virtio_user_write_dev_config,
+	.reset		= virtio_user_reset,
+	.get_status	= virtio_user_get_status,
+	.set_status	= virtio_user_set_status,
+	.get_features	= virtio_user_get_features,
+	.set_features	= virtio_user_set_features,
+	.get_isr	= virtio_user_get_isr,
+	.set_config_irq	= virtio_user_set_config_irq,
+	.set_queue_irq	= virtio_user_set_queue_irq,
+	.get_queue_num	= virtio_user_get_queue_num,
+	.setup_queue	= virtio_user_setup_queue,
+	.del_queue	= virtio_user_del_queue,
+	.notify_queue	= virtio_user_notify_queue,
+};
+
+static const char * const valid_args[] = {
+#define VIRTIO_USER_ARG_QUEUES_NUM     "queues"
+	VIRTIO_USER_ARG_QUEUES_NUM,
+#define VIRTIO_USER_ARG_QUEUE_SIZE     "queue_size"
+	VIRTIO_USER_ARG_QUEUE_SIZE,
+#define VIRTIO_USER_ARG_PATH           "path"
+	VIRTIO_USER_ARG_PATH,
+	NULL
+};
+
+#define VIRTIO_USER_DEF_Q_NUM	1
+#define VIRTIO_USER_DEF_Q_SZ	256
+#define VIRTIO_USER_DEF_SERVER_MODE	0
+
+static int
+get_string_arg(const char *key __rte_unused,
+		const char *value, void *extra_args)
+{
+	if (!value || !extra_args)
+		return -EINVAL;
+
+	*(char **)extra_args = strdup(value);
+
+	if (!*(char **)extra_args)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int
+get_integer_arg(const char *key __rte_unused,
+		const char *value, void *extra_args)
+{
+	uint64_t integer = 0;
+	if (!value || !extra_args)
+		return -EINVAL;
+	errno = 0;
+	integer = strtoull(value, NULL, 0);
+	/* extra_args keeps default value, it should be replaced
+	 * only in case of successful parsing of the 'value' arg
+	 */
+	if (errno == 0)
+		*(uint64_t *)extra_args = integer;
+	return -errno;
+}
+
+static struct rte_cryptodev *
+virtio_user_cryptodev_alloc(struct rte_vdev_device *vdev)
+{
+	struct rte_cryptodev_pmd_init_params init_params = {
+		.name = "",
+		.private_data_size = sizeof(struct virtio_user_dev),
+	};
+	struct rte_cryptodev_data *data;
+	struct rte_cryptodev *cryptodev;
+	struct virtio_user_dev *dev;
+	struct virtio_crypto_hw *hw;
+
+	init_params.socket_id = vdev->device.numa_node;
+	init_params.private_data_size = sizeof(struct virtio_user_dev);
+	cryptodev = rte_cryptodev_pmd_create(vdev->device.name, &vdev->device, &init_params);
+	if (cryptodev == NULL) {
+		PMD_INIT_LOG(ERR, "failed to create cryptodev vdev");
+		return NULL;
+	}
+
+	data = cryptodev->data;
+	dev = data->dev_private;
+	hw = &dev->hw;
+
+	hw->dev_id = data->dev_id;
+	VTPCI_OPS(hw) = &crypto_virtio_user_ops;
+
+	return cryptodev;
+}
+
+static void
+virtio_user_cryptodev_free(struct rte_cryptodev *cryptodev)
+{
+	rte_cryptodev_pmd_destroy(cryptodev);
+}
+
+static int
+virtio_user_pmd_probe(struct rte_vdev_device *vdev)
+{
+	uint64_t server_mode = VIRTIO_USER_DEF_SERVER_MODE;
+	uint64_t queue_size = VIRTIO_USER_DEF_Q_SZ;
+	uint64_t queues = VIRTIO_USER_DEF_Q_NUM;
+	struct rte_cryptodev *cryptodev = NULL;
+	struct rte_kvargs *kvlist = NULL;
+	struct virtio_user_dev *dev;
+	char *path = NULL;
+	int ret;
+
+	kvlist = rte_kvargs_parse(rte_vdev_device_args(vdev), valid_args);
+
+	if (!kvlist) {
+		PMD_INIT_LOG(ERR, "error when parsing param");
+		goto end;
+	}
+
+	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_PATH) == 1) {
+		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_PATH,
+					&get_string_arg, &path) < 0) {
+			PMD_INIT_LOG(ERR, "error to parse %s",
+					VIRTIO_USER_ARG_PATH);
+			goto end;
+		}
+	} else {
+		PMD_INIT_LOG(ERR, "arg %s is mandatory for virtio_user",
+				VIRTIO_USER_ARG_PATH);
+		goto end;
+	}
+
+	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_QUEUES_NUM) == 1) {
+		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_QUEUES_NUM,
+					&get_integer_arg, &queues) < 0) {
+			PMD_INIT_LOG(ERR, "error to parse %s",
+					VIRTIO_USER_ARG_QUEUES_NUM);
+			goto end;
+		}
+	}
+
+	if (rte_kvargs_count(kvlist, VIRTIO_USER_ARG_QUEUE_SIZE) == 1) {
+		if (rte_kvargs_process(kvlist, VIRTIO_USER_ARG_QUEUE_SIZE,
+					&get_integer_arg, &queue_size) < 0) {
+			PMD_INIT_LOG(ERR, "error to parse %s",
+					VIRTIO_USER_ARG_QUEUE_SIZE);
+			goto end;
+		}
+	}
+
+	cryptodev = virtio_user_cryptodev_alloc(vdev);
+	if (!cryptodev) {
+		PMD_INIT_LOG(ERR, "virtio_user fails to alloc device");
+		goto end;
+	}
+
+	dev = cryptodev->data->dev_private;
+	if (crypto_virtio_user_dev_init(dev, path, queues, queue_size,
+			server_mode) < 0) {
+		PMD_INIT_LOG(ERR, "virtio_user_dev_init fails");
+		virtio_user_cryptodev_free(cryptodev);
+		goto end;
+	}
+
+	if (crypto_virtio_dev_init(cryptodev, VIRTIO_USER_CRYPTO_PMD_GUEST_FEATURES,
+			NULL) < 0) {
+		PMD_INIT_LOG(ERR, "crypto_virtio_dev_init fails");
+		crypto_virtio_user_dev_uninit(dev);
+		virtio_user_cryptodev_free(cryptodev);
+		goto end;
+	}
+
+	rte_cryptodev_pmd_probing_finish(cryptodev);
+
+	ret = 0;
+end:
+	rte_kvargs_free(kvlist);
+	free(path);
+	return ret;
+}
+
+static int
+virtio_user_pmd_remove(struct rte_vdev_device *vdev)
+{
+	struct rte_cryptodev *cryptodev;
+	const char *name;
+	int devid;
+
+	if (!vdev)
+		return -EINVAL;
+
+	name = rte_vdev_device_name(vdev);
+	PMD_DRV_LOG(INFO, "Removing %s", name);
+
+	devid = rte_cryptodev_get_dev_id(name);
+	if (devid < 0)
+		return -EINVAL;
+
+	rte_cryptodev_stop(devid);
+
+	cryptodev = rte_cryptodev_pmd_get_named_dev(name);
+	if (cryptodev == NULL)
+		return -ENODEV;
+
+	if (rte_cryptodev_pmd_destroy(cryptodev) < 0) {
+		PMD_DRV_LOG(ERR, "Failed to remove %s", name);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int virtio_user_pmd_dma_map(struct rte_vdev_device *vdev, void *addr,
+		uint64_t iova, size_t len)
+{
+	struct rte_cryptodev *cryptodev;
+	struct virtio_user_dev *dev;
+	const char *name;
+
+	if (!vdev)
+		return -EINVAL;
+
+	name = rte_vdev_device_name(vdev);
+	cryptodev = rte_cryptodev_pmd_get_named_dev(name);
+	if (cryptodev == NULL)
+		return -EINVAL;
+
+	dev = cryptodev->data->dev_private;
+
+	if (dev->ops->dma_map)
+		return dev->ops->dma_map(dev, addr, iova, len);
+
+	return 0;
+}
+
+static int virtio_user_pmd_dma_unmap(struct rte_vdev_device *vdev, void *addr,
+		uint64_t iova, size_t len)
+{
+	struct rte_cryptodev *cryptodev;
+	struct virtio_user_dev *dev;
+	const char *name;
+
+	if (!vdev)
+		return -EINVAL;
+
+	name = rte_vdev_device_name(vdev);
+	cryptodev = rte_cryptodev_pmd_get_named_dev(name);
+	if (cryptodev == NULL)
+		return -EINVAL;
+
+	dev = cryptodev->data->dev_private;
+
+	if (dev->ops->dma_unmap)
+		return dev->ops->dma_unmap(dev, addr, iova, len);
+
+	return 0;
+}
+
+static struct rte_vdev_driver virtio_user_driver = {
+	.probe = virtio_user_pmd_probe,
+	.remove = virtio_user_pmd_remove,
+	.dma_map = virtio_user_pmd_dma_map,
+	.dma_unmap = virtio_user_pmd_dma_unmap,
+};
+
+static struct cryptodev_driver virtio_crypto_drv;
+
+uint8_t cryptodev_virtio_user_driver_id;
+
+RTE_PMD_REGISTER_VDEV(crypto_virtio_user, virtio_user_driver);
+RTE_PMD_REGISTER_CRYPTO_DRIVER(virtio_crypto_drv,
+	virtio_user_driver.driver,
+	cryptodev_virtio_user_driver_id);
+RTE_PMD_REGISTER_PARAM_STRING(crypto_virtio_user,
+	"path=<path> "
+	"queues=<int> "
+	"queue_size=<int>");
-- 
2.25.1

