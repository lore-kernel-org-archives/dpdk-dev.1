Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B8CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31B694064E;
	Mon, 25 Aug 2025 05:42:22 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 2907D402D0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:01 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3c51f015a1cso1798424f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093321;
 x=1756698121; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A85tMucwQbAfwWPsi+7AVjM75Be5XAHqEVpx/J2KLmQ=;
 b=lneLGTyJOC3gkg/sdh4izZD1K/rYo67khWA7+sk1CaArLNnvlfRJrPq9kbAn0Frxft
 jm+UlR8XmAqNFDYs/c1pEiS3O8xXRpAvjjEEdfw8gn5OZFXLqWayGm8aiqwmz7+jWcEO
 po5/cgUQCQLT9HqkP5aaLmmHccEwRCX3JHEDd97EUT9vWAKgHbgL8FXJX2p3Iy7lo00n
 GppUxFJSNl0lNRBFjcQDuZ8CDRtfKe4Rw22wywxOOYKkS9/a/o1+wzAGk9dWIQmn8i7T
 Iik+J7FYAnJcewA2iddnOParbdFGUVNk7jOp1OE60hjpqo2TmYDEOxlGT1wOctpdn6UU
 3neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093321; x=1756698121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A85tMucwQbAfwWPsi+7AVjM75Be5XAHqEVpx/J2KLmQ=;
 b=OFLHPOydC7PjqmDFzy6tiMpVKDZr7K+/QeJfPbLO0ZiFVlXNJ+OWR+A/wcWqHDf/go
 cKip6sAVHcsTT02hjkrjJx93UoIc0YjBeRPWrobky7akhQ/EWl4/QCtGlZkYI3OXWJW8
 s62zjsAUsda9fLcBj5BHGDMh48bMUgNJZB9b1X+aKdFoSYzZTzj73kz0EyTT545KP/iK
 XWC+ni68UukOIRb7kWZXN5QQIBCqx5pF2yNy9rRuk57uf1yNv4WN5JjHPflBXwCQ9ted
 3LZl+aN4d88Vez3ULyH7CMlgBfbhL+1xqRzQp5Eken+0dQw5R/L3QxrSsTjjQSXnegHU
 QMvA==
X-Gm-Message-State: AOJu0YzIdpOA1ep1+M20xkkh7yapI2e0b5swZePEBGuPIwzZuDAGY3g6
 i6aumhLq4+wAzw996a+dqaXlQIGHnHQdjxhsE1FVoOA9Ym6JODRCGotXmqVsdOU5IAJCG/Jam5J
 H6SLC
X-Gm-Gg: ASbGncu/NGldS+S6tTSh/SuAOFmyylAVZE/oYZPn3LYT/5QlEdHTK5KnPT+o3uL8i1t
 qmcUpT3DHoprZyLxBCwcwEQ57JQ1xu7PwkM0CqRuXJqdAhcEuV33VDw0sFg5LVCttrwpKhNjmIv
 RaMmST2fmUpj1PKUgDq/YU9NgbIEhQChNKsjV8wCX5AUGBn2wuQdVU9nU3sm+Na/PAdtTFMsuo4
 tnD8icKkPzephTXFpebgVNuhMekUB2AX76IVOtg35GyMhG1wb+u1lrT1paMofvTP9pmEEUj2NwQ
 1V6jHdmoogxVofEyoPY6gUhKorSZ4r44Mqx/q+Z8b/nedwL/vTTO9tOUoGl6OhUGW6zz2rLJr67
 b97sNLMaFp4nwRflrUp36tf9DMuI8MP0T/94qrhzYZRLK/X3BxwkqS8279ebRytsz7qgNXT2C
X-Google-Smtp-Source: AGHT+IHqbz6L/HT20LxihnHekVMKfyHjSr+Q8jf99e2TadYaLAgQhfbnpjEIaHv6pas8SQrHV64PjA==
X-Received: by 2002:a05:6000:1883:b0:3c0:4f30:acde with SMTP id
 ffacd0b85a97d-3c5dcff535cmr6555723f8f.55.1756093320619; 
 Sun, 24 Aug 2025 20:42:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:00 -0700 (PDT)
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
Subject: [PATCH v2 09/43] examples: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:22 -0700
Message-ID: <20250825034126.12046-10-stephen@networkplumber.org>
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

Where macros are actually used directly include rte_bsd_queue.h.
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
index 03f15f91cc..4e788e842e 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -10,7 +10,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdarg.h>
 #include <ctype.h>
 #include <errno.h>
diff --git a/examples/bond/main.c b/examples/bond/main.c
index 9f38b63cbb..e168b6adf7 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
index 1223ac1e8b..a7a7e586af 100644
--- a/examples/cmdline/parse_obj_list.h
+++ b/examples/cmdline/parse_obj_list.h
@@ -10,7 +10,7 @@
 /* This file is an example of extension of libcmdline. It provides an
  * example of objects stored in a list. */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
index af509138da..630c757ba9 100644
--- a/examples/helloworld/main.c
+++ b/examples/helloworld/main.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 1f84102844..ca80b4163a 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -9,7 +9,7 @@
 #include <sys/types.h>
 #include <sys/param.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/ip_pipeline/action.h b/examples/ip_pipeline/action.h
index cde17e69a3..bffea3de4c 100644
--- a/examples/ip_pipeline/action.h
+++ b/examples/ip_pipeline/action.h
@@ -5,7 +5,7 @@
 #ifndef _INCLUDE_ACTION_H_
 #define _INCLUDE_ACTION_H_
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_port_in_action.h>
 #include <rte_table_action.h>
