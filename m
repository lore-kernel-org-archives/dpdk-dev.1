Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7305CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C44B40689;
	Tue, 19 Aug 2025 01:33:11 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 2037E402EA
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:08 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b9e41669d6so3619328f8f.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559988;
 x=1756164788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLRjchzM89sTNIrzX7aWLLAatsvnd0KnClTM9VedWWQ=;
 b=WmOyPOb1WAtJxDDLF3vwzKN7HcgG+V1iC+gHd9DehO0X6i7Z2zE2aKAthRA87J1ugw
 a4i1nEfinjwdRmiai+/nJAvQIszX2lXLQRYpOLwQmng1mb4HF9FVTGkKJuSFujFgqSW5
 5095c5l0ZnLCb/U8jZsB+AunYYyzPpSDSbq7e9VlVdT7WvGuj3RKVm11Y1x9DDw45veN
 6fY482lQJADkULeO8VGvI6OiG3loyTBmLlWMdHgDt52fCxZsdXyGZ9gMSxbTzJQ1ytk2
 6Vla3jUldTtd/cKku8aV81YQ3BRTVWepdOjwNKlNaZOs/3XyH+v8kLuA4evWmT/dCXIf
 U+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559988; x=1756164788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLRjchzM89sTNIrzX7aWLLAatsvnd0KnClTM9VedWWQ=;
 b=on8MmBNni9IHI9pXgqV21Rn3ol5uFOtbVOEtiImL7YBzoLHwJ8JlsaeMwftg0+Hkez
 3oypq5+feARy6bC1kaSx2rRgSF4mPkQaEhjH+ZpXrrA0bSb+00EjnwvXsUrV5u9QCkDv
 CJVrdBG4tb6k2zOEwlIOXz7v0aQVliaZv/NDkkEOc7Wkmn5PAzJkSp2dALLt8pm0OpNH
 3d9fP8Ifyxh8ewDu92xJiwKeYl5S0nGGqOBHBpirF5UUsQ1YZyy22nV7sn7Qgx6S7UKp
 eh+w/spmaRaj47bPp1QKaU3BI4kna0Ye4tiHKTfX5VxtHClXuLgE+Hf0tL5h7LLaJcQN
 x43w==
X-Gm-Message-State: AOJu0YyBzof7btMRBnv7Wzh3ivcNuQ8hybOTmy34dYfgZOfYdsKMEQDJ
 p9Bl9XWcH/L1aGlV6c201s9+QDiOuCi1gx/K0HjBWy9LV1S6r2kgbb4B4XvFe8+IyCZuYUTODYs
 vXVJE
X-Gm-Gg: ASbGnctZ6bCOHHx2tKDPrvAPgephGpHuz30XsYjiPZSSR3uovkkrnYLquxSr2BT6LmF
 H15q5rxUwfWmB7HE3f65EdXDR2JMlCaDBCnWO7S1iCuIONWoOMaN0fGD8ddMMIndF8vDDHa3edS
 bqFAXID7Pl9ej/ZSXgNZERH5oRtucgOoHFoQC9Ad/JVUuLZdRL6W2XFU1DklVVp5wK2/imh5CR7
 nrlWogWELq8LUnpLjP/kB7Aj4W99i4szhY9Al4UfyByPR38wjN5t22x/zpsLcxPu7S/kkRwXvKv
 gtJnrjtyuvKM7EQggcXxL+USrB2LHg0XVvIQr8xc+Q8PO3LkrGjaI+4LxNEyHDxcYCjZPDEnM1c
 vx6lwLOf7ir0oVuYN6pvQIoGQC0PKhwSOra0Zs1H5dv6X5wjl/NA22rlv6bT+W+tkwT7r8CUd
X-Google-Smtp-Source: AGHT+IE7sn5zpjtynC0rOiI7hQOswIITp5Aso1KcgsAWftVkZ7y7NCRYj/BwJWkYfRuiybBEmQngBA==
X-Received: by 2002:a05:6000:2209:b0:3b7:9bd2:7ad6 with SMTP id
 ffacd0b85a97d-3c0ec09e253mr306343f8f.38.1755559987641; 
 Mon, 18 Aug 2025 16:33:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Ori Kam <orika@nvidia.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC 12/47] examples: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:23 -0700
Message-ID: <20250818233102.180207-13-stephen@networkplumber.org>
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

