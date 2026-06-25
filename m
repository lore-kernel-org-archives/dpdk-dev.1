Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6442CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54BA240A75;
	Thu, 25 Jun 2026 19:49:23 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id ABC6C40650
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:49:18 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30b9e755555so344822eec.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782409758;
 x=1783014558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7art3WLQ0Dsd1WVT8gYnX1P9nT3S8QwIgUPeNKNZJw=;
 b=TYdQlrQmuIujpSr6FzxovC7bS/S1WiseK5QsT6qj3VXr48+YAIW5kzZLidUvdddyax
 56u46pLvcJqjCxVLwWmGqFSK+SL/z9Ah0/zlZKEmnys5ebllANiHNfyX8aYZujVvB0Xw
 neOJQ0E50TiYKsHIgqL/fH79sgQFhdAK2MhNA4AvTtOwc9+nC2BklBuKRDshJ9qpoUHN
 FtCUe0LjO2/UiqNzpnn088KEt4oeYJLfHQRLd8DtIn9I1FZJZi5B+dHczUvtsYR+KRqO
 MolHX1DLcE4ot8VfeOLnDCBZgpVH/qnQ7BpWS48Xaf8rpRjc2b+h7DR3nrQEuyRp7eE/
 vJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409758; x=1783014558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7art3WLQ0Dsd1WVT8gYnX1P9nT3S8QwIgUPeNKNZJw=;
 b=ZL3XhnXVT/hNcxCzaL0p0Ga+FteRGXWifNx8JTK8HrQbhPhC24Z7RF4Cl2LDMjWiq8
 jTYl8iVN+RTnYqc3DCvq3EP4FzE5Upjwi34eq+igbm3S2D37deczASrZsT4KkAIwvRCu
 UFOEcCt0E90w+PqE5b30aAuVb8LWcV4MQIOpAhui7a/zeLQjdRcLrFbmd7YDI0sY+yrS
 d/6TJNusm4Hk+ThGcK5/KD8OAE0Wq92YF22E0DfS7nWsQyxpoQqetYzVccj/aQth89T4
 UM69Z210NAmqxik/5UeVTCjc4F5IVVtoXfElOXtINbJNLn+N9piqfcXbixvnIq+WFnQu
 jn8Q==
X-Gm-Message-State: AOJu0YzOco5L8G9VZMz4b8IwgUyJyv87J3hX9NPpDfK401IYq9cwf/ba
 qWImTnNkgFQ8mecn/lC9aulVppsTqJV2CoLmRLRFtOvORXNjSrR0bQFRvvx3v1Uj/S4470T5jn8
 m7vFo
X-Gm-Gg: AfdE7cle8lcS2csewQL0CzWFfScNmW66gIHnYx/WFHF5JTpEI2sMPIwio6W4J+JNkXx
 5AyqhphlCzmdaY7JOwOe2VQEAiqrR1uI9y6LPXGz3cUxzw6ZYXOAlbuu3VT2dMBCENvLl95VXBL
 b1RUMpSLxukQQQ0ojPAAyLNxtpuDmI6YWoz48N2i5d6nK9vnfPlZHDuEOP4Ckp+T1BXUZckMeB6
 dehdnBDHL9nkontmVyX+r3K8+NgFZ2+xO/YLNQ51aROu9RobB8JWYWR3hBHsAmIyP+UuUPCxVl8
 ic6JbfY15sP//0YPBLg57GJiCSgTydJLYi60FuMqRIOlOZLwZq1Fr4Cu8jg4c/lPPzrzLWbABAz
 f2YypspUHSOgyY/AODa5GV7I1VupBjRZdR3cNUaO4hleOGQKezAFPd+PpdOlJIdlNvwK7tQ0jgp
 bP80M46me+oM77Rzf6YQ2IcVk0UzqeTStKVkCGMSmMNioEOE+GeCYPxqQ7sisG3A==
