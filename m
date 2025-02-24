Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855DBC021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E32224113D;
	Mon, 24 Feb 2025 10:55:15 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 80E7E40E41
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:54:56 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKi001315
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 +/IOZ7rL3dt2C3Xg5S6LHev5NfNsoa/eFCw+KS1pUE=; b=fsTBgKT2n9/wY5X4l
 PT0XPUfWM5+00Ej+Kdhg+uHfABHBJMcP043FtxkqGOdX1Ebh2jlJ/2eP/NRPM1wP
 w5EcZp+4Yr+/u+C56Vxzhi9z5CdZl+xx46aTAinWyZ0LLKcJqAmHsbrK7VMnSMiQ
 YGuzPEHFoP5ix7IM4BeqLKnYOeX8BxwnGVgD1yQfIY/UDMdieF0X6Diw7CH00mDD
 Na90xWoySydJq4dIIIjKs/98N9iXgW8+Bn2lzyPERZlM0x42xJwSgEuZnjYiPOMn
 kCsFtCrJAQY4QkqfRTU4vQEYeFQ9RDJjpynLUB1DFatbCacg2Fl2yd24jHGDNKof
 BAVZg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh3c-17
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:55 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:54:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:54:47 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 6D6393F705D;
 Mon, 24 Feb 2025 01:54:45 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3 33/33] common/cnxk: move interrupt handling to
 platform-specific
Date: Mon, 24 Feb 2025 15:22:41 +0530
Message-ID: <20250224095241.1263700-33-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: H7Tj21Ol37JzH4vdcLYJqtHxm1xYZB7q
X-Proofpoint-ORIG-GUID: H7Tj21Ol37JzH4vdcLYJqtHxm1xYZB7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Satha Rao <skoteshwar@marvell.com>

This change refactors the interrupt handling to be platform-specific.
Some platforms directly call ioctls, while others provide a library API
for the same functionality. Moving the interrupt handling to
platform-specific implementations enhances clarity and maintainability.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_irq.c      | 239 +++--------------------------
 drivers/common/cnxk/roc_platform.c | 231 ++++++++++++++++++++++++++++
 drivers/common/cnxk/roc_platform.h |   7 +
 3 files changed, 259 insertions(+), 218 deletions(-)

diff --git a/drivers/common/cnxk/roc_irq.c b/drivers/common/cnxk/roc_irq.c
index 0b21b9e2d9..b1d41346c0 100644
--- a/drivers/common/cnxk/roc_irq.c
+++ b/drivers/common/cnxk/roc_irq.c
@@ -7,243 +7,37 @@
 
 #if defined(__linux__)
 