Where macros are actually used directly include bsd_queue.h.
Most places were just copying some other file and doing unnecessary
include of sys/queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/bbdev_app/main.c                                  | 2 +-
 examples/bond/main.c                                       | 2 +-
 examples/cmdline/main.c                                    | 1 -
 examples/cmdline/parse_obj_list.h                          | 2 +-
 examples/flow_filtering/main.c                             | 1 -
 examples/helloworld/main.c                                 | 2 +-
 examples/ip_fragmentation/main.c                           | 2 +-
 examples/ip_pipeline/action.h                              | 2 +-
 examples/ip_pipeline/cryptodev.h                           | 2 +-
 examples/ip_pipeline/link.h                                | 2 +-
 examples/ip_pipeline/mempool.h                             | 2 +-
 examples/ip_pipeline/pipeline.h                            | 2 +-
 examples/ip_pipeline/swq.h                                 | 2 +-
 examples/ip_pipeline/tap.h                                 | 2 +-
 examples/ip_pipeline/tmgr.h                                | 2 +-
 examples/ip_reassembly/main.c                              | 2 +-
 examples/ipsec-secgw/ipsec-secgw.c                         | 2 +-
 examples/ipv4_multicast/main.c                             | 2 +-
 examples/l2fwd-crypto/main.c                               | 2 +-
 examples/l2fwd-event/l2fwd_common.h                        | 1 -
 examples/l2fwd-keepalive/ka-agent/main.c                   | 1 -
 examples/l2fwd-keepalive/main.c                            | 2 +-
 examples/l2fwd-macsec/main.c                               | 2 +-
 examples/l2fwd/main.c                                      | 2 +-
 examples/l3fwd-graph/main.c                                | 2 +-
 examples/l3fwd-power/main.c                                | 2 +-
 examples/l3fwd/l3fwd_em.c                                  | 1 -
 examples/l3fwd/l3fwd_lpm.c                                 | 1 -
 examples/l3fwd/main.c                                      | 2 +-
 examples/link_status_interrupt/main.c                      | 2 +-
 examples/multi_process/client_server_mp/mp_client/client.c | 1 -
 examples/multi_process/client_server_mp/mp_server/init.c   | 1 -
 examples/multi_process/client_server_mp/mp_server/main.c   | 2 +-
 examples/multi_process/hotplug_mp/main.c                   | 1 -
 examples/multi_process/simple_mp/main.c                    | 2 +-
 examples/multi_process/symmetric_mp/main.c                 | 2 +-
 examples/server_node_efd/efd_node/node.c                   | 1 -
 examples/server_node_efd/efd_server/init.c                 | 1 -
 examples/server_node_efd/efd_server/main.c                 | 1 -
 examples/service_cores/main.c                              | 1 -
 examples/timer/main.c                                      | 2 +-
 examples/vhost/main.h                                      | 2 +-
 examples/vm_power_manager/channel_manager.c                | 2 +-
 examples/vm_power_manager/channel_monitor.c                | 2 +-
 examples/vm_power_manager/main.c                           | 2 +-
 examples/vmdq/main.c                                       | 2 +-
 examples/vmdq_dcb/main.c                                   | 2 +-
 47 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 03f15f91cc..f05c8e6ce1 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -10,7 +10,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdarg.h>
 #include <ctype.h>
 #include <errno.h>
diff --git a/examples/bond/main.c b/examples/bond/main.c
index 9f38b63cbb..427bc3ab5e 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <sys/socket.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/examples/cmdline/main.c b/examples/cmdline/main.c
index c04a782507..73ac631901 100644
--- a/examples/cmdline/main.c
+++ b/examples/cmdline/main.c
@@ -8,7 +8,6 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <cmdline_rdline.h>
 #include <cmdline_parse.h>
diff --git a/examples/cmdline/parse_obj_list.h b/examples/cmdline/parse_obj_list.h
index 1223ac1e8b..38a6a77f64 100644
--- a/examples/cmdline/parse_obj_list.h
+++ b/examples/cmdline/parse_obj_list.h
@@ -10,7 +10,7 @@
 /* This file is an example of extension of libcmdline. It provides an
  * example of objects stored in a list. */
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <cmdline_parse.h>
 #include <cmdline_parse_string.h>
 
diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index 13ad17a712..51d8d22900 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -8,7 +8,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/helloworld/main.c b/examples/helloworld/main.c
index af509138da..d53caff23c 100644
--- a/examples/helloworld/main.c
+++ b/examples/helloworld/main.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 1f84102844..f4106288fc 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -9,7 +9,7 @@
 #include <sys/types.h>
 #include <sys/param.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/ip_pipeline/action.h b/examples/ip_pipeline/action.h
index cde17e69a3..c9c400ba9b 100644
--- a/examples/ip_pipeline/action.h
+++ b/examples/ip_pipeline/action.h
@@ -5,7 +5,7 @@
 #ifndef _INCLUDE_ACTION_H_
 #define _INCLUDE_ACTION_H_
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_port_in_action.h>
 #include <rte_table_action.h>
