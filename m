Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB97CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A09D40667;
	Mon, 25 Aug 2025 05:42:32 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 1AF7F402D0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:12 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so22367945e9.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093332;
 x=1756698132; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6Nvbm7Tm6merMQsexTBzbHhg7izWRTPZn87X4YbSAg=;
 b=tMWP6aWkfs5nnUUiUiegVGtllbJT8IeFpfFjl5vMpQDL57wNjyE9DBrhFT0PI1+Nxm
 2dnHW6UP9u+yDM8Wvqxhucl96vehGqZM5IpyJyNN6aVzReUbh65ftavIYxq8TF+rmU4k
 nqyBh6LK2wjcpg+Ya7+XgCuEQF0nKSWsmJlwIp+nQzGZPCZ1AM1b+Q3c542faZBSB5/r
 xbEU4mO5WjFzkw6nB/SQNKRByZfmbwUsXr3E66LtAmPGgTQV4Gz+ZWLxHPmgbvyAY25B
 GoK0w9K9CQ1Zb4o6Hg98rswRAJP6+fiYCcla6eZrHLBqU4Vh91oR2FbVuPA/JONd4ELK
 Wkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093332; x=1756698132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6Nvbm7Tm6merMQsexTBzbHhg7izWRTPZn87X4YbSAg=;
 b=dtf8CB6ZmwE/cGvdG+GCqwDK6UobBvN5cjUCXw8XuZUw3vnbtJ4Vn65xdr2uNwYT5Y
 JyNUAyPs/l6RAo+cHCMHdwE2Rk2XaoGr8U/BuguobZFs/r8rcCqlBAR/FWeuPaOVr2KK
 gZbSATFWed1MgWupRwMWxDm9MJAEh27FtW4n8Y6AWXJQuno0YakhVQuMEZAQriw3zLg+
 5p91bx42MFu52/vQXxhiyxMu4n+7tANRImDcyy6EwaCsIvqz78r2BNl922AYPMiAWjyW
 Jo4xl/5MYsC3UTaGE7wgOuVvHjBnUwvQ1FOkOsOBLHWCtfeWiySsbA/jrpuJOLC0cDmw
 RBkw==
X-Gm-Message-State: AOJu0YxmaZEO5rQOC26yZUPIeE8dD3bjTSQ5nWtY/Z8S8eHlQjAzA89D
 ECthBBt8nUigwOZc9/AVzkEayGm4Tt66V40SUdi4TYgoU+ayg9V/BAu22DpBYBbSzmy/4bqJwvw
 4epxT
X-Gm-Gg: ASbGnct9i0JWRCjzDs200VAq3xpphsoh1VhBSPn76qztTL3A7co+0i6tI0DngomgqYf
 x8uzttpm8a6s5QeB6b4LrYs1wZjzaiYZgt0zv+Fc0LLDAVhSsjlhWHMfSwqfix8x61XNgaOZ6aL
 E5pxt1bvBBkAXkzlgMGE0zKQGhruiSbCnmSGO+0rYn5Y1HBM+tUHbTc/P9tnnjLYEW1E90BjqoR
 WHR0vMerdozJZFL/RqiCZ8O1ZfUn0HSX4/LNObbhyBYEH5VnDoL7LLIVk42me4onV2OKnrWHEmu
 CaKuSHM97gq+c2dF01qDoUSpeQwT/Bo71rTU/S2Dj8PkXmiaV45AJggwa+33hfA3hcjVyt+iiJo
 puu4WQrcl1+SRMuIZcZuW3Iv6ZM7cOHdYNO+hE/IQlHbecLYaxUgNd+lMRNIGZe8MsaTjyfXw
X-Google-Smtp-Source: AGHT+IHRs596okns65/EXbEj+NBjdYrAPIvn7mwmj2s/pFzCsTpNI0/mNyzMEuLEyjbtE1QI4PcPVw==
X-Received: by 2002:a05:600c:46c5:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-45b517e95a3mr76407215e9.29.1756093331659; 
 Sun, 24 Aug 2025 20:42:11 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 12/43] drivers/bus: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:25 -0700
Message-ID: <20250825034126.12046-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Prefer just using rte_tailq.h when TAILQ macro's are used.
Other places eliminate sys/queue.h if possible.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/auxiliary/auxiliary_common.c |  2 +-
 drivers/bus/auxiliary/private.h          |  2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h     |  1 -
 drivers/bus/fslmc/fslmc_vfio.c           |  1 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 11 ++---------
 drivers/bus/ifpga/ifpga_bus.c            |  2 +-
 drivers/bus/pci/bsd/pci.c                |  2 +-
 drivers/bus/pci/pci_common.c             |  1 -
 drivers/bus/pci/pci_params.c             |  2 --
 drivers/bus/pci/windows/pci.c            |  3 +--
 drivers/bus/pci/windows/pci_netuio.c     |  2 --
 drivers/bus/platform/platform.c          |  2 +-
 drivers/bus/vdev/vdev.c                  |  1 -
 drivers/bus/vmbus/vmbus_common.c         |  1 -
 14 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index ac766e283e..4edc621268 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -8,7 +8,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
