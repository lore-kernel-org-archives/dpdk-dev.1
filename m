Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC94C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 347AD406B7;
	Fri, 21 Aug 2026 21:28:07 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4284A40658
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:06 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1384470b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340485;
 x=1787945285; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1D2Q4Xy9wt0oZIIwSCUH1aC/zT+San5Lzeq8obj1t6w=;
 b=qh4TAxbAwMAoJdVWSlNe4os7OavN8lvV7CIPL8uKpCq/r67j0Ed0OVo8GSSKZeUmxl
 XMpXVL3kDRefqwD6fSCYUQdq+VzWmEU4/QuWrqpR3xoJ5AkD0RJxyLOSlt2paQy6FRgK
 sM56Y2KTynQgl9Pp1qT0mAgVSmxVtKwKPStyjGZrv1cnYhtOOR9tkx87h+JjstQVhl0p
 tT7dcZGp0DxOXB2bDjx5j9QmS4SH3MeqVBjKn+jc55tUk6hv7I8pqLQxg+2fU3Thwj5q
 HhQMXqV3P4+bCVcBtKhGOEvSunFeMlWGrGSVnL8HWBdSb++mYGzWHm43geNNBUsirlwM
 OpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340485; x=1787945285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1D2Q4Xy9wt0oZIIwSCUH1aC/zT+San5Lzeq8obj1t6w=;
 b=cNH8+jeiQ7QdPLTLJl7aXpQtssAOF7hvk5vWMAOJJM8lVs6KeTu6rNK/TbU2vokw94
 xHFI2kJH9lykg88xavh4zT3BQ/KujH386fNcbyzmk24YJf3drz9yfQeYzce30irbZ+lq
 i7f1ODHovJzakrGwk7310TQJp1ZoBUxImLMuR19qjCcWYBXyncUwtRyGPsyAxZ5nq/O0
 YM24Z6are5rPnoURyNdVFju4T+LAfGcFoPDyXGai85wcDo0kzZC5IjjaX57crhp+4Ir/
 dmdQNhDVcLi0GDDycqkEFvtnMJEiJJ+1q52TM1BPK5WNVUwM/effumW9pp+Xl5OjgpKU
 IfMw==
X-Gm-Message-State: AFuF++nbH2bOxTJfDq7issMnxicZEDmvhz40J4nr5n7BXerviSUAiMY9
 w03yci10N4mi6I1P+wlP8cJDYTZRKtw4ZOGDB8Q/pV7SQAZ4ft5GkolQOqZg6FCvzalQpk4G3UI
 9O+Po
X-Gm-Gg: AR+sD13HZ6219zp4Ev48Je1n5pb0pseoFgbk3pRl2NTYqx7jRCmSaqrCHibonB2uSSl
 o0ECTDo5lddQ6fVMicTL3H8bw+2cU9sXzLqt1kaVCQwzSZDsyCYRrcIJDARfSnjcc2eoCnXysMw
 P2FNlSk7qvcvf2o5vdaJFE8k4aQrVGsOS6Gu6SQ70aLH9ktfTYgbSUX1BY03uoIl7Jbw3xzSqEp
 CklRYc011D803Y8694w8b+bZVAbcHeAFlNtd5Kj8yWkWzPI92BKLbyta+HjdABGOgEryyyODDzK
 DYonN+mU3jlHtWig7WEPIkSQMCRbi56sauaAQfAdjNqN2wH/viHvtSjccqJEkKgQ+u47Pvy+BEz
 55983sRyG+t73IFUO2+OLikl5plWhxYCJTHeahDUwdgvuTpmL1Eytnx5W0IW9Wsrg8LYPXs0NVn
 rb3bAF2KH59dJTVJCoBcNahwp/MYSpGcGFTOEz9smuPrcONKPnqX4cB5I30crctyhI5GYmWDNYf
 ceE04NTOD3zfRIKBIOnd/Rffms=
X-Received: by 2002:a05:6a21:7113:b0:3cc:9620:5816 with SMTP id
 adf61e73a8af0-3cd4ba674e3mr1926712637.8.1787340485365; 
 Fri, 21 Aug 2026 12:28:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v2 05/68] drivers: add missing include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:24:00 -0700
Message-ID: <20260821192646.146382-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

