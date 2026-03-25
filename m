Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBB103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AF1B40E09;
	Wed, 25 Mar 2026 03:40:30 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 994D940DDD
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:26 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2c1092cc08cso2271722eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406426;
 x=1775011226; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=UQoDcwkf9rVZXwX6TxvD5H7pRpjlcDP4qv4rQ3WqAqTjJgi4Zpc/ntHsKYtp/YkH7Y
 7GNKCfZV+QVFWIZilSpvz6o1oSHMYIuVLnaZ8B85VFShpr/Ve/VWQZ/jLaHObVm/OjPA
 Rp9Ad2/ARYOwmtmSLafshseXXMPH1UfQHK3tf3Aus3X8k/y+aGYlJaD9kNEuHbCP0/DS
 JNACHX0QcJJil0z5JOJBAwxmPirW7GKL40FunOKmm07YhWB2t/ggqQUJOmpP5YNEHt7E
 47pIUV4ESEWcqvGaHbM5PwxMCaUTAtMe4/Io568clviY1jlctJFqMNGV6UPm6bxNG7bq
 beqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406426; x=1775011226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=dknpBSlMbNwx7R3bkL/9p64v5J1Mf2AEtNiQ3GKkvunpiIHvkpR+ML+jo6lI7y8BeT
 +LRfrqczQJsbWh5AyVcX+I7s/IZzgpi5Q6My5GgQEj6kQOS098+EtHaJGKV7PwTjFKKs
 DInLVoOiupiNfiVMgn9UiarQLTs1Q/wimEA0+KYf94h3mwwVQrOWWgomP0oi5xyd8/79
 oBiVs9iGzTu120KDJobrZ2veYuS0IXrJi7evxtqHCCJn6vXX9h8Pi4y3w/oytWKLpsF6
 LuLMrCr4C+vZkvQyt+fEO0m5dCq/TC0GIwGDiPt+KRx3lpX+Nu2the5Kn70nToZzs9aG
 K/iw==
X-Gm-Message-State: AOJu0Yz+o9CksmtJN+6Rza83bONLMhM0uiBYKCP4fL8Dag6cifE/kupN
 mjDJ2IQU113eoVbftiKppY/lEgccIebvPFhU4s9Ps74JWw2TAou/9DCFqax2tXDO2DDXDmpkSgM
 nRCgL
X-Gm-Gg: ATEYQzz/cfXI+4mTvpuOAUpAfNSKUKE73SCJBJ4wCU5dh4/MEB/F3mbD2/IiHF41iKR
 ZCSUy+LInSotCbkInb4+wueLTknFJJtEOH/gT3JaUsEh2R4oaHTAcENtrLxw5tD89uXfo8aSwpT
 KvUlaSL85RFNDteAyqj62oiFb24a35YFNNwz2n4DOpfUIT0xxCxWmRZ2InKECBPCblShzGF7S0N
 D82pYyxPsl/QNd2hPwsUWVZe7sUTTcdfr/sII8TMCXQcPFbBhfquULojMoVT8iiPWLKNUqlDcV3
 e1gfgQUT4/LJ64R2vQLvKhODJlQ8w0jScGtvvptE9WnHlysAY0Zl2RQeysvGIVw5P1BpPu1xtRr
 Blpsu7OTZ85cGx4iHnVgDu1oBp5zKGGO9t4alUvlr1oQwqsT06cIQOuZJmbN4YI4YcDj70wo2mp
 IU8yDMNxCyyvTgtd6h+Vmaz5qEw2qGlxqeLaRBvxq7gbg=
X-Received: by 2002:a05:7300:7493:b0:2be:9d3:c8c5 with SMTP id
 5a478bee46e88-2c15d4b36a4mr960355eec.34.1774406425621; 
 Tue, 24 Mar 2026 19:40:25 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v21 04/25] net/pcap: include used headers
Date: Tue, 24 Mar 2026 19:37:35 -0700
Message-ID: <20260325024018.1275209-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

