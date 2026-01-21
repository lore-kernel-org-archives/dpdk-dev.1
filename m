Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82AEC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5DF642E50;
	Wed, 21 Jan 2026 18:05:58 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 4E6C542E47
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:05:57 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so371435e9.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769015157;
 x=1769619957; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaYuhfuajovHWgw6nfLCiVm0u166KXLip+sWFzprabc=;
 b=3VqwRZZH2CCKjv5NT5J7IyZLxFqIGIzWn1IDkOb/L7A6sT4vWxt5nDAno39L9RTnEM
 GTsD+kSkxMmBMZkKBoky9ijxAoMp6zAKcQCgq/JK/Lfl8t6Ktxul74x/Hpr0B/Cg6j98
 WcsB8kmBE4QL/Sth/jcANxvUWs0BYN/vPG61VrxaAp4fP48B6J/a1s2R9PI7GB2aZ3TR
 zq35xtHSSRQQklWCreWF3pgZOCLmjWRsAdquwuQbgQA5t/YFeEQ3jf8zeIE48u8NONQb
 TzJWp7Gk0CcBe5HTpVCVybzdXmX+CZOgdKCrlo2FbXqoaMPmq3Ul4kONfFA6TlkTsnXD
 sAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015157; x=1769619957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PaYuhfuajovHWgw6nfLCiVm0u166KXLip+sWFzprabc=;
 b=c8t/bYuVKd419wruvSvHKZDdiHTnvcmby6nD84wPUPnAK0f0vhnaZc0np52PNc0QOW
 VYiRl5S0LK1kcNGQiqZr0ytRIKTetNztjepqPHD25ynZiCemtHFlBopWac/9H+R149bV
 ZlTfDrspNsebprCT0y8d9lLoVVnCcQ1cot6oyvq6zp0Wvk58BjJYTJIy04a5ztfepuQ+
 mb8+es8vfQzB3Cv+kG9yA0Rzq9AoVATw1lXaSGyoRyBOVFewOF2tX2dqYkmFaqOxsFmK
 epcHJXfCHVS1PI4BVoTMLYNuFSrsphsvmDfmZ3Ddd9x6j8mGXHRI8TmIxPr9Z+6aGAeG
 k9Rg==
X-Gm-Message-State: AOJu0YxV0Ar6VaeMHVSGz8d4sw1+v2IvK+nWxebZc4J1ky9ANfr9gL22
 lMxGpEHz52X3FxNXkQ4JiuqQnllb4WUrKNsn87qPQUnCvzladB872XQLwydURIRCNfmPM0VnD+2
 WvGc+
X-Gm-Gg: AZuq6aIwzv8TvUvoFNXC6Qv4QJYoAlk1q+FGwwwCvBstV8X1SfUGuTjI2J3UeLKhhmj
 WcBhjUrSecr8uxZZHgnk59hcaBv8PYzH1u2UF5tBTQTiV+ZsDv/2XW5A3jbJH3QaTJLrcn8MhFF
 etearRXgV6N81MmXZ0y/EX0sOjp8zp0LF+k/1GPKkKVnTqaG2MmT/kEAFIa7GLyaAeRC8J7zJdJ
 l0dm6drVX5Of9gtz6S+hWppNbwiPrqYpMF4v0H1ERGHJZ5oauElisu9ejum2NZAmruwAFITPTs7
 Dh2mypRplSyhUSjWRStdtJ8ofG8NPoilqY6WOCklm6yF0BsozvQfPybfPMR6B7HJsGk7UAEbC5N
 Ja7awbDj6TBRueYWMd5bY8x21aVt8cAZnv26nUxnHMUwvDsmjWYdjGFKBSfqPY1/9QeF7aKSeqY
 kaxqSEhqa3zoesGmobIfSUdzXCHIgImFfM9fMymU0Kw96vOf6Gxw==
X-Received: by 2002:a05:600c:a403:b0:477:a246:8398 with SMTP id
 5b1f17b1804b1-4803ea5bcd4mr78221635e9.2.1769015156804; 
 Wed, 21 Jan 2026 09:05:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1e381sm25653555e9.11.2026.01.21.09.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:05:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH 4/4] examples: remove unnecessary include
Date: Wed, 21 Jan 2026 09:04:57 -0800
Message-ID: <20260121170540.785735-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121170540.785735-1-stephen@networkplumber.org>
References: <20260121170540.785735-1-stephen@networkplumber.org>
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

All these examples include rte_memcpy.h but do not use
that function.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/bond/main.c                                     | 1 -
 examples/ip_fragmentation/main.c                         | 1 -
 examples/ip_reassembly/main.c                            | 1 -
 examples/ipv4_multicast/main.c                           | 1 -
 examples/l2fwd-cat/cat.c                                 | 1 -
 examples/l2fwd-event/l2fwd_common.h                      | 1 -
 examples/l2fwd-jobstats/main.c                           | 1 -
 examples/l2fwd-keepalive/main.c                          | 1 -
 examples/l2fwd-macsec/main.c                             | 1 -
 examples/l2fwd/main.c                                    | 1 -
 examples/l3fwd-power/main.c                              | 1 -
 examples/l3fwd/main.c                                    | 1 -
 examples/link_status_interrupt/main.c                    | 1 -
 examples/multi_process/client_server_mp/mp_server/init.c | 1 -
 examples/multi_process/client_server_mp/mp_server/main.c | 1 -
 examples/multi_process/symmetric_mp/main.c               | 1 -
 examples/qos_sched/app_thread.c                          | 1 -
 examples/qos_sched/main.c                                | 1 -
 examples/server_node_efd/efd_server/init.c               | 1 -
 examples/server_node_efd/efd_server/main.c               | 1 -
 20 files changed, 20 deletions(-)

