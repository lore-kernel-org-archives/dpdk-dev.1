Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF9FD9E2D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 02:58:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC74040656;
	Fri, 27 Feb 2026 03:57:58 +0100 (CET)
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com
 [115.124.28.146])
 by mails.dpdk.org (Postfix) with ESMTP id F10F74028E;
 Fri, 27 Feb 2026 03:57:54 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gfuCFlS_1772161071 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 27 Feb 2026 10:57:52 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v4 1/1] net/nbl: add probe checks for unsupported UIO drivers
Date: Thu, 26 Feb 2026 18:57:33 -0800
Message-Id: <20260227025734.46870-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227025734.46870-1-dimon.zhao@nebula-matrix.com>
References: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
 <20260227025734.46870-1-dimon.zhao@nebula-matrix.com>
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

The NBL PMD does not support igb_uio (deprecated) or uio_pci_generic
(lacks MSI-X support). Add explicit checks in probe to reject devices
bound to these drivers with clear error messages.
Update documentation to reflect these limitations.

Fixes: a12f1acc7bc4 ("net/nbl: check IOVA mode in Linux coexistence")
Cc: stable@dpdk.org
Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 doc/guides/nics/nbl.rst      | 14 ++++++++++++++
 drivers/net/nbl/nbl_core.c   |  2 ++
 drivers/net/nbl/nbl_ethdev.c | 11 +++++++++++
 3 files changed, 27 insertions(+)

diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
index ba0a119dfd..a9f439ae96 100644
--- a/doc/guides/nics/nbl.rst
+++ b/doc/guides/nics/nbl.rst
@@ -78,6 +78,8 @@ it is necessary to force I/O virtual address (IOVA)
 to be mapped to physical address (PA)
 with the EAL command line option ``--iova-mode=pa``.
 
+Only PF supports Coexistence Between DPDK And Kernel Driver, VF does not.
+
 
 Prerequisites
 -------------
@@ -101,3 +103,15 @@ Limitations or Known Issues
 32-bit architectures are not supported.
 
 Windows and BSD are not supported yet.
+
+**igb_uio Driver Support**
+
+The ``igb_uio`` driver is not supported.
+
+**uio_pci_generic Driver Support**
+
+The ``uio_pci_generic`` driver is not supported.
+
+**VFIO no-IOMMU mode**
+If there is no IOMMU available on the system, VF must use ``vfio`` driver in ``noiommu`` mode.
+
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 313f8c5bd6..df8c0c76ed 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -41,6 +41,8 @@ int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
 	common->eth_dev = eth_dev;
 	nbl_init_func_caps(pci_dev, &adapter->caps);
 
+	common->is_vf = (pci_dev->id.device_id == NBL_DEVICE_ID_M18100_VF);
+
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
 
 	/* every product's hw/chan/res layer has a great difference, so call their own init ops */
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index d269ea8058..5a7d8266a4 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -88,6 +88,17 @@ static int nbl_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		NBL_LOG(ERR, "Secondary process is not supported.");
 		return -ENOTSUP;
 	}
+
+	if (pci_dev->kdrv == RTE_PCI_KDRV_UIO_GENERIC) {
+		NBL_LOG(ERR, "uio_pci_generic is not supported.");
+		return -ENOTSUP;
+	}
+
+	if (pci_dev->kdrv == RTE_PCI_KDRV_IGB_UIO) {
+		NBL_LOG(ERR, "igb_uio is not supported.");
+		return -ENOTSUP;
+	}
+
 	return rte_eth_dev_pci_generic_probe(pci_dev, sizeof(struct nbl_adapter),
 					     nbl_eth_dev_init);
 }
-- 
2.34.1

