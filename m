Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986C7FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F13C406A2;
	Wed, 29 Apr 2026 13:47:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7EC0940A4B
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPtYJjpvInihXRD/4X8QUWL7oq0TZmt6yaljcMig9OE=;
 b=VOpgREVjzPDU8jNhy+H57tuXW/M1MozY2AMWAH4sndwNZqam+JOzYaR0Vs+qae9F27pT/5
 gWFbxXZlQ9CjaF8kXy6eC1+kwW/UTaQ7Dit7lj+W7BPenO/PWwUcVVGvminaROO4uFUPst
 TJtP6g73C/EFbj6h1mGre9yKT6fcSQE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-PnsEDdNlPEKi43HrTr0OdQ-1; Wed,
 29 Apr 2026 07:47:36 -0400
X-MC-Unique: PnsEDdNlPEKi43HrTr0OdQ-1
X-Mimecast-MFC-AGG-ID: PnsEDdNlPEKi43HrTr0OdQ_1777463254
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 707F7195608F; Wed, 29 Apr 2026 11:47:34 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2E2D300019F; Wed, 29 Apr 2026 11:47:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH 18/23] drivers/bus: remove bus-specific driver references
Date: Wed, 29 Apr 2026 13:44:51 +0200
Message-ID: <20260429114503.932575-19-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4CuHY1iW3qL5AtJEEh7096gXLL6ni64zHfaPcKfjqtk_1777463254
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

With the driver reference being set in the EAL before calling
bus->probe_device, buses now rely on the generic device.driver
field instead of maintaining their own bus-specific driver pointers.

This patch removes the use of bus-specific driver fields in favor
of the generic device.driver field, accessed through the RTE_BUS_DRIVER
macro in remove/cleanup paths.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c     |  4 ----
 drivers/bus/auxiliary/bus_auxiliary_driver.h |  1 -
 drivers/bus/cdx/bus_cdx_driver.h             |  1 -
 drivers/bus/cdx/cdx.c                        |  2 --
 drivers/bus/dpaa/bus_dpaa_driver.h           |  1 -
 drivers/bus/dpaa/dpaa_bus.c                  |  3 ---
 drivers/bus/fslmc/bus_fslmc_driver.h         |  1 -
 drivers/bus/fslmc/fslmc_bus.c                |  2 --
 drivers/bus/ifpga/bus_ifpga_driver.h         |  1 -
 drivers/bus/ifpga/ifpga_bus.c                | 12 +-----------
 drivers/bus/pci/bus_pci_driver.h             |  1 -
 drivers/bus/pci/pci_common.c                 |  5 -----
 drivers/bus/platform/bus_platform_driver.h   |  1 -
 drivers/bus/platform/platform.c              |  5 +----
 drivers/bus/uacce/bus_uacce_driver.h         |  1 -
 drivers/bus/uacce/uacce.c                    |  3 ---
 drivers/bus/vmbus/bus_vmbus_driver.h         |  1 -
 drivers/bus/vmbus/vmbus_common.c             |  8 +-------
 18 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 2000ffa369..ff05716539 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -111,13 +111,10 @@ auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		return -ENOMEM;
 	}
 
-	aux_dev->driver = aux_drv;
-
 	AUXILIARY_LOG(INFO, "Probe auxiliary driver: %s device: %s (NUMA node %i)",
 		      aux_drv->driver.name, aux_dev->name, aux_dev->device.numa_node);
 	ret = aux_drv->probe(aux_drv, aux_dev);
 	if (ret != 0) {
-		aux_dev->driver = NULL;
 		rte_intr_instance_free(aux_dev->intr_handle);
 		aux_dev->intr_handle = NULL;
 	}
@@ -144,7 +141,6 @@ rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
 	}
 
 	/* clear driver structure */
-	dev->driver = NULL;
 	dev->device.driver = NULL;
 
 	return 0;
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 165145b15e..cab5f86d03 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -113,7 +113,6 @@ struct rte_auxiliary_device {
 	struct rte_device device;                 /**< Inherit core device */
 	char name[RTE_DEV_NAME_MAX_LEN + 1];      /**< ASCII device name */
 	struct rte_intr_handle *intr_handle;       /**< Interrupt handle */
-	struct rte_auxiliary_driver *driver;      /**< Device driver */
 };
 
 /**
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index cee6c4a8d6..97fd3b6f88 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -54,7 +54,6 @@ struct rte_cdx_id {
  */
 struct rte_cdx_device {
 	struct rte_device device;		/**< Inherit core device */
-	struct rte_cdx_driver *driver;		/**< CDX driver used in probing */
 	char name[RTE_DEV_NAME_MAX_LEN];	/**< Device name */
 	struct rte_cdx_id id;			/**< CDX ID. */
 	struct rte_mem_resource mem_resource[RTE_CDX_MAX_RESOURCE];
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 5a823a0dcd..cb4f755b8e 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -333,7 +333,6 @@ cdx_probe_device(struct rte_driver *drv, struct rte_device *dev)
 			cdx_drv->driver.name, dev_name, ret);
 		goto error_probe;
 	}