These files use rte_memcpy() but relied on rte_memcpy.h being
included indirectly via another header. Add the direct include
so that later patches which remove now-unnecessary includes of
rte_memcpy.h do not break the build.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/turbo_sw/bbdev_turbo_software.c | 1 +
 drivers/common/mlx5/mlx5_common_mr.c             | 1 +
 drivers/dma/dpaa2/dpaa2_qdma.c                   | 1 +
 drivers/ml/cnxk/cn10k_ml_dev.c                   | 1 +
 drivers/ml/cnxk/cn10k_ml_model.c                 | 1 +
 drivers/ml/cnxk/cn10k_ml_ops.c                   | 1 +
 drivers/ml/cnxk/cnxk_ml_io.c                     | 1 +
 drivers/ml/cnxk/tvmrt_ml_ops.c                   | 1 +
 drivers/regex/mlx5/mlx5_rxp.c                    | 1 +
 9 files changed, 9 insertions(+)

diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index 2cab495294..cb4aaea6d2 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -8,6 +8,7 @@
 #include <rte_common.h>
 #include <bus_vdev_driver.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_ring.h>
 #include <rte_kvargs.h>
 #include <rte_cycles.h>
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index aa2d5e88a4..929b47dcc8 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -8,6 +8,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_eal_paging.h>
 #include <rte_errno.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_malloc.h>
 #include <rte_rwlock.h>
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index f7d94bb799..84281844b3 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -10,6 +10,7 @@
 
 #include <mc/fsl_dpdmai.h>
 
+#include <rte_memcpy.h>
 #include <rte_pmd_dpaax_qdma.h>
 #include "dpaa2_hw_dpio.h"
 #include "dpaa2_qdma.h"
diff --git a/drivers/ml/cnxk/cn10k_ml_dev.c b/drivers/ml/cnxk/cn10k_ml_dev.c
index c35895dc14..5880770630 100644
--- a/drivers/ml/cnxk/cn10k_ml_dev.c
+++ b/drivers/ml/cnxk/cn10k_ml_dev.c
@@ -6,6 +6,7 @@
 #include <rte_dev.h>
 #include <rte_devargs.h>
 #include <rte_kvargs.h>
+#include <rte_memcpy.h>
 #include <rte_mldev.h>
 #include <rte_mldev_pmd.h>
 #include <rte_pci.h>
diff --git a/drivers/ml/cnxk/cn10k_ml_model.c b/drivers/ml/cnxk/cn10k_ml_model.c
index fa978529f5..58eebbf076 100644
--- a/drivers/ml/cnxk/cn10k_ml_model.c
+++ b/drivers/ml/cnxk/cn10k_ml_model.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_hash_crc.h>
+#include <rte_memcpy.h>
 
 #include <mldev_utils.h>
 
diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index 597806b787..ffe3356720 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2022 Marvell.
  */
 
+#include <rte_memcpy.h>
 #include <rte_mldev.h>
 #include <rte_mldev_pmd.h>
 
diff --git a/drivers/ml/cnxk/cnxk_ml_io.c b/drivers/ml/cnxk/cnxk_ml_io.c
index a418b7e684..33d95e5574 100644
--- a/drivers/ml/cnxk/cnxk_ml_io.c
+++ b/drivers/ml/cnxk/cnxk_ml_io.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2023 Marvell.
  */
 
+#include <rte_memcpy.h>
 #include <rte_mldev.h>
 
 #include <mldev_utils.h>
diff --git a/drivers/ml/cnxk/tvmrt_ml_ops.c b/drivers/ml/cnxk/tvmrt_ml_ops.c
index f6b3a51c51..01493077bb 100644
--- a/drivers/ml/cnxk/tvmrt_ml_ops.c
+++ b/drivers/ml/cnxk/tvmrt_ml_ops.c
@@ -16,6 +16,7 @@
 
 #include <rte_common.h>
 #include <rte_cycles.h>
+#include <rte_memcpy.h>
 #include <rte_mldev.h>
 #include <rte_mldev_pmd.h>
 
diff --git a/drivers/regex/mlx5/mlx5_rxp.c b/drivers/regex/mlx5/mlx5_rxp.c
index b865c08b53..42aa82d62a 100644
--- a/drivers/regex/mlx5/mlx5_rxp.c
+++ b/drivers/regex/mlx5/mlx5_rxp.c
@@ -5,6 +5,7 @@
 #include <rte_log.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_regexdev.h>
 #include <rte_regexdev_core.h>
 #include <rte_regexdev_driver.h>
-- 
2.53.0

