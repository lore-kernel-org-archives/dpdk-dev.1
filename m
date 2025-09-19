Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C092CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:39:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCBB640676;
	Fri, 19 Sep 2025 10:39:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3758740668
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758271175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TygjWGxNd0fw5whc0EjqATeGml6z5/EumSxRiO8KvI=;
 b=R8AMsM3fQmaB5Z6QgNTWE15xPQQo/VLThTEA9U+7AF+9u3rXF+lgII7mKRjsJvnfRzlkkS
 h4enEQBjhz78vifimALAhWmFlhNC53x434p6fEgE/nZbG26/5xGTQMO6s08vjoyX+i498U
 5L9p34oAFimG8/Ih64/WUd08Cw8/a58=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-_GdakXB7MMCmzqxlIIuAbA-1; Fri,
 19 Sep 2025 04:39:33 -0400
X-MC-Unique: _GdakXB7MMCmzqxlIIuAbA-1
X-Mimecast-MFC-AGG-ID: _GdakXB7MMCmzqxlIIuAbA_1758271170
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BDB6180048E; Fri, 19 Sep 2025 08:39:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7916230002CC; Fri, 19 Sep 2025 08:39:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 stephen@networkplumber.org, Rosen Xu <rosen.xu@altera.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>, Renyong Wan <wanry@yunsilicon.com>,
 Na Na <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>,
 Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v3 10/10] vfio: use imported uAPI header
Date: Fri, 19 Sep 2025 10:38:07 +0200
Message-ID: <20250919083808.1667491-11-david.marchand@redhat.com>
In-Reply-To: <20250919083808.1667491-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250919083808.1667491-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UynbrQ2vRKRRk-VVriWkWoHUVvKAwsXd-tpQbud5BH0_1758271170
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Now that we have a v6.16 header in DPDK, we can remove all remaining
wrappers around VFIO uapi.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Rosen Xu <rosen.xu@altera.com>
---
Changes since RFC v2:
- fixed header inclusion order (see patch 1),
- converted net/xsc,

---
 drivers/bus/cdx/cdx_vfio.c                 | 47 +++++-----------------
 drivers/bus/fslmc/fslmc_vfio.c             |  3 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c   |  3 +-
 drivers/bus/pci/linux/pci_vfio.c           |  4 +-
 drivers/bus/platform/platform.c            |  4 +-
 drivers/common/cnxk/roc_platform.c         |  3 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c          |  4 +-
 drivers/net/xsc/xsc_vfio.c                 |  3 +-
 drivers/raw/ifpga/afu_pmd_n3000.c          |  4 +-
 drivers/raw/ifpga/base/ifpga_feature_dev.c |  3 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c              |  4 +-
 drivers/vdpa/nfp/nfp_vdpa.c                |  4 +-
 drivers/vdpa/sfc/sfc_vdpa_ops.c            |  4 +-
 lib/eal/linux/eal_interrupts.c             |  4 +-
 lib/eal/linux/eal_vfio.c                   |  3 +-
 15 files changed, 38 insertions(+), 59 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 576718a659..c03bc01df7 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -11,6 +11,8 @@
  *
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/eventfd.h>
@@ -18,8 +20,6 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
-#include <linux/vfio.h>
-
 #include <eal_export.h>
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
@@ -616,33 +616,6 @@ rte_cdx_vfio_intr_disable(const struct rte_intr_handle *intr_handle)
 	return ret;
 }
 
