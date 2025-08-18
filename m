Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A9CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AB4A4065E;
	Tue, 19 Aug 2025 01:32:45 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 7B2714065E
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:44 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so34270145e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559964;
 x=1756164764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzRJmwOkI9LB8iWn92EPz+3YfAxJg++1zDWbq8yx5KU=;
 b=yuhK2ul1S9OgP13yQHp0neIIyBf++16hKdXW7+nNbWNdeiCMhJRkvj2IxB0Mujq5t7
 413+dzuRAvBxp90eumg4Ns0TuZ7KiqMBT48YWX9irDDnsrt5cB0O6d9J5+QRJ8XI0CXs
 Mgdo9LnChtO6iVpzUCLBw2jbxAbVGVXeARcWuOondESbF9OkEg2yzK8OssbMHt65277J
 RhM2/jGtFUZwv5LNBDuPQMo9cPcJVBLf4mvVFDeF/r2pX1Mi5bCrkPSN7TBZ36l389sc
 NMR9fPoGd+ACtNB1YKu7L6uAyYW920EYkuOeOH82epBzaSIL4JUEcQ7+sdXBLEljUY0J
 zH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559964; x=1756164764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzRJmwOkI9LB8iWn92EPz+3YfAxJg++1zDWbq8yx5KU=;
 b=ZWGA0x0evAAw9Dc8qYrIvdqSMzHJJq4RNjTk1W/VQhA1aMicyrdAEKWpYqUn3BYGU3
 D2g6Xe2ZFnlzHApwC6WjKVMWiqvi7zUcFr4CmRJ9320rOYwutx6ACSw1bSRG83EJmV0G
 Z0pe0T1j+R5XMiPYR92swWE9xKVx0ef1/PHfW+k3O8zqx3xr41fw6n924pRONo4NRiCp
 egi6L2kYpzg6DyJQngYkJAfk0AYjXcO7kCQ/I8qXhUQrdUTDFV6WLZQyaqykmiduv6EC
 XROO5MgyjHEobfl96ShuFtB48O3sCuV0qqxex4GU4FiP2nrNWaWPzfnpWp5yJQ5KdLfm
 E6Vg==
X-Gm-Message-State: AOJu0YxqAmjO6ZLuwNPstrRtnuDaRk5+2foWrjFwxVT07w8Dv9YOGrlW
 Mv8wHElB0w1y6+2JpcQtocs/+eH3Dx3k3sgWeNpSYkvaO6kC30NcKgqx7tqbakjQmbYMJ9wzVym
 aNcfM
X-Gm-Gg: ASbGncuUmVomWDj4ms/y0tO5mkZf8i8ht0PHaxExYg3JHDOaivo5QT7m+kxuCVr1LXU
 XST5z7JK0LbIxdDWhJMw1ZSNLxVUg3pJZ3Q3Atar2saSwNFkRTpLFs9jg/rVtb1oOPjuygMJ2jH
 E6LSz4QytUBTe8CZTN8aIyXN2AIVeFXqoOQ6g5fiQz1He6HJransL3uTwWuKqxYBba9oliGLQPh
 avt8W1WeK6/6Fqs6Wcrwpw3I6Aafs7/mDvz6r0j/p5++oPzljSWw5qxbobNjRx/Tt21Lopdz3sL
 c10tjmNttW6+biri8OEKhWX4jv1a+i/slbjov8AOtRcZg5aFdyjRcYvbvvP57wrPhNHBu/Gnd4g
 HZEMqLL3/h61folG9B0qiYfbZcmrM0j3HcMokrhCDPPEXS+qh1JUj0PYZG+zfB7X+dRHNWWMDq7
 ai5f43Tlw=
X-Google-Smtp-Source: AGHT+IGfPUf2vve1TJvbpy43Z0KIeQpZmqItcnL9YB7CtGeBgpZ9ewqMXFrIloov5tXYPMqzPK/39Q==
X-Received: by 2002:a05:600c:468d:b0:459:e025:8c40 with SMTP id
 5b1f17b1804b1-45b43dbbf10mr2468325e9.10.1755559964026; 
 Mon, 18 Aug 2025 16:32:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [RFC 04/47] test: remove unnecessary inclusion of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:15 -0700
Message-ID: <20250818233102.180207-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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
index 497d8e9952..6328ff3ed6 100644
--- a/app/test/commands.c
+++ b/app/test/commands.c
@@ -10,8 +10,8 @@
 #include <stdlib.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
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
index ebc4864bf8..a8a1ac9e76 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -8,8 +8,8 @@
 #include <errno.h>
 #include <stddef.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
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