diff --git a/examples/ip_pipeline/cryptodev.h b/examples/ip_pipeline/cryptodev.h
index d00434379e..b9b241045d 100644
--- a/examples/ip_pipeline/cryptodev.h
+++ b/examples/ip_pipeline/cryptodev.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_SYM_C_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_cryptodev.h>
 
diff --git a/examples/ip_pipeline/link.h b/examples/ip_pipeline/link.h
index 34ff1149e0..462f1c1e1b 100644
--- a/examples/ip_pipeline/link.h
+++ b/examples/ip_pipeline/link.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_LINK_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include "common.h"
 
diff --git a/examples/ip_pipeline/mempool.h b/examples/ip_pipeline/mempool.h
index bd46a11ca0..9dc359d2cb 100644
--- a/examples/ip_pipeline/mempool.h
+++ b/examples/ip_pipeline/mempool.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_MEMPOOL_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_mempool.h>
 
diff --git a/examples/ip_pipeline/pipeline.h b/examples/ip_pipeline/pipeline.h
index 89696480fc..da91c53a08 100644
--- a/examples/ip_pipeline/pipeline.h
+++ b/examples/ip_pipeline/pipeline.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_PIPELINE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_pipeline.h>
 #include <rte_table_action.h>
diff --git a/examples/ip_pipeline/swq.h b/examples/ip_pipeline/swq.h
index c8440ee3cd..8733db2da8 100644
--- a/examples/ip_pipeline/swq.h
+++ b/examples/ip_pipeline/swq.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_SWQ_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_ring.h>
 
diff --git a/examples/ip_pipeline/tap.h b/examples/ip_pipeline/tap.h
index 0dce72fe3c..f8a164b787 100644
--- a/examples/ip_pipeline/tap.h
+++ b/examples/ip_pipeline/tap.h
@@ -5,7 +5,7 @@
 #ifndef _INCLUDE_TAP_H_
 #define _INCLUDE_TAP_H_
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include "common.h"
 
diff --git a/examples/ip_pipeline/tmgr.h b/examples/ip_pipeline/tmgr.h
index 1994c55bcc..e8178e6f62 100644
--- a/examples/ip_pipeline/tmgr.h
+++ b/examples/ip_pipeline/tmgr.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_TMGR_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_sched.h>
 #include <rte_red.h>
diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 17ae76d4ba..3723408ad4 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index fe489f9a56..0940ca89c5 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -12,7 +12,7 @@
 #include <netinet/ip.h>
 #include <netinet/ip6.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <signal.h>
diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1eed645d02..1cb00c65aa 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index a441312f55..320838e86d 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <netinet/in.h>
 #include <setjmp.h>
 #include <stdarg.h>
diff --git a/examples/l2fwd-event/l2fwd_common.h b/examples/l2fwd-event/l2fwd_common.h
index 8cf91b919c..3703ed3329 100644
--- a/examples/l2fwd-event/l2fwd_common.h
+++ b/examples/l2fwd-event/l2fwd_common.h
@@ -11,7 +11,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <netinet/in.h>
 #include <setjmp.h>
 #include <stdarg.h>
diff --git a/examples/l2fwd-keepalive/ka-agent/main.c b/examples/l2fwd-keepalive/ka-agent/main.c
index b8a755dbd5..4afbb0897f 100644
--- a/examples/l2fwd-keepalive/ka-agent/main.c
+++ b/examples/l2fwd-keepalive/ka-agent/main.c
@@ -9,7 +9,6 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/wait.h>
-#include <sys/queue.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <time.h>
diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index bff2b99531..985dc30184 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <netinet/in.h>
 #include <setjmp.h>
 #include <stdarg.h>
diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 73e32fc197..4563773342 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index c6fafdd019..8365280734 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 92cdaa1ebe..8bac44209b 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -15,7 +15,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <unistd.h>
 
 #include <rte_branch_prediction.h>
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index e27b8531b5..6c923062b3 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index da9c45e3a4..f3af71adba 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
index fec0aeb79c..ba23a0f32a 100644
--- a/examples/l3fwd/l3fwd_lpm.c
+++ b/examples/l3fwd/l3fwd_lpm.c
@@ -8,7 +8,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index ae3b4f6439..ce0418dfb4 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index ac9c7f6217..d37f4fbc87 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/multi_process/client_server_mp/mp_client/client.c b/examples/multi_process/client_server_mp/mp_client/client.c
index 087c38ef73..0d0aad5c07 100644
--- a/examples/multi_process/client_server_mp/mp_client/client.c
+++ b/examples/multi_process/client_server_mp/mp_client/client.c
@@ -7,7 +7,6 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <string.h>
diff --git a/examples/multi_process/client_server_mp/mp_server/init.c b/examples/multi_process/client_server_mp/mp_server/init.c
index 65713dbea8..6b06754205 100644
--- a/examples/multi_process/client_server_mp/mp_server/init.c
+++ b/examples/multi_process/client_server_mp/mp_server/init.c
@@ -6,7 +6,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <inttypes.h>
diff --git a/examples/multi_process/client_server_mp/mp_server/main.c b/examples/multi_process/client_server_mp/mp_server/main.c
index ebfc2febc5..5de8183767 100644
--- a/examples/multi_process/client_server_mp/mp_server/main.c
+++ b/examples/multi_process/client_server_mp/mp_server/main.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <errno.h>
 #include <signal.h>
 
