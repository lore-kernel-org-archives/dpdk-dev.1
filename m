Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A12D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53E854067D;
	Wed, 28 Jan 2026 19:41:46 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 434B94066A
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:40 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so1057515e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625700;
 x=1770230500; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=r54eVIs3DGd6lM3g3FIuQtCGkiSI+qH9LUF3B9eynywjQC8nL1582czet9sPUtnPlS
 HO+kdc/K0v28EWcLq6ml4hmar8/00d+ZM+REr4x6y8ZNFru7wQLneJpcc/OYtMuH0/vr
 kYNl82gJKZwXdj3XYDtEmi5flE0VM63L3Nyn03yTIKGcdRh2x2LhimND6DRixN5PYhQe
 mt76ygCIffGK2sblsYtFQPtd38LISP5obQYzIySAfe5NaK1QQqjexGi8R7qCG7b554P4
 3172bAVziEF2h0EsbkHdHXdURM7onykJa3iFsvhEC0y0qsgL8rOlkHLxB1vhr4Z4iCSK
 hl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625700; x=1770230500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=gexArf1dhvVA+2wgt79o15g8LW5D1noUzS9CUdKI4CogO3S+Isrq6MJ9GzlrZJbQlQ
 o2ftN2OjzyXgdLbrlzetCe1OrBBUrQTXFcYB+seBm/XBhUlXW50JyTBsMsBFP6nbn9qL
 +NE5csRRFu9aGXoP/YlUAAHNd3KL6zzamaqB+UGAq3muh8PDtdFL9N/A2fUyR9m3SRaD
 ymg+oCwuqnRhOAeMa5Fx1ijxU247t0KlOqMZ9Md2N1mK5iwSzhiGHJFDza5Hp9V+DsNq
 veEexbb4ns7Ql9vxTi/4PqN8E7LBWUSF79KmSe7pp/rvF+8n3SrFtCWeYEEzRpfSqZyx
 pqzg==
X-Gm-Message-State: AOJu0Yx2n4OepORg94qjb5Q39r7OTmBvJDZ5FrBJpY+GfLj52f9e/059
 NjiMF5gJXCWx/xDYZFKHbUVtPsNwiNuqinRw1sgACZJr0kADzBCPlhFPwnLhK8pCf40+BCUIMy6
 0wTEC
X-Gm-Gg: AZuq6aLtqRMQhV0fuDfmxVoYPPQsZDp8vjuO/o+pdk8jDb+cFx4K+LqlqgZC30ohwao
 KPTCHBgVM6MXgcmUJ5Z4Ih6F196NuobXjdF17cIU+SAd0PgIGdkZfApd1UOXWJhmRu1+bkxj1lp
 Cbt57YD/1KW/0Kz3GFOzad3QVDL+cxdGySlfA0YNdDfb/r5rh7VE1V4Q5KDHynLhVResrrXdrHH
 yAFlSs32ROu5J61cjh3FWTk4vno+k2cWEds6J1rc/G8U9pNIlgtJtI3VUhUztV07HBjuBmM0Oly
 zSBlkSc58nJnPE7B4nJUHOX0XeMR8hl/zQ/Z+84MBYJARHrd39ZIbYvJO4oHcEwFVdDYbWNkdMi
 RMYeVknuFQmLxHc0JdCfMCERL2/MIyS7fxSfbSnsQZXqDX4PR+CToOsRroqI07XVC3wVpylb023
 x6u+zwBO4VWqKVmYKlFGDzUTl12fFA6NyAS6X1GtiVp/CWLefeiFV8sB435jqJ
X-Received: by 2002:a05:6000:2404:b0:435:9653:e154 with SMTP id
 ffacd0b85a97d-435dd074b2bmr9422344f8f.27.1769625699825; 
 Wed, 28 Jan 2026 10:41:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 03/15] net/pcap: include used headers
Date: Wed, 28 Jan 2026 10:40:32 -0800
Message-ID: <20260128184130.445567-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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

Include the used headers instead of relying on getting
the headers indirectly through other headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 8 ++++++++
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..d09ba5abe9 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,24 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/types.h>
 
 #include <pcap.h>
 
 #include <rte_cycles.h>
+#include <rte_ring.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index 2aa13f3629..a0e2b5ace9 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -6,6 +6,7 @@
 #define _RTE_PCAP_OSDEP_
 
 #include <rte_ether.h>
+#include <rte_log.h>
 
 #define PMD_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s(): ", __func__, __VA_ARGS__)
-- 
2.51.0

