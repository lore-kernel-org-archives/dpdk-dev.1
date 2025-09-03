Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8158ACA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C05B40E68;
	Wed,  3 Sep 2025 17:18:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AF77F40E30
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRn0ikJa3Qm/QTkQnY+iArXLmtCDaPOnlxJRqi26VQ8=;
 b=N16GeHm3LSxr63yD69ZV2cDjcrwWsYp+pObPnGsISv9T257Id0gT85tSTKXdMuZnuW2oZO
 DeRLsYGvls18zEHj1hpkStInc3JcQL6PRYE6CgZud/a6L9U2XFYSXce5yWU0nNfYpJGxc8
 ys1R4jRcQH4NTaZLjARk6CunVC6+YBM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-6aCNOfpzMIO7VgopNoUivQ-1; Wed,
 03 Sep 2025 11:18:54 -0400
X-MC-Unique: 6aCNOfpzMIO7VgopNoUivQ-1
X-Mimecast-MFC-AGG-ID: 6aCNOfpzMIO7VgopNoUivQ_1756912732
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90B91800365; Wed,  3 Sep 2025 15:18:51 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F7C119560AB; Wed,  3 Sep 2025 15:18:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 Rosen Xu <rosen.xu@altera.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC v2 7/9] vfio: stop including Linux kernel header in public and
 driver API
Date: Wed,  3 Sep 2025 17:17:57 +0200
Message-ID: <20250903151800.1965006-8-david.marchand@redhat.com>
In-Reply-To: <20250903151800.1965006-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SWV5E-D2lnbPnVi7rMPpX69iHfY_qfDSOUtjB1FzajM_1756912732
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

The DPDK API is not dependent on the VFIO API itself.
Remove inclusion in rte_vfio.h (and bus_fslmc_driver.h) and add explicit
inclusion where needed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Rosen Xu <rosen.xu@altera.com>
---
 drivers/bus/cdx/cdx_vfio.c                 | 3 +++
 drivers/bus/fslmc/bus_fslmc_driver.h       | 3 ++-
 drivers/bus/fslmc/fslmc_bus.c              | 1 +
 drivers/bus/fslmc/fslmc_vfio.c             | 2 ++
 drivers/bus/fslmc/fslmc_vfio.h             | 1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c   | 1 +
 drivers/bus/pci/linux/pci_vfio.c           | 2 ++
 drivers/bus/platform/platform.c            | 2 ++
 drivers/crypto/bcmfs/bcmfs_vfio.c          | 2 ++
 drivers/raw/ifpga/afu_pmd_n3000.c          | 3 ++-
 drivers/raw/ifpga/base/ifpga_feature_dev.c | 2 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c              | 2 ++
 drivers/vdpa/nfp/nfp_vdpa.c                | 2 ++
 drivers/vdpa/sfc/sfc_vdpa_ops.c            | 3 ++-
 lib/eal/include/rte_vfio.h                 | 8 --------
 lib/eal/linux/eal_interrupts.c             | 3 ++-
 lib/eal/linux/eal_vfio.c                   | 1 +
 17 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 03d156388e..576718a659 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -17,6 +17,9 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+
+#include <linux/vfio.h>
+
 #include <eal_export.h>
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 442de1a3fb..74ce7381d7 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -20,7 +20,6 @@
 #include <sys/queue.h>
 #include <stdint.h>
 #include <inttypes.h>
-#include <linux/vfio.h>
 
 #include <rte_compat.h>
 #include <rte_debug.h>