diff --git a/examples/ip_pipeline/cryptodev.h b/examples/ip_pipeline/cryptodev.h
index d00434379e..e3759a5283 100644
--- a/examples/ip_pipeline/cryptodev.h
+++ b/examples/ip_pipeline/cryptodev.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_SYM_C_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_cryptodev.h>
 
diff --git a/examples/ip_pipeline/link.h b/examples/ip_pipeline/link.h
index 34ff1149e0..d3811f5b34 100644
--- a/examples/ip_pipeline/link.h
+++ b/examples/ip_pipeline/link.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_LINK_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include "common.h"
 
diff --git a/examples/ip_pipeline/mempool.h b/examples/ip_pipeline/mempool.h
index bd46a11ca0..d665cc43e7 100644
--- a/examples/ip_pipeline/mempool.h
+++ b/examples/ip_pipeline/mempool.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_MEMPOOL_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_mempool.h>
 
diff --git a/examples/ip_pipeline/pipeline.h b/examples/ip_pipeline/pipeline.h
index 89696480fc..bffba64ceb 100644
--- a/examples/ip_pipeline/pipeline.h
+++ b/examples/ip_pipeline/pipeline.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_PIPELINE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_pipeline.h>
 #include <rte_table_action.h>
diff --git a/examples/ip_pipeline/swq.h b/examples/ip_pipeline/swq.h
index c8440ee3cd..7bcbb58496 100644
--- a/examples/ip_pipeline/swq.h
+++ b/examples/ip_pipeline/swq.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_SWQ_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_ring.h>
 
diff --git a/examples/ip_pipeline/tap.h b/examples/ip_pipeline/tap.h
index 0dce72fe3c..3faa7533db 100644
--- a/examples/ip_pipeline/tap.h
+++ b/examples/ip_pipeline/tap.h
@@ -5,7 +5,7 @@
 #ifndef _INCLUDE_TAP_H_
 #define _INCLUDE_TAP_H_
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include "common.h"
 
diff --git a/examples/ip_pipeline/tmgr.h b/examples/ip_pipeline/tmgr.h
index 1994c55bcc..e8c0661894 100644
--- a/examples/ip_pipeline/tmgr.h
+++ b/examples/ip_pipeline/tmgr.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_TMGR_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_sched.h>
 #include <rte_red.h>
diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 17ae76d4ba..3343ad4bd5 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index fe489f9a56..96bdd1a330 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -12,7 +12,7 @@
 #include <netinet/ip.h>
 #include <netinet/ip6.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <signal.h>
diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1eed645d02..a4058d48f3 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index a441312f55..6d456daaf9 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
index bff2b99531..4e20a77e3d 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <netinet/in.h>
 #include <setjmp.h>
 #include <stdarg.h>
diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 73e32fc197..531cf02e6b 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index c6fafdd019..dd189e16bc 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 92cdaa1ebe..3d70718c1d 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -15,7 +15,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <unistd.h>
 
 #include <rte_branch_prediction.h>
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index e27b8531b5..772675bde7 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
index ae3b4f6439..cf6248084a 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index ac9c7f6217..21bb0cb69d 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
index ebfc2febc5..67371c7b9d 100644
--- a/examples/multi_process/client_server_mp/mp_server/main.c
+++ b/examples/multi_process/client_server_mp/mp_server/main.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
index d73d1358ff..e648dfac37 100644
--- a/examples/multi_process/simple_mp/main.c
+++ b/examples/multi_process/simple_mp/main.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <termios.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index f7d8439cd4..55ff7de5c2 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -19,7 +19,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
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
index a349846c7c..e14584e764 100644
--- a/examples/timer/main.c
+++ b/examples/timer/main.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/examples/vhost/main.h b/examples/vhost/main.h
index c986cbc5a9..dc9388b4fe 100644
--- a/examples/vhost/main.h
+++ b/examples/vhost/main.h
@@ -5,7 +5,7 @@
 #ifndef _MAIN_H_
 #define _MAIN_H_
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_ether.h>
 #include <rte_pci.h>
diff --git a/examples/vm_power_manager/channel_manager.c b/examples/vm_power_manager/channel_manager.c
index 7d7efdd05a..18e4fc65c3 100644
--- a/examples/vm_power_manager/channel_manager.c
+++ b/examples/vm_power_manager/channel_manager.c
@@ -10,7 +10,7 @@
 #include <dirent.h>
 #include <errno.h>
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
diff --git a/examples/vm_power_manager/channel_monitor.c b/examples/vm_power_manager/channel_monitor.c
index 800f733a26..a5390d5b4f 100644
--- a/examples/vm_power_manager/channel_monitor.c
+++ b/examples/vm_power_manager/channel_monitor.c
@@ -13,7 +13,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/epoll.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <sys/time.h>
 #include <sys/socket.h>
 #include <sys/select.h>
diff --git a/examples/vm_power_manager/main.c b/examples/vm_power_manager/main.c
index c141382020..cea7da9471 100644
--- a/examples/vm_power_manager/main.c
+++ b/examples/vm_power_manager/main.c
@@ -12,7 +12,7 @@
 #include <signal.h>
 #include <errno.h>
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 #include <rte_common.h>
 #include <rte_eal.h>
diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 4a3ce6884c..cab0351d72 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index 4ccc2fe4b0..3fa9f5f045 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
-- 
2.47.2

