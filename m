Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB27CC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:46:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D5DB40A71;
	Tue,  4 Aug 2026 17:46:09 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 49E5540A75
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:06 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cad8076b01so53064405ad.2
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858365;
 x=1786463165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hwq03RY626o+sAIf04fNDI3R6ZEQNLUaN59t4BOogWM=;
 b=a/r56B+GYiAOg/D2OZYnwqYRRzIEOQpqhv1M2w1oroeVthTNB5mbnLdG6TGu8aiRuQ
 j1O6sbq0u2g71QkDMh414pST38Rj1pliXSAix7JTXdYFpNFm9WsP+DZx7Oo8eQty6VVR
 X/DcOO4FbnOt8KICn7/yuYHmOyWwbK4LBLspQKUE15ZFZanAORWEASBncgBxRN16mmgz
 4EKEmci6wWbizyL3O0z7oX99nTz0zCr1HhmeQ3Nmal4WTJ8/5Q5ngHpCspjxS+IDQNvb
 YfNAe+Q089rXWTNIjrf/m7ZAJncvluP6c9yIL7n3uAlmvxSzF/+N2VkirPSu0jG46qYH
 pr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858365; x=1786463165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hwq03RY626o+sAIf04fNDI3R6ZEQNLUaN59t4BOogWM=;
 b=hiyyOK//Huu0G/9piWlQW48z4IQ4l69lCDKM5g+kxSzGhlUgmt8jA2hFBFKdBbTcr9
 sLRRyfAXOf4aVGgQzAG5EkMpJNuYR6OmX3yNDRHC9mBKHh9sIt5/7LT2o1gQ8W4OpvBv
 TSMDkL+UZXQWFxHrDcDMolWqXauSyQ1DvaWBg61rntmnhJOmYNVdWPdfHA/1xON4oLPI
 dBpbUP/EhQCDQfx03uy5HIuN+URomPHmL0tjxsKs5CB//WEC1a9j28EX1E6FM1ZINK1D
 izX9W166/buvCo6EE0Kpx9gBi0r7thj6aTuU+pCMOvSjTqGYSyXzoVO6gomwyTd4eosW
 nsqg==
X-Gm-Message-State: AOJu0Yyqind0sztnoawNnK514krd3bzvX0z8AkiXYQgBIWtw5G4Gfo5j
 2JFv7aHLtCBf1Lfb6k8Ji//LqR8P1ObNKWZ08tnPi3SpNwiZDTaX0kSa/RLqaLZF2wxXMX94pSN
 lJw5D
X-Gm-Gg: AR+sD10x2CaOJFzxUeyPUTzOFP5J9/kDPENADLgb4l8wE7j0skgPeWVXYuBbgwFbq2L
 lqbC9I5HyyYx1OymDJClLWfcAyjMStxnnT//nxVJpYVIv4L173bbSPY1IP6ukwvoWd4Ep5cavuh
 WOcHxbzYUula2XEO38+MuzTvOM7SnCjTRJMeZVFvOZFcLrREqXMdCanxndwvlUGNDRpzHwWFxyl
 olBljR/0X1e2jLlYet8vJxwSkX7sZKyTIjhl3B7dKqjmjuUC4ZfGV1XGlUAZLfts/FjZhOa+FF+
 jwuniiOmFk1wjPxuhAUIFbtl7qTzrYQPV0yYMcJMJNB3EPFE50srLL+ZqXLbVH0fgHe2tPXfasN
 aegPT7zTknrmjohsCNhSvdOyroACHX0wJn2k1zyx5zyOYfuOUjqqWQz4xQ0ebyXrbdZWAo/Qb2B
 w3335VGHOAXgBob4Lrx8N3ZeHvpFJFFEKTMWRxw9e9QsjxlDQz7zjIR3e/2DcUdG6aVJiZapxgw
 LFlUpFqb8/K4RkT8nhVNGWgHvk=
