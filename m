Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A18C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 15:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B09AB4067D;
	Sat, 17 May 2025 17:17:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C0B5F4067D
 for <dev@dpdk.org>; Sat, 17 May 2025 17:17:50 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A541F169C;
 Sat, 17 May 2025 08:17:37 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 084A43F673;
 Sat, 17 May 2025 08:17:50 -0700 (PDT)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: [RFC PATCH v4 1/3] pci: add non-merged Linux uAPI changes
Date: Sat, 17 May 2025 15:17:33 +0000
Message-ID: <20250517151736.2565461-2-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250517151736.2565461-1-wathsala.vithanage@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-1-wathsala.vithanage@arm.com>
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

This commit is a hack to prevent build failures the next commit in this
patch series causes due to missing vfio uapi definitions.
This commit should NEVER BE MERGED.
Next commit in this patch series depends on additions to vfio uapi that
enable TPH icotl in the vfio-pci driver in the Linux kernel.
These additions have not yet been merged into the upstream kernel.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
---
 drivers/bus/pci/linux/pci_init.h   |   1 +
 kernel/linux/uapi/linux/vfio_tph.h | 100 +++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 kernel/linux/uapi/linux/vfio_tph.h

diff --git a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci_init.h
index a4d37c0d0a..25b901f460 100644
--- a/drivers/bus/pci/linux/pci_init.h
+++ b/drivers/bus/pci/linux/pci_init.h
@@ -6,6 +6,7 @@
 #define EAL_PCI_INIT_H_
 
 #include <rte_vfio.h>
+#include <uapi/linux/vfio_tph.h>
 
 #include "private.h"
 
diff --git a/kernel/linux/uapi/linux/vfio_tph.h b/kernel/linux/uapi/linux/vfio_tph.h
new file mode 100644
index 0000000000..5850400fad
--- /dev/null
+++ b/kernel/linux/uapi/linux/vfio_tph.h
@@ -0,0 +1,100 @@
+
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * VFIO API definition
+ *
+ * WARNING: CONTENTS OF THIS HEADER NEEDS TO BE MERGED INTO KERNEL'S
+ * uapi/linux/vifo.h IN A FUTURE KERNEL RELEASE. UNTIL THEN IT'S TACKED
+ * ON TO DPDK'S kernel/linux/uapi DIRECTORY TO PREVENT BUILD FAILURES.
+ *
+ * Copyright (C) 2012 Red Hat, Inc.  All rights reserved.
+ *     Author: Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _UAPIVFIO_TPH_H
+#define _UAPIVFIO_TPH_H
+
+/**
+ * VFIO_DEVICE_PCI_TPH	- _IO(VFIO_TYPE, VFIO_BASE + 22)
+ *
+ * This command is used to control PCIe TLP Processing Hints (TPH)
+ * capability in a PCIe device.
+ * It supports following operations on a PCIe device with respect to TPH
+ * capability.
+ *
+ * - Enabling/disabling TPH capability in a PCIe device.
+ *
+ *   Setting VFIO_DEVICE_TPH_ENABLE flag enables TPH in no-steering-tag,
+ *   interrupt-vector, or device-specific mode defined in the PCIe specficiation
+ *   when feature flags VFIO_TPH_ST_NS_MODE, VFIO_TPH_ST_IV_MODE, and
+ *   VFIO_TPH_ST_DS_MODE are set respectively.
+ *   VFIO_DEVICE_TPH_DISABLE disables PCIe TPH on the device.
+ *
+ * - Writing STs to MSI-X or ST table in a PCIe device.
+ *
+ *   VFIO_DEVICE_TPH_SET_ST flag set steering tags on a device at an index in
+ *   MSI-X or ST-table depending on the VFIO_TPH_ST_x_MODE flag used and device
+ *   capabilities. The caller can set one or more steering tags by passing an
+ *   array of vfio_pci_tph_entry objects containing cpu_id, cache_level, and
+ *   MSI-X/ST-table index. The caller can also set the intended memory type and
+ *   the processing hint by setting VFIO_TPH_MEM_TYPE_x and VFIO_TPH_HINT_x
+ *   flags, respectively.
+ *
+ * - Reading Steering Tags (ST) from the host platform.
+ *
+ *   VFIO_DEVICE_TPH_GET_ST flags returns steering tags to the caller. Caller
+ *   can request one or more steering tags by passing an array of
+ *   vfio_pci_tph_entry objects. Steering Tag for each request is returned via
+ *   the st field in vfio_pci_tph_entry.
+ */
+struct vfio_pci_tph_entry {
+	/* in */
+	__u32 cpu_id;			/* CPU logical ID */
+	__u32 cache_level;		/* Cache level. L1 D= 0, L2D = 2, ...*/
+	__u8  flags;
+#define VFIO_TPH_MEM_TYPE_MASK		0x1
+#define VFIO_TPH_MEM_TYPE_SHIFT		0
+#define VFIO_TPH_MEM_TYPE_VMEM		0   /* Request volatile memory ST */
+#define VFIO_TPH_MEM_TYPE_PMEM		1   /* Request persistent memory ST */
+
+#define VFIO_TPH_HINT_MASK		0x3
+#define VFIO_TPH_HINT_SHIFT		1
+#define VFIO_TPH_HINT_BIDIR		0
+#define VFIO_TPH_HINT_REQSTR		(1 << VFIO_TPH_HINT_SHIFT)
+#define VFIO_TPH_HINT_TARGET		(2 << VFIO_TPH_HINT_SHIFT)
+#define VFIO_TPH_HINT_TARGET_PRIO	(3 << VFIO_TPH_HINT_SHIFT)
+	__u8  pad0;
+	__u16 index;			/* MSI-X/ST-table index to set ST */
+	/* out */
+	__u16 st;			/* Steering-Tag */
+	__u8  ph_ignore;		/* Platform ignored the Processing */
+	__u8  pad1;
+};
+
+struct vfio_pci_tph {
+	__u32 argsz;			/* Size of vfio_pci_tph and info[] */
+	__u32 flags;
+#define VFIO_DEVICE_TPH_OP_MASK		0x7
+#define VFIO_DEVICE_TPH_OP_SHIFT	3
+#define VFIO_DEVICE_TPH_ENABLE		0	/* Enable TPH on device */
+#define VFIO_DEVICE_TPH_DISABLE		1	/* Disable TPH on device */
+#define VFIO_DEVICE_TPH_GET_ST		2	/* Get steering-tags */
+#define VFIO_DEVICE_TPH_SET_ST		4	/* Set steering-tags */
+
+#define	VFIO_TPH_ST_MODE_MASK	(0x3 << VFIO_DEVICE_TPH_OP_SHIFT)
+#define	VFIO_TPH_ST_NS_MODE	(0 << VFIO_DEVICE_TPH_OP_SHIFT)
+#define	VFIO_TPH_ST_IV_MODE	(1 << VFIO_DEVICE_TPH_OP_SHIFT)
+#define	VFIO_TPH_ST_DS_MODE	(2 << VFIO_DEVICE_TPH_OP_SHIFT)
+	__u32 count;			/* Number of entries in ents[] */
+	struct vfio_pci_tph_entry ents[];
+#define VFIO_TPH_INFO_MAX	2048	/* Max entries in ents[] */
+};
+
+#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+
+#endif /* _UAPIVFIO_TPH_H */
-- 
2.43.0

