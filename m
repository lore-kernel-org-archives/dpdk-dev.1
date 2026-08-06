Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ACAC55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69BBE40A73;
	Thu,  6 Aug 2026 07:10:25 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5ED7C409FA
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:23 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so989675a12.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993022;
 x=1786597822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hwq03RY626o+sAIf04fNDI3R6ZEQNLUaN59t4BOogWM=;
 b=htoZAbLNpd4aZRp8ssytqy2sWuSd6oQgCMdqmds60MOI5MVUG0HAHW4IMe//6JRgMI
 29QckHb0qWjTBInK9lUMxhNboH2Yj8ZdkEooK9k8P/ZwM6hGUtNiaovtS3PATOf/qf/4
 lypZYHOBFT9Qmv/Cj4jeKgdRDqYtwIq/syedBTX9R4SrUx+66ZYpcbBrPB/4NIthqc8h
 sjal/J58aY2ZyOqD82Ev6buqUNOOVYqMwZxRCv7gUzcpTI9ATqz1N5YnR9osNTJyh+PO
 xcPkDoUrUBnqS5fECxfUlBzX8eJyhHhPVwDpAry/uP0lQYr8ZlwL6EtMS8KpQ6NZxa/G
 fqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993022; x=1786597822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hwq03RY626o+sAIf04fNDI3R6ZEQNLUaN59t4BOogWM=;
 b=moxQp3oXuVmFwzGVkCg074IWqD4KCvRDGoWGwc5JcPZToqVeC+yoSa1vURnd/on5Jk
 ZJ4Ti75ae9uswuOUri1lBmq+ST7zB5f3hBPsym5jZZFu7JGoKJ0t04V4XFmYCVPMAJUn
 aILUsjMFyK29JVTMapqrNz53Me9eed09/uMH82xtsCRVHgH7AI3d0CVZ8TKf3/9g+P6o
 DbC88SZRKygzoS756Itrr3Vtdn03YvVKwAo2yAR/0GBjZar4r/Zg8gU1PUxM1YPpX2Ky
 SSLjPtfhG72GEFL6wgeOa8h2+z33KVzfPL0CPAIL3ZChBRn82Qqtq2jEKyb3C7gRPw+u
 RYig==
X-Gm-Message-State: AOJu0YyowmZ2yV5eo6xU6Fez+e8ttSfTIgRjomNvAGmHbqyptUgMjyR7
 8iOFwqA/RPCuuLaDfVFv6yBZAgXINYkh5qlB87kJy+4I7/Hsm4Vq+e0NaY5fVP1tcIfoMowor8h
 15j/6Rkc=
X-Gm-Gg: AR+sD13FsosGa4bJP6nmsu84iKUHjZcrBIyoFI9Tdk2dmJuxkGBUmec0u1uNz+nccpq
 vi/3u7wYR+TQQjHV+EnHSX5vFn/MXJZ+9zJ11S1Oit3UKlAsrbyiBFUT7xGxVjtS/fJkfYya5Zc
 nE+9tcoHphKgFo3yQy61pdhuxWCzRa3w+NS/uXzzxnSHlJH+p0u4OjmVYH9VNBaZ37NFVJbz0v7
 AL/yKy/J3GHGtyq5oMscN01ztTtyFmi6ne/Vzx74dBndJeV+Jh9ks2qf2y1L5scZwNJI0kcdnyf
 gAQiMJs+9d1sW+JVf+TYWNSMuZsSS63sD5y4Aitm7lWV1Yk3TbTkFVaq52b5eWTGrT3ak6AKXI+
 to0vLjDFH29HjpNrS1GWLIsdjsgLtuKoIRso6IZo03W4XyJmlTPjCZ3wk7vlEvpkxyBkYfIKlDv
 SSQF0PzWGSnw/GaVqD+OrXFLQZ3UhSp804MFDd6P9rdSdjoSVSlOlDp6+xYA+xXRHtCI4Q4YBxn
 utWHxEADFEmMQH5JvoH8YOQqvQ=
X-Received: by 2002:a05:6a20:2449:b0:3c4:2fe1:fa36 with SMTP id
 adf61e73a8af0-3cb86029556mr13164265637.36.1785993022456; 
 Wed, 05 Aug 2026 22:10:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiayu Hu <hujiayu.hu@foxmail.com>
Subject: [PATCH v4 08/23] gro: include headers directly
Date: Wed,  5 Aug 2026 22:09:02 -0700
Message-ID: <20260806051004.166778-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

