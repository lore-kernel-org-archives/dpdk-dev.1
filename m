Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDCC369C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 21:45:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0812342709;
	Wed, 16 Apr 2025 23:45:07 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 532934025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 23:45:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B3D492052511; Wed, 16 Apr 2025 14:45:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3D492052511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744839903;
 bh=WmdSEqmvPIFUjbCh10SZ8ZHYS2rgSYqTEByZti1L+Kc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i/tid4jwmdUz6SW955oVV2Jy7WuNrjSk0gK1UkocJajrEILKBAgqb5Kk2thXI0j67
 /9sJF9VKFJo8XgYjzYTeDx+TFe7zRp/oCXrgS55T1T2i+GgUFz33OKF4X+ZP5vi3UY
 tKkIDIySTNBvmY30LGtApB2i+GAy1wnX3vPqyRvs=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 4/4] drivers: use macro to embed information in binaries
Date: Wed, 16 Apr 2025 14:44:58 -0700
Message-Id: <1744839898-15745-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
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

DPDK uses GCC attribute "used" through macro __rte_used to indicate
that a variable not referenced in the code should be assumed being
used and therefore not be optimized away. This technique is used to embed
information in the binaries, by having crafted information stored in
them.

MSVC offers similar functionality, but it differs significantly: MSVC
requires a pragma to be used to send a command to the linker telling it
explicitly the name of the symbol that should be included (even if not
referenced). As a side-effect, variables called out to be included cannot
be static, otherwise their symbols are not "seen" by the linker. This
restriction requires some DPDK code to be refactored.

Macro RTE_INCLUDE is used in this patch to ensure these special variables
make it to the final binaries.

The elimination of "static" for some of these variables caused name
clashes when __COUNTER__ predefined macro was used. As a workaround,
predefined macro __LINE__ was used instead.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 +-
 drivers/bus/cdx/bus_cdx_driver.h             |  5 ++---
 drivers/bus/dpaa/bus_dpaa_driver.h           |  2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h         |  4 ++--
 drivers/bus/ifpga/bus_ifpga_driver.h         |  2 +-
 drivers/bus/pci/bus_pci_driver.h             |  2 +-
 drivers/bus/platform/bus_platform_driver.h   |  2 +-
 drivers/bus/uacce/bus_uacce_driver.h         |  2 +-
 drivers/bus/vdev/bus_vdev_driver.h           |  2 +-
 drivers/bus/vmbus/bus_vmbus_driver.h         |  2 +-
 drivers/common/mlx5/mlx5_common.c            |  2 +-
 drivers/common/mlx5/mlx5_common_pci.c        |  2 +-
 drivers/common/nitrox/nitrox_device.c        |  1 +
 drivers/compress/mlx5/mlx5_compress.c        |  2 +-
 drivers/crypto/mlx5/mlx5_crypto.c            |  2 +-
 drivers/event/octeontx/ssovf_evdev.c         |  1 +
 drivers/net/mlx4/mlx4.c                      |  2 +-
 drivers/net/mlx5/mlx5.c                      |  2 +-
 drivers/net/virtio/virtio_pci_ethdev.c       |  2 +-
 drivers/regex/mlx5/mlx5_regex.c              |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c                |  2 +-
 lib/eal/include/rte_dev.h                    | 14 +++++---------
 22 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 40ab1f0912..5a91ddbe2e 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -168,7 +168,7 @@ void rte_auxiliary_register(struct rte_auxiliary_driver *driver);
 		(auxiliary_drv).driver.name = RTE_STR(nm); \
 		rte_auxiliary_register(&(auxiliary_drv)); \
 	} \
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 /**
  * Unregister an auxiliary driver.
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index d390e7b5a1..88af08b19f 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -35,8 +35,7 @@ struct rte_cdx_bus;
 #define RTE_CDX_ANY_ID (0xffff)
 
 #define RTE_PMD_REGISTER_CDX_TABLE(name, table) \
-static const char DRV_EXP_TAG(name, cdx_tbl_export)[] __rte_used = \
-RTE_STR(table)
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, cdx_tbl_export))[] = RTE_STR(table)
 
 /** Device needs resource mapping */
 #define RTE_CDX_DRV_NEED_MAPPING 0x0001