-#include <inttypes.h>
-#include <linux/vfio.h>
-#include <sys/eventfd.h>
-#include <sys/ioctl.h>
-#include <unistd.h>
-
-#define MSIX_IRQ_SET_BUF_LEN                                                   \
-	(sizeof(struct vfio_irq_set) + sizeof(int) *			       \
-			((uint32_t)plt_intr_max_intr_get(intr_handle)))
-
-static int
-irq_get_info(struct plt_intr_handle *intr_handle)
-{
-	struct vfio_irq_info irq = {.argsz = sizeof(irq)};
-	int rc, vfio_dev_fd;
-
-	irq.index = VFIO_PCI_MSIX_IRQ_INDEX;
-
-	vfio_dev_fd = plt_intr_dev_fd_get(intr_handle);
-	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
-	if (rc < 0) {
-		plt_err("Failed to get IRQ info rc=%d errno=%d", rc, errno);
-		return rc;
-	}
-
-	plt_base_dbg("Flags=0x%x index=0x%x count=0x%x max_intr_vec_id=0x%x",
-		     irq.flags, irq.index, irq.count, PLT_MAX_RXTX_INTR_VEC_ID);
-
-	if (irq.count == 0) {
-		plt_err("HW max=%d > PLT_MAX_RXTX_INTR_VEC_ID: %d", irq.count,
-			PLT_MAX_RXTX_INTR_VEC_ID);
-		plt_intr_max_intr_set(intr_handle, PLT_MAX_RXTX_INTR_VEC_ID);
-	} else {
-		if (plt_intr_max_intr_set(intr_handle, irq.count))
-			return -1;
-	}
-
-	return 0;
-}
-
-static int
-irq_config(struct plt_intr_handle *intr_handle, unsigned int vec)
-{
-	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
-	struct vfio_irq_set *irq_set;
-	int len, rc, vfio_dev_fd;
-	int32_t *fd_ptr;
-
-	if (vec > (uint32_t)plt_intr_max_intr_get(intr_handle)) {
-		plt_err("vector=%d greater than max_intr=%d", vec,
-			plt_intr_max_intr_get(intr_handle));
-		return -EINVAL;
-	}
-
-	len = sizeof(struct vfio_irq_set) + sizeof(int32_t);
-
-	irq_set = (struct vfio_irq_set *)irq_set_buf;
-	irq_set->argsz = len;
-
-	irq_set->start = vec;
-	irq_set->count = 1;
-	irq_set->flags =
-		VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
-	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
-
-	/* Use vec fd to set interrupt vectors */
-	fd_ptr = (int32_t *)&irq_set->data[0];
-	fd_ptr[0] = plt_intr_efds_index_get(intr_handle, vec);
-
-	vfio_dev_fd = plt_intr_dev_fd_get(intr_handle);
-	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
-	if (rc)
-		plt_err("Failed to set_irqs vector=0x%x rc=%d", vec, rc);
-
-	return rc;
-}
-
-static int
-irq_init(struct plt_intr_handle *intr_handle)
-{
-	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
-	struct vfio_irq_set *irq_set;
-	int len, rc, vfio_dev_fd;
-	int32_t *fd_ptr;
-	uint32_t i;
-
-	len = sizeof(struct vfio_irq_set) +
-	      sizeof(int32_t) * plt_intr_max_intr_get(intr_handle);
-
-	irq_set = (struct vfio_irq_set *)irq_set_buf;
-	irq_set->argsz = len;
-	irq_set->start = 0;
-	irq_set->count = plt_intr_max_intr_get(intr_handle);
-	irq_set->flags =
-		VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
-	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
-
-	fd_ptr = (int32_t *)&irq_set->data[0];
-	for (i = 0; i < irq_set->count; i++)
-		fd_ptr[i] = -1;
-
-	vfio_dev_fd = plt_intr_dev_fd_get(intr_handle);
-	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
-	if (rc)
-		plt_err("Failed to set irqs vector rc=%d", rc);
-
-	return rc;
-}
-
 int
 dev_irqs_disable(struct plt_intr_handle *intr_handle)
 {
-	/* Clear max_intr to indicate re-init next time */
-	plt_intr_max_intr_set(intr_handle, 0);
-	return plt_intr_disable(intr_handle);
+	return plt_irq_disable(intr_handle);
 }
 
 int
 dev_irq_reconfigure(struct plt_intr_handle *intr_handle, uint16_t max_intr)
 {
-	/* Disable interrupts if enabled. */
-	if (plt_intr_max_intr_get(intr_handle))
-		dev_irqs_disable(intr_handle);
-
-	plt_intr_max_intr_set(intr_handle, max_intr);
-	return irq_init(intr_handle);
+	return plt_irq_reconfigure(intr_handle, max_intr);
 }
 
 int
-dev_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
-		 void *data, unsigned int vec)
+dev_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+		 unsigned int vec)
 {
-	struct plt_intr_handle *tmp_handle;
-	uint32_t nb_efd, tmp_nb_efd;
-	int rc, fd;
-
-	/* If no max_intr read from VFIO */
-	if (plt_intr_max_intr_get(intr_handle) == 0) {
-		irq_get_info(intr_handle);
-		irq_init(intr_handle);
-	}
-
-	if (vec > (uint32_t)plt_intr_max_intr_get(intr_handle)) {
-		plt_err("Vector=%d greater than max_intr=%d or ",
-			vec, plt_intr_max_intr_get(intr_handle));
-		return -EINVAL;
-	}
-
-	tmp_handle = intr_handle;
-	/* Create new eventfd for interrupt vector */
-	fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
-	if (fd == -1)
-		return -ENODEV;
-
-	if (plt_intr_fd_set(tmp_handle, fd))
-		return -errno;
-
-	/* Register vector interrupt callback */
-	rc = plt_intr_callback_register(tmp_handle, cb, data);
-	if (rc) {
-		plt_err("Failed to register vector:0x%x irq callback.", vec);
-		return rc;
-	}
-
-	rc = plt_intr_efds_index_set(intr_handle, vec, fd);
-	if (rc)
-		return rc;
-
-	nb_efd = (vec > (uint32_t)plt_intr_nb_efd_get(intr_handle)) ?
-		vec : (uint32_t)plt_intr_nb_efd_get(intr_handle);
-	plt_intr_nb_efd_set(intr_handle, nb_efd);
-
-	tmp_nb_efd = plt_intr_nb_efd_get(intr_handle) + 1;
-	if (tmp_nb_efd > (uint32_t)plt_intr_max_intr_get(intr_handle))
-		plt_intr_max_intr_set(intr_handle, tmp_nb_efd);
-	plt_base_dbg("Enable vector:0x%x for vfio (efds: %d, max:%d)", vec,
-		     plt_intr_nb_efd_get(intr_handle),
-		     plt_intr_max_intr_get(intr_handle));
-
-	/* Enable MSIX vectors to VFIO */
-	return irq_config(intr_handle, vec);
+	return plt_irq_register(intr_handle, cb, data, vec);
 }
 
 void
