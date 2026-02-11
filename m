Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4563ECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAF5840657;
	Wed, 11 Feb 2026 23:21:48 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id B642740657
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:46 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4833115090dso22846015e9.3
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848506;
 x=1771453306; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=tU2AyFVYIwYEWzBV6sbP+HHOlyj1qg1OQJ4VBWROZ4OHKC49QTSAW+/3vgMW5UZj2M
 kx3nFoZjf72VahLlEs5uIa20kME+1HX/6jIb5AeidxlkK3aTDxlsbGwr7BIv4jsIUshy
 N7a49tHPohKacyr+zipxCIWAw/p+TMCDX6LfeMGQgGeMO02uQpChf0mJibg1mi4/OP0X
 mxtNmJoI8GH+ufrHtr6IXcFu+SyVLIiFa1Km/liShPoDloiaVzb9HGEaW7YifyjqWMh4
 EzaM0sihjJP+zzbnl0gzBV2UnYlluAccFeuHRjbx9eQWfof6l/xmk9ce5JNgao5rnIgY
 wuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848506; x=1771453306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=LiAeonZJzaomqvrLRFE5A1fAAwBgRJC+YUFwLGnkxmBRCXPoLGh+1GscaNwQ2uLI9q
 UnQEULJoVi5uPU6o/6PJzxtrbhDe5lFmRFSWovbd2xhcyJl92Aff4UYeLuVqADstwZqd
 ao04ed86q5aYHk2rXxntsOc9X6MdnjFQTTbYpD6NvrO+89+ys1i5Re9ywcZD6oTvCl3m
 1wlzza6VavPWxPFujZp3kd7lISnTMR73Z4teVnrKxqXW4JdwkrNnuz5tmslYgYvBVPSt
 PhIB7UvYE+KBy6lXa8zLzSViL+WnHSEw62wF2Fndx2bOj2LV4wRNK8E2kjmGqpaJSLVe
 53EQ==
X-Gm-Message-State: AOJu0YwnDxiQgAJKsoH8elbwIUKJ0kJCcvJMaKqvdZOgqFv8n4W4gtpN
 iK7Zvw16ZnGJMqMXdpTTqQdKaRK/A2lZ7gNE+CbsXu9cd9uoCCsXN0kFyp8sM3BITHO2r71liTe
 R6i7L
X-Gm-Gg: AZuq6aJlKwWB4HxlN5fdkrrF7x4rhrtIRkHRFehip5apbE1RuWrjZS4QIhtC7OGhryP
 VwpbYos8kMbpV/GhlKJyc6lrMabNYjMfZt/f2jFG3HoBKHD9NQkV550YcFhRw2Uyu9NJXMSpG4B
 4N6O/Cx14aVKXajX5ylIMPLLxnqw2mGSLbXr/2kLOjUm+MscuwkgUJsBWWYIsZu4PcH2WbP9Q+q
 odzF9OJ1vt2eMfFgjzzVK5fuEYgMj5nCduDzD4aj14Uz2nR2qVV2Pwi7tSNvWj3NtE2Irg285j6
 fyhYizAUl36jaGmAzJ1rbWaNH7FRzY3BU4PrnF4Y7JTKmF+cF9zPfoAT+xEbDkdZ86w0G9rwN9T
 OAMHxwVYPDgnczVRDhTejrxjVB7r4I2yUoJt+u1q1+dovY3BNWz41h2znYfmV9AsF9kCC3QNLoH
 pGhysQVw5QB423VkXSUfQs1Vyf0DwsTExIRMQl8fOmJjyLxk6VNnQeKBo91fuRKw==
X-Received: by 2002:a05:600c:6285:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-4836715979emr915405e9.17.1770848505871; 
 Wed, 11 Feb 2026 14:21:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 03/18] net/pcap: include used headers
Date: Wed, 11 Feb 2026 13:09:36 -0800
Message-ID: <20260211222130.338797-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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
2.51.0

