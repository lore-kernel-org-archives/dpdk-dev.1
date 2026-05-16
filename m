Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1604ECD4F21
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 May 2026 07:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F6F40281;
	Sat, 16 May 2026 09:46:31 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8F61940269
 for <dev@dpdk.org>; Sat, 16 May 2026 09:46:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAB3XOPSIAhqhIMqEQ--.2759S6;
 Sat, 16 May 2026 15:46:27 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v15 04/11] drivers: add base driver skeleton
Date: Sat, 16 May 2026 15:46:11 +0800
Message-ID: <20260516074618.2343883-5-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516074618.2343883-1-liujie5@linkdatatechnology.com>
References: <20260516025540.2092621-12-liujie5@linkdatatechnology.com>
 <20260516074618.2343883-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3XOPSIAhqhIMqEQ--.2759S6
X-Coremail-Antispam: 1UD129KBjvAXoWfKFyDZr1xGF4Uur43Xr4ruFg_yoW7WryDWo
 W7JrsxXw15Arn7A3ykWa17X34Iv39Y93s8Jw40krZ7X3ZrJr9rGFyUt3s8X3WjqFn5GF13
 WFn2v348K39xJFykn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU17KsUUUUU
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
 drivers/common/sxe2/meson.build            |  15 +
 drivers/common/sxe2/sxe2_common.c          | 635 +++++++++++++++++++++
 drivers/common/sxe2/sxe2_common.h          |  85 +++
 drivers/common/sxe2/sxe2_host_regs.h       | 226 ++++----
 drivers/common/sxe2/sxe2_ioctl_chnl.c      | 160 ++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.h      | 130 +++++
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |  44 ++
 drivers/common/sxe2/sxe2_osal.h            |   4 +-
 drivers/meson.build                        |   1 +
 9 files changed, 1185 insertions(+), 115 deletions(-)
 create mode 100644 drivers/common/sxe2/meson.build
 create mode 100644 drivers/common/sxe2/sxe2_common.c
 create mode 100644 drivers/common/sxe2/sxe2_common.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.c
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.h
 create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl_func.h