-dev_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
-		   void *data, unsigned int vec)
+dev_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+		   unsigned int vec)
 {
-	struct plt_intr_handle *tmp_handle;
-	uint8_t retries = 5; /* 5 ms */
-	int rc, fd;
-
-	if (vec > (uint32_t)plt_intr_max_intr_get(intr_handle)) {
-		plt_err("Error unregistering MSI-X interrupts vec:%d > %d", vec,
-			plt_intr_max_intr_get(intr_handle));
-		return;
-	}
-
-	tmp_handle = intr_handle;
-	fd = plt_intr_efds_index_get(intr_handle, vec);
-	if (fd == -1)
-		return;
-
-	if (plt_intr_fd_set(tmp_handle, fd))
-		return;
-
-	do {
-		/* Un-register callback func from platform lib */
-		rc = plt_intr_callback_unregister(tmp_handle, cb, data);
-		/* Retry only if -EAGAIN */
-		if (rc != -EAGAIN)
-			break;
-		plt_delay_ms(1);
-		retries--;
-	} while (retries);
-
-	if (rc < 0) {
-		plt_err("Error unregistering MSI-X vec %d cb, rc=%d", vec, rc);
-		return;
-	}
-
-	plt_base_dbg("Disable vector:0x%x for vfio (efds: %d, max:%d)", vec,
-		     plt_intr_nb_efd_get(intr_handle),
-		     plt_intr_max_intr_get(intr_handle));
-
-	if (plt_intr_efds_index_get(intr_handle, vec) != -1)
-		close(plt_intr_efds_index_get(intr_handle, vec));
-	/* Disable MSIX vectors from VFIO */
-	plt_intr_efds_index_set(intr_handle, vec, -1);
-
-	irq_config(intr_handle, vec);
+	plt_irq_unregister(intr_handle, cb, data, vec);
 }
 
 #else
 
 int
-dev_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
-		 void *data, unsigned int vec)
+dev_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+		 unsigned int vec)
 {
 	PLT_SET_USED(intr_handle);
 	PLT_SET_USED(cb);
@@ -254,8 +48,8 @@ dev_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
 }
 
 void
-dev_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
-		   void *data, unsigned int vec)
+dev_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+		   unsigned int vec)
 {
 	PLT_SET_USED(intr_handle);
 	PLT_SET_USED(cb);
@@ -271,4 +65,13 @@ dev_irqs_disable(struct plt_intr_handle *intr_handle)
 	return -ENOTSUP;
 }
 
+int
+dev_irq_reconfigure(struct plt_intr_handle *intr_handle, uint16_t max_intr)
+{
+	PLT_SET_USED(intr_handle);
+	PLT_SET_USED(max_intr);
+
+	return -ENOTSUP;
+}
+
 #endif /* __linux__ */
diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index f1e0a93d97..401f737ad4 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -5,6 +5,237 @@
 #include <rte_log.h>
 
 #include "roc_api.h"
