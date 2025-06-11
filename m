Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E40BC61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 09:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E3A040652;
	Wed, 11 Jun 2025 11:46:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 92CCB40649
 for <dev@dpdk.org>; Wed, 11 Jun 2025 11:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749635167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gU+bUqHGrPbUd3xrF32r/vjNLrzHoSMSvZ1iVkzd6kg=;
 b=Ae9G2MdryZp5oFMfG9KbvEFuW4jHoMOrsr9aKhy42FnmqiOwAynLsqrLaIaOjPjHOcxUfZ
 iJzcQnLPVG4CpKl8yGAxkAEWuU6UZS6anj+r+HwvXevjVVtB3eu5sPJNpR9SNYdWj03Bfg
 eXvSzUP4Uy9zdOPh1gg7Fc9naPtoDMk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-fw_YFAHbPVizuMoL4FRakg-1; Wed,
 11 Jun 2025 05:46:03 -0400
X-MC-Unique: fw_YFAHbPVizuMoL4FRakg-1
X-Mimecast-MFC-AGG-ID: fw_YFAHbPVizuMoL4FRakg_1749635160
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 587401956087; Wed, 11 Jun 2025 09:46:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 731521956087; Wed, 11 Jun 2025 09:45:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 2/5] dev: rename pmdinfo internal symbols
Date: Wed, 11 Jun 2025 11:45:29 +0200
Message-ID: <20250611094532.1242167-3-david.marchand@redhat.com>
In-Reply-To: <20250611094532.1242167-1-david.marchand@redhat.com>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KCLWMAWPWxy6XsH9tuQiTkoBs3r1Qgngn0SOqtMUj0k_1749635160
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

__COUNTER__ is not supported by MSVC.
Plus the this_pmd_name* symbols will become global (again for MSVC) in a
next commit.
Prefer the driver name to generate a unique symbol.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 buildtools/pmdinfogen.py                     | 2 +-
 drivers/bus/auxiliary/bus_auxiliary_driver.h | 2 +-
 drivers/bus/cdx/bus_cdx_driver.h             | 2 +-
 drivers/bus/dpaa/bus_dpaa_driver.h           | 2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h         | 4 ++--
 drivers/bus/ifpga/bus_ifpga_driver.h         | 2 +-
 drivers/bus/pci/bus_pci_driver.h             | 2 +-
 drivers/bus/platform/bus_platform_driver.h   | 2 +-
 drivers/bus/uacce/bus_uacce_driver.h         | 2 +-
 drivers/bus/vdev/bus_vdev_driver.h           | 2 +-
 drivers/bus/vmbus/bus_vmbus_driver.h         | 2 +-
 drivers/common/mlx5/mlx5_common.c            | 2 +-
 drivers/common/mlx5/mlx5_common_pci.c        | 2 +-
 drivers/compress/mlx5/mlx5_compress.c        | 2 +-
 drivers/crypto/mlx5/mlx5_crypto.c            | 2 +-
 drivers/net/mlx4/mlx4.c                      | 2 +-
 drivers/net/mlx5/mlx5.c                      | 2 +-
 drivers/net/virtio/virtio_pci_ethdev.c       | 2 +-
 drivers/regex/mlx5/mlx5_regex.c              | 2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c                | 2 +-
 lib/eal/include/dev_driver.h                 | 7 ++-----
 21 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/buildtools/pmdinfogen.py b/buildtools/pmdinfogen.py
index dfb89500c0..7be2e39dd2 100755
--- a/buildtools/pmdinfogen.py
+++ b/buildtools/pmdinfogen.py
@@ -200,7 +200,7 @@ def dump(self, file):
 
 def load_drivers(image):
     drivers = []
