Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB5CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:41:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EB68402AE;
	Mon, 25 Aug 2025 05:41:52 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 5B059402D8
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:41:43 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c7ba6c2b2cso702071f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093303;
 x=1756698103; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7OpDvAZFBrKl8TnRqILyFZ0aXz8/eYhlea0FTElE7g=;
 b=OIbRhozg5S2SG90HIfBmQznKCuuCRhrm7WkB4fu+qCLg+luw6NmIT6tHVvfJq+1gdr
 TpuXw3e9so5C6Zxbn1iQ7tpG1sf07szfDldU2/J5fb+HUM4b3TEzjdWGv6AhkcO4FYmh
 z8pVu8v6Tr0uqfMUewE2QUE2S3Ntbhm9Apx0jUyHsMtud+hXuWc3JWlZ59mjO48Idssd
 5Msiv/ZRU2G6RmTSr2OqQhDABJI5ZkPkVYcRzUxcIag7H9l27bppI1fqL8WdSyu2twFr
 X2oyPqmxosn1uRUQw/kQoC2J0xgdFORW0s/hUF+mqje+LAgQmTLG4cYzkUlCATaabwsU
 V1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093303; x=1756698103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7OpDvAZFBrKl8TnRqILyFZ0aXz8/eYhlea0FTElE7g=;
 b=bBAOBSQDuea8d9hlD+TmjDApSuOMMJp2khg2QoFbEJ7zGtVWl+WdTYq16siO7RfPvY
 RCrE2KOB9MrI+/yHdNz0ZOwnT/Ugb4m7daKMiDqqzxjLV1Bdx54B0i8lICmEZ58tybqA
 kSFmg5DMJYVwqLiwZhIdCTT58kzmvp4TfifhZUava3klfgA6Uj6rGz3ckdAFoDuBssF9
 ofKJ0JDzLdFtLFcW/BqdhnB9g/blI/9ScPqP/Q+IARnPxcGKJyTyGuxesF73HBR5nXgt
 xE88nZq6wIOHhlp6VJki29YsOuzsMUfB0mNtFZ8TMhsuj7RJ+EawJNrQrrty0WCmXHdN
 b74Q==
X-Gm-Message-State: AOJu0Yz6nXW8efPWod3ybXIaCVAYR7dZGmLgBvDwpPhCRKjZe0jqn/+n
 T0J+wgkLvVzTDk864K8rNSLb5Oe8cRDjSvIp+m7kwVG5Y/sWv7IuKXbdHudo2xWMgFoJK9lB2m3
 D6llC
X-Gm-Gg: ASbGncsWH0Dvp8AfXLYO7xBX+Ht3fIiULZwHovn4n0J+XFT19AJqXXXG0ShV957dM9N
 5V5xwDQMBd499lT+nqiC1inqnpzEBuK6jxPiqU0E7ML2s/1O5RJYnbZcxrMNCdpXvAGvcsHc6RI
 rsHCpeAlm1TP5k18IYQz/QDSBh/EhQ/0JWolXSPWjxSGap2U2UOiHJoJ/STwdAr7fd0d5Sa3ZMO
 PlrhsVTxPOBf6/O/1iS2XKG4BZagRnX7TuyuaBJeqg5XQYEmoHZQEcxf8nkLmOC2ySMKxfKtDCB
 th5h2HfU/9/H0gfB03D/Jpn99ILaao4KvuIVeSz60dEmp8ONWc93Vz2ssrX4ZDwBs07ECgkLsto
 zizK1YgkHrPUCkxXhNoDIs3RE9/2Xwmj6fF5Xj6HjBwqmnJYYAaqUhx3Hd3M78N7WBS8/ysJSXs
 VeeR1ajaM=
X-Google-Smtp-Source: AGHT+IE9LtirrouzxsfunGse/pUIAWPdVZVJrFJPO5MFjgFpiLnWNs0NIgWPp4gI0FodnZZznzM+Gg==
X-Received: by 2002:a05:6000:2282:b0:3c7:2768:2e15 with SMTP id
 ffacd0b85a97d-3c7276830d5mr4173579f8f.4.1756093302883; 
 Sun, 24 Aug 2025 20:41:42 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:41:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v2 03/43] test: remove unnecessary inclusion of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:16 -0700
Message-ID: <20250825034126.12046-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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
index fd653cbbfd..b3a15529d9 100644
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
index ebc4864bf8..23092a78ab 100644
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
index 34d685d493..c7f359e360 100644
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
index 2cb689b1de..50bdc909f5 100644
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
index 61385e096e..6e6431e422 100644
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
2.47.2

