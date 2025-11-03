Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C82CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C59C84066A;
	Mon,  3 Nov 2025 17:49:25 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 9880B4065E
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:24 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-33db8fde85cso4566177a91.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188564;
 x=1762793364; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URs6kJNepSQwHKOdpuzN9bkSt2agGSEfXhyBaUWKe3U=;
 b=2NrUJ9jhjfnkI+IXmdkHxCvPt/3ilnrQJBQhbvHJwpL4NE+mZ05XvKZI7V10X25Le6
 rhx4BVxLT7SjhbuC3zUdxnNUK8F99EEvv0qDBZ8DJJcHf1nN3wSiTeNjbNOIVWlWrOvU
 jdGYoPls0IPVXBp0aEo6BwYqebEUENQ8nfGBIF2p9Vo0USojPvm7rb6JJdE79tXiTsEg
 9ufNAJRRS/k3XjLt3arFFqGJ6m9n0Yns2WkXFo0ZT+n5E4zmFy4kcpEww5fopjLvQtEn
 SscML/5EuFAHlFCxW7JKVSyDDzWapCwCcgOEvziZea0epCoZGgkqF2HcENGybQMVzghQ
 XN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188564; x=1762793364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URs6kJNepSQwHKOdpuzN9bkSt2agGSEfXhyBaUWKe3U=;
 b=wWb0v2j89dsmbD1Ib0PfqG4PoMJv9J5ort+2YfFxvbdP1174p5H7F0eMjU4E1FDX12
 sJiREsMTwkKQHlpSAjJk8UjlYRho7P80Vs7IUs0/O1t4MhXt5Y5R/tb0G2XjzuQb/NjG
 FY5c3PkYqi5MfCYef4UCvnLnIqHBTHtDynRz2gly8yvErESgLobZM5tcaVQzlWiTZKLf
 m0w2XB7fpa148xafb1cfS1v6hMzGTl9FiQluvqGAXIJIEjqs4cs8XBNm6XM4ighWWvvf
 TVyZVKSR4qhEBp7IoP7Qk3kuCgqtNNq5rNeJVJo2s4lKJz4ivwqRzXWdmPrNA1MV9+k0
 PAOQ==
X-Gm-Message-State: AOJu0YywTEWQ0s6qw/MNQfCJys1jj+shh2+rbhRTgE45xERp7Ok8qsGO
 WryEPISs+piKO5AnsMY5V9d1s6vCkI83kv46sorJiTmd++gbGu3Z+QWOpOGWJSrDPZsHVJQ9MyD
 v0fCW
X-Gm-Gg: ASbGncuLb1/BSAhAv3ZOyWiMBmLJSY8TWQhnBID3ZYOCBuX6FsfkBKmVMh2vWVJpRjq
 nyTDFLRLRGAiHRSdWy3wKo1IYl3N4NTM5NyLcFWFPv/CDCezEpIXPhenRdjzXOIvF1lYxumqm1q
 8jl9htx63gRwsn5vkUtxGlO/syvJh4ELOVuO08PziGahIXq/o2tBV1jGLbpVBuIQTi4q/+NI4Kn
 J302RBMoqwadELBj3mjqe8oX6w32RBMqU+nG8p0vjBuKl5lRbg3C1bwp9eIsJF7jsjLp/eYf0wA
 OcWP270hzozKY3VZdjEDatH4icQ5WXHSWt1Ktv535BQ+XioNR3Yaf+M2t1E7aywc6a8ucxTduX2
 IOXmGAdhATtzEa6NJN/6Lp3K3+BpJGnqysV9TXcMbNIApftOzNaZA5gpnF1EStzYqGH8ypepYaJ
 QFsQ9AiSJQHshqCF9B857bYpqswWECSzBGEC78TEs=
X-Google-Smtp-Source: AGHT+IFKnNXGaJEQ8oFQ2Ba3xZgenPUiLX98colZ4biy3E+Lk7Xi/R3hv4D1wnzmDUjdvaK0M9MNHg==
X-Received: by 2002:a17:90b:4b04:b0:340:be4d:8980 with SMTP id
 98e67ed59e1d1-340be4d8f3emr10347400a91.14.1762188563460; 
 Mon, 03 Nov 2025 08:49:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v3 03/44] test: remove unnecessary inclusion of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:08 -0800