X-Received: by 2002:a17:903:38cc:b0:2c2:7baf:139f with SMTP id
 d9443c01a7336-2d052411d78mr154854475ad.30.1785858365413; 
 Tue, 04 Aug 2026 08:46:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiayu Hu <hujiayu.hu@foxmail.com>
Subject: [PATCH v3 08/23] gro: include headers directly
Date: Tue,  4 Aug 2026 08:44:56 -0700
Message-ID: <20260804154549.148691-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

The gro library was getting headers such as VXLAN implicitly
via rte_ethdev.h.
This will change, so include the needed headers directly.
Use iwyu to make sure all headers are covered.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/gro/gro_tcp4.c       |  9 ++++++++-
 lib/gro/gro_tcp6.c       |  9 ++++++++-
 lib/gro/gro_vxlan_tcp4.c | 10 +++++++++-
 lib/gro/gro_vxlan_udp4.c |  9 ++++++++-
 lib/gro/rte_gro.c        |  9 ++++++++-
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/lib/gro/gro_tcp4.c b/lib/gro/gro_tcp4.c
index 855cc7a71d..3997fb8bf1 100644
--- a/lib/gro/gro_tcp4.c
+++ b/lib/gro/gro_tcp4.c
@@ -2,9 +2,16 @@
  * Copyright(c) 2017 Intel Corporation
  */
 
+#include <stddef.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_ether.h>
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
-#include <rte_ethdev.h>
+#include <rte_ip.h>
+#include <rte_tcp.h>
 
 #include "gro_tcp4.h"
 #include "gro_tcp_internal.h"
diff --git a/lib/gro/gro_tcp6.c b/lib/gro/gro_tcp6.c
index ab4cd6c68b..4e1ae596b7 100644
--- a/lib/gro/gro_tcp6.c
+++ b/lib/gro/gro_tcp6.c
@@ -2,9 +2,16 @@
  * Copyright(c) 2023 Intel Corporation
  */
 
+#include <stdbool.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_ether.h>
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
-#include <rte_ethdev.h>
+#include <rte_ip.h>
+#include <rte_tcp.h>
 
 #include "gro_tcp6.h"
 #include "gro_tcp_internal.h"
diff --git a/lib/gro/gro_vxlan_tcp4.c b/lib/gro/gro_vxlan_tcp4.c
index 29d4a2e13d..650d02eb74 100644
--- a/lib/gro/gro_vxlan_tcp4.c
+++ b/lib/gro/gro_vxlan_tcp4.c
@@ -2,9 +2,17 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include <stddef.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_byteorder.h>
+#include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
-#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_vxlan.h>
+#include <rte_ip.h>
+#include <rte_tcp.h>
 #include <rte_udp.h>
 
 #include "gro_vxlan_tcp4.h"
diff --git a/lib/gro/gro_vxlan_udp4.c b/lib/gro/gro_vxlan_udp4.c
index ca8cee270d..bdfa8d6d20 100644
--- a/lib/gro/gro_vxlan_udp4.c
+++ b/lib/gro/gro_vxlan_udp4.c
@@ -2,9 +2,16 @@
  * Copyright(c) 2020 Inspur Corporation
  */
 
+#include <stddef.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_byteorder.h>
+#include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
-#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_vxlan.h>
+#include <rte_ip.h>
 #include <rte_udp.h>
 
 #include "gro_vxlan_udp4.h"
diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b801..5bccd3cbac 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -2,12 +2,19 @@
  * Copyright(c) 2017 Intel Corporation
  */
 
+#include <stddef.h>
+
 #include <eal_export.h>
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
 #include <rte_malloc.h>
+#include <rte_mbuf.h>
 #include <rte_cycles.h>
-#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_vxlan.h>
 
 #include "rte_gro.h"
+#include "gro_tcp.h"
 #include "gro_tcp4.h"
 #include "gro_tcp6.h"
 #include "gro_udp4.h"
-- 
2.53.0

