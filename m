Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1EBCA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15A5C40B9B;
	Tue, 19 Aug 2025 01:33:47 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 2877940666
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:44 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso36286915e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560024;
 x=1756164824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wKHJNxrg82y1Ygs2kKUg1BmHOG3CPTT/a7NsYZ0uds=;
 b=Sm98vvwT4574oplHvBZ3Wo3ZZA5cIQLRSfsJNZm1lZQ9UA+i352OayJhVcl8Re2iKK
 Js0lS6txjfg6wpL6KvpNEOTCavojl+SBpeyGunsUCuN3sRBMTp5UO4QrKDd9fZMfloZT
 Gd6SUAfbj1iDtln7Aq1/5Bc37q3eGKDy1UJJOEY3WiDVJeLZ67VPeKJ+3Z/eMPDB3e/3
 C/kmYySkn5A2WDgIyPHGAwz/iowJ5ksY/YobH5Q3aLA4bLxllXCcyuzMU1axmIZs2IWR
 yJZbJxr16u2H60/LOPuajRbZdpUsWvIcwd2AVKAd4YlX+sJBVLqye2RiQKJ8VhTzXUpt
 Uf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560024; x=1756164824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wKHJNxrg82y1Ygs2kKUg1BmHOG3CPTT/a7NsYZ0uds=;
 b=UuQM0iha26ZakMPeV3KYR+WefWHJPb29mHWeqOspRXCzLbieNUdsKW1Wrfot+d8q7Z
 Yl04vtri9p1eEH8U8cBcJVV+iQUeGx4b2A1/tXYoLvcEjJ4kISgCvfDH/GkgxWn5+7Jz
 LAY6X7yF7BeBKjYROjxf0vjHtFOUdXqM0uC6tv6dUaw7f5iWLRM4XV2x94ciJtRgnm+R
 XWldFy1YL6dQ42ohXWCdo/TqSd0BwSHJfHiBIYo0AMHDpbDFJThIW1CpfP2NSUM9BPfn
 8tTykcCGAhfGW1cE/4m6mxtxR+CuOwZfe+Lg0u6si816n8ciEu75vJTiMPTubcwRig7P
 faSw==
X-Gm-Message-State: AOJu0YzomCj6QCXp1pEXEgyyS7M5lp7LSsmnCscfhieBY0VqCI1jejOz
 qXSJwF1SA9OQfrf1Pyoaj6fvmK5MmTW9PF4tuH/5nU2rW6YPLJiqf2XYXMOoaEl7n0z/CNySoSV
 JPSXX
X-Gm-Gg: ASbGncuOiUcLKhI4XBMy6ZOqQM/QJE/DBzdiAz5vzjVuke3/i/BnJAVYqsMRaMFDYTW
 Wc9NdK6ny8b+URl3fhFULKlcrYwkTi+Ybs3zkgdsXB3hJaYs4eDKwUXX42uT+rWp9vi3zNLZnfE
 wKB4+BgVHR6K4hY+zP+MEPhHB6qYZmb1cjDz9kqSbVcLmmrUZcceTdYmVgph3ldvBYFNdU4fbK5
 YCAJBsNXyJU+tPSWMN7vgzuog/EknvKou7ayeUDlA4JYwXFgg41CrbDfDFhd3X2RLVZNm7tNEJE
 xEKJCz89uTYEk+GgNJ1y9wnK6/+tzF5RDBt95Qiqm2pejJ3qqZIhJuKMnEdag7oFNGQKN3uYZua
 uiPIAnD6vRd2CcObErxaeb0+jr7upNs0dwUTU5ZGEuXcL1XNnQgpTMzB+9vWuPPMQF/h1Y9Jo
X-Google-Smtp-Source: AGHT+IF3LG1Y+6HQfgqHTnLQvtnorXS6rrEhch5MIiweIyFQrXvlBarRM+vzgfcFBVDvIBZMGmWQOA==
X-Received: by 2002:a05:600c:a07:b0:458:bc3f:6a77 with SMTP id
 5b1f17b1804b1-45b43db436fmr2583515e9.2.1755560023752; 
 Mon, 18 Aug 2025 16:33:43 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [RFC 25/47] net/mlx5: remove unnecessary include of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:36 -0700
Message-ID: <20250818233102.180207-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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
index c08894cd03..f79052a2b9 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -10,7 +10,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
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
index 8db372123c..55721f96d5 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e890e732c3..9026de9419 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -8,7 +8,7 @@
 #include <stdalign.h>
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
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
index 5b4a4eda3b..774fc3b27a 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -3,7 +3,7 @@
  */
 
 #include <netinet/in.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
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
index 77c5848c37..79f664fa06 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -8,7 +8,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <fcntl.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
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

