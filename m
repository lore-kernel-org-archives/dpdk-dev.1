Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C7FCD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 06:13:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DC214066B;
	Wed,  6 May 2026 08:13:27 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 478B94027E
 for <dev@dpdk.org>; Wed,  6 May 2026 08:13:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7sX_2_ppDUE1EA--.16873S6;
 Wed, 06 May 2026 14:13:20 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v8 04/10] common/sxe2: add base driver skeleton
Date: Wed,  6 May 2026 14:12:53 +0800
Message-ID: <20260506061301.817613-5-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506061301.817613-1-liujie5@linkdatatechnology.com>
References: <20260506033123.726997-10-liujie5@linkdatatechnology.com>
 <20260506061301.817613-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7sX_2_ppDUE1EA--.16873S6
X-Coremail-Antispam: 1UD129KBjvAXoWftrykKryUAF4kAr1fJF4fKrg_yoW5ArW7Go
 W7WFZxXw1fXrn7A3yUXw1xt3s3Ww4kW3sxJr4Fkrsru3Z8t345GF97Kw45ZF1DWF4rAr1a
 k3Z2v3yxGrs7GrWkn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUAwIDUUUUU==
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Initialize the sxe2 PMD skeleton by implementing the PCI probe and
remove functions. This includes the setup and cleanup of a character
device used for control path communication between the user space
and the hardware.

The character device provides an interface for ioctl-based management
operations, supporting device-specific configuration.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/meson.build            |   2 +
 drivers/common/sxe2/sxe2_common.c          | 636 +++++++++++++++++++++
 drivers/common/sxe2/sxe2_common.h          |  86 +++
 drivers/common/sxe2/sxe2_ioctl_chnl.c      | 161 ++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.h      | 141 +++++
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |  45 ++
 6 files changed, 1071 insertions(+)
 create mode 100644 drivers/common/sxe2/sxe2_common.c
 create mode 100644 drivers/common/sxe2/sxe2_common.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.c
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl_func.h