diff --git a/drivers/common/sxe2/meson.build b/drivers/common/sxe2/meson.build
new file mode 100644
index 0000000000..f1cc1205a0
--- /dev/null
+++ b/drivers/common/sxe2/meson.build
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2023 Corigine, Inc.
+
+if is_windows
+        build = false
+        reason = 'only supported on Linux'
+        subdir_done()
+endif
+
+deps += ['bus_pci', 'net', 'eal', 'ethdev']
+
+sources = files(
+        'sxe2_common.c',
+        'sxe2_ioctl_chnl.c',
+)
diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
new file mode 100644
index 0000000000..27c33b1186
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -0,0 +1,635 @@
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
+#include <pthread.h>
+
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
+	const char *name;
+	uint32_t class_type;
+} sxe2_class_types[] = {
+	{ .name = "eth", .class_type = SXE2_CLASS_TYPE_ETH },
+	{ .name = "vdpa", .class_type = SXE2_CLASS_TYPE_VDPA },
+};
+
+static uint32_t sxe2_class_name_to_value(const char *class_name)
+{
+	uint32_t class_type = SXE2_CLASS_TYPE_INVALID;
+	uint32_t i;
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
+static struct sxe2_class_driver *sxe2_class_driver_get(uint32_t class_type)
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
+static int32_t sxe2_kvargs_preprocessing(struct sxe2_dev_kvargs_info *kv_info,
+			const struct rte_devargs *devargs)
+{
+	const struct rte_kvargs_pair *pair;
+	struct rte_kvargs *kvlist;
+	int32_t ret = -1;
+	uint32_t i;
+
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (kvlist == NULL) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < kvlist->count; i++) {
+		pair = &kvlist->pairs[i];
+		if (pair->value == NULL || *(pair->value) == '\0') {
+			PMD_LOG_ERR(COM, "Key %s has no value.", pair->key);
+			rte_kvargs_free(kvlist);
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+	kv_info->kvlist = kvlist;
+	ret = 0;
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
+int32_t
+sxe2_kvargs_process(struct sxe2_dev_kvargs_info *kv_info,
+		const char *const key_match, arg_handler_t handler, void *opaque_arg)
+{
+	const struct rte_kvargs_pair *pair;
+	struct rte_kvargs *kvlist;
+	uint32_t i;
+	int32_t ret = 0;
+
+	if ((kv_info == NULL) || (kv_info->kvlist == NULL) ||
+			(key_match == NULL)) {
+		PMD_LOG_ERR(COM, "Failed to process kvargs, NULL parameter.");
+		ret = -EINVAL;
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
+static int32_t sxe2_parse_class_type(const char *key, const char *value, void *args)
+{
+	uint32_t *class_type = (uint32_t *)args;
+	int32_t ret = 0;
+
+	*class_type = sxe2_class_name_to_value(value);
+	if (*class_type == SXE2_CLASS_TYPE_INVALID) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(COM, "Unsupported %s type: %s", key, value);
+	}
+
+	return ret;
+}
+
+static int32_t sxe2_common_device_setup(struct sxe2_common_device *cdev)
+{
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	int32_t ret = 0;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto l_end;
+
+	ret = sxe2_drv_dev_open(cdev, pci_dev);
+	if (ret != 0) {
+		PMD_LOG_ERR(COM, "Open pmd chrdev failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_handshark(cdev);
+	if (ret != 0) {
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
+		struct rte_device *rte_dev, uint32_t class_type)
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
+	pthread_mutex_init(&cdev->config.lock, NULL);
+
+	(void)pthread_mutex_lock(&sxe2_common_devices_list_lock);
+	TAILQ_INSERT_TAIL(&sxe2_common_devices_list, cdev, next);
+	pthread_mutex_unlock(&sxe2_common_devices_list_lock);
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
+	pthread_mutex_unlock(&sxe2_common_devices_list_lock);
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
+static int32_t sxe2_classes_driver_probe(struct sxe2_common_device *cdev,
+		struct sxe2_dev_kvargs_info *kv_info, uint32_t class_type)
+{
+	struct sxe2_class_driver *cdrv = NULL;
+	int32_t ret = -1;
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
+static int32_t sxe2_classes_driver_remove(struct sxe2_common_device *cdev)
+{
+	struct sxe2_class_driver *cdrv = cdev->cdrv;
+
+	return cdrv->remove(cdev);
+}
+
+static int32_t sxe2_kvargs_validate(struct sxe2_dev_kvargs_info *kv_info)
+{
+	int32_t ret = 0;
+	uint32_t i;
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
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_common_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+		struct rte_pci_device *pci_dev)
+{
+	struct rte_device *rte_dev =  &pci_dev->device;
+	struct sxe2_common_device *cdev;
+	struct sxe2_dev_kvargs_info *kv_info_p = NULL;
+
+	uint32_t class_type = SXE2_CLASS_TYPE_ETH;
+	int32_t ret = -1;
+
+	PMD_LOG_INFO(COM, "Probe pci device: %s", pci_dev->name);
+
+	cdev = sxe2_rtedev_to_cdev(rte_dev);
+	if (cdev != NULL) {
+		PMD_LOG_ERR(COM, "Device %s already probed.", rte_dev->name);
+		ret = -EBUSY;
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
+		ret = -ENOMEM;
+		goto l_free_args;
+	}
+
+	ret = sxe2_common_device_setup(cdev);
+	if (ret != 0)
+		goto l_err_setup;
+
+	ret = sxe2_classes_driver_probe(cdev, kv_info_p, class_type);
+	if (ret != 0)
+		goto l_err_probe;
+
+	ret = sxe2_kvargs_validate(kv_info_p);
+	if (ret != 0) {
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
+static int32_t sxe2_common_pci_remove(struct rte_pci_device *pci_dev)
+{
+	struct sxe2_common_device *cdev;
+	int32_t ret = -1;
+
+	PMD_LOG_INFO(COM, "Remove pci device: %s", pci_dev->name);
+	cdev = sxe2_rtedev_to_cdev(&pci_dev->device);
+	if (cdev == NULL) {
+		ret = -ENODEV;
+		PMD_LOG_ERR(COM, "Fail to get remove device.");
+		goto l_end;
+	}
+
+	ret = sxe2_classes_driver_remove(cdev);
+	if (ret != 0) {
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
+static uint32_t sxe2_common_pci_id_table_size_get(const struct rte_pci_id *id_table)
+{
+	uint32_t table_size = 0;
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
+		const struct rte_pci_id *id_table, uint32_t next_idx)
+{
+	int32_t current_size = next_idx - 1;
+	int32_t i;
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
+		uint32_t *next_idx, const struct rte_pci_id *insert_table)
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
+static int32_t sxe2_common_pci_id_table_update(const struct rte_pci_id *id_table)
+{
+	const struct rte_pci_id *id_iter;
+	struct rte_pci_id *updated_table;
+	struct rte_pci_id *old_table;
+	uint32_t num_ids = 0;
+	uint32_t i = 0;
+	int32_t ret = 0;
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
+	int32_t ret = -1;
+
+	if (sxe2_common_pci_id_table == NULL) {
+		ret = sxe2_common_pci_id_table_update(empty_table);
+		if (ret != 0)
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
+
+RTE_LOG_REGISTER_SUFFIX(sxe2_common_log, com, NOTICE);
diff --git a/drivers/common/sxe2/sxe2_common.h b/drivers/common/sxe2/sxe2_common.h
new file mode 100644
index 0000000000..5fe218db99
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_common.h
@@ -0,0 +1,85 @@
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
+#include <pthread.h>
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
+	int32_t cmd_fd;
+	bool support_iommu;
+	bool kernel_reset;
+	pthread_mutex_t lock;
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
+typedef int32_t (sxe2_class_driver_probe_t)(struct sxe2_common_device *scdev,
+					struct sxe2_dev_kvargs_info *kvargs);
+
+typedef int32_t (sxe2_class_driver_remove_t)(struct sxe2_common_device *scdev);
+
+struct sxe2_class_driver {
+	TAILQ_ENTRY(sxe2_class_driver) next;
+	enum sxe2_class_type drv_class;
+	const char *name;
+	sxe2_class_driver_probe_t *probe;
+	sxe2_class_driver_remove_t *remove;
+	const struct rte_pci_id *id_table;
+	uint32_t intr_lsc;
+	uint32_t intr_rmv;
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
+int32_t
+sxe2_kvargs_process(struct sxe2_dev_kvargs_info *kv_info,
+		const char *const key_match, arg_handler_t handler, void *opaque_arg);
+
+#endif /* __SXE2_COMMON_H__ */
diff --git a/drivers/common/sxe2/sxe2_host_regs.h b/drivers/common/sxe2/sxe2_host_regs.h
index 984ea6214c..9116be0ba0 100644
--- a/drivers/common/sxe2/sxe2_host_regs.h
+++ b/drivers/common/sxe2/sxe2_host_regs.h
@@ -15,7 +15,7 @@
 
 #define SXE2_RXQ_CTRL_STATUS_ACTIVE       0x00000004
 #define SXE2_RXQ_CTRL_ENABLED             0x00000001
-#define SXE2_RXQ_CTRL_CDE_ENABLE		BIT(3)
+#define SXE2_RXQ_CTRL_CDE_ENABLE		RTE_BIT32(3)
 
 #define SXE2_PCIEPROC_BASE         0x002d6000
 
@@ -25,78 +25,78 @@
 #define SXE2_PF_INT_ALLOC_LAST_S 12
 #define SXE2_PF_INT_ALLOC_LAST \
 	(0x7FF << SXE2_PF_INT_ALLOC_LAST_S)
-#define SXE2_PF_INT_ALLOC_VALID BIT(31)
+#define SXE2_PF_INT_ALLOC_VALID RTE_BIT32(31)
 
 #define SXE2_PF_INT_OICR                  (SXE2_PF_INT_BASE + 0x0040)
-#define SXE2_PF_INT_OICR_PCIE_TIMEOUT     BIT(0)
-#define SXE2_PF_INT_OICR_UR               BIT(1)
-#define SXE2_PF_INT_OICR_CA               BIT(2)
-#define SXE2_PF_INT_OICR_VFLR             BIT(3)
-#define SXE2_PF_INT_OICR_VFR_DONE         BIT(4)
-#define SXE2_PF_INT_OICR_LAN_TX_ERR       BIT(5)
-#define SXE2_PF_INT_OICR_BFDE             BIT(6)
-#define SXE2_PF_INT_OICR_LAN_RX_ERR       BIT(7)
-#define SXE2_PF_INT_OICR_ECC_ERR          BIT(8)
-#define SXE2_PF_INT_OICR_GPIO             BIT(9)
-#define SXE2_PF_INT_OICR_TSYN_TX          BIT(11)
-#define SXE2_PF_INT_OICR_TSYN_EVENT       BIT(12)
-#define SXE2_PF_INT_OICR_TSYN_TGT         BIT(13)
-#define SXE2_PF_INT_OICR_EXHAUST          BIT(14)
-#define SXE2_PF_INT_OICR_FW               BIT(15)
-#define SXE2_PF_INT_OICR_SWINT            BIT(16)
-#define SXE2_PF_INT_OICR_LINKSEC_CHG      BIT(17)
-#define SXE2_PF_INT_OICR_INT_CFG_ADDR_ERR BIT(18)
-#define SXE2_PF_INT_OICR_INT_CFG_DATA_ERR BIT(19)
-#define SXE2_PF_INT_OICR_INT_CFG_ADR_UNRANGE BIT(20)
-#define SXE2_PF_INT_OICR_INT_RAM_CONFLICT BIT(21)
-#define SXE2_PF_INT_OICR_GRST             BIT(22)
-#define SXE2_PF_INT_OICR_FWQ_INT          BIT(29)
-#define SXE2_PF_INT_OICR_FWQ_TOOL_INT     BIT(30)
-#define SXE2_PF_INT_OICR_MBXQ_INT         BIT(31)
+#define SXE2_PF_INT_OICR_PCIE_TIMEOUT     RTE_BIT32(0)
+#define SXE2_PF_INT_OICR_UR               RTE_BIT32(1)
+#define SXE2_PF_INT_OICR_CA               RTE_BIT32(2)
+#define SXE2_PF_INT_OICR_VFLR             RTE_BIT32(3)
+#define SXE2_PF_INT_OICR_VFR_DONE         RTE_BIT32(4)
+#define SXE2_PF_INT_OICR_LAN_TX_ERR       RTE_BIT32(5)
+#define SXE2_PF_INT_OICR_BFDE             RTE_BIT32(6)
+#define SXE2_PF_INT_OICR_LAN_RX_ERR       RTE_BIT32(7)
+#define SXE2_PF_INT_OICR_ECC_ERR          RTE_BIT32(8)
+#define SXE2_PF_INT_OICR_GPIO             RTE_BIT32(9)
+#define SXE2_PF_INT_OICR_TSYN_TX          RTE_BIT32(11)
+#define SXE2_PF_INT_OICR_TSYN_EVENT       RTE_BIT32(12)
+#define SXE2_PF_INT_OICR_TSYN_TGT         RTE_BIT32(13)
+#define SXE2_PF_INT_OICR_EXHAUST          RTE_BIT32(14)
+#define SXE2_PF_INT_OICR_FW               RTE_BIT32(15)
+#define SXE2_PF_INT_OICR_SWINT            RTE_BIT32(16)
+#define SXE2_PF_INT_OICR_LINKSEC_CHG      RTE_BIT32(17)
+#define SXE2_PF_INT_OICR_INT_CFG_ADDR_ERR RTE_BIT32(18)
+#define SXE2_PF_INT_OICR_INT_CFG_DATA_ERR RTE_BIT32(19)
+#define SXE2_PF_INT_OICR_INT_CFG_ADR_UNRANGE RTE_BIT32(20)
+#define SXE2_PF_INT_OICR_INT_RAM_CONFLICT RTE_BIT32(21)
+#define SXE2_PF_INT_OICR_GRST             RTE_BIT32(22)
+#define SXE2_PF_INT_OICR_FWQ_INT          RTE_BIT32(29)
+#define SXE2_PF_INT_OICR_FWQ_TOOL_INT     RTE_BIT32(30)
+#define SXE2_PF_INT_OICR_MBXQ_INT         RTE_BIT32(31)
 
 #define SXE2_PF_INT_OICR_ENABLE (SXE2_PF_INT_BASE + 0x0020)
 
 #define SXE2_PF_INT_FW_EVENT (SXE2_PF_INT_BASE + 0x0100)
-#define SXE2_PF_INT_FW_ABNORMAL BIT(0)
-#define SXE2_PF_INT_RDMA_AEQ_OVERFLOW BIT(1)
-#define SXE2_PF_INT_CGMAC_LINK_CHG BIT(18)
-#define SXE2_PF_INT_VFLR_DONE         BIT(2)
+#define SXE2_PF_INT_FW_ABNORMAL RTE_BIT32(0)
+#define SXE2_PF_INT_RDMA_AEQ_OVERFLOW RTE_BIT32(1)
+#define SXE2_PF_INT_CGMAC_LINK_CHG RTE_BIT32(18)
+#define SXE2_PF_INT_VFLR_DONE         RTE_BIT32(2)
 
 #define SXE2_PF_INT_OICR_CTL           (SXE2_PF_INT_BASE + 0x0060)
 #define SXE2_PF_INT_OICR_CTL_MSIX_IDX  0x7FF
 #define SXE2_PF_INT_OICR_CTL_ITR_IDX_S 11
 #define SXE2_PF_INT_OICR_CTL_ITR_IDX \
 	(0x3 << SXE2_PF_INT_OICR_CTL_ITR_IDX_S)
-#define SXE2_PF_INT_OICR_CTL_CAUSE_ENABLE BIT(30)
+#define SXE2_PF_INT_OICR_CTL_CAUSE_ENABLE RTE_BIT32(30)
 
 #define SXE2_PF_INT_FWQ_CTL           (SXE2_PF_INT_BASE + 0x00C0)
 #define SXE2_PF_INT_FWQ_CTL_MSIX_IDX  0x7FFF
 #define SXE2_PF_INT_FWQ_CTL_ITR_IDX_S 11
 #define SXE2_PF_INT_FWQ_CTL_ITR_IDX \
 	(0x3 << SXE2_PF_INT_FWQ_CTL_ITR_IDX_S)
-#define SXE2_PF_INT_FWQ_CTL_CAUSE_ENABLE BIT(30)
+#define SXE2_PF_INT_FWQ_CTL_CAUSE_ENABLE RTE_BIT32(30)
 
 #define SXE2_PF_INT_MBX_CTL           (SXE2_PF_INT_BASE + 0x00A0)
 #define SXE2_PF_INT_MBX_CTL_MSIX_IDX  0x7FF
 #define SXE2_PF_INT_MBX_CTL_ITR_IDX_S 11
 #define SXE2_PF_INT_MBX_CTL_ITR_IDX   (0x3 << SXE2_PF_INT_MBX_CTL_ITR_IDX_S)
-#define SXE2_PF_INT_MBX_CTL_CAUSE_ENABLE BIT(30)
+#define SXE2_PF_INT_MBX_CTL_CAUSE_ENABLE RTE_BIT32(30)
 
 #define SXE2_PF_INT_GPIO_ENA      (SXE2_PF_INT_BASE + 0x0100)
-#define SXE2_PF_INT_GPIO_X_ENA(x) BIT(x)
+#define SXE2_PF_INT_GPIO_X_ENA(x) RTE_BIT32(x)
 
 #define SXE2_PFG_INT_CTL               (SXE2_PF_INT_BASE + 0x0120)
 #define SXE2_PFG_INT_CTL_ITR_GRAN      0x7
 #define SXE2_PFG_INT_CTL_ITR_GRAN_0    (2)
-#define SXE2_PFG_INT_CTL_CREDIT_GRAN   BIT(4)
+#define SXE2_PFG_INT_CTL_CREDIT_GRAN   RTE_BIT32(4)
 #define SXE2_PFG_INT_CTL_CREDIT_GRAN_0 (4)
 #define SXE2_PFG_INT_CTL_CREDIT_GRAN_1 (8)
 
 #define SXE2_VFG_RAM_INIT_DONE \
 	(SXE2_PF_INT_BASE + 0x0128)
-#define SXE2_VFG_RAM_INIT_DONE_0 BIT(0)
-#define SXE2_VFG_RAM_INIT_DONE_1 BIT(1)
-#define SXE2_VFG_RAM_INIT_DONE_2 BIT(2)
+#define SXE2_VFG_RAM_INIT_DONE_0 RTE_BIT32(0)
+#define SXE2_VFG_RAM_INIT_DONE_1 RTE_BIT32(1)
+#define SXE2_VFG_RAM_INIT_DONE_2 RTE_BIT32(2)
 
 #define SXE2_LINK_REG_GET_10G_VALUE   4
 #define SXE2_LINK_REG_GET_25G_VALUE   1
@@ -129,7 +129,7 @@
 #define SXE2_PFVP_INT_ALLOC_LAST_S 12
 #define SXE2_PFVP_INT_ALLOC_LAST_M \
 	(0x7FF << SXE2_PFVP_INT_ALLOC_LAST_S)
-#define SXE2_PFVP_INT_ALLOC_VALID BIT(31)
+#define SXE2_PFVP_INT_ALLOC_VALID RTE_BIT32(31)
 
 #define SXE2_PCI_PFVP_INT_ALLOC(vf_idx)  (SXE2_PCIEPROC_BASE + 0x5800 + ((vf_idx) * 4))
 #define SXE2_PCI_PFVP_INT_ALLOC_FIRST_S  0
@@ -139,7 +139,7 @@
 
 #define SXE2_PCI_PFVP_INT_ALLOC_LAST_M \
 		(0x7FF << SXE2_PCI_PFVP_INT_ALLOC_LAST_S)
-#define SXE2_PCI_PFVP_INT_ALLOC_VALID BIT(31)
+#define SXE2_PCI_PFVP_INT_ALLOC_VALID RTE_BIT32(31)
 
 #define SXE2_PCIEPROC_INT2FUNC(_INT)		   (SXE2_PCIEPROC_BASE + 0xe000 + ((_INT) * 4))
 #define SXE2_PCIEPROC_INT2FUNC_VF_NUM_S		0
@@ -147,37 +147,37 @@
 #define SXE2_PCIEPROC_INT2FUNC_PF_NUM_S		12
 #define SXE2_PCIEPROC_INT2FUNC_PF_NUM_M		(0x7 << SXE2_PCIEPROC_INT2FUNC_PF_NUM_S)
 #define SXE2_PCIEPROC_INT2FUNC_IS_PF_S       16
-#define SXE2_PCIEPROC_INT2FUNC_IS_PF_M       BIT(16)
+#define SXE2_PCIEPROC_INT2FUNC_IS_PF_M       RTE_BIT32(16)
 
 #define SXE2_VSI_PF(vf_idx)                (SXE2_PF_INT_BASE + 0x14000 + ((vf_idx) * 4))
 #define SXE2_VSI_PF_ID_S		   0
 #define SXE2_VSI_PF_ID_M		  (0x7 << SXE2_VSI_PF_ID_S)
-#define SXE2_VSI_PF_EN_M		  BIT(3)
+#define SXE2_VSI_PF_EN_M		  RTE_BIT32(3)
 
 #define SXE2_MBX_CTL(_VSI)			(0x0026692C + ((_VSI) * 4))
 #define SXE2_MBX_CTL_MSIX_INDX_S		0
 #define SXE2_MBX_CTL_MSIX_INDX_M		(0x7FF << SXE2_MBX_CTL_MSIX_INDX_S)
-#define SXE2_MBX_CTL_CAUSE_ENA_M		BIT(30)
+#define SXE2_MBX_CTL_CAUSE_ENA_M		RTE_BIT32(30)
 
 #define SXE2_PF_INT_TQCTL(q_idx)    (SXE2_PF_INT_BASE + 0x092C + 4 * (q_idx))
 #define SXE2_PF_INT_TQCTL_MSIX_IDX  0x7FF
 #define SXE2_PF_INT_TQCTL_ITR_IDX_S 11
 #define SXE2_PF_INT_TQCTL_ITR_IDX \
 	(0x3 << SXE2_PF_INT_TQCTL_ITR_IDX_S)
-#define SXE2_PF_INT_TQCTL_CAUSE_ENABLE BIT(30)
+#define SXE2_PF_INT_TQCTL_CAUSE_ENABLE RTE_BIT32(30)
 
 #define SXE2_PF_INT_RQCTL(q_idx)    (SXE2_PF_INT_BASE + 0x292C + 4 * (q_idx))
 #define SXE2_PF_INT_RQCTL_MSIX_IDX  0x7FF
 #define SXE2_PF_INT_RQCTL_ITR_IDX_S 11
 #define SXE2_PF_INT_RQCTL_ITR_IDX \
 	(0x3 << SXE2_PF_INT_RQCTL_ITR_IDX_S)
-#define SXE2_PF_INT_RQCTL_CAUSE_ENABLE BIT(30)
+#define SXE2_PF_INT_RQCTL_CAUSE_ENABLE RTE_BIT32(30)
 
 #define SXE2_PF_INT_RATE(irq_idx)        (SXE2_PF_INT_BASE + 0x7530 + 4 * (irq_idx))
 #define SXE2_PF_INT_RATE_CREDIT_INTERVAL (0x3F)
 #define SXE2_PF_INT_RATE_CREDIT_INTERVAL_MAX \
 	(0x3F)
-#define SXE2_PF_INT_RATE_INTRL_ENABLE           (BIT(6))
+#define SXE2_PF_INT_RATE_INTRL_ENABLE           (RTE_BIT32(6))
 #define SXE2_PF_INT_RATE_CREDIT_MAX_VALUE_SHIFT (7)
 #define SXE2_PF_INT_RATE_CREDIT_MAX_VALUE \
 	(0x3F << SXE2_PF_INT_RATE_CREDIT_MAX_VALUE_SHIFT)
@@ -187,20 +187,20 @@
 #define SXE2_VF_INT_ITR_INTERVAL 0xFFF
 
 #define SXE2_VF_DYN_CTL(irq_idx)   (SXE2_PF_INT_BASE + 0x9530 + 4 * (irq_idx))
-#define SXE2_VF_DYN_CTL_INTENABLE     BIT(0)
-#define SXE2_VF_DYN_CTL_CLEARPBA   BIT(1)
-#define SXE2_VF_DYN_CTL_SWINT_TRIG BIT(2)
+#define SXE2_VF_DYN_CTL_INTENABLE     RTE_BIT32(0)
+#define SXE2_VF_DYN_CTL_CLEARPBA   RTE_BIT32(1)
+#define SXE2_VF_DYN_CTL_SWINT_TRIG RTE_BIT32(2)
 #define SXE2_VF_DYN_CTL_ITR_IDX_S \
 	3
 #define SXE2_VF_DYN_CTL_ITR_IDX_M      0x3
 #define SXE2_VF_DYN_CTL_INTERVAL_S     5
 #define SXE2_VF_DYN_CTL_INTERVAL_M     0xFFF
-#define SXE2_VF_DYN_CTL_SW_ITR_IDX_ENABLE BIT(24)
+#define SXE2_VF_DYN_CTL_SW_ITR_IDX_ENABLE RTE_BIT32(24)
 #define SXE2_VF_DYN_CTL_SW_ITR_IDX_S   25
 #define SXE2_VF_DYN_CTL_SW_ITR_IDX_M   0x3
 
 #define SXE2_VF_DYN_CTL_INTENABLE_MSK \
-	BIT(31)
+	RTE_BIT32(31)
 
 #define SXE2_BAR4_MSIX_BASE 0
 #define SXE2_BAR4_MSIX_CTL(_idx) (SXE2_BAR4_MSIX_BASE + 0xC + ((_idx) * 0x10))
@@ -225,8 +225,8 @@
 #define SXE2_TXQ_DIS_CNT(_pfIdx)       (0x100D0 + ((_pfIdx) * 0x100))
 
 #define SXE2_TXQ_CTXT_CTRL_USED_MASK   0x00000800
-#define SXE2_TXQ_CTRL_SW_EN_M		BIT(0)
-#define SXE2_TXQ_CTRL_HW_EN_M		BIT(1)
+#define SXE2_TXQ_CTRL_SW_EN_M		RTE_BIT32(0)
+#define SXE2_TXQ_CTRL_HW_EN_M		RTE_BIT32(1)
 
 #define	SXE2_TXQ_CTXT2_PROT_IDX_S	0
 #define	SXE2_TXQ_CTXT2_PROT_IDX_M	SXE2_BITS_MASK(0x7, 0)
@@ -239,37 +239,37 @@
 #define	SXE2_TXQ_CTXT2_VMVF_TYPE_S	23
 #define	SXE2_TXQ_CTXT2_VMVF_TYPE_M	SXE2_BITS_MASK(0x3, 23)
 #define	SXE2_TXQ_CTXT2_TSYN_ENA_S	25
-#define	SXE2_TXQ_CTXT2_TSYN_ENA_M	BIT(25)
+#define	SXE2_TXQ_CTXT2_TSYN_ENA_M	RTE_BIT32(25)
 #define	SXE2_TXQ_CTXT2_ALT_VLAN_S	26
-#define	SXE2_TXQ_CTXT2_ALT_VLAN_M	BIT(26)
+#define	SXE2_TXQ_CTXT2_ALT_VLAN_M	RTE_BIT32(26)
 #define	SXE2_TXQ_CTXT2_WB_MODE_S	27
-#define	SXE2_TXQ_CTXT2_WB_MODE_M	BIT(27)
+#define	SXE2_TXQ_CTXT2_WB_MODE_M	RTE_BIT32(27)
 #define	SXE2_TXQ_CTXT2_ITR_WB_S	28
-#define	SXE2_TXQ_CTXT2_ITR_WB_M	BIT(28)
+#define	SXE2_TXQ_CTXT2_ITR_WB_M	RTE_BIT32(28)
 #define	SXE2_TXQ_CTXT2_LEGACY_EN_S	29
-#define	SXE2_TXQ_CTXT2_LEGACY_EN_M	BIT(29)
+#define	SXE2_TXQ_CTXT2_LEGACY_EN_M	RTE_BIT32(29)
 #define	SXE2_TXQ_CTXT2_SSO_EN_S	30
-#define	SXE2_TXQ_CTXT2_SSO_EN_M	BIT(30)
+#define	SXE2_TXQ_CTXT2_SSO_EN_M	RTE_BIT32(30)
 
 #define	SXE2_TXQ_CTXT3_SRC_VSI_S	0
 #define	SXE2_TXQ_CTXT3_SRC_VSI_M	SXE2_BITS_MASK(0x3FF, 0)
 #define	SXE2_TXQ_CTXT3_CPU_ID_S	12
 #define	SXE2_TXQ_CTXT3_CPU_ID_M	SXE2_BITS_MASK(0xFF, 12)
 #define	SXE2_TXQ_CTXT3_TPH_RDDESC_S	20
-#define	SXE2_TXQ_CTXT3_TPH_RDDESC_M	BIT(20)
+#define	SXE2_TXQ_CTXT3_TPH_RDDESC_M	RTE_BIT32(20)
 #define	SXE2_TXQ_CTXT3_TPH_RDDATA_S	21
-#define	SXE2_TXQ_CTXT3_TPH_RDDATA_M	BIT(21)
+#define	SXE2_TXQ_CTXT3_TPH_RDDATA_M	RTE_BIT32(21)
 #define	SXE2_TXQ_CTXT3_TPH_WRDESC_S	22
-#define	SXE2_TXQ_CTXT3_TPH_WRDESC_M	BIT(22)
+#define	SXE2_TXQ_CTXT3_TPH_WRDESC_M	RTE_BIT32(22)
 
 #define	SXE2_TXQ_CTXT3_QID_IN_FUNC_S	0
 #define	SXE2_TXQ_CTXT3_QID_IN_FUNC_M	SXE2_BITS_MASK(0x7FF, 0)
 #define	SXE2_TXQ_CTXT3_RDDESC_RO_S	13
-#define	SXE2_TXQ_CTXT3_RDDESC_RO_M	BIT(13)
+#define	SXE2_TXQ_CTXT3_RDDESC_RO_M	RTE_BIT32(13)
 #define	SXE2_TXQ_CTXT3_WRDESC_RO_S	14
-#define	SXE2_TXQ_CTXT3_WRDESC_RO_M	BIT(14)
+#define	SXE2_TXQ_CTXT3_WRDESC_RO_M	RTE_BIT32(14)
 #define	SXE2_TXQ_CTXT3_RDDATA_RO_S	15
-#define	SXE2_TXQ_CTXT3_RDDATA_RO_M	BIT(15)
+#define	SXE2_TXQ_CTXT3_RDDATA_RO_M	RTE_BIT32(15)
 #define	SXE2_TXQ_CTXT3_QLEN_S		16
 #define	SXE2_TXQ_CTXT3_QLEN_M		SXE2_BITS_MASK(0x1FFF, 16)
 
@@ -400,16 +400,16 @@ enum {
 #define SXE2_PF_CTRLQ_MBX_ARQT   (SXE2_PF_CTRLQ_MBX_BASE + 0xE580)
 
 #define SXE2_CMD_REG_LEN_M      0x3FF
-#define SXE2_CMD_REG_LEN_VFE_M  BIT(28)
-#define SXE2_CMD_REG_LEN_OVFL_M BIT(29)
-#define SXE2_CMD_REG_LEN_CRIT_M BIT(30)
-#define SXE2_CMD_REG_LEN_ENABLE_M  BIT(31)
+#define SXE2_CMD_REG_LEN_VFE_M  RTE_BIT32(28)
+#define SXE2_CMD_REG_LEN_OVFL_M RTE_BIT32(29)
+#define SXE2_CMD_REG_LEN_CRIT_M RTE_BIT32(30)
+#define SXE2_CMD_REG_LEN_ENABLE_M  RTE_BIT32(31)
 
 #define SXE2_CMD_REG_HEAD_M     0x3FF
 
 #define SXE2_PF_CTRLQ_FW_HW_STS (SXE2_PF_CTRLQ_FW_BASE + 0x0500)
-#define SXE2_PF_CTRLQ_FW_ATQ_IDLE_MASK BIT(0)
-#define SXE2_PF_CTRLQ_FW_ARQ_IDLE_MASK BIT(1)
+#define SXE2_PF_CTRLQ_FW_ATQ_IDLE_MASK RTE_BIT32(0)
+#define SXE2_PF_CTRLQ_FW_ARQ_IDLE_MASK RTE_BIT32(1)
 
 #define SXE2_TOP_CFG_BASE      0x00292000
 #define SXE2_HW_VER (SXE2_TOP_CFG_BASE + 0x48c)
@@ -465,26 +465,26 @@ enum {
 #define SXE2_L2TAG_ID_VLAN		3
 
 #define SXE2_PFP_L2TAGSEN_ALL_TAG	0xFF
-#define SXE2_PFP_L2TAGSEN_DVM		BIT(10)
+#define SXE2_PFP_L2TAGSEN_DVM		RTE_BIT32(10)
 
 #define SXE2_VSI_TSR_STRIP_TAG_S	0
 #define SXE2_VSI_TSR_SHOW_TAG_S	4
 
-#define SXE2_VSI_TSR_ID_STAG		BIT(0)
-#define SXE2_VSI_TSR_ID_OUT_VLAN1	BIT(1)
-#define SXE2_VSI_TSR_ID_OUT_VLAN2	BIT(2)
-#define SXE2_VSI_TSR_ID_VLAN		BIT(3)
+#define SXE2_VSI_TSR_ID_STAG		RTE_BIT32(0)
+#define SXE2_VSI_TSR_ID_OUT_VLAN1	RTE_BIT32(1)
+#define SXE2_VSI_TSR_ID_OUT_VLAN2	RTE_BIT32(2)
+#define SXE2_VSI_TSR_ID_VLAN		RTE_BIT32(3)
 
 #define SXE2_VSI_L2TAGSTXVALID_L2TAG1_ID_S	0
 #define SXE2_VSI_L2TAGSTXVALID_L2TAG1_ID_M	0x7
-#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_VALID	BIT(3)
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_VALID	RTE_BIT32(3)
 #define SXE2_VSI_L2TAGSTXVALID_L2TAG2_ID_S	4
 #define SXE2_VSI_L2TAGSTXVALID_L2TAG2_ID_M	0x7
-#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_VALID	BIT(7)
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_VALID	RTE_BIT32(7)
 #define SXE2_VSI_L2TAGSTXVALID_TIR0_ID_S	16
-#define SXE2_VSI_L2TAGSTXVALID_TIR0_VALID	BIT(19)
+#define SXE2_VSI_L2TAGSTXVALID_TIR0_VALID	RTE_BIT32(19)
 #define SXE2_VSI_L2TAGSTXVALID_TIR1_ID_S	20
-#define SXE2_VSI_L2TAGSTXVALID_TIR1_VALID	BIT(23)
+#define SXE2_VSI_L2TAGSTXVALID_TIR1_VALID	RTE_BIT32(23)
 
 #define SXE2_VSI_L2TAGSTXVALID_ID_STAG		0
 #define SXE2_VSI_L2TAGSTXVALID_ID_OUT_VLAN1	2
@@ -498,43 +498,43 @@ enum {
 #define SXE2_VSI_RX_SWITCH_CTRL(_i)	(SXE2_SWITCH_RG_BASE + 0x01074 + ((_i) * 4))
 #define SXE2_VSI_TX_SWITCH_CTRL(_i)	(SXE2_SWITCH_RG_BASE + 0x01C74 + ((_i) * 4))
 
-#define SXE2_VSI_RX_SW_CTRL_VLAN_PRUNE	BIT(9)
+#define SXE2_VSI_RX_SW_CTRL_VLAN_PRUNE	RTE_BIT32(9)
 
-#define SXE2_VSI_TX_SW_CTRL_LOOPBACK_EN	BIT(1)
-#define SXE2_VSI_TX_SW_CTRL_LAN_EN		BIT(2)
-#define SXE2_VSI_TX_SW_CTRL_MACAS_EN		BIT(3)
-#define SXE2_VSI_TX_SW_CTRL_VLAN_PRUNE		BIT(9)
+#define SXE2_VSI_TX_SW_CTRL_LOOPBACK_EN	RTE_BIT32(1)
+#define SXE2_VSI_TX_SW_CTRL_LAN_EN		RTE_BIT32(2)
+#define SXE2_VSI_TX_SW_CTRL_MACAS_EN		RTE_BIT32(3)
+#define SXE2_VSI_TX_SW_CTRL_VLAN_PRUNE		RTE_BIT32(9)
 
 #define SXE2_VSI_TAR_UNTAGGED_SHIFT		(16)
 
 #define SXE2_PCIE_SYS_READY                    0x38c
-#define SXE2_PCIE_SYS_READY_CORER_ASSERT       BIT(0)
-#define SXE2_PCIE_SYS_READY_STOP_DROP_DONE     BIT(2)
-#define SXE2_PCIE_SYS_READY_R5                 BIT(3)
-#define SXE2_PCIE_SYS_READY_STOP_DROP          BIT(16)
+#define SXE2_PCIE_SYS_READY_CORER_ASSERT       RTE_BIT32(0)
+#define SXE2_PCIE_SYS_READY_STOP_DROP_DONE     RTE_BIT32(2)
+#define SXE2_PCIE_SYS_READY_R5                 RTE_BIT32(3)
+#define SXE2_PCIE_SYS_READY_STOP_DROP          RTE_BIT32(16)
 
 #define SXE2_PCIE_DEV_CTRL_DEV_STATUS               0x78
-#define SXE2_PCIE_DEV_CTRL_DEV_STATUS_TRANS_PENDING BIT(21)
+#define SXE2_PCIE_DEV_CTRL_DEV_STATUS_TRANS_PENDING RTE_BIT32(21)
 
 #define SXE2_TOP_CFG_CORE            (SXE2_TOP_CFG_BASE + 0x0630)
 #define SXE2_TOP_CFG_CORE_RST_CODE   0x09FBD586
 
 #define SXE2_PFGEN_CTRL       (0x00336000)
-#define SXE2_PFGEN_CTRL_PFSWR BIT(0)
+#define SXE2_PFGEN_CTRL_PFSWR RTE_BIT32(0)
 
 #define SXE2_VFGEN_CTRL(_vf)       (0x00337000 + ((_vf) * 4))
-#define SXE2_VFGEN_CTRL_VFSWR      BIT(0)
+#define SXE2_VFGEN_CTRL_VFSWR      RTE_BIT32(0)
 
 #define SXE2_VF_VRC_VFGEN_RSTAT(_vf)        (0x00338000 + (_vf)*4)
 #define SXE2_VF_VRC_VFGEN_VFRSTAT           (0x3)
 #define SXE2_VF_VRC_VFGEN_VFRSTAT_VFR       (0)
-#define SXE2_VF_VRC_VFGEN_VFRSTAT_COMPLETE  (BIT(0))
-#define SXE2_VF_VRC_VFGEN_VFRSTAT_VF_ACTIVE (BIT(1))
-#define SXE2_VF_VRC_VFGEN_VFRSTAT_MASK (BIT(2))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_COMPLETE  (RTE_BIT32(0))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_VF_ACTIVE (RTE_BIT32(1))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_MASK (RTE_BIT32(2))
 #define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF (0x300)
 #define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_NO_VFR (0)
 #define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_VFR (1)
-#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_MASK (BIT(10))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_MASK (RTE_BIT32(10))
 
 #define SXE2_GLGEN_VFLRSTAT(_reg) (0x0033A000 + ((_reg)*4))
 
@@ -548,7 +548,7 @@ enum {
 #define SXE2_VF_RXQ_BASE_Q_NUM_M		(0x7FF << SXE2_VF_RXQ_BASE_Q_NUM_S)
 
 #define SXE2_VF_RXQ_MAPENA(_VF)		(0x000b0400 + ((_VF) * 4))
-#define SXE2_VF_RXQ_MAPENA_M		        BIT(0)
+#define SXE2_VF_RXQ_MAPENA_M		        RTE_BIT32(0)
 
 #define SXE2_VF_TXQ_BASE(_VF)			(0x00040400 + ((_VF) * 4))
 #define SXE2_VF_TXQ_BASE_FIRST_Q_S		0
@@ -557,12 +557,12 @@ enum {
 #define SXE2_VF_TXQ_BASE_Q_NUM_M		(0xFF << SXE2_VF_TXQ_BASE_Q_NUM_S)
 
 #define SXE2_VF_TXQ_MAPENA(_VF)		(0x00045000 + ((_VF) * 4))
-#define SXE2_VF_TXQ_MAPENA_M		        BIT(0)
+#define SXE2_VF_TXQ_MAPENA_M		        RTE_BIT32(0)
 
 #define PRI_PTP_BASEADDR 0x2a8000
 
 #define GLTSYN (PRI_PTP_BASEADDR + 0x0)
-#define GLTSYN_ENA_M BIT(0)
+#define GLTSYN_ENA_M RTE_BIT32(0)
 
 #define GLTSYN_CMD (PRI_PTP_BASEADDR + 0x4)
 #define GLTSYN_CMD_INIT_TIME 0x01
@@ -578,12 +578,12 @@ enum {
 #define GLTSYN_SYNC_GEN_PULSE 0x4
 
 #define GLTSYN_SEM (PRI_PTP_BASEADDR + 0xC)
-#define GLTSYN_SEM_BUSY_M BIT(0)
+#define GLTSYN_SEM_BUSY_M RTE_BIT32(0)
 
 #define GLTSYN_STAT (PRI_PTP_BASEADDR + 0x10)
-#define GLTSYN_STAT_EVENT0_M			BIT(0)
-#define GLTSYN_STAT_EVENT1_M			BIT(1)
-#define GLTSYN_STAT_EVENT2_M			BIT(2)
+#define GLTSYN_STAT_EVENT0_M			RTE_BIT32(0)
+#define GLTSYN_STAT_EVENT1_M			RTE_BIT32(1)
+#define GLTSYN_STAT_EVENT2_M			RTE_BIT32(2)
 
 #define GLTSYN_TIME_SUBNS (PRI_PTP_BASEADDR + 0x20)
 #define GLTSYN_TIME_NS (PRI_PTP_BASEADDR + 0x24)
@@ -616,19 +616,19 @@ enum {
 
 #define GLTSYN_AUXOUT(_i) \
 	(PRI_PTP_BASEADDR + 0xD0 + ((_i) * 4))
-#define GLTSYN_AUXOUT_OUT_ENA BIT(0)
+#define GLTSYN_AUXOUT_OUT_ENA RTE_BIT32(0)
 #define GLTSYN_AUXOUT_OUT_MOD (0x03 << 1)
-#define GLTSYN_AUXOUT_OUTLVL BIT(3)
-#define GLTSYN_AUXOUT_INT_ENA BIT(4)
+#define GLTSYN_AUXOUT_OUTLVL RTE_BIT32(3)
+#define GLTSYN_AUXOUT_INT_ENA RTE_BIT32(4)
 #define GLTSYN_AUXOUT_PULSEW (0x1fff << 3)
 
 #define GLTSYN_CLKO(_i) \
 	(PRI_PTP_BASEADDR + 0xE0 + ((_i) * 4))
 
 #define GLTSYN_AUXIN(_i) (PRI_PTP_BASEADDR + 0xF4 + ((_i) * 4))
-#define GLTSYN_AUXIN_RISING_EDGE BIT(0)
-#define GLTSYN_AUXIN_FALLING_EDGE BIT(1)
-#define GLTSYN_AUXIN_ENABLE BIT(4)
+#define GLTSYN_AUXIN_RISING_EDGE RTE_BIT32(0)
+#define GLTSYN_AUXIN_FALLING_EDGE RTE_BIT32(1)
+#define GLTSYN_AUXIN_ENABLE RTE_BIT32(4)
 
 #define CGMAC_CSR_BASE 0x2B4000
 
@@ -654,13 +654,13 @@ enum {
 #define SXE2_VF_GLINT_CEQCTL_MSIX_INDX_M	SXE2_BITS_MASK(0x7FF, 0)
 #define SXE2_VF_GLINT_CEQCTL_ITR_INDX_S	11
 #define SXE2_VF_GLINT_CEQCTL_ITR_INDX_M	SXE2_BITS_MASK(0x3, 11)
-#define SXE2_VF_GLINT_CEQCTL_CAUSE_ENA_M	BIT(30)
+#define SXE2_VF_GLINT_CEQCTL_CAUSE_ENA_M	RTE_BIT32(30)
 #define SXE2_VF_GLINT_CEQCTL(_INT)			(0x0026492C + ((_INT) * 4))
 
 #define SXE2_VF_PFINT_AEQCTL_MSIX_INDX_M	SXE2_BITS_MASK(0x7FF, 0)
 #define SXE2_VF_VPINT_AEQCTL_ITR_INDX_S	11
 #define SXE2_VF_VPINT_AEQCTL_ITR_INDX_M	SXE2_BITS_MASK(0x3, 11)
-#define SXE2_VF_VPINT_AEQCTL_CAUSE_ENA_M	BIT(30)
+#define SXE2_VF_VPINT_AEQCTL_CAUSE_ENA_M	RTE_BIT32(30)
 #define SXE2_VF_VPINT_AEQCTL(_VF)			(0x0026052c + ((_VF) * 4))
 
 #define SXE2_IPSEC_TX_BASE (0x2A0000)
@@ -704,4 +704,4 @@ enum {
 #define SXE2_RXPFCXOFFFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
 						(0x0b70 + 8 * (pri)))
 
-#endif
+#endif /* __SXE2_HOST_REGS_H__ */
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
new file mode 100644
index 0000000000..4c2bc452ff
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <sys/types.h>
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
+int32_t
+sxe2_drv_cmd_exec(struct sxe2_common_device *cdev,
+		struct sxe2_drv_cmd_params *cmd_params)
+{
+	int32_t cmd_fd;
+	int32_t ret = -EIO;
+
+	if (cdev->config.kernel_reset) {
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
+		PMD_LOG_ERR(COM, "Fail to exec cmd, fd[%d] error", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Exec drv cmd fd[%d] trace_id[0x%"PRIx64"]"
+			"opcode[0x%x] req_len[%d] resp_len[%d]",
+			cmd_fd, cmd_params->trace_id, cmd_params->opcode,
+			cmd_params->req_len, cmd_params->resp_len);
+
+	(void)pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_PASSTHROUGH, cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Fail to exec cmd, fd[%d] opcode[0x%x] ret[%d], err:%s",
+				cmd_fd, cmd_params->opcode, ret, strerror(errno));
+		ret = -errno;
+		(void)pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	(void)pthread_mutex_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_open)
+int32_t
+sxe2_drv_dev_open(struct sxe2_common_device *cdev, struct rte_pci_device *pci_dev)
+{
+	int32_t ret = 0;
+	int32_t fd = 0;
+	char drv_name[32] = {0};
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
+		ret = -EBADF;
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
+	int32_t fd = SXE2_CDEV_TO_CMD_FD(cdev);
+
+	if (fd >= 0)
+		close(fd);
+	PMD_LOG_INFO(COM, "closed device fd=%d", fd);
+	SXE2_CDEV_TO_CMD_FD(cdev) = -1;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_handshark)
+int32_t
+sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
+{
+	int32_t ret = 0;
+	int32_t cmd_fd = 0;
+	struct sxe2_ioctl_cmd_common_hdr cmd_params;
+
+	if (cdev->config.kernel_reset) {
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
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
+	(void)pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_HANDSHAKE, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to handshark, fd=%d, ret=%d, err:%s",
+				cmd_fd, ret, strerror(errno));
+		ret = -EIO;
+		(void)pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	(void)pthread_mutex_unlock(&cdev->config.lock);
+
+	if (cmd_params.cap & RTE_BIT32(SXE2_COM_CAP_IOMMU_MAP))
+		cdev->config.support_iommu = true;
+	else
+		cdev->config.support_iommu = false;
+
+l_end:
+	return ret;
+}
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.h b/drivers/common/sxe2/sxe2_ioctl_chnl.h
new file mode 100644
index 0000000000..2560349e70
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_IOCTL_CHNL_H__
+#define __SXE2_IOCTL_CHNL_H__
+
+#include <rte_version.h>
+#include <bus_pci_driver.h>
+
+#include "sxe2_internal_ver.h"
+
+#define SXE2_COM_INVAL_uint32_t 0xFFFFFFFF
+
+#define SXE2_COM_PCI_OFFSET_SHIFT 40
+
+#define SXE2_COM_PCI_INDEX_TO_OFFSET(index)	((uint64_t)(index) << SXE2_COM_PCI_OFFSET_SHIFT)
+#define SXE2_COM_PCI_OFFSET_MASK	(((uint64_t)(1) << SXE2_COM_PCI_OFFSET_SHIFT) - 1)
+#define SXE2_COM_PCI_OFFSET_GEN(index, off) ((((uint64_t)(index)) << SXE2_COM_PCI_OFFSET_SHIFT) | \
+		(((uint64_t)(off)) & SXE2_COM_PCI_OFFSET_MASK))
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
+	uint32_t dpdk_ver;
+	uint32_t drv_ver;
+	uint32_t msg_len;
+	uint32_t cap;
+	uint8_t  reserved[32];
+};
+
+struct sxe2_drv_cmd_params {
+	uint64_t trace_id;
+	uint32_t timeout;
+	uint32_t opcode;
+	uint16_t vsi_id;
+	uint16_t repr_id;
+	uint32_t req_len;
+	uint32_t resp_len;
+	void *req_data;
+	void *resp_data;
+	uint8_t    resv[32];
+};
+
+struct sxe2_ioctl_irq_set {
+	uint32_t  cnt;
+	uint8_t   resv[4];
+	uint32_t  base_irq_in_com;
+	int32_t *event_fd;
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
+	int32_t eventfd;
+	uint8_t  resv[4];
+	uint64_t filter_table;
+};
+
+struct sxe2_ioctl_other_evt_get {
+	uint64_t evt_cause;
+	uint8_t  resv[8];
+};
+
+struct sxe2_ioctl_reset_sub_set {
+	int32_t eventfd;
+	uint8_t  resv[4];
+};
+
+struct sxe2_ioctl_iommu_dma_map {
+	uint64_t vaddr;
+	uint64_t iova;
+	uint64_t size;
+	uint8_t  resv[4];
+};
+
+struct sxe2_ioctl_iommu_dma_unmap {
+	uint64_t iova;
+};
+
+union sxe2_drv_trace_info {
+	uint64_t id;
+	struct {
+		uint64_t count : 54;
+		uint64_t cpu_id : 10;
+	} sxe2_drv_trace_id_param;
+};
+
+#endif /* __SXE2_IOCTL_CHNL_H__ */
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
new file mode 100644
index 0000000000..055229b0c3
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
@@ -0,0 +1,44 @@
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
+int32_t
+sxe2_drv_cmd_exec(struct sxe2_common_device *cdev,
+		struct sxe2_drv_cmd_params *cmd_params);
+
+__rte_internal
+int32_t
+sxe2_drv_dev_open(struct sxe2_common_device *cdev,
+		struct rte_pci_device *pci_dev);
+
+__rte_internal
+void
+sxe2_drv_dev_close(struct sxe2_common_device *cdev);
+
+__rte_internal
+int32_t
+sxe2_drv_dev_handshark(struct sxe2_common_device *cdev);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __SXE2_IOCTL_CHNL_FUNC_H__ */
diff --git a/drivers/common/sxe2/sxe2_osal.h b/drivers/common/sxe2/sxe2_osal.h
index 3bea8fbf85..58a8dbc522 100644
--- a/drivers/common/sxe2/sxe2_osal.h
+++ b/drivers/common/sxe2/sxe2_osal.h
@@ -63,7 +63,7 @@ enum sxe2_itr_idx {
 #define  ETH_P_QINQ1  0x9100
 
 #define BITS_TO_LONGS(nr) DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(unsigned long))
-#define BITS_TO_U32(nr) DIV_ROUND_UP(nr, 32)
+#define BITS_TO_uint32_t(nr) DIV_ROUND_UP(nr, 32)
 
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (__BITS_PER_LONG - 1)))
 
@@ -86,4 +86,4 @@ static inline uint32_t sxe2_test_bit(uint32_t nr, const volatile unsigned long *
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (__BITS_PER_LONG-1)));
 }
 
-#endif /* __SXE2_OSAL_H */
+#endif /* __SXE2_OSAL_H__ */
diff --git a/drivers/meson.build b/drivers/meson.build
index 6ae102e943..d4ae512bae 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -12,6 +12,7 @@ subdirs = [
         'common/qat',     # depends on bus.
         'common/sfc_efx', # depends on bus.
         'common/zsda',    # depends on bus.
+        'common/sxe2',    # depends on bus.
         'mempool',        # depends on common and bus.
         'dma',            # depends on common and bus.
         'net',            # depends on common, bus, mempool
-- 
2.47.3