-	cdx_dev->driver = cdx_drv;
 
 	return ret;
 
@@ -395,7 +394,6 @@ cdx_detach_dev(struct rte_cdx_device *dev)
 	}
 
 	/* clear driver structure */
-	dev->driver = NULL;
 	dev->device.driver = NULL;
 
 	rte_cdx_unmap_device(dev);
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 7e5e9b2126..5ddb52c419 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -85,7 +85,6 @@ struct rte_dpaa_device {
 		struct rte_cryptodev *crypto_dev;
 		struct rte_dma_dev *dmadev;
 	};
-	struct rte_dpaa_driver *driver;
 	struct dpaa_device_id id;
 	struct rte_intr_handle *intr_handle;
 	enum rte_dpaa_type device_type; /**< Ethernet or crypto type device */
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 0fd6a8d7a6..ade093cd13 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -802,8 +802,6 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	ret = dpaa_drv->probe(dpaa_drv, dpaa_dev);
 	if (ret != 0)
 		DPAA_BUS_ERR("unable to probe: %s", dpaa_dev->name);
-	else
-		dpaa_dev->driver = dpaa_drv;
 
 	return ret;
 }
@@ -828,7 +826,6 @@ dpaa_bus_cleanup(void)
 			rte_errno = errno;
 			return -1;
 		}
-		dev->driver = NULL;
 		dev->device.driver = NULL;
 	}
 	dpaa_portal_finish((void *)DPAA_PER_LCORE_PORTAL);
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index ab8bc1c41d..44f81cf662 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -101,7 +101,6 @@ struct rte_dpaa2_device {
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
-	struct rte_dpaa2_driver *driver;    /**< Associated driver */
 	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
 };
 
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index e33b63259d..d855d6b36b 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -523,7 +523,6 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 	if (ret != 0) {
 		DPAA2_BUS_ERR("Unable to probe");
 	} else {
-		dev->driver = drv;
 		DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
 	}
 
@@ -538,7 +537,6 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 
 	if (drv->remove != NULL) {
 		drv->remove(dev);
-		dev->driver = NULL;
 		dev->device.driver = NULL;
 		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
 		return 0;
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index b56916167c..4df95485c9 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -75,7 +75,6 @@ struct rte_afu_device {
 						/**< AFU Memory Resource */
 	struct rte_afu_shared shared;
 	struct rte_intr_handle *intr_handle;     /**< Interrupt handle */
-	struct rte_afu_driver *driver;          /**< Associated driver */
 	char path[IFPGA_BUS_BITSTREAM_PATH_MAX_LEN];
 };
 
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index b13285230b..2c22329f65 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -272,17 +272,8 @@ ifpga_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
 	struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
 	struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(drv, *afu_drv);
-	int ret;
-
-	/* reference driver structure */
-	afu_dev->driver = afu_drv;
-
-	/* call the driver probe() function */
-	ret = afu_drv->probe(afu_dev);
-	if (ret)
-		afu_dev->driver = NULL;
 
-	return ret;
+	return afu_drv->probe(afu_dev);
 }
 
 /*
@@ -310,7 +301,6 @@ ifpga_cleanup(void)
 			rte_errno = errno;
 			error = -1;
 		}
-		afu_dev->driver = NULL;
 		afu_dev->device.driver = NULL;
 
 free:
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index b0e5428e64..cb7039f8d6 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -39,7 +39,6 @@ struct rte_pci_device {
 	struct rte_mem_resource mem_resource[PCI_MAX_RESOURCE];
 					    /**< PCI Memory Resource */
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
-	struct rte_pci_driver *driver;      /**< PCI driver used in probing */
 	uint16_t max_vfs;                   /**< sriov enable if not zero */
 	enum rte_pci_kernel_driver kdrv;    /**< Kernel driver passthrough */
 	char name[PCI_PRI_STR_SIZE+1];      /**< PCI location (ASCII) */
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index e927f4af7b..2bdb94a924 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -245,11 +245,9 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 			return -ENOMEM;
 		}
 