Message-ID: <20251103164915.101713-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Those macros are not directly in most of the test code.
Replace with rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/commands.c                  | 2 +-
 app/test/test.c                      | 1 -
 app/test/test.h                      | 2 +-
 app/test/test_atomic.c               | 1 -
 app/test/test_cmdline_lib.c          | 1 -
 app/test/test_func_reentrancy.c      | 1 -
 app/test/test_hash.c                 | 1 -
 app/test/test_hash_functions.c       | 1 -
 app/test/test_link_bonding.c         | 1 -
 app/test/test_link_bonding_mode4.c   | 1 -
 app/test/test_link_bonding_rssconf.c | 1 -
 app/test/test_logs.c                 | 1 -
 app/test/test_malloc.c               | 1 -
 app/test/test_mbuf.c                 | 1 -
 app/test/test_mcslock.c              | 1 -
 app/test/test_mempool.c              | 1 -
 app/test/test_mempool_perf.c         | 1 -
 app/test/test_memzone.c              | 1 -
 app/test/test_mp_secondary.c         | 1 -
 app/test/test_per_lcore.c            | 1 -
 app/test/test_pflock.c               | 1 -
 app/test/test_ring.c                 | 1 -
 app/test/test_rwlock.c               | 1 -
 app/test/test_soring.c               | 1 -
 app/test/test_spinlock.c             | 1 -
 app/test/test_tailq.c                | 1 -
 app/test/test_ticketlock.c           | 1 -
 app/test/test_timer.c                | 1 -
 28 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/app/test/commands.c b/app/test/commands.c
index 497d8e9952..4ebd2cdd70 100644
--- a/app/test/commands.c
+++ b/app/test/commands.c
@@ -10,8 +10,8 @@
 #include <stdlib.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_debug.h>
diff --git a/app/test/test.c b/app/test/test.c
index 8a4598baee..28a5ed1daa 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/queue.h>
 
 #include <cmdline_rdline.h>
 #include <cmdline_parse.h>
diff --git a/app/test/test.h b/app/test/test.h
index c6d7d23313..fdc227d2ce 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -8,8 +8,8 @@
 #include <errno.h>
 #include <stddef.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_hexdump.h>
 #include <rte_common.h>
 #include <rte_os_shim.h>
diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 3f26ce88d9..d98f7b1d09 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_per_lcore.h>
diff --git a/app/test/test_cmdline_lib.c b/app/test/test_cmdline_lib.c
index 87c1059366..67a2d73137 100644
--- a/app/test/test_cmdline_lib.c
+++ b/app/test/test_cmdline_lib.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 
diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index 51e3069611..855ab15bed 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -9,7 +9,6 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..f538053367 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_malloc.h>
diff --git a/app/test/test_hash_functions.c b/app/test/test_hash_functions.c
index 70820d1f19..0d9f1dc0f6 100644
--- a/app/test/test_hash_functions.c
+++ b/app/test/test_hash_functions.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_cycles.h>
 #include <rte_random.h>
diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index 19b064771a..39541b04b0 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -11,7 +11,6 @@
 #include <inttypes.h>
 #include <errno.h>
 #include <pthread.h>
-#include <sys/queue.h>
 #include <sys/time.h>
 
 #include <rte_cycles.h>
diff --git a/app/test/test_link_bonding_mode4.c b/app/test/test_link_bonding_mode4.c
index ff13dbed93..0df83d94d3 100644
--- a/app/test/test_link_bonding_mode4.c
+++ b/app/test/test_link_bonding_mode4.c
@@ -10,7 +10,6 @@
 #include <inttypes.h>
 #include <errno.h>
 #include <rte_cycles.h>
-#include <sys/queue.h>
 
 #include <rte_byteorder.h>
 #include <rte_common.h>
