Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C708CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DCE340B9D;
	Mon,  3 Nov 2025 17:49:49 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 593C740A75
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:45 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-34077439166so3916033a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188584;
 x=1762793384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3q748VyzKuq5ySIu0v5c3y53aNMOeuXMrF+Ag1KAMo=;
 b=11sWe5oX5b4smzlJIVo6qNU9BExrk7xnsh/ZBEO2P4ThkQ15w8Ssx66fRSo9l1mPWp
 axApvZC29AK1xmOdvNE+F2qNMR67xXe93mpikVAnYLPUgNuXvLHSvHR86ZdlWYEayVaf
 rFM3d17UzNdCF1D7s1FDYwuoVv8gfKXO3zi7XAPfCH8kxCK7THTEswhOtmRG07FSA3/1
 whejv+O/YluZqXqDnzTcFhlm9I6XXCVQk+aBBSPoUvmibsJ1/3HVTqVQze+sP0SwvSop
 J9pG2O9FYYbXC2UjAdxp2hpftvKL/KlJgdoh9yf2Jy8q8/bOUUjB1Mjlp2kHMD2m3E21
 vuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188584; x=1762793384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3q748VyzKuq5ySIu0v5c3y53aNMOeuXMrF+Ag1KAMo=;
 b=RP7UkxCSS7O+u3mRKNgp3Uhaz60SXJ899CfmO8AOHEEekYR+N8tiQSXkYAp/wwgbtM
 FRuVDHQgMGJ56iVdKDmkyqECF6AmrtEGyc+NLja6VHf3x6Ow/LiX6VWcA2SVyWkkT0y3
 fdBJq2QhyAoCaJkNR+wai/J45NhooNQtSzbNDLlVtnKSuRgUtHgQwrMAmsaKDT/rQ3Im
 m9Np/REK8z65EnL/VVZwkaUiROjiJ6J8RjGrj383JGHvfg+Nnj2uptXQ/z+6rT3MIs9o
 NnrWxdH1Kbbyfpa9FyStX8wq3FI5jVhGFYX6YuuvtkmfpJjNc2jagtb6AtyuXK40obrr
 1Fqg==
X-Gm-Message-State: AOJu0YxIhpKQgwuO2VTcQwTM28bFxmPU+IjzrfIiC7WWM0x7VLGnzzR1
 KG7woo0mkX/qigNZwn6+hSFJUYjz7+0O4aJ2VvVxCLODl5cSEkJ0xzwUneFj/J4C8V8h6oqofKJ
 0jSui
X-Gm-Gg: ASbGncuKpfQioudOAVvNzXiz2+PlPHCvJpXO59be6TOa/PcxluT43h3QBN7F6J1Fntw
 V/XthMhk+YM/4S8HV/K1uGM6hVHUbaTZ8dj14L+ePcpkdr9B6fVxyfSM6QwJ1+6OJma28sjFi+b
 Yb8jNDNVNxBooCfCZBKYjM9UiqkpX8IULLTgFrauMG40rlR/aa178iOyLMyePjV+Lz+MKvLSX2/
 /MfLlGeM/MdLDdk3u/TV0sbUGBFoXNcYKyhkct0F8W6/tExC51pBKBSiZeJFyvWF8PMvVwQLzwi
 tAlfhGUFmURPTTk/AlpRDBMEo+EllPrusOWCg1a3QAyn3sePo9weUsnl7EwtDb9pBQiUMgA6kdW
 HVpLuzIBngaGiDaE17ASEvzPotUVYqaPU8VIMFc5/XWR4ysVyU3LxF/4FHrkAFeqjgROQkPopUU
 BmzCDcayyeI7EAOgQJoZRAejZ/bHxPjGeMzycWJ5igCEy7I81eYg==
X-Google-Smtp-Source: AGHT+IEJ2RbQFBGFVLdWbkjPPuud3eaEbx8c6QhYZhPK5LkUhN5xFiiADlfAFvE5rWEZJgJIyHKS2Q==
X-Received: by 2002:a17:90a:e18e:b0:339:a243:e96d with SMTP id
 98e67ed59e1d1-3408309eec0mr15390774a91.36.1762188584409; 
 Mon, 03 Nov 2025 08:49:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 17/44] net/mlx5: remove unnecessary include of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:22 -0800
Message-ID: <20251103164915.101713-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Already handled by rte_tailq.h in most places.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/hws/mlx5dr_internal.h | 1 -
 drivers/net/mlx5/linux/mlx5_verbs.c    | 1 -
 drivers/net/mlx5/mlx5.h                | 2 +-
 drivers/net/mlx5/mlx5_devx.c           | 1 -
 drivers/net/mlx5/mlx5_flow.c           | 2 +-
 drivers/net/mlx5/mlx5_flow.h           | 2 +-
 drivers/net/mlx5/mlx5_flow_dv.c        | 1 -
 drivers/net/mlx5/mlx5_flow_verbs.c     | 2 +-
 drivers/net/mlx5/mlx5_rx.h             | 1 -
 drivers/net/mlx5/mlx5_rxq.c            | 2 +-
 drivers/net/mlx5/mlx5_rxtx.h           | 1 -
 drivers/net/mlx5/mlx5_tx.h             | 1 -
 12 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_internal.h b/drivers/net/mlx5/hws/mlx5dr_internal.h
index 2abc516b5e..4687e16dbe 100644
--- a/drivers/net/mlx5/hws/mlx5dr_internal.h
+++ b/drivers/net/mlx5/hws/mlx5dr_internal.h
@@ -6,7 +6,6 @@
 #define MLX5DR_INTERNAL_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
 #pragma GCC diagnostic ignored "-Wpedantic"
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index 9011319a3e..6d5864ae3d 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -8,7 +8,6 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 
 #include "mlx5_autoconf.h"
 
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 07418b0922..463ce730ab 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -10,7 +10,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_pci.h>
 #include <rte_ether.h>
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 673c9f3902..4fa9e444c4 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -7,7 +7,6 @@
 #include <stdbool.h>
 #include <string.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_malloc.h>
 #include <rte_common.h>
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 1de398982a..c359923c29 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index ff61706054..84aec40458 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -8,7 +8,7 @@
 #include <stdalign.h>
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_alarm.h>
 #include <rte_mtr.h>
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index bcce1597e2..ba23280abc 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -2,7 +2,6 @@
  * Copyright 2018 Mellanox Technologies, Ltd
  */
 
-#include <sys/queue.h>
 #include <stdalign.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/drivers/net/mlx5/mlx5_flow_verbs.c b/drivers/net/mlx5/mlx5_flow_verbs.c
index 67d199ce15..aa94a9fee1 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -3,7 +3,7 @@
  */
 
 #include <netinet/in.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdalign.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 7be31066a5..e88c60aa22 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -7,7 +7,6 @@
 #define RTE_PMD_MLX5_RX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 1425886a22..cddc0da9fa 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -8,7 +8,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <fcntl.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <eal_export.h>
 #include <rte_mbuf.h>
diff --git a/drivers/net/mlx5/mlx5_rxtx.h b/drivers/net/mlx5/mlx5_rxtx.h
index 3fa9245769..c999ca9052 100644
--- a/drivers/net/mlx5/mlx5_rxtx.h
+++ b/drivers/net/mlx5/mlx5_rxtx.h
@@ -8,7 +8,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 16307206e2..f320b18481 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -7,7 +7,6 @@
 #define RTE_PMD_MLX5_TX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
-- 
2.51.0