-		pci_dev->driver = pci_drv;
 		if (pci_drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING) {
 			ret = rte_pci_map_device(pci_dev);
 			if (ret != 0) {
-				pci_dev->driver = NULL;
 				rte_intr_instance_free(pci_dev->vfio_req_intr_handle);
 				pci_dev->vfio_req_intr_handle = NULL;
 				rte_intr_instance_free(pci_dev->intr_handle);
@@ -268,7 +266,6 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (already_probed)
 		return ret; /* no rollback if already succeeded earlier */
 	if (ret) {
-		pci_dev->driver = NULL;
 		if ((pci_drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING) &&
 			/* Don't unmap if device is unsupported and
 			 * driver needs mapped resources.
@@ -312,7 +309,6 @@ rte_pci_detach_dev(struct rte_pci_device *dev)
 	}
 
 	/* clear driver structure */
-	dev->driver = NULL;
 	dev->device.driver = NULL;
 
 	if (dr->drv_flags & RTE_PCI_DRV_NEED_MAPPING)
@@ -348,7 +344,6 @@ pci_cleanup(void)
 			rte_errno = errno;
 			error = -1;
 		}
-		dev->driver = NULL;
 		dev->device.driver = NULL;
 
 free:
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index 3912ed5b85..3ac405a201 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -95,7 +95,6 @@ struct rte_platform_resource {
  */
 struct rte_platform_device {
 	struct rte_device device; /**< Core device */
-	struct rte_platform_driver *driver; /**< Matching device driver */
 	char name[RTE_DEV_NAME_MAX_LEN]; /**< Device name */
 	unsigned int num_resource; /**< Number of device resources */
 	struct rte_platform_resource *resource; /**< Device resources */
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 433bab9b60..4492ed62ec 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -329,10 +329,8 @@ device_setup(struct rte_platform_device *pdev)
 static int
 driver_call_probe(struct rte_platform_driver *pdrv, struct rte_platform_device *pdev)
 {
-	if (pdrv->probe != NULL) {
-		pdev->driver = pdrv;
+	if (pdrv->probe != NULL)
 		return pdrv->probe(pdev);
-	}
 
 	return 0;
 }
@@ -418,7 +416,6 @@ device_release_driver(struct rte_platform_device *pdev)
 	}
 
 	pdev->device.driver = NULL;
-	pdev->driver = NULL;
 }
 
 static int
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index 04ced912c9..afed71bb67 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -44,7 +44,6 @@ struct rte_uacce_driver;
  */
 struct rte_uacce_device {
 	struct rte_device device;                /**< Inherit core device. */
-	struct rte_uacce_driver *driver;         /**< Driver used in probing. */
 	char name[RTE_DEV_NAME_MAX_LEN];         /**< Device name. */
 	char dev_root[RTE_UACCE_DEV_PATH_SIZE];  /**< Sysfs path with device name. */
 	char cdev_path[RTE_UACCE_DEV_PATH_SIZE]; /**< Device path in devfs. */
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index efc0da606b..4fc4d522a8 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -365,7 +365,6 @@ uacce_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		UACCE_BUS_ERR("probe device %s with driver %s failed %d",
 			      dev_name, uacce_drv->driver.name, ret);
 	} else {
-		uacce_dev->driver = uacce_drv;
 		UACCE_BUS_DEBUG("probe device %s with driver %s success",
 				dev_name, uacce_drv->driver.name);
 	}
@@ -394,7 +393,6 @@ uacce_cleanup(void)
 			rte_errno = errno;
 			error = -1;
 		}
-		dev->driver = NULL;
 		dev->device.driver = NULL;
 
 free:
@@ -419,7 +417,6 @@ uacce_detach_dev(struct rte_uacce_device *dev)
 			return ret;
 	}
 
-	dev->driver = NULL;
 	dev->device.driver = NULL;
 
 	return 0;
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index d53bda2340..888d856141 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -37,7 +37,6 @@ enum hv_uio_map {
  * A structure describing a VMBUS device.
  */
 struct rte_vmbus_device {
-	const struct rte_vmbus_driver *driver; /**< Associated driver */
 	struct rte_device device;              /**< Inherit core device */
 	rte_uuid_t device_id;		       /**< VMBUS device id */
 	rte_uuid_t class_id;		       /**< VMBUS device type */
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index b96f4133dd..2b1730afc2 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -107,19 +107,14 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (ret != 0)
 		return ret;
 
-	/* reference driver structure */
-	vmbus_dev->driver = vmbus_drv;
-
 	if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid);
 
 	/* call the driver probe() function */
 	VMBUS_LOG(INFO, "  probe driver: %s", vmbus_drv->driver.name);
 	ret = vmbus_drv->probe(vmbus_drv, vmbus_dev);
-	if (ret != 0) {
-		vmbus_dev->driver = NULL;
+	if (ret != 0)
 		rte_vmbus_unmap_device(vmbus_dev);
-	}
 
 	return ret;
 }
@@ -158,7 +153,6 @@ rte_vmbus_cleanup(void)
 
 		rte_vmbus_unmap_device(dev);
 
-		dev->driver = NULL;
 		dev->device.driver = NULL;
 		rte_bus_remove_device(&rte_vmbus_bus.bus, &dev->device);
 		free(dev);
-- 
2.53.0