X-Received: by 2002:a05:693c:8816:20b0:30c:8656:6db0 with SMTP id
 5a478bee46e88-30c865672dcmr2442587eec.27.1782409757575; 
 Thu, 25 Jun 2026 10:49:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm10594472eec.4.2026.06.25.10.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:49:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v3 6/6] examples: remove unused define
Date: Thu, 25 Jun 2026 10:46:56 -0700
Message-ID: <20260625174908.278408-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625174908.278408-1-stephen@networkplumber.org>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20260625174908.278408-1-stephen@networkplumber.org>
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

The #define MAX_TX_QUEUE_PER_PORT was copy/pasted across
all the examples but never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-crypto/main.c          | 1 -
 examples/l2fwd-event/l2fwd_common.h   | 1 -
 examples/l2fwd-jobstats/main.c        | 1 -
 examples/l2fwd-keepalive/main.c       | 1 -
 examples/l2fwd-macsec/main.c          | 1 -
 examples/l2fwd/main.c                 | 2 +-
 examples/l3fwd-power/main.c           | 1 -
 examples/link_status_interrupt/main.c | 1 -
 8 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index ff189b5fab..aab356aa6a 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -100,7 +100,6 @@ struct op_buffer {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 
 enum l2fwd_crypto_xform_chain {
 	L2FWD_CRYPTO_CIPHER_HASH,
diff --git a/examples/l2fwd-event/l2fwd_common.h b/examples/l2fwd-event/l2fwd_common.h
index f4f1c45cd1..53774e0fe6 100644
--- a/examples/l2fwd-event/l2fwd_common.h
+++ b/examples/l2fwd-event/l2fwd_common.h
@@ -43,7 +43,6 @@
 
 #define MAX_PKT_BURST 32
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 
 #define RX_DESC_DEFAULT 1024
 #define TX_DESC_DEFAULT 1024
diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index f2c284cebb..856914e9f2 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -64,7 +64,6 @@ static uint32_t l2fwd_dst_ports[RTE_MAX_ETHPORTS];
 static unsigned int l2fwd_rx_queue_per_lcore = 1;
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 /* List of queues to be polled for given lcore. 8< */
 struct __rte_cache_aligned lcore_queue_conf {
 	unsigned n_rx_port;
diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index 12ca60c3e4..fde997f778 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -65,7 +65,6 @@ static uint32_t l2fwd_dst_ports[RTE_MAX_ETHPORTS];
 static unsigned int l2fwd_rx_queue_per_lcore = 1;
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 struct __rte_cache_aligned lcore_queue_conf {
 	unsigned n_rx_port;
 	unsigned rx_port_list[MAX_RX_QUEUE_PER_LCORE];
diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 98763440bc..e40e5b6284 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -83,7 +83,6 @@ static uint16_t nb_port_pair_params;
 static unsigned int l2fwd_rx_queue_per_lcore = 1;
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 /* List of queues to be polled for a given lcore. 8< */
 struct __rte_cache_aligned lcore_queue_conf {
 	unsigned int n_rx_port;
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index 59ea3172ae..1c4a89ae90 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -80,7 +80,7 @@ static uint16_t nb_port_pair_params;
 static unsigned int l2fwd_rx_queue_per_lcore = 1;
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
+
 /* List of queues to be polled for a given lcore. 8< */
 struct __rte_cache_aligned lcore_queue_conf {
 	unsigned n_rx_port;
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index ff0e61e639..0915ed5658 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -221,7 +221,6 @@ struct __rte_cache_aligned lcore_rx_queue {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
 #define MAX_RX_QUEUE_PER_PORT 128
 
 #define MAX_RX_QUEUE_INTERRUPT_PER_PORT 16
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index aa33e71d7a..52bfb3c35e 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -63,7 +63,6 @@ static unsigned lsi_dst_ports[RTE_MAX_ETHPORTS] = {0};
 #define MAX_PKT_BURST 32
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 /* List of queues must be polled for a give lcore. 8< */
 struct __rte_cache_aligned lcore_queue_conf {
 	unsigned n_rx_port;
-- 
2.53.0

