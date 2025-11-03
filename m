Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6944CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26B6C4068E;
	Mon,  3 Nov 2025 17:49:36 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 4458140698
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:33 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-340564186e0so3951657a91.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188572;
 x=1762793372; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RQ8K3pE8vIWlLGM7mhtk4/fS82DipOKtNcyJPWrCQo=;
 b=oBojeOw8xLw/i9nDwp6NuM9EBVbMvMLHMk+TThJqH6C6QcdgVwxWVU7T0Zo9ZtBxn5
 XDD2rOG8gDC5/bG9tm/OI2qTe87t1TWk0Ai2A9/XQu92SUFGIzf4afPhs3FKRH47aMFP
 L0umFJ42L8VMfbBP8PBhxfL8LOSQY7/QlNu0CbhgGoQLquJImH1yJ2SoiMbCgD+Yh3HV
 ggPAnCi8cZgWt+nbrpkpI3qCM5AcGehw9k397WryxyYKT50ks2wfBS4O47VTwDfd626F
 xiyWYzM51H3/bt9/zVd0KMacmcJ1cwoJ5yB1F1ZYwpLxbv2crLfMF4Bmzso8LR4YUB9t
 PnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188572; x=1762793372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RQ8K3pE8vIWlLGM7mhtk4/fS82DipOKtNcyJPWrCQo=;
 b=X91Y0Ju7KAbYlKK+YUqox04wiDhj0cExsx+mVDiW06Kn3Rj3HXCxc9DKoXzYauxdiJ
 HPbx5UHLgLR89kB0rSyN0scTDXPQAc66dCDmWoBEuEBoeEeUe9nLWzMTQNb1G9InFzQS
 XcpVips/vLrPHUJ5yYKrAbyAr+hxQuu6gEAVZ9HZntWNszjDegBl6DWNqo3xDfILR/do
 AyTtt2OfIbMnPJJoGrJphP/DgWDqsQh2rlyntq4gdQ6LpO9RpcBS+uacMxjyBQf9wZw5
 SrgMCnRiBdQpicGC8qeAe471uxVPQjliKk8juQ8A8xTh9VVzLf7MXFy7M48ApXEbD1e1
 KJyA==
X-Gm-Message-State: AOJu0YzGKc8S9byoy9z+Ajs1brVuNrtMHVf9rjNU43UU7RRFnOJFOxtd
 7o2LQHe2vJLJa/3GUF91w+WGdu2nhRAgJsNujCr3e5QQxuHsR6skLDXTrof8JHn4MIHViSdeW3z
 LIIFe
X-Gm-Gg: ASbGncuy1Ia7pZhLnBTu1qVfyRmIgPtDg2hURVcu4cR638M857ox5BkfLqSFEhvAB2p
 4ufqxdavjhseDd+JODtnRFOu3qTTAmsR+nT9PSM/b7DGYZqU4azM3uZL2nr12UqV5rjasuX/UKw
 Cb/Q9WdywzUwiBgayaYafnPPyvh/+i3uZv1H9pnnjitgidK1RqtHta61qQ/EG5hIe9eWyV6KOO7
 CvJoIUaa71HJ34PL9QET+HN6iFogHIRSVzKIUN2uDwZ04rrkxpnRDIKvo3AhxuqLtkdeUTlM8vT
 K4VlDIrDmwxapAqTbBc0jggNCPlKSgSwHBizPwU5vDWRniNWtIDJ8mcAxxQYxOGqzs2/vf9RSUR
 XvKXjLuyTB27R7xFaZyMVibDWzPzssWc6K4QKmx7WrY1/JcXHpJD60C2HLgADCMuihl9Ue51A7J
 CV20P014R0tsqQWlZTzW8gRM+2SeyFdk4HnP0py/M=
X-Google-Smtp-Source: AGHT+IFMbN962gkOMyk7zKxkJA2hIb2PVH9FHK3JdeBvNjwiGzatiqUP/qAwuHucwPARxP+ArTjcAQ==
X-Received: by 2002:a17:90b:5246:b0:340:fb6a:cb52 with SMTP id
 98e67ed59e1d1-340fb6acc4fmr6735006a91.25.1762188572137; 
 Mon, 03 Nov 2025 08:49:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:31 -0800 (PST)
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
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 09/44] examples: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:14 -0800
Message-ID: <20251103164915.101713-10-stephen@networkplumber.org>
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
index 8ea6596ed4..e1c8a9a35e 100644
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
2.51.0

