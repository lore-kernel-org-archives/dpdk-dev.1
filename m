Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C6FEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5626E40667;
	Sun, 19 Apr 2026 18:11:11 +0200 (CEST)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41]) by mails.dpdk.org (Postfix) with ESMTP id AF6E040662
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:09 +0200 (CEST)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so937897fac.2
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615069;
 x=1777219869; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=H/R1WzX6pFftqvw90i9I/iZTr210kvFLA064DXTnjl0lX+V5BxqRobpv/afH0hCPGx
 L3KtIn9m2vWKzs0+6wc2lIDlAb5MjfzOirtd1UfUzt2LvD499q89k6ia05XeuEcZtCbr
 6RbT+N3Y08Y/kMa9g0fow/xS9IH4QmgC+u/BFgmX8oL54YKtv4A50u2SXy5ad+Se/GmF
 PwgNlAxoELJeGTu3QNuqGU7QdiZurJOq1fK5f0u5WKssLxc3j8euhtELxjVO+RfGJQ3k
 JmJy7SrnJI9OuTNNo73txeEYUlOxBa6+bOdvbhcuQGRY34Nc8mzMTg7arp1IYCxLNE1h
 lZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615069; x=1777219869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=i+Ov6y5eV6FLEb0DOMTg4/PDCautkzn3wIoE/+tTZIqA4nd1/PpVqIIuePk82LKEsa
 h8iInNyiWMQfTEcRp8bb1xwiUpDK1gOSD5jn31BY1tw1DsIKfhPQq/GrgdjnAVw2kGrZ
 ViQQ+9uYzh91j2fEINHrjfWYLiTAXSfz68gY1z5abV0IwSjt0UXTkGyfA12vL+4hiIDb
 MygSUbwRRBbA60JUQTB+zcsF4poHhDfYG2bU46vvKVnMWaX3DqKLbeuR7vfZxL5vTg6l
 Zta0dR3qjENtNr86jVXTNj/pGEVdREWdhfiLoLV2tEoUjzTaBQ4cmZffiT//juItNe1w
 G99g==
X-Gm-Message-State: AOJu0Yw1l4PZD2XgVy8N6vNrKTTKVgn5iLo6sGu9qUtGU6FRO0u2r7Cc
 I7ikP1gsZKTZb2U6CGzibG6Lrxobrdi7HQ9UdUpaGBN7AoJViBO8izFP+IJCeItuL27Ut/i+AcY
 Qt9TG
X-Gm-Gg: AeBDievTNRz/y5F1f/ZhVvdC/EpjkO9VXokkvCkqVmOVtAXZ6Xj25T3NXlPKYxnuE8i
 bOtzbfE6Gvll9SBaDz0GhUj3AyzCH+chZ7r3M8gktIR2Gd9Z/tXXuD5AFrGVY0jw4/8F9/0Xqeg
 xHCJeLIUMLNi6LHHq2zqIGnNKYgjUaFlxzC2MEYSwulgjyf2LN8ZsPr2TpsMNzJPtKu1NUc5hJt
 uqbR5SFy0uOcL7quBISQvdi1KOB4YSNqq0rkoAn4axXCkMd2THKfVGvYnz6m5yEpC2qQ+6hcz2+
 LGiQqL/iomldR+VcyJK/jHCWvS0YpdGVYesqcbMV0rAulu3OzMUfuKDk3h0bsfjVaddcLQgcMk/
 2istbWdNvmq83edqF2a1pHnk8HvbXwg49c0pN0bftNbxtH9JSckeV2jKnTCesTJs2aej3dpQGGk
 GuIRXB1i5dBBK89pVvQrqQcEc3S3Ks38lJOW2JM/inxEk=
X-Received: by 2002:a05:6870:9d88:b0:3ec:3dbd:d4cc with SMTP id
 586e51a60fabf-42abf224538mr6344880fac.8.1776615068954; 
 Sun, 19 Apr 2026 09:11:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v25 04/24] net/pcap: include used headers
Date: Sun, 19 Apr 2026 09:09:37 -0700
Message-ID: <20260419161059.205954-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