@@ -37,6 +36,8 @@
 extern "C" {
 #endif
 
+struct vfio_device_info;
+
 #define FSLMC_OBJECT_MAX_LEN 32   /**< Length of each device on bus */
 
 #define DPAA2_INVALID_MBUF_SEQN        0
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 20458d5030..49c61c9d2d 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -17,6 +17,7 @@
 #include <rte_memcpy.h>
 #include <ethdev_driver.h>
 #include <rte_mbuf_dyn.h>
+#include <rte_vfio.h>
 
 #include "private.h"
 #include <fslmc_vfio.h>
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index c08c316c94..3f041f447c 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -20,6 +20,7 @@
 #include <dirent.h>
 #include <sys/eventfd.h>
 #include <ctype.h>
+#include <linux/vfio.h>
 
 #include <eal_export.h>
 #include <eal_filesystem.h>
@@ -32,6 +33,7 @@
 #include <rte_kvargs.h>
 #include <dev_driver.h>
 #include <rte_eal_memconfig.h>
+#include <rte_vfio.h>
 #include <eal_vfio.h>
 
 #include "private.h"
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index 815970ec38..c995fd67b8 100644
--- a/drivers/bus/fslmc/fslmc_vfio.h
+++ b/drivers/bus/fslmc/fslmc_vfio.h
@@ -9,7 +9,6 @@
 #define _FSLMC_VFIO_H_
 
 #include <rte_compat.h>
-#include <rte_vfio.h>
 
 /* Pathname of FSL-MC devices directory. */
 #define SYSFS_FSL_MC_DEVICES	"/sys/bus/fsl-mc/devices"
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e32471d8b5..cffbf3c28a 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -22,6 +22,7 @@
 #include <sys/epoll.h>
 #include <sys/eventfd.h>
 #include <sys/syscall.h>
+#include <linux/vfio.h>
 
 #include <eal_export.h>
 #include <rte_mbuf.h>
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 9e5776ce3c..46b87c7c38 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -11,6 +11,8 @@
 #include <sys/mman.h>
 #include <stdbool.h>
 
+#include <linux/vfio.h>
+
 #include <rte_log.h>
 #include <rte_pci.h>
 #include <rte_bus_pci.h>
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 90524fd961..149cba81a7 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -11,6 +11,8 @@
 #include <sys/queue.h>
 #include <unistd.h>
 
+#include <linux/vfio.h>
+
 #include <bus_driver.h>
 #include <bus_platform_driver.h>
 #include <eal_export.h>
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index 9138f96eb0..e747bef924 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -7,6 +7,8 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
+#include <linux/vfio.h>
+
 #include <rte_vfio.h>
 
 #include "bcmfs_device.h"
diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c b/drivers/raw/ifpga/afu_pmd_n3000.c
index 0882a27701..ec2fdd46df 100644
--- a/drivers/raw/ifpga/afu_pmd_n3000.c
+++ b/drivers/raw/ifpga/afu_pmd_n3000.c
@@ -13,11 +13,12 @@
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 
+#include <linux/vfio.h>
+
 #include <rte_eal.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_io.h>
-#include <rte_vfio.h>
 #include <bus_pci_driver.h>
 #include <bus_ifpga_driver.h>
 #include <rte_rawdev.h>
diff --git a/drivers/raw/ifpga/base/ifpga_feature_dev.c b/drivers/raw/ifpga/base/ifpga_feature_dev.c
index 0a00af1b6b..3402ad97e4 100644
--- a/drivers/raw/ifpga/base/ifpga_feature_dev.c
+++ b/drivers/raw/ifpga/base/ifpga_feature_dev.c
@@ -3,7 +3,7 @@
  */
 
 #include <sys/ioctl.h>
-#include <rte_vfio.h>
+#include <linux/vfio.h>
 
 #include "ifpga_feature_dev.h"
 
diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index 65de383b95..c8e47e41c1 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -11,6 +11,8 @@
 #include <linux/virtio_net.h>
 #include <stdbool.h>
 
+#include <linux/vfio.h>
+
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index 7f2f21ec6c..c1ffbd1f91 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -8,6 +8,8 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
+#include <linux/vfio.h>
+
 #include <nfp_common_pci.h>
 #include <nfp_dev.h>
 #include <rte_vfio.h>
diff --git a/drivers/vdpa/sfc/sfc_vdpa_ops.c b/drivers/vdpa/sfc/sfc_vdpa_ops.c
index 00f9a4b04c..1ece47d373 100644
--- a/drivers/vdpa/sfc/sfc_vdpa_ops.c
+++ b/drivers/vdpa/sfc/sfc_vdpa_ops.c
@@ -6,10 +6,11 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 
+#include <linux/vfio.h>
+
 #include <rte_errno.h>
 #include <rte_malloc.h>
 #include <rte_vdpa.h>
-#include <rte_vfio.h>
 #include <rte_vhost.h>
 
 #include <vdpa_driver.h>
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 509ffec80c..683affa933 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -19,17 +19,9 @@
 extern "C" {
 #endif
 
-#ifdef RTE_EXEC_ENV_LINUX
-
-#include <linux/vfio.h>
-
-#else /* ! RTE_EXEC_ENV_LINUX */
-
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
 
-#endif /* RTE_EXEC_ENV_LINUX */
-
 #define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
 
 /**
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 43e05c86a2..d1789cbda2 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -15,6 +15,8 @@
 #include <assert.h>
 #include <stdbool.h>
 
+#include <linux/vfio.h>
+
 #include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_common.h>
@@ -28,7 +30,6 @@
 #include <rte_errno.h>
 #include <rte_spinlock.h>
 #include <rte_pause.h>
-#include <rte_vfio.h>
 
 #include "eal_private.h"
 
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index c6aed44946..62f9d05e63 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <dirent.h>
+#include <linux/vfio.h>
 
 #include <rte_errno.h>
 #include <rte_log.h>
-- 
2.51.0

