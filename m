Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D6CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78A4A40A76;
	Tue, 19 Aug 2025 01:33:34 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 80BCC406FF
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:33 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b9d41baedeso2486027f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560013;
 x=1756164813; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnBYs3B4HvPGuRLfDPt0GkTT6P+0KgeG3idxLGSTyJw=;
 b=XFhtNbP2mDeabBrZMhnHsHQvKjuo/17MQgjbzTbt8UE+dt5hqzbrT33MtHpeo7+uBO
 NpdTna4ccSR9voTG/rjfo9g2bMZt5cMG3Vry5a/HDP1YYWmoGJDsWKGWA/3wbGOAIIr/
 ne2DMDV5O1ReI8E06zSG11P3XTkH+qBfPtd/iJ0iCWdQopYNluQCX3YbuW/nIQOc/eG3
 EXMctM3HI7pcsEdOjJ1CvJrFNrnwEUGe85OzpIRnnh05wBV+9fph7T0uyS4gtwodC3Yo
 JFRLhupSRIdmy7To8uMeBtHTH4gcCucsfIIptj6yNET6s/6y8+IwQGEeN2iBfxGhPXlr
 ag5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560013; x=1756164813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnBYs3B4HvPGuRLfDPt0GkTT6P+0KgeG3idxLGSTyJw=;
 b=P4TcxKJfiegLqvwfbKEzOnzxkHvP4C2Bg6cevSaQSh3yzRtGP9e30ZiPPbVhES/oyc
 map8+zA4NMZrLShe6cjYsNa05MedotW+rRGFrFPlPqFwtFlXQu6/2hF/NsiPCTKLuEhP
 z1V2B3jfRYEL62ELyB+7w/r/m5H0x1kNUCIK/IwAJic9by5NfjMrclyXqIvaWmBe6GaZ
 5r+LaeLHZEXNO1bsg9H4AblZ2zMxeJl3tP6JUMis2XMALlzSMSU/VjsLtmuxLNNMUtpB
 pJ75QzMxyIIIRMHN7l++U1d+HHz+76uPzsxxkm8wh1DSZSOQa0ymG8tbqi4tPegLlQa0
 /5dQ==
X-Gm-Message-State: AOJu0Ywcdr+igR1d/95FZCuHcoychJEh1KslNA/IFdc2QT8uXNsjyiKF
 z/Vw/4NdxSdUyPLBXq7HrPxa28jqRgjpCMUSi0JmGy+uI3M3nJp1QtrC2JdH+lG7ub8vBDj/giV
 /cOPb
X-Gm-Gg: ASbGncuLXqL5ov8Pz3kjz0O7ZnPDzKhJkm0TSbiPbXk0MfIpTw1TFd9NOYTwt7fO+8J
 r+JdO9wVKtPANr1Q9ZEM0ALwh1khjZOVTloB5C6eVQQ7dvWiCCi04PsfZ5cIW07kJlT1WPZ7Jnc
 S8Neqj9WTLuAdr1aokesSlGrtwHXei6vZvzTJ/gZPPKw1jNWuQ6IYOT9Mbu5cmQurP00b2D2tyb
 yt7Z/tsbH/e77Kcqjbb3EgAQhZMEoUt5uxwP/EGQW7Nd/aZZkh1zKL2Iob1Ttv1mOEltHsHBRWD
 sAc0DjM+k6xn5CX+soYn0tEHGV9Aa8M2Z2CQTgiCBas9A1bMEXFJWhjwsUgSBSJ3yyiBzDvj3xz
 wxGu/+cWjjFBRPzAxY2bl0uSa8jgSuDSE4NGe8QTuyzCpSH1DsXnKW7pfsh1Y+F2MwfGLziPQ
X-Google-Smtp-Source: AGHT+IFSUHT00pY6YNn3kZZI0EU0VQk/DVZx4xREj9WkpuL4JgxpZo9Mrvw9JYQ6+QJRhw7HJ61kIw==
X-Received: by 2002:a05:6000:1a8c:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3c0eb41da27mr303853f8f.27.1755560013124; 
 Mon, 18 Aug 2025 16:33:33 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Rosen Xu <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [RFC 21/47] drivers/bus: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:32 -0700
Message-ID: <20250818233102.180207-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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
 drivers/bus/auxiliary/auxiliary_common.c | 2 +-
 drivers/bus/auxiliary/private.h          | 2 +-
 drivers/bus/ifpga/ifpga_bus.c            | 2 +-
 drivers/bus/pci/bsd/pci.c                | 2 +-
 drivers/bus/pci/pci_common.c             | 1 -
 drivers/bus/pci/pci_params.c             | 2 --
 drivers/bus/pci/windows/pci.c            | 3 +--
 drivers/bus/pci/windows/pci_netuio.c     | 2 --
 drivers/bus/platform/platform.c          | 2 +-
 drivers/bus/vdev/vdev.c                  | 1 -
 drivers/bus/vmbus/vmbus_common.c         | 1 -
 11 files changed, 6 insertions(+), 14 deletions(-)

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
index 4604f6f4a7..808426c4a3 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -7,9 +7,9 @@
 
 #include <stdbool.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <bus_driver.h>
+#include <bsd_queue.h>
 
 #include "bus_auxiliary_driver.h"
 
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

