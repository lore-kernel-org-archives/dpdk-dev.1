Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C8CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:50:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1626540A6D;
	Mon,  3 Nov 2025 17:49:42 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 289F6406A2
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:39 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b553412a19bso3086806a12.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188578;
 x=1762793378; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3azN2PAom3QpA0exsYKhMQGZ9Y+smhVBXVknLdyfkM=;
 b=FEIlS5e5GzidtyCEU81kHvfPSx1T24axck4nMET78QissZ9C3G7llx5xzciFWQUNcR
 6kiBE//Kuq6MevilhBo1v9qMIMqQKtOxAXam4MlNlTOTX8llgPEgylSaOwqwvWIraOq3
 SJvYcPFMJfmrZ0Y/LOFV2XKfZZC+zjQ4ABXZczWz3SaNUu/NJwNM36mRZP8uWhk0KW3a
 Y6vGFyEu83puI/Zpbj3KPNG6ygZYknV7PBKGZnANPLFrozkMVhKni7FNUMVenvEVf3Ns
 BfmjrafA8mof9fWr+K93Jhi5CltCQX3ttYgdVbX/4fyrXfTi50msf86bwk4zD4eRmGWy
 P/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188578; x=1762793378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3azN2PAom3QpA0exsYKhMQGZ9Y+smhVBXVknLdyfkM=;
 b=Wr7bP26avAgjyM6pRI0P/eKtyZjhy5f8QurQIGI7kt/+rj4B+lgdqPuY0K2RRWAcJP
 T0nVYhbP+JOpfc5FQENMAZsat+1DnmdVUKXU6e2sWV0W6389C4BzQbzcLjq/N8XXeBFn
 ZKtnk2KhgQ2G1RvQLoGSlBcJ5yB8v31WIV0LJgKVg7snWE0lOqGpFPA5HLbg30m+n5q5
 ia8RIWVz4/q9xwXyoUKRk4KzQ9waVqd5VnzgRCY+MZCpJ/HWNoGvSnVJjMD2SaElW3M+
 +jqWNVzvcfwon+sqyyiZM49aFd94DYTS7/h5UlMNUBo9vIRVcFrKXyFpP46KA1VFcuz5
 8TLg==
X-Gm-Message-State: AOJu0YyH/9Rz12nbNhUwfkyD+TqSFd4Fa6SDwC4Yhh8KVHtWYq4N565i
 DLtYCZOdWnNNbUBlTOjWeZOL0s1s6p4p9GnKznQuYKahj7onpTvV+LKjk8QqALZI8HLWndkbbrp
 d8vdA
X-Gm-Gg: ASbGncvRQZiZVtQTx46o+oHVdQ2DOHcgCE5icetjA16Ztdcq7vu8X8fpwuzDv0v3zYL
 2Poimf/S/bZCtN+vV9vq12EoAY2xDjVAmrt0rNzi8LCAVORS3hh0tj2AFZY+GnR/puIM4zxRkQM
 dbXGp9MJUks5EcldQIUIqZshwUQXI/QF0jCOtlwCMJ41zSrlhdWII99DIBa1ENO+iOkV+ruZwIx
 WyNXTyc2CfzLTVQnYvXIdUgQDyivMuQ5727HDp5H5N4icQBKTm2ClvYVn1Hx5qahPeH/yV4MlS7
 Sacqs1P2w+6Eu30QucFecHbGbuPcEYe8clHBzRlhjlLQetfVSsEhzldPQ5FtymWpSaWIP6EPCF6
 5l4i68QGFXea1lfT1vgAQkR2WHghczrjUalbb2tq1Utxnfk07mm71v/hn4o6jdIznOIhPqUS9i1
 9jrK96jyHoBogjdCzOg/ERTJDzk1PpGXBzyXhXKUo=
X-Google-Smtp-Source: AGHT+IEXQMXPJkW0Adt2+358F+L096CkTwpiLr7ez4/fUlf8cZP9gAwp9HW22v55FnX1pKfvLPl2hg==
X-Received: by 2002:a17:902:c406:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-2951a3eacaamr202654885ad.17.1762188577827; 
 Mon, 03 Nov 2025 08:49:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 12/44] drivers/bus: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:17 -0800
Message-ID: <20251103164915.101713-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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
index b6a6238a01..88c9ce88a9 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -17,7 +17,6 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <errno.h>
-#include <sys/queue.h>
 #include <stdint.h>
 #include <inttypes.h>
 
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 550d4e0e8d..cf6b4c6ab4 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -23,6 +23,7 @@
 #include <sys/eventfd.h>
 #include <ctype.h>
 
+#include <rte_bsd_queue.h>
 #include <eal_export.h>
 #include <eal_filesystem.h>
 #include <rte_mbuf.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2a9e519668..ac7cbd3a1f 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -17,7 +17,6 @@
 #include <signal.h>
 #include <pthread.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -34,6 +33,7 @@
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
 #include <dev_driver.h>
+#include <rte_tailq.h>
 
 #include <fslmc_logs.h>
 #include <bus_fslmc_driver.h>
@@ -41,13 +41,6 @@
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
@@ -107,7 +100,7 @@ static struct dpaa2_dpio_dev *get_dpio_dev_from_id(int32_t dpio_id)
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
index bf5df3d94e..fd535967dd 100644
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
index 6f6f368cb7..1f74d81af5 100644
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
 
 /* DEVPKEY_Device_Numa_Node should be defined in devpkey.h */
 #include <devpkey.h>
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
index f6673cf181..edad25e759 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -10,7 +10,6 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
 #include <bus_driver.h>
@@ -23,6 +22,7 @@
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
2.51.0

