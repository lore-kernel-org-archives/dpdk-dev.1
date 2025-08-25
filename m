Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E500CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C47854069D;
	Mon, 25 Aug 2025 05:42:38 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 3EBE740612
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:25 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45b614ccbe4so2162775e9.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093345;
 x=1756698145; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Eo14pis+f93pgLhBE7oqMghY5vp+gxYcbNJTYNcwlc=;
 b=Adh2x+5xk/LdV7JN7ZhRhaDDmTw+Z5wAd0PU9CJ6HTKgTLMpFA+obQuXti48pxBLIU
 g/XT1kmDu4+TufpiqWJeHYaL5D8n+iuguCBYBqNm/N0Qvb29hllOzfYbIIUSx20r9G9x
 Qb40MIQemUHnSreMU40SDhfD/tqNe/eKwDZypz67Ui3BE/DmIXzUI8ZCHbyfu3/TktaS
 AMfdy8MhSwAHw81YLg1jDGDGAWNOT2eh2/WNLpCY1yBdqzL5dymYFGsDMCtjabgEJbCC
 qVXlD44xiGMByMNcVuFoMKzJ3VZ3HS4QHyHLzQmIAAvUwBRFQJvx46Qs4R/+q3llSqVV
 mHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093345; x=1756698145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Eo14pis+f93pgLhBE7oqMghY5vp+gxYcbNJTYNcwlc=;
 b=Ac4lqPHblXpUKgXhHY8P1ONxfqts2DeKBxNnX3m20hzvnjuyVolOwpmY0x/tZ9I0z2
 vgSh1sLf30qzC6EYvd7ZQ+p67tTbLJp0eBysIu/1Ce+OgJKDR3psvn9P4FIvSlHnlTfk
 CYlm7FCgnF0Dsruj2Ck3ivsLtgE/c3V25CXDDlCyrSy/7AxObEN1BwayUiyy5+qmnWxM
 gy7ZA4JaXt6roytD0YPX+nQ3ZRDqtarhp6rOS8hcJicAPeYhZp4XOyyJtA9KIXpk57AS
 /iCuPKynuo7c71zBLN2saY/nKW0e8YbiH8YbtlSbQ/rID4bBJZhaqb3srDV02dIL1SQY
 Z4OA==
X-Gm-Message-State: AOJu0Yy6L5VP85xXK2ina5X42Pe+XHHS88nsK70ECNK+AvQkM+ghn4Ub
 gXpqHw3dwjvheE8lM/VCDr3QsNTsJJgMbqu9FJcHyL1a5F7eFR187FNoOcJ+/K1wsixF7uwxEDy
 jcrLo
X-Gm-Gg: ASbGncsH4eTEnwl6OoMAHoH8Kv9DXXmrOeGSNuw4A0sRmtVC7gFmuWe585Lhmf8lVL1
 t+ih4qNbbCZLJKWn0QIO6okr5YSFifOQ9SmZZ4A+BvgO6YjgUl+35KoPS5M7KpZcdSCm+wJJXw/
 6twCYjYhWTtAFWN4MP1l6IvlV0eWjnwLrLj/iQJPovZnAm58GEpI/rsBA0NBB1Ck6vLZu7huVI1
 QWVEpqdL88lqfylFL2PQDrTsyIMoHqAWiFlCrhnaci6cUMV31245VEDl8lRsx37mFuqq8gsCxZW
 7AN9sRESOkuHjm3CCf0a1EdGcRMBCy2ANIXgCpc2EeigbK702aQAfjlNPsX8GnGI51KKKpZIROP
 5utEf659h7/Wh97yA5lYKluqFXC30uhuhzPuLwGKAYIJ+c6TY+I3zKv7lvRR/Ko9sXE3ZFm6K
X-Google-Smtp-Source: AGHT+IFT8RLK/1kCvNXs0tANUPavpDOfyGCwa8hR9v81zCJWji+KEY487WVTDjRNSgdfxTFoJo1Q0Q==
X-Received: by 2002:a05:600c:4f14:b0:45b:629b:dc1e with SMTP id
 5b1f17b1804b1-45b629bde06mr2293745e9.1.1756093344848; 
 Sun, 24 Aug 2025 20:42:24 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 17/43] net/mlx5: remove unnecessary include of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:30 -0700
Message-ID: <20250825034126.12046-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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
index c08894cd03..9b4b8e301a 100644
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
index 10bd93c29a..c549f917c3 100644
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
index 8db372123c..69d62d4794 100644
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
index e890e732c3..8deedcf756 100644
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
index 7b9e5018b8..f968b0febb 100644
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
index 5b4a4eda3b..c0b59a7fd4 100644
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
index 4f3d73e3c4..1ff01f710c 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -7,7 +7,6 @@
 #define RTE_PMD_MLX5_RX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 77c5848c37..4dc1ab0db9 100644
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
2.47.2

