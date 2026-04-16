Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01AF8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9208440A79;
	Thu, 16 Apr 2026 20:51:55 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 4FA0140297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:52 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so9553630eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365511;
 x=1776970311; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=BjR0FcOaEqe9ArX5immX/oQwwCuiKLNx5bRBfqepwKgw6cyYqDdJigF69BwJrzjFq/
 Xg56Yg6ghVE3n4o2cNTstF8eOJgqXjqZqJQxYihp1HcwJrfPC4YYNRkANtkvm8fCwZB0
 oJFKV7ZRQqrRzNA9Ttk1kih2JwE7okgTxZ7p8ZVsW5J1dfG+CjmPNfTNXCCXTfDX0bCC
 UD41KyBVWhbDNperSBtuN0Fd5lwRvsHbke0DzuprsovsU92/V2BWdM3AHpJF/NKWyuGK
 M8H1Jv1ycTLYkp9v3i359LEvXsqoX1QwmOh6bWPGLROXilJiESHxMHOaefYhZfUUsXzC
 lm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365511; x=1776970311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=DsrBR8Rs2pk9WTeV9hyencOLoWhWwlOHO2iyih+19LryAuE755bRfznU4/6+jkfW/U
 nTaz77QOvVpKpMXNgt6ogBmDrvYneK+HW6etHHl7Buy144N0MtmX5440+mrfQZH5fu3Z
 DbN0dTJAlg7gyl1wqkndag2oLcJiEEzVCpiSsJB9cViA/fPVc2kEe4YNV8bGHmHKwtri
 x8pe7Mi1b56e1omnZzbSkudGzs7s/awHIzi+f05JgnLYUWFD2z5CXqkWD81/prIYQFOS
 ePO7bIAHItVg8vFcD1sCEqRxBbw3l7FL/eI8TD3MQ/c1s2FIBd2R37Z9gjWte8PkY7eR
 w5Pg==
X-Gm-Message-State: AOJu0YySjMfQ383YOp3C3+2a2RiAMqSRrZ+otQSjmJVh3YVGdVhcTQhy
 m0jYCBhtWEUni+rilBeKjPTX6M4UgKbyQHFH8Oy7q338bhwL7apy1/oX1u4jAVKq5l3AuA4OAOO
 2q2m/
X-Gm-Gg: AeBDiesfp7+VMOB5kOImYGEuw4DfDYhsuwrhP0qUK14FWU1tZiZa5nFs21cOsGy8pIR
 PNRB368qNJaePcQTJMEu7i+MwrD1/TQVrGWkvuG4mxyDTL2n4CjZTH6d/YdSXVXUtoCNwudvzKp
 4VwECZnfyX3Is5OoNLVgNocVxwNy2E4BrgrKUE4g/iMk2112wteJURpkr+7Dd1Sthv1zc3tUqgw
 3a4u+FzBY3ol27mhABNrZMaALNE5xnDN6cDkoU2vdR6qaeXpTqgqtdft1zf4qh8vfX+IKzTdp0T
 3XZcmhqaAVVaD18qB6J8mc4QB9dVkuYK0bHaLMPM1LQHWVC2XaNXsgUh/sLo7/9yhyR29DAGVIP
 5Hx2OcpHSTR6plAZTuA46V8sA0pF+cYZPvt2C13e6UqZPkSM0gq43AZA9VL2YCvSpoiyS6FhWkd
 1RIdeVPc4d2C59AFaHabbMPpRTdRtoWXybjipix4hk4mI=
X-Received: by 2002:a05:7301:6788:b0:2be:7885:31df with SMTP id
 5a478bee46e88-2e2e4f21fdemr285291eec.17.1776365511428; 
 Thu, 16 Apr 2026 11:51:51 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 04/24] net/pcap: include used headers
Date: Thu, 16 Apr 2026 11:48:21 -0700
Message-ID: <20260416185144.1359260-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