diff --git a/examples/bond/main.c b/examples/bond/main.c
index 9f38b63cbb..4e8eeb7a5e 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -21,7 +21,6 @@
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 1f84102844..2180682373 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -18,7 +18,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 25b904dbd4..520fbea1c2 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -19,7 +19,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1eed645d02..bd4c3f335b 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -17,7 +17,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/l2fwd-cat/cat.c b/examples/l2fwd-cat/cat.c
index ac8feaec8e..5beee22159 100644
--- a/examples/l2fwd-cat/cat.c
+++ b/examples/l2fwd-cat/cat.c
@@ -12,7 +12,6 @@
 #include <stdio.h>
 
 #include <rte_common.h>
-#include <rte_memcpy.h>
 
 #include <pqos.h>
 
diff --git a/examples/l2fwd-event/l2fwd_common.h b/examples/l2fwd-event/l2fwd_common.h
index 8cf91b919c..f4f1c45cd1 100644
--- a/examples/l2fwd-event/l2fwd_common.h
+++ b/examples/l2fwd-event/l2fwd_common.h
@@ -24,7 +24,6 @@
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index 308b8edd20..a7cd5b4840 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -13,7 +13,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index bff2b99531..993e0bf9da 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -21,7 +21,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 73e32fc197..98763440bc 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -21,7 +21,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index c6fafdd019..59ea3172ae 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -21,7 +21,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index ec12d1cc0b..02ec17d799 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -21,7 +21,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index a5626ff02d..4c64194794 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -22,7 +22,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index ac9c7f6217..aa33e71d7a 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -19,7 +19,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_launch.h>
 #include <rte_cycles.h>
diff --git a/examples/multi_process/client_server_mp/mp_server/init.c b/examples/multi_process/client_server_mp/mp_server/init.c
index 65713dbea8..f3b9b49380 100644
--- a/examples/multi_process/client_server_mp/mp_server/init.c
+++ b/examples/multi_process/client_server_mp/mp_server/init.c
@@ -24,7 +24,6 @@
 #include <rte_ring.h>
 #include <rte_log.h>
 #include <rte_mempool.h>
-#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_interrupts.h>
 #include <rte_ether.h>
diff --git a/examples/multi_process/client_server_mp/mp_server/main.c b/examples/multi_process/client_server_mp/mp_server/main.c
index ebfc2febc5..691d453d0e 100644
--- a/examples/multi_process/client_server_mp/mp_server/main.c
+++ b/examples/multi_process/client_server_mp/mp_server/main.c
@@ -24,7 +24,6 @@
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <rte_mempool.h>
-#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_ether.h>
 #include <rte_interrupts.h>
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index f7d8439cd4..7314a9c6ea 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -37,7 +37,6 @@
 #include <rte_ether.h>
 #include <rte_ethdev.h>
 #include <rte_mempool.h>
-#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
diff --git a/examples/qos_sched/app_thread.c b/examples/qos_sched/app_thread.c
index e50cc33fde..e9db70bb3c 100644
--- a/examples/qos_sched/app_thread.c
+++ b/examples/qos_sched/app_thread.c
@@ -9,7 +9,6 @@
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
-#include <rte_memcpy.h>
 #include <rte_byteorder.h>
 #include <rte_branch_prediction.h>
 #include <rte_sched.h>
diff --git a/examples/qos_sched/main.c b/examples/qos_sched/main.c
index b3c2c9ef23..e756ce0da2 100644
--- a/examples/qos_sched/main.c
+++ b/examples/qos_sched/main.c
@@ -10,7 +10,6 @@
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
-#include <rte_memcpy.h>
 #include <rte_byteorder.h>
 #include <rte_branch_prediction.h>
 
diff --git a/examples/server_node_efd/efd_server/init.c b/examples/server_node_efd/efd_server/init.c
index 9c89f6b60d..9a20831a0d 100644
--- a/examples/server_node_efd/efd_server/init.c
+++ b/examples/server_node_efd/efd_server/init.c
@@ -24,7 +24,6 @@
 #include <rte_ring.h>
 #include <rte_log.h>
 #include <rte_mempool.h>
-#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_interrupts.h>
 #include <rte_ether.h>
diff --git a/examples/server_node_efd/efd_server/main.c b/examples/server_node_efd/efd_server/main.c
index 62c3f4a16d..70a7372d4a 100644
--- a/examples/server_node_efd/efd_server/main.c
+++ b/examples/server_node_efd/efd_server/main.c
@@ -26,7 +26,6 @@
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <rte_mempool.h>
-#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_ether.h>
 #include <rte_interrupts.h>
-- 
2.51.0

