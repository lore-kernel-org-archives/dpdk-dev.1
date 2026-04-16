Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31104F8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F41F940672;
	Thu, 16 Apr 2026 20:47:45 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id A53014066D
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:43 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2dbb4ad19a5so2874924eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365263;
 x=1776970063; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=fYUdWiksWja17GYqldXJ9KFybIrmhwTgHhLQ4t67nZ7WTeMvuBLSPcxCn/UqEy597Z
 Bv81eOl0LKXJli2Dxn9EncNR5C3jDEflFznHuwpd4KWL+c6l6GrQFZPO8CZ+45/SakBT
 Z5cn4PMSrfoaOK+qiIqXav7G85tQXyKCoQXDTOKV4UmOucYo5pEzCw0FL98p47br9aWO
 /ZTQC1gQ2/358HsFKmVvkc2PcrC85o2eAbSDje/6AMYwKYkVpQh5NVxq4wYwPrmEdx3P
 zvGAHBT3rIjZNBWYcCFzw4suvMua1wxX1WxBIFgr8pSlG1PRCCWM8T+VkUedswiufSgp
 voMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365263; x=1776970063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=K+jlMiJ+15uRIHBH1h8IcCUmwqGGbeKcHev/o7wOVOAZi41VUA5rrxQtm5FamH89Eh
 tCVUPNiFRvqRMoDt4tNIitkD49bzRbUMJCDDYgLW6uxzQzH4b50pKuFW1gj2xW9Vr1TG
 B/Zr6bKunc+j6HX75ovujwRbS2xk3ngZClI+4ierlcsIxf1Ny87wncomoAVfGmDHAW/3
 77l7LY9JqlX2y7FOLo2adAbdur6Mot0m++mJUsYOG1oRnF+EoU7IWDMbeOcMeYXgUNrM
 9Kv0v3LkIp19Rd5qPJCscdV7ADbo4gsQFQL0/qAkfk0mFWMJcXv5o4iLafSN/rUQd0Ie
 DAgA==
X-Gm-Message-State: AOJu0Yzh96Kg8WhBVcVlFpuh18NN8mq1TWCzjKE3MTRUH10K5edx9/Sz
 AoQzMwEJsGjjOm1gEhqt5SLCqjAQOqFcDjXoMM4EI7ab+ppKFYqmTjxbo+k5veq968cr5tZ77ac
 slZSk
X-Gm-Gg: AeBDietGoJHlxEftlMPYOxp9i01b3jJnc8VH/M5tG/a3OI/yX6WFkGXoUeV42QzB3Wr
 PFVCQf0YE7jez+8+AQTv51y07NxEkFVcT5sdgC2f99QN++usig9xQKemQrUYo/7e7gNF+s2xnwh
 8RBZpdOkE8lzz4qybY+2ZpQUhM+Y+U+6GCqGgU8MJ7GOqSVRrUaQhGQGZcM1SD5MmtrHDJEVc7G
 GGAeljQP91xrxZX2dvzbKXPcrTblQI0sGgErbEPxiD5b7RSiIrXNe4xoA1XiJJCawcU5rOvLWEc
 yD9/YqK1WaYDcFoxXxjwAr4gvUiHe2Oe8mzafv0zOXTalaZaWxRoK9+aM7IDTvPEbmlyMdNU5bT
 17CCAWUo/S6cvn4LBeiHdb79DjzCLZpT1+9cbTDJTB5HQ3cJehf5Ls9WComt+cDpu1Rlz7ni1Az
 c+oKkyHPx6q5atdwDEDkeGpP66cOC3VukW7Kn/VcLYzQE=
X-Received: by 2002:a05:7300:ec17:b0:2e2:3381:2fc2 with SMTP id
 5a478bee46e88-2e2e3b6522emr258022eec.3.1776365262743; 
 Thu, 16 Apr 2026 11:47:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 04/24] net/pcap: include used headers
Date: Thu, 16 Apr 2026 11:45:26 -0700
Message-ID: <20260416184731.1347342-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 9 ++++++++-
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..4513d46d61 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,23 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-
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
2.53.0