+
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_interrupts.h>
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 4604f6f4a7..bd519c1091 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -7,9 +7,9 @@
 
 #include <stdbool.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <bus_driver.h>
+#include <rte_bsd_queue.h>
 
 #include "bus_auxiliary_driver.h"
 
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 442de1a3fb..211864f945 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -17,7 +17,6 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <errno.h>
-#include <sys/queue.h>
 #include <stdint.h>
 #include <inttypes.h>
 #include <linux/vfio.h>
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 68439cbd8c..f6f61fc877 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -21,6 +21,7 @@
 #include <sys/eventfd.h>
 #include <ctype.h>
 
+#include <rte_bsd_queue.h>
 #include <eal_export.h>
 #include <eal_filesystem.h>
 #include <rte_mbuf.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e32471d8b5..8c87d35742 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -15,7 +15,6 @@
 #include <signal.h>
 #include <pthread.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -32,6 +31,7 @@
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
 #include <dev_driver.h>
+#include <rte_tailq.h>
 
 #include <fslmc_logs.h>
 #include <bus_fslmc_driver.h>
@@ -39,13 +39,6 @@
 #include "dpaa2_hw_dpio.h"
 #include <mc/fsl_dpmng.h>
 
-#ifndef TAILQ_FOREACH_SAFE
-#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = TAILQ_FIRST((head));				\
-	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #define NUM_HOST_CPUS RTE_MAX_LCORE
 
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_io_portal)
@@ -105,7 +98,7 @@ static struct dpaa2_dpio_dev *get_dpio_dev_from_id(int32_t dpio_id)
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
 
 	/* Get DPIO dev handle from list using index */
-	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
+	RTE_TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
 		if (dpio_dev->hw_id == dpio_id)
 			break;
 	}
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index ca9e49f548..3af95921a7 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -26,6 +25,7 @@
 #include <rte_alarm.h>
 #include <rte_string_fns.h>
 #include <rte_debug.h>
+#include <rte_tailq.h>
 
 #include "rte_rawdev.h"
 #include "rte_rawdev_pmd.h"
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 3f13e1d6ac..97214ea049 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -15,7 +15,6 @@
 #include <errno.h>
 #include <dirent.h>
 #include <limits.h>
-#include <sys/queue.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/pciio.h>
@@ -38,6 +37,7 @@
 #include <rte_string_fns.h>
 #include <rte_debug.h>
 #include <rte_devargs.h>
+#include <rte_tailq.h>
 
 #include <eal_export.h>
 #include "eal_filesystem.h"
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index c88634f790..2898f8d9c7 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -9,7 +9,6 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_interrupts.h>
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index 087ec38bb9..0b6d944118 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -2,8 +2,6 @@
  * Copyright 2018 Gaëtan Rivet
  */
 
-#include <sys/queue.h>
-
 #include <bus_driver.h>
 #include <rte_bus_pci.h>
 #include <dev_driver.h>
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index e7e449306e..18e5f5369e 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -2,8 +2,6 @@
  * Copyright 2020 Mellanox Technologies, Ltd
  */
 
-#include <sys/queue.h>
-
 #include <eal_export.h>
 #include <rte_windows.h>
 #include <rte_errno.h>
@@ -11,6 +9,7 @@
 #include <rte_eal.h>
 #include <rte_memory.h>
 #include <rte_bus_pci.h>
+#include <rte_tailq.h>
 
 #include "private.h"
 #include "pci_netuio.h"
diff --git a/drivers/bus/pci/windows/pci_netuio.c b/drivers/bus/pci/windows/pci_netuio.c
index 346b2f4c0a..d3d7e1f504 100644
--- a/drivers/bus/pci/windows/pci_netuio.c
+++ b/drivers/bus/pci/windows/pci_netuio.c
@@ -2,8 +2,6 @@
  * Copyright(c) 2020 Intel Corporation.
  */
 
-#include <sys/queue.h>
-
 #include <rte_windows.h>
 #include <rte_errno.h>
 #include <rte_log.h>
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 0f50027236..b47c41c18b 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -8,7 +8,6 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
 #include <bus_driver.h>
@@ -21,6 +20,7 @@
 #include <rte_log.h>
 #include <rte_memory.h>
 #include <rte_string_fns.h>
+#include <rte_tailq.h>
 #include <rte_vfio.h>
 
 #include "private.h"
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index be375f63dc..85df5f02c6 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_eal.h>
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index a787d8b18d..8a987a7d0e 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -7,7 +7,6 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <fcntl.h>
-#include <sys/queue.h>
 #include <sys/mman.h>
 
 #include <eal_export.h>
-- 
2.47.2