-/* VFIO_DEVICE_FEATURE is defined for kernel version 5.7 and newer. */
-#ifdef	VFIO_DEVICE_FEATURE
-#define	RTE_VFIO_DEVICE_FEATURE	VFIO_DEVICE_FEATURE
-#else
-#define	RTE_VFIO_DEVICE_FEATURE	_IO(VFIO_TYPE, VFIO_BASE + 17)
-struct vfio_device_feature {
-	__u32	argsz;
-	__u32	flags;
-#define	VFIO_DEVICE_FEATURE_MASK	(0xffff) /* 16-bit feature index */
-#define	VFIO_DEVICE_FEATURE_GET		(1 << 16) /* Get feature into data[] */
-#define	VFIO_DEVICE_FEATURE_SET		(1 << 17) /* Set feature from data[] */
-#define	VFIO_DEVICE_FEATURE_PROBE	(1 << 18) /* Probe feature support */
-	__u8	data[];
-};
-#endif
-
-#ifdef	VFIO_DEVICE_FEATURE_BUS_MASTER
-#define	RTE_VFIO_DEVICE_FEATURE_BUS_MASTER	VFIO_DEVICE_FEATURE_BUS_MASTER
-#else
-#define	RTE_VFIO_DEVICE_FEATURE_BUS_MASTER	10
-struct vfio_device_feature_bus_master {
-	__u32 op;
-#define	VFIO_DEVICE_FEATURE_CLEAR_MASTER	0	/* Clear Bus Master */
-#define	VFIO_DEVICE_FEATURE_SET_MASTER		1	/* Set Bus Master */
-};
-#endif
-
 /* Enable Bus Mastering */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_enable)
 int
@@ -668,9 +641,9 @@ rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
 
 	feature->argsz = argsz;
 
-	feature->flags = RTE_VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_PROBE;
+	feature->flags = VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_PROBE;
 	feature->flags |= VFIO_DEVICE_FEATURE_SET;
-	ret = ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
 	if (ret) {
 		CDX_BUS_ERR("Bus Master configuring not supported for device: %s, error: %d (%s)",
 			dev->name, errno, strerror(errno));
@@ -678,9 +651,9 @@ rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
 		return ret;
 	}
 
-	feature->flags = RTE_VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_SET;
+	feature->flags = VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_SET;
 	vfio_bm_feature->op = VFIO_DEVICE_FEATURE_SET_MASTER;
-	ret = ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
 	if (ret < 0)
 		CDX_BUS_ERR("BM Enable Error for device: %s, Error: %d (%s)",
 			dev->name, errno, strerror(errno));
@@ -713,9 +686,9 @@ rte_cdx_vfio_bm_disable(struct rte_cdx_device *dev)
 
 	feature->argsz = argsz;
 
-	feature->flags = RTE_VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_PROBE;
+	feature->flags = VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_PROBE;
 	feature->flags |= VFIO_DEVICE_FEATURE_SET;
-	ret = ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
 	if (ret) {
 		CDX_BUS_ERR("Bus Master configuring not supported for device: %s, Error: %d (%s)",
 			dev->name, errno, strerror(errno));
@@ -723,9 +696,9 @@ rte_cdx_vfio_bm_disable(struct rte_cdx_device *dev)
 		return ret;
 	}
 
-	feature->flags = RTE_VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_SET;
+	feature->flags = VFIO_DEVICE_FEATURE_BUS_MASTER | VFIO_DEVICE_FEATURE_SET;
 	vfio_bm_feature->op = VFIO_DEVICE_FEATURE_CLEAR_MASTER;
-	ret = ioctl(vfio_dev_fd, RTE_VFIO_DEVICE_FEATURE, feature);
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature);
 	if (ret < 0)
 		CDX_BUS_ERR("BM Disable Error for device: %s, Error: %d (%s)",
 			dev->name, errno, strerror(errno));
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 6219057a4e..550d4e0e8d 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -5,6 +5,8 @@
  *
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/types.h>
@@ -20,7 +22,6 @@
 #include <dirent.h>
 #include <sys/eventfd.h>
 #include <ctype.h>
-#include <linux/vfio.h>
 
 #include <eal_export.h>
 #include <eal_filesystem.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index cffbf3c28a..2a9e519668 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -4,6 +4,8 @@
  *   Copyright 2016-2022 NXP
  *
  */
+#include <uapi/linux/vfio.h>
+
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
@@ -22,7 +24,6 @@
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
 #include <sys/syscall.h>
-#include <linux/vfio.h>
 
 #include <eal_export.h>
 #include <rte_mbuf.h>
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 46b87c7c38..c63721dd61 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <unistd.h>
 #include <string.h>
 #include <fcntl.h>
@@ -11,8 +13,6 @@
 #include <sys/mman.h>
 #include <stdbool.h>
 
