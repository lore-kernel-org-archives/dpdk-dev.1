Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185ACA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 07:29:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF79D4067C;
	Wed,  3 Sep 2025 09:29:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5AC4B4066A
 for <dev@dpdk.org>; Wed,  3 Sep 2025 09:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756884575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vvsl+WjOSOf9kr3FEEX8+Ffd0ejKDvYZwU5sK4LdzY=;
 b=JZEBXLHWMgIhYodF5R75h0Q7j8FwqIyMUqqvaIFEqzmG7JFjnEgsqUJEAxW3OHatje9IeX
 p9waDBHOCJnRk+cuI0milza1UJ+ThbeoiHJqekmTKqIFKfhP1hs0i0JZmmMxsEeHEg6HRl
 XTN2JqprI6PxdT//+c2gPNewErabn2A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-LKrtFuTRPDGGO1YLzPy8QQ-1; Wed,
 03 Sep 2025 03:29:32 -0400
X-MC-Unique: LKrtFuTRPDGGO1YLzPy8QQ-1
X-Mimecast-MFC-AGG-ID: LKrtFuTRPDGGO1YLzPy8QQ_1756884570
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B2BE1800562; Wed,  3 Sep 2025 07:29:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 716261956056; Wed,  3 Sep 2025 07:29:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Kai Ji <kai.ji@intel.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>, Rosen Xu <rosen.xu@altera.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 8/8] vfio: use imported uAPI header
Date: Wed,  3 Sep 2025 09:28:25 +0200
Message-ID: <20250903072826.1727004-9-david.marchand@redhat.com>
In-Reply-To: <20250903072826.1727004-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tXtd0xP_fu7SiUZFa19SeAL2o3DmNuBF7BSSKptcxp0_1756884570
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
---
 drivers/bus/cdx/cdx_vfio.c               | 45 +++++-------------------
 drivers/bus/fslmc/fslmc_vfio.c           |  3 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |  3 +-
 drivers/bus/pci/linux/pci_vfio.c         |  2 +-
 drivers/bus/platform/platform.c          |  2 +-
 drivers/common/qat/dev/qat_dev_gen_lce.c |  2 +-
 drivers/crypto/bcmfs/bcmfs_vfio.c        |  2 +-
 drivers/raw/ifpga/afu_pmd_n3000.c        |  2 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c            |  2 +-
 drivers/vdpa/nfp/nfp_vdpa.c              |  2 +-
 drivers/vdpa/sfc/sfc_vdpa_ops.c          |  2 +-
 lib/eal/linux/eal_interrupts.c           |  2 +-
 lib/eal/linux/eal_vfio.c                 |  3 +-
 13 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 576718a659..f9f19b4122 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -18,7 +18,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <eal_export.h>
 #include <rte_eal_paging.h>
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
index 3f041f447c..abf38a7bf6 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -20,7 +20,8 @@
 #include <dirent.h>
 #include <sys/eventfd.h>
 #include <ctype.h>
-#include <linux/vfio.h>
+
+#include <uapi/linux/vfio.h>
 
 #include <eal_export.h>
 #include <eal_filesystem.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index cffbf3c28a..18909811a1 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -22,7 +22,8 @@
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
 #include <sys/syscall.h>
-#include <linux/vfio.h>
+
+#include <uapi/linux/vfio.h>
 
 #include <eal_export.h>
 #include <rte_mbuf.h>
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 46b87c7c38..ec54b7ac69 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -11,7 +11,7 @@
 #include <sys/mman.h>
 #include <stdbool.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <rte_log.h>
 #include <rte_pci.h>
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 149cba81a7..905b258595 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -11,7 +11,7 @@
 #include <sys/queue.h>
 #include <unistd.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <bus_driver.h>
 #include <bus_platform_driver.h>
diff --git a/drivers/common/qat/dev/qat_dev_gen_lce.c b/drivers/common/qat/dev/qat_dev_gen_lce.c
index 466878bf76..8486dfa384 100644
--- a/drivers/common/qat/dev/qat_dev_gen_lce.c
+++ b/drivers/common/qat/dev/qat_dev_gen_lce.c
@@ -4,7 +4,7 @@
 
 #include <rte_pci.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include "qat_device.h"
 #include "qat_qp.h"
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index e747bef924..5f309a6b34 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -7,7 +7,7 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <rte_vfio.h>
 
diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c b/drivers/raw/ifpga/afu_pmd_n3000.c
index ec2fdd46df..5e792ead8c 100644
--- a/drivers/raw/ifpga/afu_pmd_n3000.c
+++ b/drivers/raw/ifpga/afu_pmd_n3000.c
@@ -13,7 +13,7 @@
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <rte_eal.h>
 #include <rte_malloc.h>
diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index c8e47e41c1..ce63abd275 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -11,7 +11,7 @@
 #include <linux/virtio_net.h>
 #include <stdbool.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index c1ffbd1f91..df31851cb6 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -8,7 +8,7 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <nfp_common_pci.h>
 #include <nfp_dev.h>
diff --git a/drivers/vdpa/sfc/sfc_vdpa_ops.c b/drivers/vdpa/sfc/sfc_vdpa_ops.c
index 1ece47d373..dc64c4d213 100644
--- a/drivers/vdpa/sfc/sfc_vdpa_ops.c
+++ b/drivers/vdpa/sfc/sfc_vdpa_ops.c
@@ -6,7 +6,7 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <rte_errno.h>
 #include <rte_malloc.h>
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index d1789cbda2..346a2d4c72 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -15,7 +15,7 @@
 #include <assert.h>
 #include <stdbool.h>
 
-#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
 
 #include <eal_export.h>
 #include <eal_trace_internal.h>
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 62f9d05e63..89a8fb0a12 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -8,7 +8,8 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <dirent.h>
-#include <linux/vfio.h>
+
+#include <uapi/linux/vfio.h>
 
 #include <rte_errno.h>
 #include <rte_log.h>
-- 
2.51.0