-    for symbol in image.find_by_pattern("^this_pmd_name[0-9]+$"):
+    for symbol in image.find_by_pattern("^this_pmd_name[0-9a-zA-Z_]+$"):
         drivers.append(Driver.load(image, symbol))
     return drivers
 
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 40ab1f0912..1dc814151e 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -168,7 +168,7 @@ void rte_auxiliary_register(struct rte_auxiliary_driver *driver);
 		(auxiliary_drv).driver.name = RTE_STR(nm); \
 		rte_auxiliary_register(&(auxiliary_drv)); \
 	} \
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm)
 
 /**
  * Unregister an auxiliary driver.
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index d390e7b5a1..4febf1fd3b 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -153,7 +153,7 @@ void rte_cdx_register(struct rte_cdx_driver *driver);
 		(cdx_drv).driver.name = RTE_STR(nm);\
 		rte_cdx_register(&cdx_drv); \
 	} \
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm)
 
 /**
  * Enables VFIO Interrupts for CDX bus devices.
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 26a83b2cdf..325071dc0f 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -245,7 +245,7 @@ RTE_INIT(dpaainitfn_ ##nm) \
 	(dpaa_drv).driver.name = RTE_STR(nm);\
 	rte_dpaa_driver_register(&dpaa_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm)
 
 __rte_internal
 struct fm_eth_port_cfg *dpaa_get_eth_port_cfg(int dev_id);
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 1d4ce4785f..442de1a3fb 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -205,7 +205,7 @@ RTE_INIT(dpaa2initfn_ ##nm) \
 	(dpaa2_drv).driver.name = RTE_STR(nm);\
 	rte_fslmc_driver_register(&dpaa2_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm)
 
 /**
  * Register a DPAA2 MC Object driver.
@@ -236,7 +236,7 @@ RTE_INIT(dpaa2objinitfn_ ##nm) \
 	(dpaa2_obj).name = RTE_STR(nm);\
 	rte_fslmc_object_register(&dpaa2_obj); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index 56ce34c91d..d34ab8cec1 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -154,7 +154,7 @@ RTE_INIT(afudrvinitfn_ ##afudrv)\
 	(afudrv).driver.alias = afudrvinit_ ## nm ## _alias;\
 	rte_ifpga_driver_register(&afudrv);\
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm)
 
 #define RTE_PMD_REGISTER_AFU_ALIAS(nm, alias)\
 static const char *afudrvinit_ ## nm ## _alias = RTE_STR(alias)
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index 2cc1119072..54e25c8c2a 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -171,7 +171,7 @@ RTE_INIT(pciinitfn_ ##nm) \
 	(pci_drv).driver.name = RTE_STR(nm);\
 	rte_pci_register(&pci_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm)
 
 /**
  * Unregister a PCI driver.
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index a6f246f7c4..ef4b27c0c0 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -138,7 +138,7 @@ RTE_INIT(pdrvinitfn_ ##nm) \
 	(platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
 	rte_platform_register(&(platform_drv)); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm)
 
 /** Helper for setting platform driver alias. */
 #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index c8e177d44f..618e0f9b76 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -245,7 +245,7 @@ void rte_uacce_unregister(struct rte_uacce_driver *driver);
 			(uacce_drv).driver.name = RTE_STR(nm);\
 			rte_uacce_register(&uacce_drv); \
 		} \
-		RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+		RTE_PMD_EXPORT_NAME(nm)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index cba1fb5269..17efec51a3 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -139,7 +139,7 @@ RTE_INIT(vdrvinitfn_ ##vdrv)\
 	(vdrv).driver.alias = vdrvinit_ ## nm ## _alias;\
 	rte_vdev_register(&vdrv);\
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm)
 
 #define RTE_PMD_REGISTER_ALIAS(nm, alias)\
 static const char *vdrvinit_ ## nm ## _alias = RTE_STR(alias)
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index 0a56275437..485bfde720 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -101,7 +101,7 @@ void rte_vmbus_unregister(struct rte_vmbus_driver *driver);
 		(vmbus_drv).driver.name = RTE_STR(nm);	\
 		rte_vmbus_register(&vmbus_drv);		\
 	}						\
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 4f25127582..0c95aa2993 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -1452,4 +1452,4 @@ mlx5_devx_uar_prepare(struct mlx5_common_device *cdev, struct mlx5_uar *uar)
 	return 0;
 }
 
-RTE_PMD_EXPORT_NAME(mlx5_common_driver, __COUNTER__);
+RTE_PMD_EXPORT_NAME(mlx5_common_driver);
diff --git a/drivers/common/mlx5/mlx5_common_pci.c b/drivers/common/mlx5/mlx5_common_pci.c
index 819b799bb8..8bd43bc166 100644
--- a/drivers/common/mlx5/mlx5_common_pci.c
+++ b/drivers/common/mlx5/mlx5_common_pci.c
@@ -245,4 +245,4 @@ RTE_FINI(mlx5_common_pci_finish)
 	}
 }
 