@@ -153,7 +152,7 @@ void rte_cdx_register(struct rte_cdx_driver *driver);
 		(cdx_drv).driver.name = RTE_STR(nm);\
 		rte_cdx_register(&cdx_drv); \
 	} \
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 /**
  * Enables VFIO Interrupts for CDX bus devices.
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 26a83b2cdf..9ccc353523 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -245,7 +245,7 @@ RTE_INIT(dpaainitfn_ ##nm) \
 	(dpaa_drv).driver.name = RTE_STR(nm);\
 	rte_dpaa_driver_register(&dpaa_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 __rte_internal
 struct fm_eth_port_cfg *dpaa_get_eth_port_cfg(int dev_id);
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 1d4ce4785f..33d28e5aa4 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -205,7 +205,7 @@ RTE_INIT(dpaa2initfn_ ##nm) \
 	(dpaa2_drv).driver.name = RTE_STR(nm);\
 	rte_fslmc_driver_register(&dpaa2_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 /**
  * Register a DPAA2 MC Object driver.
@@ -236,7 +236,7 @@ RTE_INIT(dpaa2objinitfn_ ##nm) \
 	(dpaa2_obj).name = RTE_STR(nm);\
 	rte_fslmc_object_register(&dpaa2_obj); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index 56ce34c91d..b792f8e866 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -154,7 +154,7 @@ RTE_INIT(afudrvinitfn_ ##afudrv)\
 	(afudrv).driver.alias = afudrvinit_ ## nm ## _alias;\
 	rte_ifpga_driver_register(&afudrv);\
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 #define RTE_PMD_REGISTER_AFU_ALIAS(nm, alias)\
 static const char *afudrvinit_ ## nm ## _alias = RTE_STR(alias)
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index 2cc1119072..9863ae22ed 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -171,7 +171,7 @@ RTE_INIT(pciinitfn_ ##nm) \
 	(pci_drv).driver.name = RTE_STR(nm);\
 	rte_pci_register(&pci_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 /**
  * Unregister a PCI driver.
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index a6f246f7c4..0a2743900f 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -138,7 +138,7 @@ RTE_INIT(pdrvinitfn_ ##nm) \
 	(platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
 	rte_platform_register(&(platform_drv)); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 /** Helper for setting platform driver alias. */
 #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index c8e177d44f..2401401322 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -245,7 +245,7 @@ void rte_uacce_unregister(struct rte_uacce_driver *driver);
 			(uacce_drv).driver.name = RTE_STR(nm);\
 			rte_uacce_register(&uacce_drv); \
 		} \
-		RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+		RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index cba1fb5269..d46f45386e 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -139,7 +139,7 @@ RTE_INIT(vdrvinitfn_ ##vdrv)\
 	(vdrv).driver.alias = vdrvinit_ ## nm ## _alias;\
 	rte_vdev_register(&vdrv);\
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 #define RTE_PMD_REGISTER_ALIAS(nm, alias)\
 static const char *vdrvinit_ ## nm ## _alias = RTE_STR(alias)
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index bc394208de..842453434e 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -97,7 +97,7 @@ void rte_vmbus_unregister(struct rte_vmbus_driver *driver);
 		(vmbus_drv).driver.name = RTE_STR(nm);	\
 		rte_vmbus_register(&vmbus_drv);		\
 	}						\
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm, __LINE__)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 4f25127582..ebe327a950 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -1452,4 +1452,4 @@ mlx5_devx_uar_prepare(struct mlx5_common_device *cdev, struct mlx5_uar *uar)
 	return 0;
 }
 
-RTE_PMD_EXPORT_NAME(mlx5_common_driver, __COUNTER__);
+RTE_PMD_EXPORT_NAME(mlx5_common_driver, __LINE__);
diff --git a/drivers/common/mlx5/mlx5_common_pci.c b/drivers/common/mlx5/mlx5_common_pci.c
index 819b799bb8..22de17ae67 100644
--- a/drivers/common/mlx5/mlx5_common_pci.c
+++ b/drivers/common/mlx5/mlx5_common_pci.c
@@ -245,4 +245,4 @@ RTE_FINI(mlx5_common_pci_finish)
 	}
 }
 
-RTE_PMD_EXPORT_NAME(mlx5_common_pci, __COUNTER__);
+RTE_PMD_EXPORT_NAME(mlx5_common_pci, __LINE__);
diff --git a/drivers/common/nitrox/nitrox_device.c b/drivers/common/nitrox/nitrox_device.c
index 74c7a859a4..22c5d64446 100644
--- a/drivers/common/nitrox/nitrox_device.c
+++ b/drivers/common/nitrox/nitrox_device.c
@@ -144,5 +144,6 @@ static struct rte_pci_driver nitrox_pmd = {
 	.remove         = nitrox_pci_remove,
 };
 
+/* Blank line to get unique ID */
 RTE_PMD_REGISTER_PCI(nitrox, nitrox_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(nitrox, pci_id_nitrox_map);
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index 82105bfebd..17017863a4 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -937,6 +937,6 @@ RTE_INIT(rte_mlx5_compress_init)
 }
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_compress_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_COMPRESS_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_COMPRESS_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_COMPRESS_DRIVER_NAME, mlx5_compress_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_COMPRESS_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 2319c6920d..4fb7060bd0 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -514,6 +514,6 @@ RTE_PMD_REGISTER_CRYPTO_DRIVER(mlx5_cryptodev_driver, mlx5_drv,
 			       mlx5_crypto_driver_id);
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_crypto_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_CRYPTO_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_CRYPTO_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_CRYPTO_DRIVER_NAME, mlx5_crypto_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_CRYPTO_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/event/octeontx/ssovf_evdev.c b/drivers/event/octeontx/ssovf_evdev.c
index 957fcab04e..c8881f5375 100644
--- a/drivers/event/octeontx/ssovf_evdev.c
+++ b/drivers/event/octeontx/ssovf_evdev.c
@@ -971,4 +971,5 @@ static struct rte_vdev_driver vdev_ssovf_pmd = {
 	.remove = ssovf_vdev_remove
 };
 