diff --git a/examples/multi_process/hotplug_mp/main.c b/examples/multi_process/hotplug_mp/main.c
index d668580784..cfdcbe7329 100644
--- a/examples/multi_process/hotplug_mp/main.c
+++ b/examples/multi_process/hotplug_mp/main.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <termios.h>
-#include <sys/queue.h>
 
 #include <cmdline_rdline.h>
 #include <cmdline_parse.h>
diff --git a/examples/multi_process/simple_mp/main.c b/examples/multi_process/simple_mp/main.c
index d73d1358ff..7d033dbd9b 100644
--- a/examples/multi_process/simple_mp/main.c
+++ b/examples/multi_process/simple_mp/main.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <termios.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index f7d8439cd4..d1d553dd8a 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -19,7 +19,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <getopt.h>
 #include <signal.h>
 #include <inttypes.h>
diff --git a/examples/server_node_efd/efd_node/node.c b/examples/server_node_efd/efd_node/node.c
index fc2aa5ffef..4ae218ebf7 100644
--- a/examples/server_node_efd/efd_node/node.c
+++ b/examples/server_node_efd/efd_node/node.c
@@ -7,7 +7,6 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <string.h>
diff --git a/examples/server_node_efd/efd_server/init.c b/examples/server_node_efd/efd_server/init.c
index 9c89f6b60d..d6ded10edf 100644
--- a/examples/server_node_efd/efd_server/init.c
+++ b/examples/server_node_efd/efd_server/init.c
@@ -6,7 +6,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <inttypes.h>
diff --git a/examples/server_node_efd/efd_server/main.c b/examples/server_node_efd/efd_server/main.c
index 75ff0ea532..367fac156c 100644
--- a/examples/server_node_efd/efd_server/main.c
+++ b/examples/server_node_efd/efd_server/main.c
@@ -9,7 +9,6 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <netinet/in.h>
diff --git a/examples/service_cores/main.c b/examples/service_cores/main.c
index 9f52082254..b1d34466d3 100644
--- a/examples/service_cores/main.c
+++ b/examples/service_cores/main.c
@@ -7,7 +7,6 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
diff --git a/examples/timer/main.c b/examples/timer/main.c
index a349846c7c..872c05c7c5 100644
--- a/examples/timer/main.c
+++ b/examples/timer/main.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/examples/vhost/main.h b/examples/vhost/main.h
index c986cbc5a9..2c04576336 100644
--- a/examples/vhost/main.h
+++ b/examples/vhost/main.h
@@ -5,7 +5,7 @@
 #ifndef _MAIN_H_
 #define _MAIN_H_
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_ether.h>
 #include <rte_pci.h>
diff --git a/examples/vm_power_manager/channel_manager.c b/examples/vm_power_manager/channel_manager.c
index 7d7efdd05a..74201f8b23 100644
--- a/examples/vm_power_manager/channel_manager.c
+++ b/examples/vm_power_manager/channel_manager.c
@@ -10,7 +10,7 @@
 #include <dirent.h>
 #include <errno.h>
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
diff --git a/examples/vm_power_manager/channel_monitor.c b/examples/vm_power_manager/channel_monitor.c
index 800f733a26..4b66594139 100644
--- a/examples/vm_power_manager/channel_monitor.c
+++ b/examples/vm_power_manager/channel_monitor.c
@@ -13,7 +13,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/epoll.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <sys/time.h>
 #include <sys/socket.h>
 #include <sys/select.h>
diff --git a/examples/vm_power_manager/main.c b/examples/vm_power_manager/main.c
index c141382020..910cc76670 100644
--- a/examples/vm_power_manager/main.c
+++ b/examples/vm_power_manager/main.c
@@ -12,7 +12,7 @@
 #include <signal.h>
 #include <errno.h>
 
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 #include <rte_common.h>
 #include <rte_eal.h>
diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 4a3ce6884c..50d5348651 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index 4ccc2fe4b0..e5ce027f79 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
-- 
2.47.2