-RTE_PMD_EXPORT_NAME(mlx5_common_pci, __COUNTER__);
+RTE_PMD_EXPORT_NAME(mlx5_common_pci);
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index 82105bfebd..e5325c6150 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -937,6 +937,6 @@ RTE_INIT(rte_mlx5_compress_init)
 }
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_compress_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_COMPRESS_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_COMPRESS_DRIVER_NAME);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_COMPRESS_DRIVER_NAME, mlx5_compress_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_COMPRESS_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 2319c6920d..78a9e3d0fe 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -514,6 +514,6 @@ RTE_PMD_REGISTER_CRYPTO_DRIVER(mlx5_cryptodev_driver, mlx5_drv,
 			       mlx5_crypto_driver_id);
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_crypto_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_CRYPTO_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_CRYPTO_DRIVER_NAME);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_CRYPTO_DRIVER_NAME, mlx5_crypto_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_CRYPTO_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index 9c2872429f..997829a107 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -1385,7 +1385,7 @@ RTE_INIT(rte_mlx4_pmd_init)
 	rte_pci_register(&mlx4_driver);
 }
 
-RTE_PMD_EXPORT_NAME(net_mlx4, __COUNTER__);
+RTE_PMD_EXPORT_NAME(net_mlx4);
 RTE_PMD_REGISTER_PCI_TABLE(net_mlx4, mlx4_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_mlx4,
 	"* ib_uverbs & mlx4_en & mlx4_core & mlx4_ib");
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b4bd43aae2..8cf8322b34 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3819,6 +3819,6 @@ RTE_INIT(rte_mlx5_pmd_init)
 		mlx5_class_driver_register(&mlx5_net_driver);
 }
 
-RTE_PMD_EXPORT_NAME(MLX5_ETH_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_ETH_DRIVER_NAME);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_ETH_DRIVER_NAME, mlx5_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_ETH_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/net/virtio/virtio_pci_ethdev.c b/drivers/net/virtio/virtio_pci_ethdev.c
index 9b4b846f8a..daf513d04d 100644
--- a/drivers/net/virtio/virtio_pci_ethdev.c
+++ b/drivers/net/virtio/virtio_pci_ethdev.c
@@ -239,4 +239,4 @@ RTE_INIT(rte_virtio_net_pci_pmd_init)
 
 RTE_PMD_REGISTER_PCI_TABLE(net_virtio, pci_id_virtio_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_virtio, "* igb_uio | uio_pci_generic | vfio-pci");
-RTE_PMD_EXPORT_NAME(net_virtio, __COUNTER__);
+RTE_PMD_EXPORT_NAME(net_virtio);
diff --git a/drivers/regex/mlx5/mlx5_regex.c b/drivers/regex/mlx5/mlx5_regex.c
index 4ed62b538b..042f585abd 100644
--- a/drivers/regex/mlx5/mlx5_regex.c
+++ b/drivers/regex/mlx5/mlx5_regex.c
@@ -183,6 +183,6 @@ RTE_INIT(rte_mlx5_regex_init)
 }
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_regex_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_REGEX_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_REGEX_DRIVER_NAME);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_REGEX_DRIVER_NAME, mlx5_regex_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_REGEX_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.c b/drivers/vdpa/mlx5/mlx5_vdpa.c
index 98c39a5e64..11708e2005 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.c
@@ -1003,6 +1003,6 @@ RTE_INIT(rte_mlx5_vdpa_init)
 		mlx5_class_driver_register(&mlx5_vdpa_driver);
 }
 
-RTE_PMD_EXPORT_NAME(MLX5_VDPA_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_VDPA_DRIVER_NAME);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_VDPA_DRIVER_NAME, mlx5_vdpa_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_VDPA_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/lib/eal/include/dev_driver.h b/lib/eal/include/dev_driver.h
index 22e48226f9..7766038b1b 100644
--- a/lib/eal/include/dev_driver.h
+++ b/lib/eal/include/dev_driver.h
@@ -30,11 +30,8 @@ struct rte_device {
 	struct rte_devargs *devargs;  /**< Arguments for latest probing */
 };
 
-#define RTE_PMD_EXPORT_NAME_ARRAY(n, idx) n##idx[]
-
-#define RTE_PMD_EXPORT_NAME(name, idx) \
-static const char RTE_PMD_EXPORT_NAME_ARRAY(this_pmd_name, idx) \
-__rte_used = RTE_STR(name)
+#define RTE_PMD_EXPORT_NAME(name) \
+static const char this_pmd_name ## name __rte_used = RTE_STR(name)
 
 #define DRV_EXP_TAG(name, tag) __##name##_##tag
 
-- 
2.49.0

