Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27634E63CA4
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:23:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A8B402D3;
	Sun, 25 Jan 2026 20:23:21 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 35C4B402AB
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:17 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so3751311f8f.3
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769368997;
 x=1769973797; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=mXS3IakQwsyKnmg+itxxF/o3CDnnwvsE6zHHBwD6HURg2R4hJkeyaJkSQ2815qYTB/
 yIpYf6/qa4Xfd2y4oioS2Jm21TgBUiclViyQdtU/pF4NtNNU6wTkGokpZMrpLnByLKgo
 wNulR3u/v4VShtFU90oifNjEqvuzBCJ8K9TdcSopdw/tO8XkWbfNE5FZVXkE62Oh+x1t
 BPNumn2UjA2DQH42EG/fZOHENV0ejvIlAAt5bCO74qkQUTk8c1mDIJaM1BjI0QzCjJod
 8sjL5PmAcWxtFlN480YAyqC5q5MdnKM+7Uu6HOuow/AdsjONtYyJjfSjXXTcxLa6t8H5
 o3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769368997; x=1769973797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=LPbcqKC4ulHfw/1EajfPxqxCEwgJZDW2V8pE6wQR8kDf+3i9en0ThOAJd7U2Ni5HTW
 fuqiDYqsGY/XRnZkqZDcMUqiQ3WL/8H6HVru1YuruJHoaRpsCz/yyWkkpO0X+g0mg8yl
 dkMpWL+/eN6vI46jWQ5p3e1rhA6tzsjh1LUIRPh4ZQyXS2O8Ls93FQJQ2dzzS4GbikVP
 ur0GLQv986y/6BZCjGlMVfqwPbavsuRvpAuRnKLfClx2YVyiSAvHXKenIKhueX20AdPh
 UKaPb4hDBmHysi29Hxi69Ok9CfrwEHce3BnlOIHW3gio7u4n0klqOCYoW6D3j7N8kWxh
 MzDA==
X-Gm-Message-State: AOJu0Yx59qUzqZyb46tyRvWT5HRghsRzgXXntvPPHDhdJqYBdDw2lum9
 jINlteYgT5iPxihtRG9DhwXP81W/5feOsEPGGX38vCctM+pC3xY3UwOO2Cj1c6xzCPnZ8H7ED8o
 uv1hS
X-Gm-Gg: AZuq6aJViBjH7j90Bju0tSLxWsx1IwvJqSUsMYXsICnuq2fyykkikS6+63VMNNq7wQt
 GUJQVewE17vNgR9IVr/VdvnIcD2lpqHlZFtR8vBluydZN80MCIxq1g0BI6w+/6hld5Q5PKjsoXy
 gH+KIE94JXICbFnrJWDArckTyRZ94wD3qp9hhI3/czTIe90jsI6U86nEj7YC8PivRWWaFQmncXR
 EMcARkPIyBqGJc1jYfCzE+BSKuNpK6bMD0wokww0KvKBM7YLxYxF6T+y6T7bnRrOz1Dj/XRDEB3
 QUjKxmpe2i/C0Vc5VuW+bhFo4xsXYHh5wj+5WbLh4stbBGk2Q9D2hvsgGomfPt2VM5suaB1w3uN
 pZlkYgn1VK0OqmbnTqeDuzkQlh8uxBOBX5u8/mh8ETY+2Y+b/+/Pm6B/up51B3auJIbNLZAyAL1
 Eg2oNl6vlUnqNwcaEY0FDom0UHD+8gKCkzGzMhNOs0l/lJqhWevQ==
X-Received: by 2002:a05:600c:8b6b:b0:480:1c53:208b with SMTP id
 5b1f17b1804b1-4805d07366fmr42270305e9.36.1769368996740; 
 Sun, 25 Jan 2026 11:23:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 03/13] net/pcap: include used headers
Date: Sun, 25 Jan 2026 11:20:01 -0800
Message-ID: <20260125192248.497563-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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