+#include "roc_priv.h"
+
+#if defined(__linux__)
+
+#include <inttypes.h>
+#include <linux/vfio.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#define MSIX_IRQ_SET_BUF_LEN                                                                       \
+	(sizeof(struct vfio_irq_set) + sizeof(int) * (plt_intr_max_intr_get(intr_handle)))
+
+static int
+irq_get_info(struct plt_intr_handle *intr_handle)
+{
+	struct vfio_irq_info irq = {.argsz = sizeof(irq)};
+	int rc, vfio_dev_fd;
+
+	irq.index = VFIO_PCI_MSIX_IRQ_INDEX;
+
+	vfio_dev_fd = plt_intr_dev_fd_get(intr_handle);
+	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
+	if (rc < 0) {
+		plt_err("Failed to get IRQ info rc=%d errno=%d", rc, errno);
+		return rc;
+	}
+
+	plt_base_dbg("Flags=0x%x index=0x%x count=0x%x max_intr_vec_id=0x%x", irq.flags, irq.index,
+		     irq.count, PLT_MAX_RXTX_INTR_VEC_ID);
+
+	if (irq.count == 0) {
+		plt_err("HW max=%d > PLT_MAX_RXTX_INTR_VEC_ID: %d", irq.count,
+			PLT_MAX_RXTX_INTR_VEC_ID);
+		plt_intr_max_intr_set(intr_handle, PLT_MAX_RXTX_INTR_VEC_ID);
+	} else {
+		if (plt_intr_max_intr_set(intr_handle, irq.count))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int
+irq_config(struct plt_intr_handle *intr_handle, unsigned int vec)
+{
+	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
+	struct vfio_irq_set *irq_set;
+	int len, rc, vfio_dev_fd;
+	int32_t *fd_ptr;
+
+	if (vec > (uint32_t)plt_intr_max_intr_get(intr_handle)) {
+		plt_err("vector=%d greater than max_intr=%d", vec,
+			plt_intr_max_intr_get(intr_handle));
+		return -EINVAL;
+	}
+
+	len = sizeof(struct vfio_irq_set) + sizeof(int32_t);
+
+	irq_set = (struct vfio_irq_set *)irq_set_buf;
+	irq_set->argsz = len;
+
+	irq_set->start = vec;
+	irq_set->count = 1;
+	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
+	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
+
+	/* Use vec fd to set interrupt vectors */
+	fd_ptr = (int32_t *)&irq_set->data[0];
+	fd_ptr[0] = plt_intr_efds_index_get(intr_handle, vec);
+
+	vfio_dev_fd = plt_intr_dev_fd_get(intr_handle);
+	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
+	if (rc)
+		plt_err("Failed to set_irqs vector=0x%x rc=%d", vec, rc);
+
+	return rc;
+}
+
+static int
+irq_init(struct plt_intr_handle *intr_handle)
+{
+	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
+	struct vfio_irq_set *irq_set;
+	int len, rc, vfio_dev_fd;
+	int32_t *fd_ptr;
+	uint32_t i;
+
+	len = sizeof(struct vfio_irq_set) + sizeof(int32_t) * plt_intr_max_intr_get(intr_handle);
+
+	irq_set = (struct vfio_irq_set *)irq_set_buf;
+	irq_set->argsz = len;
+	irq_set->start = 0;
+	irq_set->count = plt_intr_max_intr_get(intr_handle);
+	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
+	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
+
+	fd_ptr = (int32_t *)&irq_set->data[0];
+	for (i = 0; i < irq_set->count; i++)
+		fd_ptr[i] = -1;
+
+	vfio_dev_fd = plt_intr_dev_fd_get(intr_handle);
+	rc = ioctl(vfio_dev_fd, VFIO_DEVICE_SET_IRQS, irq_set);
+	if (rc)
+		plt_err("Failed to set irqs vector rc=%d", rc);
+
+	return rc;
+}
+
+int
+plt_irq_disable(struct plt_intr_handle *intr_handle)
+{
+	/* Clear max_intr to indicate re-init next time */
+	plt_intr_max_intr_set(intr_handle, 0);
+	return plt_intr_disable(intr_handle);
+}
+
+int
+plt_irq_reconfigure(struct plt_intr_handle *intr_handle, uint16_t max_intr)
+{
+	/* Disable interrupts if enabled. */
+	if (plt_intr_max_intr_get(intr_handle))
+		dev_irqs_disable(intr_handle);
+
+	plt_intr_max_intr_set(intr_handle, max_intr);
+	return irq_init(intr_handle);
+}
+
+int
+plt_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+		 unsigned int vec)
+{
+	struct plt_intr_handle *tmp_handle;
+	uint32_t nb_efd, tmp_nb_efd;
+	int rc, fd;
+
+	/* If no max_intr read from VFIO */
+	if (plt_intr_max_intr_get(intr_handle) == 0) {
+		irq_get_info(intr_handle);
+		irq_init(intr_handle);
+	}
+
+	if (vec > (uint32_t)plt_intr_max_intr_get(intr_handle)) {
+		plt_err("Vector=%d greater than max_intr=%d or ", vec,
+			plt_intr_max_intr_get(intr_handle));
+		return -EINVAL;
+	}
+
+	tmp_handle = intr_handle;
+	/* Create new eventfd for interrupt vector */
+	fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (fd == -1)
+		return -ENODEV;
+
+	if (plt_intr_fd_set(tmp_handle, fd))
+		return -errno;
+
+	/* Register vector interrupt callback */
+	rc = plt_intr_callback_register(tmp_handle, cb, data);
+	if (rc) {
+		plt_err("Failed to register vector:0x%x irq callback.", vec);
+		return rc;
+	}
+
+	rc = plt_intr_efds_index_set(intr_handle, vec, fd);
+	if (rc)
+		return rc;
+
+	nb_efd = (vec > (uint32_t)plt_intr_nb_efd_get(intr_handle)) ?
+			 vec :
+			 (uint32_t)plt_intr_nb_efd_get(intr_handle);
+	plt_intr_nb_efd_set(intr_handle, nb_efd);
+
+	tmp_nb_efd = plt_intr_nb_efd_get(intr_handle) + 1;
+	if (tmp_nb_efd > (uint32_t)plt_intr_max_intr_get(intr_handle))
+		plt_intr_max_intr_set(intr_handle, tmp_nb_efd);
+	plt_base_dbg("Enable vector:0x%x for vfio (efds: %d, max:%d)", vec,
+		     plt_intr_nb_efd_get(intr_handle), plt_intr_max_intr_get(intr_handle));
+
+	/* Enable MSIX vectors to VFIO */
+	return irq_config(intr_handle, vec);
+}
+
+void
+plt_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+		   unsigned int vec)
+{
+	struct plt_intr_handle *tmp_handle;
+	uint8_t retries = 5; /* 5 ms */
+	int rc, fd;
+
+	if (vec > (uint32_t)plt_intr_max_intr_get(intr_handle)) {
+		plt_err("Error unregistering MSI-X interrupts vec:%d > %d", vec,
+			plt_intr_max_intr_get(intr_handle));
+		return;
+	}
+
+	tmp_handle = intr_handle;
+	fd = plt_intr_efds_index_get(intr_handle, vec);
+	if (fd == -1)
+		return;
+
+	if (plt_intr_fd_set(tmp_handle, fd))
+		return;
+
+	do {
+		/* Un-register callback func from platform lib */
+		rc = plt_intr_callback_unregister(tmp_handle, cb, data);
+		/* Retry only if -EAGAIN */
+		if (rc != -EAGAIN)
+			break;
+		plt_delay_ms(1);
+		retries--;
+	} while (retries);
+
+	if (rc < 0) {
+		plt_err("Error unregistering MSI-X vec %d cb, rc=%d", vec, rc);
+		return;
+	}
+
+	plt_base_dbg("Disable vector:0x%x for vfio (efds: %d, max:%d)", vec,
+		     plt_intr_nb_efd_get(intr_handle), plt_intr_max_intr_get(intr_handle));
+
+	if (plt_intr_efds_index_get(intr_handle, vec) != -1)
+		close(plt_intr_efds_index_get(intr_handle, vec));
+	/* Disable MSIX vectors from VFIO */
+	plt_intr_efds_index_set(intr_handle, vec, -1);
+
+	irq_config(intr_handle, vec);
+}
+#endif
 
 #define PLT_INIT_CB_MAX 8
 
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index b5da615af6..ff3a25e57f 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -351,6 +351,13 @@ extern int cnxk_logtype_esw;
 }
 #endif
 
+int plt_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+		     unsigned int vec);
+void plt_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
+			unsigned int vec);
+int plt_irq_reconfigure(struct plt_intr_handle *intr_handle, uint16_t max_intr);
+int plt_irq_disable(struct plt_intr_handle *intr_handle);
+
 /* Device memory does not support unaligned access, instruct compiler to
  * not optimize the memory access when working with mailbox memory.
  */
-- 
2.34.1