-#include <linux/vfio.h>
-
 #include <rte_log.h>
 #include <rte_pci.h>
 #include <rte_bus_pci.h>
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 149cba81a7..f6673cf181 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -2,6 +2,8 @@
  * Copyright(C) 2023 Marvell.
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <dirent.h>
 #include <inttypes.h>
 #include <stdlib.h>
@@ -11,8 +13,6 @@
 #include <sys/queue.h>
 #include <unistd.h>
 
-#include <linux/vfio.h>
-
 #include <bus_driver.h>
 #include <bus_platform_driver.h>
 #include <eal_export.h>
diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index 88f229163a..e13cb42285 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -2,6 +2,8 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <eal_export.h>
 #include <rte_log.h>
 
@@ -11,7 +13,6 @@
 #if defined(__linux__)
 
 #include <inttypes.h>
-#include <linux/vfio.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index e747bef924..e7f7ed994c 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -3,12 +3,12 @@
  * All rights reserved.
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <errno.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
-#include <linux/vfio.h>
-
 #include <rte_vfio.h>
 
 #include "bcmfs_device.h"
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index c233728c5f..2177971827 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -2,11 +2,12 @@
  * Copyright 2025 Yunsilicon Technology Co., Ltd.
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <linux/vfio.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 
diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c b/drivers/raw/ifpga/afu_pmd_n3000.c
index ec2fdd46df..b4c2f0d0a8 100644
--- a/drivers/raw/ifpga/afu_pmd_n3000.c
+++ b/drivers/raw/ifpga/afu_pmd_n3000.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2022 Intel Corporation
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
@@ -13,8 +15,6 @@
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 
-#include <linux/vfio.h>
-
 #include <rte_eal.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
diff --git a/drivers/raw/ifpga/base/ifpga_feature_dev.c b/drivers/raw/ifpga/base/ifpga_feature_dev.c
index 3402ad97e4..1493d87ea4 100644
--- a/drivers/raw/ifpga/base/ifpga_feature_dev.c
+++ b/drivers/raw/ifpga/base/ifpga_feature_dev.c
@@ -2,8 +2,9 @@
  * Copyright(c) 2010-2018 Intel Corporation
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <sys/ioctl.h>
-#include <linux/vfio.h>
 
 #include "ifpga_feature_dev.h"
 
diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index c8e47e41c1..f319d455ba 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <unistd.h>
 #include <pthread.h>
 #include <fcntl.h>
@@ -11,8 +13,6 @@
 #include <linux/virtio_net.h>
 #include <stdbool.h>
 
-#include <linux/vfio.h>
-
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index c1ffbd1f91..f4fd5c92ec 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -3,13 +3,13 @@
  * All rights reserved.
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <pthread.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#include <linux/vfio.h>
-
 #include <nfp_common_pci.h>
 #include <nfp_dev.h>
 #include <rte_vfio.h>
diff --git a/drivers/vdpa/sfc/sfc_vdpa_ops.c b/drivers/vdpa/sfc/sfc_vdpa_ops.c
index 1ece47d373..84ba141b34 100644
--- a/drivers/vdpa/sfc/sfc_vdpa_ops.c
+++ b/drivers/vdpa/sfc/sfc_vdpa_ops.c
@@ -2,12 +2,12 @@
  * Copyright(c) 2020-2021 Xilinx, Inc.
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <pthread.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 
-#include <linux/vfio.h>
-
 #include <rte_errno.h>
 #include <rte_malloc.h>
 #include <rte_vdpa.h>
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index d1789cbda2..9db978923a 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
@@ -15,8 +17,6 @@
 #include <assert.h>
 #include <stdbool.h>
 
-#include <linux/vfio.h>
-
 #include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_common.h>
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 91e85225db..45c1354390 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -2,13 +2,14 @@
  * Copyright(c) 2010-2018 Intel Corporation
  */
 
+#include <uapi/linux/vfio.h>
+
 #include <inttypes.h>
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <dirent.h>
-#include <linux/vfio.h>
 
 #include <rte_errno.h>
 #include <rte_log.h>
-- 
2.51.0