diff --git a/app/test/test_link_bonding_rssconf.c b/app/test/test_link_bonding_rssconf.c
index 693b0ccd12..87924ca96a 100644
--- a/app/test/test_link_bonding_rssconf.c
+++ b/app/test/test_link_bonding_rssconf.c
@@ -10,7 +10,6 @@
 #include <inttypes.h>
 #include <errno.h>
 #include <rte_cycles.h>
-#include <sys/queue.h>
 
 #include <rte_byteorder.h>
 #include <rte_common.h>
diff --git a/app/test/test_logs.c b/app/test/test_logs.c
index 43b09704a3..a02e4b7860 100644
--- a/app/test/test_logs.c
+++ b/app/test/test_logs.c
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdarg.h>
-#include <sys/queue.h>
 
 #include <rte_log.h>
 #include <rte_memory.h>
diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index ce8fc5dd06..c74ebaad10 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -13,7 +13,6 @@
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <sys/mman.h>
 #endif
-#include <sys/queue.h>
 #include <unistd.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index 17be977f31..b057ae79b4 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -12,7 +12,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_errno.h>
diff --git a/app/test/test_mcslock.c b/app/test/test_mcslock.c
index 8fcbc11a08..e88da6d8de 100644
--- a/app/test/test_mcslock.c
+++ b/app/test/test_mcslock.c
@@ -7,7 +7,6 @@
 #include <inttypes.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 63356998fd..94c72ffc06 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -9,7 +9,6 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_eal_paging.h>
diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index e164eca788..775d61461d 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -10,7 +10,6 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 506725ea41..8080501a89 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -6,7 +6,6 @@
 #include <stdint.h>
 #include <string.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 
 #include <rte_random.h>
 #include <rte_cycles.h>
diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..72a50c92e4 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -10,7 +10,6 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/app/test/test_per_lcore.c b/app/test/test_per_lcore.c
index e0674b0e70..a3e56b5c9d 100644
--- a/app/test/test_per_lcore.c
+++ b/app/test/test_per_lcore.c
@@ -4,7 +4,6 @@
 
 #include <stdio.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/app/test/test_pflock.c b/app/test/test_pflock.c
index 162049201f..5fb7f21d50 100644
--- a/app/test/test_pflock.c
+++ b/app/test/test_pflock.c
@@ -6,7 +6,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <unistd.h>
-#include <sys/queue.h>
 #include <string.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index ba1fec1de3..1487093bc4 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -10,7 +10,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_rwlock.c b/app/test/test_rwlock.c
index 785317621d..3bbcd8100e 100644
--- a/app/test/test_rwlock.c
+++ b/app/test/test_rwlock.c
@@ -6,7 +6,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <unistd.h>
-#include <sys/queue.h>
 #include <string.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_soring.c b/app/test/test_soring.c
index 3c1944424e..d75054d95c 100644
--- a/app/test/test_soring.c
+++ b/app/test/test_soring.c
@@ -9,7 +9,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_spinlock.c b/app/test/test_spinlock.c
index 34e0ef9422..5b2064ee9a 100644
--- a/app/test/test_spinlock.c
+++ b/app/test/test_spinlock.c
@@ -7,7 +7,6 @@
 #include <inttypes.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/app/test/test_tailq.c b/app/test/test_tailq.c
index 2ff2877344..edb671a2be 100644
--- a/app/test/test_tailq.c
+++ b/app/test/test_tailq.c
@@ -7,7 +7,6 @@
 #include <stdarg.h>
 #include <string.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_eal.h>
 #include <rte_string_fns.h>
diff --git a/app/test/test_ticketlock.c b/app/test/test_ticketlock.c
index 8ac2e90876..2de7cc71c0 100644
--- a/app/test/test_ticketlock.c
+++ b/app/test/test_ticketlock.c
@@ -6,7 +6,6 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_timer.c b/app/test/test_timer.c
index 3411b7fe20..5efcc7e61d 100644
--- a/app/test/test_timer.c
+++ b/app/test/test_timer.c
@@ -91,7 +91,6 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 #include <math.h>
 
 #include <rte_common.h>
-- 
2.51.0