+/* Blank line to get unique ID */
 RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_OCTEONTX_PMD, vdev_ssovf_pmd);
diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index 9c2872429f..0e7d8cdd6c 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -1385,7 +1385,7 @@ RTE_INIT(rte_mlx4_pmd_init)
 	rte_pci_register(&mlx4_driver);
 }
 
-RTE_PMD_EXPORT_NAME(net_mlx4, __COUNTER__);
+RTE_PMD_EXPORT_NAME(net_mlx4, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_mlx4, mlx4_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_mlx4,
 	"* ib_uverbs & mlx4_en & mlx4_core & mlx4_ib");
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b4bd43aae2..03a75fc0ec 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3819,6 +3819,6 @@ RTE_INIT(rte_mlx5_pmd_init)
 		mlx5_class_driver_register(&mlx5_net_driver);
 }
 
-RTE_PMD_EXPORT_NAME(MLX5_ETH_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_ETH_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_ETH_DRIVER_NAME, mlx5_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_ETH_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/net/virtio/virtio_pci_ethdev.c b/drivers/net/virtio/virtio_pci_ethdev.c
index 9b4b846f8a..a0ba770901 100644
--- a/drivers/net/virtio/virtio_pci_ethdev.c
+++ b/drivers/net/virtio/virtio_pci_ethdev.c
@@ -239,4 +239,4 @@ RTE_INIT(rte_virtio_net_pci_pmd_init)
 
 RTE_PMD_REGISTER_PCI_TABLE(net_virtio, pci_id_virtio_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_virtio, "* igb_uio | uio_pci_generic | vfio-pci");
-RTE_PMD_EXPORT_NAME(net_virtio, __COUNTER__);
+RTE_PMD_EXPORT_NAME(net_virtio, __LINE__);
diff --git a/drivers/regex/mlx5/mlx5_regex.c b/drivers/regex/mlx5/mlx5_regex.c
index 4ed62b538b..238676586c 100644
--- a/drivers/regex/mlx5/mlx5_regex.c
+++ b/drivers/regex/mlx5/mlx5_regex.c
@@ -183,6 +183,6 @@ RTE_INIT(rte_mlx5_regex_init)
 }
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_regex_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_REGEX_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_REGEX_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_REGEX_DRIVER_NAME, mlx5_regex_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_REGEX_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.c b/drivers/vdpa/mlx5/mlx5_vdpa.c
index 98c39a5e64..3450634ea9 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.c
@@ -1003,6 +1003,6 @@ RTE_INIT(rte_mlx5_vdpa_init)
 		mlx5_class_driver_register(&mlx5_vdpa_driver);
 }
 
-RTE_PMD_EXPORT_NAME(MLX5_VDPA_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_VDPA_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_VDPA_DRIVER_NAME, mlx5_vdpa_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_VDPA_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/lib/eal/include/rte_dev.h b/lib/eal/include/rte_dev.h
index 738400e8d1..39698f934f 100644
--- a/lib/eal/include/rte_dev.h
+++ b/lib/eal/include/rte_dev.h
@@ -232,21 +232,18 @@ int rte_dev_remove(struct rte_device *dev);
  */
 typedef int (*rte_dev_cmp_t)(const struct rte_device *dev, const void *data);
 
-#define RTE_PMD_EXPORT_NAME_ARRAY(n, idx) n##idx[]
+#define RTE_PMD_COMPOST_NAME(n, idx) n##idx
 
 #define RTE_PMD_EXPORT_NAME(name, idx) \
-static const char RTE_PMD_EXPORT_NAME_ARRAY(this_pmd_name, idx) \
-__rte_used = RTE_STR(name)
+RTE_INCLUDE(const char, RTE_PMD_COMPOST_NAME(this_pmd_name, idx))[] = RTE_STR(name)
 
 #define DRV_EXP_TAG(name, tag) __##name##_##tag
 
 #define RTE_PMD_REGISTER_PCI_TABLE(name, table) \
-static const char DRV_EXP_TAG(name, pci_tbl_export)[] __rte_used = \
-RTE_STR(table)
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, pci_tbl_export))[] = RTE_STR(table)
 
 #define RTE_PMD_REGISTER_PARAM_STRING(name, str) \
-static const char DRV_EXP_TAG(name, param_string_export)[] \
-__rte_used = str
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, param_string_export))[] = str
 
 /**
  * Advertise the list of kernel modules required to run this driver
@@ -270,8 +267,7 @@ __rte_used = str
  * - "* igb_uio | uio_pci_generic | vfio"
  */
 #define RTE_PMD_REGISTER_KMOD_DEP(name, str) \
-static const char DRV_EXP_TAG(name, kmod_dep_export)[] \
-__rte_used = str
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, kmod_dep_export))[] = str
 
 /**
  * Iteration context.
-- 
2.49.0.vfs.0.0

