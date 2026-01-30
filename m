Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D93E6BF32
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA4054060F;
	Fri, 30 Jan 2026 18:35:04 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 3B9B5402D8
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:02 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so18810115e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794502;
 x=1770399302; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=hIqiLk3oIF1RTOpaVpWax+2riKt7ahX6wgRmuqNDnqwSnfXwZFrdZBF/DnDqjolZ/7
 85PRaLvXbaOYjRzF4IQmoFhfMryHtAUXZCqo4+iJFifJ8Y+W4N9sdoLp66vKE+7hLtaB
 rZ+4wX86RjhxuuuCYd6UN8zikW/MDFdBzs58rSUVQ1vwXid39wmJ+zZEZkFYnoIy9I9P
 bJSeJwaPQ4MM9opE0p8B2XoXMaZ62phWbgo5Zx+slBluyLuB0FhS1is67eJT90Yel5GZ
 90EKiUvY/EGw54g+xjtJ0R3B6c8nRZtsYyggOceLfxwH1jU/nsdCkh6Z5aPAtABRYV6D
 +2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794502; x=1770399302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=hpXaxUGA6TwgfRAgMffpusi4xKqU5eMqO697nnpbhIfBHxFKdlQDmPn5H1NaFUpDTc
 VL5XJ6OkmBrKEapws5J3kaHNTywcH83/kDXmqNIXWprCHgygYOppV5y566E61986WI25
 frphW0szQ839/sJ4SAEpqJ5S18+br14epoqAIHXa2Xss5JdddeEEVVX85qn2ze5gD2Lp
 ceoAxyuYrA7UNIUkF+UsjRtNNIpQgGh5ooXkZTakOvLzjUuKZtGz2iJ/qIudpNR+FGS3
 U9DVpmjEXa1qvWpeGX5/Qt8v2rYn5SryaIko3+g+FxQyMjwEWUphKy4r3kpjbzJJbTi1
 /DtQ==
X-Gm-Message-State: AOJu0YzDwHOSoTgrD21iwoipgLUS1RzSxuMfb3aBlEOXIvGQgg4z5k/B
 k3uFhxQNqfgs5D6tBDGRZXZMo9B6FGkIcaeqF5oGQsOKZiI7Yw1lRNUfEhOSeRzmcucR4m1KNoq
 9Oe8C
X-Gm-Gg: AZuq6aI31W2+OzJv3ilImiAdqVO3xsB3D7SASnqAcJcDhxO5h0Ci6CHiEiY73zNjrue
 vhhYsKGPM4jtG2BWisGr+GHpFg1mqaYF2gzlc/9SQiZctUU+jiGjpMJ1tcaOSKbUHx43MX9warW
 tl09psxZMnKQmAgB7UzeHTeKracBucd3XimsX9qcWUYmDIAIWh7NzeXae7fnwTi6esMI6l1mZ2M
 XaHLovGIe3653abDhOUQ1+WeFwhy/AtumfCD/xlNyouCl+rnHat4/g/RvWS+LY85rbFKaFozHol
 ldRWs9eZATb9Vm7lD4ly1P6LPW7gHaw5huiZStmOLtKZcXFSoPO4erAcQiZqMX7Y5eWhceFFVX9
 1EZmrXm4gc4gNsa29O5AMrr/iP32V5aRuKKLy6YYIWUQHd4dFIcnud2LaUYpXtgoc4KhblE/ff4
 WjyR8ocrsQyr2AJdf3BqvVok78da27N3nf4rFeKklJeAP9x9sAtVDppwC5yJ3J
X-Received: by 2002:a05:600c:3b23:b0:480:1dc6:2686 with SMTP id
 5b1f17b1804b1-482db49e661mr49634145e9.13.1769794501680; 
 Fri, 30 Jan 2026 09:35:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 03/19] net/pcap: include used headers
Date: Fri, 30 Jan 2026 09:33:16 -0800
Message-ID: <20260130173447.14546-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

