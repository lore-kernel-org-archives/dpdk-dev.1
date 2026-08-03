Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E4FC55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2115040A70;
	Mon,  3 Aug 2026 18:53:25 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id E7A96406BA
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:17 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so80719a12.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775997;
 x=1786380797; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKk438/D+jhl2dVrajVFdXPWJeRCVENYJcdmIm1LpxY=;
 b=BS3W8msd10JOmYzPZGrUdfqPYmaqoX+Olmxt9DcYU3uFer4GseQcOHGh89MkAHL8FY
 1Gz6GApcVxBmh4IaeRkYxRpj6zO3PjWr8mVEkRz1bnDULBfPpfGB/TE42E4Pk24iXXbY
 5SNC5Qr5Gb90CBBJH83Nqhcii0DCrbcmN0GCUyrqKfiJZ8uoy9A2d3omph+L5yQ3AuEE
 4Bgt+wUXZ722QOsg6bGMj9SrCZBt5kSKckF3Q4BOjwx2PMv2pPKb0kSbQ71rFwc6OWyI
 D+asmWA96vWyGlwoe392d66SdrQIy8s4h3GaYVVTMsxAIP61mSjV+WTlr7Ey5GHG7tj0
 EEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775997; x=1786380797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UKk438/D+jhl2dVrajVFdXPWJeRCVENYJcdmIm1LpxY=;
 b=cXq4o1nO7Tu9gncTLsYZlr8PishzumjjKsFm+hDy8XNnevNYXX/ixJFBp5O/stlxYn
 dAyVTdZw831L9igCLfwbv4kkFU2X3+AXvO4Ib4ogAMyZgwhvfPaXIu/9AvLS7omBGVsC
 aKNgcxnDhEAD95gi67Y7K2fdeXQmBhVCvMV761Oe5Nm42U4mBBoQ4D0NGY0FeYDviUCw
 1wrQHvbDPpumR69K6kAJ0kUf8DWz6pXyUDlNYl8t9T2WIsnLbWFm3sCStScc1G9hYS98
 vqVdxvZbWz4wlgHP4g49/V9/1j84zvRqcr2AgXVleOd01ooTz+f28oyS5bi3us4CmLUH
 CloQ==
X-Gm-Message-State: AOJu0YwUDiTwscGlCkCqZLWXUvpLNvf13nNkh7xTSpIiqf30KJ+OgWpZ
 XJxoI9yRB8pM3ZXAyGdt/IQTO0RMkXRb4ZVqp0TvdDiTe6SD2cBh3TFc/woWjTDdE7xRYPfRs0x
 42WoJ
X-Gm-Gg: AR+sD13JwlnGtFUaFsVE2Uelb43c28fW/fdovpYY+vTxMQ5rOd0fFPvkIpebWu3+F5o
 I0d8H/uvTljcqiIDxgjDvXUabedHUJWil4LxS78ZFGg/swLV0cF0y6QgNmN5rMqXdYSVdAi4KvV
 NdsmDC/8GSZtzrLRnA5OCwRQAHv+U6jvmoibwCqxL+6bBenhA9rhDDbIxo3iNyf8gxvTkwDi1xb
 C7LBAtxTeDfbhNCBYUjyETs7O89oJPD12jDpvX2QNACG88ItmjkfHsYvSN6rdERZVd6Spj1XhTt
 BoODB3E8n92fs86dljP8fOr8lzQqibdoRND2/+8i3e4mv2tNZMzyXt241oEhlCsc0wdAZMzNoeO
 JSG0dKBrTyLR9raVcdbn9xQSRznlrZCbMBFjVijhTtcT5qkqyqNskSfIZMCDE11vHwH+d/cqng1
 9kHG8kZLe8mxP+QaMM9BJXeayNcFBcWRDFOZZjIAuMvcbacd1y/ingYI1L1jA76GOc0OFXwhldf
 ajh3YJZoTlImxnmostnlJ86iro=
X-Received: by 2002:a05:6a20:1605:b0:3c4:2cd3:f0bb with SMTP id
 adf61e73a8af0-3cb6c7b8165mr315129637.10.1785775997082; 
 Mon, 03 Aug 2026 09:53:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiayu Hu <hujiayu.hu@foxmail.com>
Subject: [PATCH v2 10/22] gro: include headers directly
Date: Mon,  3 Aug 2026 09:51:56 -0700
Message-ID: <20260803165304.289869-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/gro/gro_tcp4.c       | 1 +
 lib/gro/gro_vxlan_tcp4.c | 4 +++-
 lib/gro/gro_vxlan_udp4.c | 1 +
 lib/gro/rte_gro.c        | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/gro/gro_tcp4.c b/lib/gro/gro_tcp4.c
index 855cc7a71d..d8f3227c92 100644
--- a/lib/gro/gro_tcp4.c
+++ b/lib/gro/gro_tcp4.c
@@ -5,6 +5,7 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_ip.h>
 
 #include "gro_tcp4.h"
 #include "gro_tcp_internal.h"
diff --git a/lib/gro/gro_vxlan_tcp4.c b/lib/gro/gro_vxlan_tcp4.c
index 29d4a2e13d..653c7ea585 100644
--- a/lib/gro/gro_vxlan_tcp4.c
+++ b/lib/gro/gro_vxlan_tcp4.c
@@ -5,7 +5,9 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
-#include <rte_udp.h>
+#include <rte_vxlan.h>
+#include <rte_ip.h>
+#include <rte_tcp.h>
 
 #include "gro_vxlan_tcp4.h"
 
diff --git a/lib/gro/gro_vxlan_udp4.c b/lib/gro/gro_vxlan_udp4.c
index ca8cee270d..47262bcc32 100644
--- a/lib/gro/gro_vxlan_udp4.c
+++ b/lib/gro/gro_vxlan_udp4.c
@@ -5,6 +5,7 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_vxlan.h>
 #include <rte_udp.h>
 
 #include "gro_vxlan_udp4.h"
diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b801..d6b27bf8fb 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -6,6 +6,7 @@
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
+#include <rte_vxlan.h>
 
 #include "rte_gro.h"
 #include "gro_tcp4.h"
-- 
2.53.0