diff --git a/drivers/common/sxe2/meson.build b/drivers/common/sxe2/meson.build
index 7d448629d5..3626fb1119 100644
--- a/drivers/common/sxe2/meson.build
+++ b/drivers/common/sxe2/meson.build
@@ -9,5 +9,7 @@ cflags += [
 deps += ['bus_pci', 'net', 'eal', 'ethdev']
 
 sources = files(
+        'sxe2_common.c',
         'sxe2_common_log.c',
+        'sxe2_ioctl_chnl.c',
 )
diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
new file mode 100644
index 0000000000..dfdefb8b78
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -0,0 +1,636 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_version.h>
+#include <rte_pci.h>
+#include <rte_dev.h>
+#include <rte_devargs.h>
+#include <rte_class.h>
+#include <rte_malloc.h>
+#include <rte_errno.h>
+#include <rte_fbarray.h>
+#include <rte_eal.h>
+#include <eal_private.h>
+#include <eal_memcfg.h>
+#include <bus_driver.h>
+#include <bus_pci_driver.h>
+#include <eal_export.h>
+
+#include "sxe2_errno.h"
+#include "sxe2_common.h"
+#include "sxe2_common_log.h"
+#include "sxe2_ioctl_chnl_func.h"
+
+static TAILQ_HEAD(sxe2_class_drivers, sxe2_class_driver) sxe2_class_drivers_list =
+				TAILQ_HEAD_INITIALIZER(sxe2_class_drivers_list);
+
+static TAILQ_HEAD(sxe2_common_devices, sxe2_common_device) sxe2_common_devices_list =
+				TAILQ_HEAD_INITIALIZER(sxe2_common_devices_list);
+
+static pthread_mutex_t sxe2_common_devices_list_lock;
+
+static struct rte_pci_id *sxe2_common_pci_id_table;
+
+static const struct {
+	const s8 *name;
+	u32 class_type;
+} sxe2_class_types[] = {
+	{ .name = "eth", .class_type = SXE2_CLASS_TYPE_ETH },
+	{ .name = "vdpa", .class_type = SXE2_CLASS_TYPE_VDPA },
+};
+
+static u32 sxe2_class_name_to_value(const s8 *class_name)
+{
+	u32 class_type = SXE2_CLASS_TYPE_INVALID;
+	u32 i;
+
+	for (i = 0; i < RTE_DIM(sxe2_class_types); i++) {
+		if (strcmp(class_name, sxe2_class_types[i].name) == 0)
+			class_type = sxe2_class_types[i].class_type;
+	}
+
+	return class_type;
+}
+
+static struct sxe2_common_device *sxe2_rtedev_to_cdev(struct rte_device *rte_dev)
+{
+	struct sxe2_common_device *cdev = NULL;
+
+	TAILQ_FOREACH(cdev, &sxe2_common_devices_list, next) {
+		if (rte_dev == cdev->dev)
+			goto l_end;
+	}
+
+	cdev = NULL;
+l_end:
+	return cdev;
+}
+
+static struct sxe2_class_driver *sxe2_class_driver_get(u32 class_type)
+{
+	struct sxe2_class_driver *cdrv = NULL;
+
+	TAILQ_FOREACH(cdrv, &sxe2_class_drivers_list, next) {
+		if (cdrv->drv_class == class_type)
+			goto l_end;
+	}
+
+	cdrv = NULL;
+l_end:
+	return cdrv;
+}
+
+static s32 sxe2_kvargs_preprocessing(struct sxe2_dev_kvargs_info *kv_info,
+			const struct rte_devargs *devargs)
+{
+	const struct rte_kvargs_pair *pair;
+	struct rte_kvargs *kvlist;
+	s32 ret = SXE2_ERROR;
+	u32 i;
+
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (kvlist == NULL) {
+		ret = SXE2_ERR_INVAL;
+		goto l_end;
+	}
+
+	for	(i = 0; i < kvlist->count; i++) {
+		pair = &kvlist->pairs[i];
+		if (pair->value == NULL || *(pair->value) == '\0') {
+			PMD_LOG_ERR(COM, "Key %s has no value.", pair->key);
+			rte_kvargs_free(kvlist);
+			ret = SXE2_ERR_INVAL;
+			goto l_end;
+		}
+	}
+
+	kv_info->kvlist = kvlist;
+	ret = SXE2_SUCCESS;
+	PMD_LOG_DEBUG(COM, "kvargs %d preprocessing success.",
+			kv_info->kvlist->count);
+l_end:
+	return ret;
+}
+
+static void sxe2_kvargs_free(struct sxe2_dev_kvargs_info *kv_info)
+{
+	if ((kv_info != NULL) && (kv_info->kvlist != NULL)) {
+		rte_kvargs_free(kv_info->kvlist);
+		kv_info->kvlist = NULL;
+	}
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_kvargs_process)
+s32
+sxe2_kvargs_process(struct sxe2_dev_kvargs_info *kv_info,
+		const s8 *const key_match, arg_handler_t handler, void *opaque_arg)
+{
+	const struct rte_kvargs_pair *pair;
+	struct rte_kvargs *kvlist;
+	u32 i;
+	s32 ret = SXE2_SUCCESS;
+
+	if ((kv_info == NULL) || (kv_info->kvlist == NULL) ||
+			(key_match == NULL)) {
+		PMD_LOG_ERR(COM, "Failed to process kvargs, NULL parameter.");
+		ret = SXE2_ERR_INVAL;
+		goto l_end;
+	}
+	kvlist = kv_info->kvlist;
+
+	for (i = 0; i < kvlist->count; i++) {
+		pair = &kvlist->pairs[i];
+		if (strcmp(pair->key, key_match) == 0) {
+			ret = (*handler)(pair->key, pair->value, opaque_arg);
+			if (ret)
+				goto l_end;
+
+			kv_info->is_used[i] = true;
+			break;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_parse_class_type(const s8 *key, const s8 *value, void *args)
+{
+	u32 *class_type = (u32 *)args;
+	s32 ret = SXE2_SUCCESS;
+
+	*class_type = sxe2_class_name_to_value(value);
+	if (*class_type == SXE2_CLASS_TYPE_INVALID) {
+		ret = SXE2_ERR_INVAL;
+		PMD_LOG_ERR(COM, "Unsupported %s type: %s", key, value);
+	}
+
+	return ret;
+}
+
+static s32 sxe2_common_device_setup(struct sxe2_common_device *cdev)
+{
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	s32 ret = SXE2_SUCCESS;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto l_end;
+
+	ret = sxe2_drv_dev_open(cdev, pci_dev);
+	if (ret != SXE2_SUCCESS) {
+		PMD_LOG_ERR(COM, "Open pmd chrdev failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_handshark(cdev);
+	if (ret != SXE2_SUCCESS) {
+		PMD_LOG_ERR(COM, "Handshark failed, ret=%d", ret);
+		goto l_close_dev;
+	}
+
+	goto l_end;
+
+l_close_dev:
+	sxe2_drv_dev_close(cdev);
+l_end:
+	return ret;
+}
+
+static void sxe2_common_device_cleanup(struct sxe2_common_device *cdev)
+{
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return;
+
+	if (TAILQ_EMPTY(&sxe2_common_devices_list))
+		(void)rte_mem_event_callback_unregister("SXE2_MEM_ENVENT_CB", NULL);
+
+	sxe2_drv_dev_close(cdev);
+}
+
+static struct sxe2_common_device *sxe2_common_device_alloc(
+		struct rte_device *rte_dev, u32 class_type)
+{
+	struct sxe2_common_device *cdev = NULL;
+
+	cdev = rte_zmalloc("sxe2_common_device", sizeof(*cdev), 0);
+	if (cdev == NULL) {
+		PMD_LOG_ERR(COM, "Fail to alloc sxe2 common device.");
+		goto l_end;
+	}
+	cdev->dev = rte_dev;
+	cdev->class_type = class_type;
+	cdev->config.kernel_reset = false;
+	rte_ticketlock_init(&cdev->config.lock);
+
+	(void)pthread_mutex_lock(&sxe2_common_devices_list_lock);
+	TAILQ_INSERT_TAIL(&sxe2_common_devices_list, cdev, next);
+	(void)pthread_mutex_unlock(&sxe2_common_devices_list_lock);
+
+l_end:
+	return cdev;
+}
+
+static void sxe2_common_device_free(struct sxe2_common_device *cdev)
+{
+
+	(void)pthread_mutex_lock(&sxe2_common_devices_list_lock);
+	TAILQ_REMOVE(&sxe2_common_devices_list, cdev, next);
+	(void)pthread_mutex_unlock(&sxe2_common_devices_list_lock);
+
+	rte_free(cdev);
+}
+
+static bool sxe2_dev_is_pci(const struct rte_device *dev)
+{
+	return strcmp(dev->bus->name, "pci") == 0;
+}
+
+static bool sxe2_dev_pci_id_match(const struct sxe2_class_driver *cdrv,
+			const struct rte_device *dev)
+{
+	const struct rte_pci_device *pci_dev;
+	const struct rte_pci_id *id_table;
+	bool ret = false;
+
+	if (!sxe2_dev_is_pci(dev)) {
+		PMD_LOG_ERR(COM, "Device %s is not a PCI device", dev->name);
+		goto l_end;
+	}
+
+	pci_dev = RTE_DEV_TO_PCI_CONST(dev);
+	for (id_table = cdrv->id_table; id_table->vendor_id != 0;
+			id_table++) {
+
+		if (id_table->vendor_id != pci_dev->id.vendor_id &&
+				id_table->vendor_id != RTE_PCI_ANY_ID) {
+			continue;
+		}
+		if (id_table->device_id != pci_dev->id.device_id &&
+				id_table->device_id != RTE_PCI_ANY_ID) {
+			continue;
+		}
+		if (id_table->subsystem_vendor_id !=
+				pci_dev->id.subsystem_vendor_id &&
+				id_table->subsystem_vendor_id != RTE_PCI_ANY_ID) {
+			continue;
+		}
+		if (id_table->subsystem_device_id !=
+				pci_dev->id.subsystem_device_id &&
+				id_table->subsystem_device_id != RTE_PCI_ANY_ID) {
+
+			continue;
+		}
+		if (id_table->class_id != pci_dev->id.class_id &&
+				id_table->class_id != RTE_CLASS_ANY_ID) {
+			continue;
+		}
+		ret = true;
+		break;
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_classes_driver_probe(struct sxe2_common_device *cdev,
+		struct sxe2_dev_kvargs_info *kv_info, u32 class_type)
+{
+	struct sxe2_class_driver *cdrv = NULL;
+	s32 ret = SXE2_ERROR;
+
+	cdrv = sxe2_class_driver_get(class_type);
+	if (cdrv == NULL) {
+		PMD_LOG_ERR(COM, "Fail to get class type[%u] driver.", class_type);
+		goto l_end;
+	}
+
+	if (!sxe2_dev_pci_id_match(cdrv, cdev->dev)) {
+		PMD_LOG_ERR(COM, "Fail to match pci id for driver:%s.", cdrv->name);
+		goto l_end;
+	}
+
+	ret = cdrv->probe(cdev, kv_info);
+	if (ret) {
+
+		PMD_LOG_DEBUG(COM, "Fail to probe driver:%s.", cdrv->name);
+		goto l_end;
+	}
+
+	cdev->cdrv = cdrv;
+l_end:
+	return ret;
+}
+
+static s32 sxe2_classes_driver_remove(struct sxe2_common_device *cdev)
+{
+	struct sxe2_class_driver *cdrv = cdev->cdrv;
+
+	return cdrv->remove(cdev);
+}
+
+static s32 sxe2_kvargs_validate(struct sxe2_dev_kvargs_info *kv_info)
+{
+	s32 ret = SXE2_SUCCESS;
+	u32 i;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto l_end;
+
+	if (kv_info == NULL)
+		goto l_end;
+
+	for (i = 0; i < kv_info->kvlist->count; i++) {
+		if (kv_info->is_used[i] == 0) {
+			PMD_LOG_ERR(COM, "Key \"%s\" is unsupported for the class driver.",
+					kv_info->kvlist->pairs[i].key);
+			ret = SXE2_ERR_INVAL;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_common_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+		struct rte_pci_device *pci_dev)
+{
+	struct rte_device *rte_dev =  &pci_dev->device;
+	struct sxe2_common_device *cdev;
+	struct sxe2_dev_kvargs_info *kv_info_p = NULL;
+
+	u32 class_type = SXE2_CLASS_TYPE_ETH;
+	s32 ret = SXE2_ERROR;
+
+	PMD_LOG_INFO(COM, "Probe pci device: %s", pci_dev->name);
+
+	cdev = sxe2_rtedev_to_cdev(rte_dev);
+	if (cdev != NULL) {
+		PMD_LOG_ERR(COM, "Device %s already probed.", rte_dev->name);
+		ret = SXE2_ERR_BUSY;
+		goto l_end;
+	}
+
+	if ((rte_dev->devargs != NULL) && (rte_dev->devargs->args != NULL)) {
+		kv_info_p = calloc(1, sizeof(struct sxe2_dev_kvargs_info));
+		if (!kv_info_p) {
+			PMD_LOG_ERR(COM, "Failed to allocate memory for kv_info");
+			goto l_end;
+		}
+
+		ret = sxe2_kvargs_preprocessing(kv_info_p, rte_dev->devargs);
+		if (ret < 0) {
+			PMD_LOG_ERR(COM, "Unsupported device args: %s",
+				rte_dev->devargs->args);
+			goto l_free_kvargs;
+		}
+
+		ret = sxe2_kvargs_process(kv_info_p, SXE2_DEVARGS_KEY_CLASS,
+				sxe2_parse_class_type, &class_type);
+		if (ret < 0) {
+			PMD_LOG_ERR(COM, "Unsupported sxe2 driver class: %s",
+				rte_dev->devargs->args);
+			goto l_free_args;
+		}
+
+	}
+
+	cdev = sxe2_common_device_alloc(rte_dev, class_type);
+	if (cdev == NULL) {
+		ret = SXE2_ERR_NOMEM;
+		goto l_free_args;
+	}
+
+	ret = sxe2_common_device_setup(cdev);
+	if (ret != SXE2_SUCCESS)
+		goto l_err_setup;
+
+	ret = sxe2_classes_driver_probe(cdev, kv_info_p, class_type);
+	if (ret != SXE2_SUCCESS)
+		goto l_err_probe;
+
+	ret = sxe2_kvargs_validate(kv_info_p);
+	if (ret != SXE2_SUCCESS) {
+		PMD_LOG_ERR(COM, "Device args validate failed: %s",
+			rte_dev->devargs->args);
+		goto l_err_valid;
+	}
+	cdev->kvargs = kv_info_p;
+
+	goto l_end;
+l_err_valid:
+	(void)sxe2_classes_driver_remove(cdev);
+l_err_probe:
+	sxe2_common_device_cleanup(cdev);
+l_err_setup:
+	sxe2_common_device_free(cdev);
+l_free_args:
+	sxe2_kvargs_free(kv_info_p);
+l_free_kvargs:
+	free(kv_info_p);
+l_end:
+	return ret;
+}
+
+static s32 sxe2_common_pci_remove(struct rte_pci_device *pci_dev)
+{
+	struct sxe2_common_device *cdev;
+	s32 ret = SXE2_ERROR;
+
+	PMD_LOG_INFO(COM, "Remove pci device: %s", pci_dev->name);
+	cdev = sxe2_rtedev_to_cdev(&pci_dev->device);
+	if (cdev == NULL) {
+		ret = SXE2_ERR_NODEV;
+		PMD_LOG_ERR(COM, "Fail to get remove device.");
+		goto l_end;
+	}
+
+	ret = sxe2_classes_driver_remove(cdev);
+	if (ret != SXE2_SUCCESS) {
+		PMD_LOG_ERR(COM, "Fail to remove device: %s", pci_dev->name);
+		goto l_end;
+	}
+
+	sxe2_common_device_cleanup(cdev);
+
+	if (cdev->kvargs != NULL) {
+		sxe2_kvargs_free(cdev->kvargs);
+		free(cdev->kvargs);
+		cdev->kvargs = NULL;
+	}
+
+	sxe2_common_device_free(cdev);
+
+l_end:
+	return ret;
+}
+
+static struct rte_pci_driver sxe2_common_pci_driver = {
+	.driver = {
+		   .name = SXE2_COMMON_PCI_DRIVER_NAME,
+	},
+	.probe = sxe2_common_pci_probe,
+	.remove = sxe2_common_pci_remove,
+};
+
+static u32 sxe2_common_pci_id_table_size_get(const struct rte_pci_id *id_table)
+{
+	u32 table_size = 0;
+
+	while (id_table->vendor_id != 0) {
+		table_size++;
+		id_table++;
+	}
+
+	return table_size;
+}
+
+static bool sxe2_common_pci_id_exists(const struct rte_pci_id *id,
+		const struct rte_pci_id *id_table, u32 next_idx)
+{
+	s32 current_size = next_idx - 1;
+	s32 i;
+	bool exists = false;
+
+	for (i = 0; i < current_size; i++) {
+		if ((id->device_id == id_table[i].device_id) &&
+				(id->vendor_id == id_table[i].vendor_id) &&
+				(id->subsystem_vendor_id == id_table[i].subsystem_vendor_id) &&
+				(id->subsystem_device_id == id_table[i].subsystem_device_id)) {
+			exists = true;
+			break;
+		}
+	}
+
+	return exists;
+}
+
+static void sxe2_common_pci_id_insert(struct rte_pci_id *id_table,
+		u32 *next_idx, const struct rte_pci_id *insert_table)
+{
+	for (; insert_table->vendor_id != 0; insert_table++) {
+		if (!sxe2_common_pci_id_exists(insert_table, id_table, *next_idx)) {
+
+			id_table[*next_idx] = *insert_table;
+			(*next_idx)++;
+		}
+	}
+}
+
+static s32 sxe2_common_pci_id_table_update(const struct rte_pci_id *id_table)
+{
+	const struct rte_pci_id *id_iter;
+	struct rte_pci_id *updated_table;
+	struct rte_pci_id *old_table;
+	u32 num_ids = 0;
+	u32 i = 0;
+	s32 ret = SXE2_SUCCESS;
+
+	old_table = sxe2_common_pci_id_table;
+	if (old_table)
+		num_ids = sxe2_common_pci_id_table_size_get(old_table);
+
+	num_ids += sxe2_common_pci_id_table_size_get(id_table);
+
+	num_ids += 1;
+
+	updated_table = calloc(num_ids, sizeof(*updated_table));
+	if (!updated_table) {
+		PMD_LOG_ERR(COM, "Failed to allocate memory for PCI ID table");
+		goto l_end;
+	}
+
+	if (old_table == NULL) {
+
+		for (id_iter = id_table; id_iter->vendor_id != 0;
+				id_iter++, i++)
+			updated_table[i] = *id_iter;
+	} else {
+
+		for (id_iter = old_table; id_iter->vendor_id != 0;
+				id_iter++, i++)
+			updated_table[i] = *id_iter;
+
+		sxe2_common_pci_id_insert(updated_table, &i, id_table);
+	}
+
+	updated_table[i].vendor_id = 0;
+	sxe2_common_pci_driver.id_table = updated_table;
+	sxe2_common_pci_id_table = updated_table;
+	free(old_table);
+
+l_end:
+	return ret;
+}
+
+static void sxe2_common_driver_on_register_pci(struct sxe2_class_driver *driver)
+{
+	if (driver->id_table != NULL) {
+		if (sxe2_common_pci_id_table_update(driver->id_table) != 0)
+			return;
+	}
+
+	if (driver->intr_lsc)
+		sxe2_common_pci_driver.drv_flags |= RTE_PCI_DRV_INTR_LSC;
+	if (driver->intr_rmv)
+		sxe2_common_pci_driver.drv_flags |= RTE_PCI_DRV_INTR_RMV;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_class_driver_register)
+void
+sxe2_class_driver_register(struct sxe2_class_driver *driver)
+{
+	sxe2_common_driver_on_register_pci(driver);
+	TAILQ_INSERT_TAIL(&sxe2_class_drivers_list, driver, next);
+}
+
+static void sxe2_common_pci_init(void)
+{
+	const struct rte_pci_id empty_table[] = {
+		{
+			.vendor_id = 0
+		},
+	};
+	s32 ret = SXE2_ERROR;
+
+	if (sxe2_common_pci_id_table == NULL) {
+		ret = sxe2_common_pci_id_table_update(empty_table);
+		if (ret != SXE2_SUCCESS)
+			goto l_end;
+	}
+	rte_pci_register(&sxe2_common_pci_driver);
+
+l_end:
+	return;
+}
+
+static bool sxe2_commoin_inited;
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_common_init)
+void
+sxe2_common_init(void)
+{
+	if (sxe2_commoin_inited)
+		goto l_end;
+
+	pthread_mutex_init(&sxe2_common_devices_list_lock, NULL);
+#ifdef SXE2_DPDK_DEBUG
+	sxe2_common_log_stream_init();
+#endif
+	sxe2_common_pci_init();
+	sxe2_commoin_inited = true;
+
+l_end:
+	return;
+}
+
+RTE_FINI(sxe2_common_pci_finish)
+{
+	if (sxe2_common_pci_id_table != NULL) {
+		rte_pci_unregister(&sxe2_common_pci_driver);
+		free(sxe2_common_pci_id_table);
+	}
+}
+
+RTE_PMD_EXPORT_NAME(sxe2_common_pci);
diff --git a/drivers/common/sxe2/sxe2_common.h b/drivers/common/sxe2/sxe2_common.h
new file mode 100644
index 0000000000..f62e00e053
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_common.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_COMMON_H__
+#define __SXE2_COMMON_H__
+
+#include <rte_bitops.h>
+#include <rte_kvargs.h>
+#include <rte_compat.h>
+#include <rte_memory.h>
+#include <rte_ticketlock.h>
+
+#include "sxe2_type.h"
+
+#define SXE2_COMMON_PCI_DRIVER_NAME "sxe2_pci"
+
+#define SXE2_CDEV_TO_CMD_FD(cdev) \
+	((cdev)->config.cmd_fd)
+
+#define SXE2_DEVARGS_KEY_CLASS "class"
+
+struct sxe2_class_driver;
+
+enum sxe2_class_type {
+	SXE2_CLASS_TYPE_ETH = 0,
+	SXE2_CLASS_TYPE_VDPA,
+	SXE2_CLASS_TYPE_INVALID,
+};
+
+struct sxe2_common_dev_config {
+	s32 cmd_fd;
+	bool support_iommu;
+	bool kernel_reset;
+	rte_ticketlock_t lock;
+};
+
+struct sxe2_common_device {
+	struct rte_device *dev;
+	TAILQ_ENTRY(sxe2_common_device) next;
+	struct sxe2_class_driver *cdrv;
+	enum sxe2_class_type class_type;
+	struct sxe2_common_dev_config config;
+	struct sxe2_dev_kvargs_info *kvargs;
+};
+
+struct sxe2_dev_kvargs_info {
+	struct rte_kvargs *kvlist;
+	bool is_used[RTE_KVARGS_MAX];
+};
+
+typedef s32 (sxe2_class_driver_probe_t)(struct sxe2_common_device *scdev,
+					struct sxe2_dev_kvargs_info *kvargs);
+
+typedef s32 (sxe2_class_driver_remove_t)(struct sxe2_common_device *scdev);
+
+struct sxe2_class_driver {
+	TAILQ_ENTRY(sxe2_class_driver) next;
+	enum sxe2_class_type drv_class;
+	const s8 *name;
+	sxe2_class_driver_probe_t *probe;
+	sxe2_class_driver_remove_t *remove;
+	const struct rte_pci_id *id_table;
+	u32 intr_lsc;
+	u32 intr_rmv;
+};
+
+__rte_internal
+void
+sxe2_common_mem_event_cb(enum rte_mem_event type,
+		const void *addr, size_t size, void *arg __rte_unused);
+
+__rte_internal
+void
+sxe2_class_driver_register(struct sxe2_class_driver *driver);
+
+__rte_internal
+void
+sxe2_common_init(void);
+
+__rte_internal
+s32
+sxe2_kvargs_process(struct sxe2_dev_kvargs_info *kv_info,
+		const s8 *const key_match, arg_handler_t handler, void *opaque_arg);
+
+#endif
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
new file mode 100644
index 0000000000..db09dd3126
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+ #include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <rte_version.h>
+#include <eal_export.h>
+
+#include "sxe2_osal.h"
+#include "sxe2_errno.h"
+#include "sxe2_common_log.h"
+#include "sxe2_ioctl_chnl.h"
+#include "sxe2_ioctl_chnl_func.h"
+
+#define SXE2_CHR_DEV_NAME "/dev/sxe2-dpdk-"
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_cmd_close)
+void
+sxe2_drv_cmd_close(struct sxe2_common_device *cdev)
+{
+	cdev->config.kernel_reset = true;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_cmd_exec)
+s32
+sxe2_drv_cmd_exec(struct sxe2_common_device *cdev,
+		struct sxe2_drv_cmd_params *cmd_params)
+{
+	s32 cmd_fd;
+	s32 ret = SXE2_ERR_IO;
+
+	if (cdev->config.kernel_reset) {
+		ret = SXE2_ERR_PERM;
+		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = SXE2_ERR_BADF;
+		PMD_LOG_ERR(COM, "Fail to exec cmd, fd[%d] error", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Exec drv cmd fd[%d] trace_id[0x%"PRIx64"]"
+			"opcode[0x%x] req_len[%d] resp_len[%d]",
+			cmd_fd, cmd_params->trace_id, cmd_params->opcode,
+			cmd_params->req_len, cmd_params->resp_len);
+
+	rte_ticketlock_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_PASSTHROUGH, cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Fail to exec cmd, fd[%d] opcode[0x%x] ret[%d], err:%s",
+				cmd_fd, cmd_params->opcode, ret, strerror(errno));
+		ret = -errno;
+		rte_ticketlock_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	rte_ticketlock_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_open)
+s32
+sxe2_drv_dev_open(struct sxe2_common_device *cdev, struct rte_pci_device *pci_dev)
+{
+	s32 ret = SXE2_SUCCESS;
+	s32 fd = 0;
+	s8 drv_name[32] = {0};
+
+	snprintf(drv_name, sizeof(drv_name),
+				"%s%04"PRIx32":%02"PRIx8":%02"PRIx8".%"PRIx8,
+				SXE2_CHR_DEV_NAME,
+				pci_dev->addr.domain,
+				pci_dev->addr.bus,
+				pci_dev->addr.devid,
+				pci_dev->addr.function);
+
+	fd = open(drv_name, O_RDWR);
+	if (fd < 0) {
+		ret = SXE2_ERR_BADF;
+		PMD_LOG_ERR(COM, "Fail to open device:%s, ret=%d, err:%s",
+				drv_name, ret, strerror(errno));
+		goto l_end;
+	}
+
+	SXE2_CDEV_TO_CMD_FD(cdev) = fd;
+
+	PMD_LOG_INFO(COM, "Successfully opened device:%s, fd=%d",
+				drv_name, SXE2_CDEV_TO_CMD_FD(cdev));
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_close)
+void
+sxe2_drv_dev_close(struct sxe2_common_device *cdev)
+{
+	s32 fd = SXE2_CDEV_TO_CMD_FD(cdev);
+
+	if (fd > 0)
+		close(fd);
+	PMD_LOG_INFO(COM, "closed device fd=%d", fd);
+	SXE2_CDEV_TO_CMD_FD(cdev) = -1;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_handshark)
+s32
+sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
+{
+	s32 ret = SXE2_SUCCESS;
+	s32 cmd_fd = 0;
+	struct sxe2_ioctl_cmd_common_hdr cmd_params;
+
+	if (cdev->config.kernel_reset) {
+		ret = SXE2_ERR_PERM;
+		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = SXE2_ERR_BADF;
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Open fd=%d to handshark with kernel", cmd_fd);
+
+	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_cmd_common_hdr));
+	cmd_params.dpdk_ver = SXE2_COM_VER;
+	cmd_params.msg_len = sizeof(struct sxe2_ioctl_cmd_common_hdr);
+
+	rte_ticketlock_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_HANDSHAKE, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to handshark, fd=%d, ret=%d, err:%s",
+				cmd_fd, ret, strerror(errno));
+		ret = SXE2_ERR_IO;
+		rte_ticketlock_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	rte_ticketlock_unlock(&cdev->config.lock);
+
+	if (cmd_params.cap & BIT(SXE2_COM_CAP_IOMMU_MAP))
+		cdev->config.support_iommu = true;
+	else
+		cdev->config.support_iommu = false;
+
+l_end:
+	return ret;
+}
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.h b/drivers/common/sxe2/sxe2_ioctl_chnl.h
new file mode 100644
index 0000000000..eedb3d6693
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_IOCTL_CHNL_H__
+#define __SXE2_IOCTL_CHNL_H__
+
+#ifdef SXE2_DPDK_DRIVER
+
+#include <rte_version.h>
+#include <bus_pci_driver.h>
+#include "sxe2_type.h"
+#endif
+
+#ifdef SXE2_LINUX_DRIVER
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#endif
+#endif
+
+#include "sxe2_internal_ver.h"
+
+#define SXE2_COM_INVAL_U32 0xFFFFFFFF
+
+#define SXE2_COM_PCI_OFFSET_SHIFT 40
+
+#define SXE2_COM_PCI_INDEX_TO_OFFSET(index)	((u64)(index) << SXE2_COM_PCI_OFFSET_SHIFT)
+#define SXE2_COM_PCI_OFFSET_MASK	(((u64)(1) << SXE2_COM_PCI_OFFSET_SHIFT) - 1)
+#define SXE2_COM_PCI_OFFSET_GEN(index, off) ((((u64)(index)) << SXE2_COM_PCI_OFFSET_SHIFT) | \
+		(((u64)(off)) & SXE2_COM_PCI_OFFSET_MASK))
+
+#define SXE2_DRV_TRACE_ID_COUNT_MASK 0x003FFFFFFFFFFFFFLLU
+
+#define SXE2_DRV_CMD_DFLT_TIMEOUT (30)
+
+#define SXE2_COM_VER_MAJOR 1
+#define SXE2_COM_VER_MINOR 0
+#define SXE2_COM_VER       SXE2_MK_VER(SXE2_COM_VER_MAJOR, SXE2_COM_VER_MINOR)
+
+enum SXE2_COM_CMD {
+	SXE2_DEVICE_HANDSHAKE = 1,
+	SXE2_DEVICE_IO_IRQS_REQ,
+	SXE2_DEVICE_EVT_IRQ_REQ,
+	SXE2_DEVICE_RST_IRQ_REQ,
+	SXE2_DEVICE_EVT_CAUSE_GET,
+	SXE2_DEVICE_DMA_MAP,
+	SXE2_DEVICE_DMA_UNMAP,
+	SXE2_DEVICE_PASSTHROUGH,
+	SXE2_DEVICE_MAX,
+};
+
+#define SXE2_CMD_TYPE 'S'
+
+#define SXE2_COM_CMD_HANDSHAKE     _IO(SXE2_CMD_TYPE, SXE2_DEVICE_HANDSHAKE)
+#define SXE2_COM_CMD_IO_IRQS_REQ   _IO(SXE2_CMD_TYPE, SXE2_DEVICE_IO_IRQS_REQ)
+#define SXE2_COM_CMD_EVT_IRQ_REQ   _IO(SXE2_CMD_TYPE, SXE2_DEVICE_EVT_IRQ_REQ)
+#define SXE2_COM_CMD_RST_IRQ_REQ   _IO(SXE2_CMD_TYPE, SXE2_DEVICE_RST_IRQ_REQ)
+#define SXE2_COM_CMD_EVT_CAUSE_GET _IO(SXE2_CMD_TYPE, SXE2_DEVICE_EVT_CAUSE_GET)
+#define SXE2_COM_CMD_DMA_MAP       _IO(SXE2_CMD_TYPE, SXE2_DEVICE_DMA_MAP)
+#define SXE2_COM_CMD_DMA_UNMAP     _IO(SXE2_CMD_TYPE, SXE2_DEVICE_DMA_UNMAP)
+#define SXE2_COM_CMD_PASSTHROUGH   _IO(SXE2_CMD_TYPE, SXE2_DEVICE_PASSTHROUGH)
+
+enum sxe2_com_cap {
+	SXE2_COM_CAP_IOMMU_MAP = 0,
+};
+
+struct sxe2_ioctl_cmd_common_hdr {
+	u32 dpdk_ver;
+	u32 drv_ver;
+	u32 msg_len;
+	u32 cap;
+	u8  reserved[32];
+};
+
+struct sxe2_drv_cmd_params {
+	u64 trace_id;
+	u32 timeout;
+	u32 opcode;
+	u16 vsi_id;
+	u16 repr_id;
+	u32 req_len;
+	u32 resp_len;
+	void *req_data;
+	void *resp_data;
+	u8    resv[32];
+};
+
+struct sxe2_ioctl_irq_set {
+	u32  cnt;
+	u8   resv[4];
+	u32  base_irq_in_com;
+	s32 *event_fd;
+};
+
+enum sxe2_com_event_cause {
+	SXE2_COM_EC_LINK_CHG = 0,
+	SXE2_COM_SW_MODE_LEGACY,
+	SXE2_COM_SW_MODE_SWITCHDEV,
+	SXE2_COM_FC_ST_CHANGE,
+
+	SXE2_COM_EC_RESET = 62,
+	SXE2_COM_EC_MAX = 63,
+};
+
+struct sxe2_ioctl_other_evt_set {
+	s32 eventfd;
+	u8  resv[4];
+	u64 filter_table;
+};
+
+struct sxe2_ioctl_other_evt_get {
+	u64 evt_cause;
+	u8  resv[8];
+};
+
+struct sxe2_ioctl_reset_sub_set {
+	s32 eventfd;
+	u8  resv[4];
+};
+
+struct sxe2_ioctl_iommu_dma_map {
+	u64 vaddr;
+	u64 iova;
+	u64 size;
+	u8  resv[4];
+};
+
+struct sxe2_ioctl_iommu_dma_unmap {
+	u64 iova;
+};
+
+union sxe2_drv_trace_info {
+	u64 id;
+	struct {
+		u64 count : 54;
+		u64 cpu_id : 10;
+	} sxe2_drv_trace_id_param;
+};
+
+#endif
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
new file mode 100644
index 0000000000..0c3cb9caea
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_IOCTL_CHNL_FUNC_H__
+#define __SXE2_IOCTL_CHNL_FUNC_H__
+
+#include <rte_version.h>
+#include <bus_pci_driver.h>
+
+#include "sxe2_type.h"
+#include "sxe2_common.h"
+#include "sxe2_ioctl_chnl.h"
+
+#ifdef	__cplusplus
+extern "C" {
+#endif
+
+__rte_internal
+void
+sxe2_drv_cmd_close(struct sxe2_common_device *cdev);
+
+__rte_internal
+s32
+sxe2_drv_cmd_exec(struct sxe2_common_device *cdev,
+		struct sxe2_drv_cmd_params *cmd_params);
+
+__rte_internal
+s32
+sxe2_drv_dev_open(struct sxe2_common_device *cdev,
+		struct rte_pci_device *pci_dev);
+
+__rte_internal
+void
+sxe2_drv_dev_close(struct sxe2_common_device *cdev);
+
+__rte_internal
+s32
+sxe2_drv_dev_handshark(struct sxe2_common_device *cdev);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.47.3

