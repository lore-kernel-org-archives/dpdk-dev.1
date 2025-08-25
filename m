Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A5ACA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03B5040656;
	Mon, 25 Aug 2025 05:42:31 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id BB920402D0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:08 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3c79f0a606eso674174f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093328;
 x=1756698128; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyCttTjauCF/rRgEUd7SYtkPK+Fveuu99ApE36kY2kA=;
 b=POxz3BHqjxLQdV5AeX9Hji6Amw5nIrYKOxwniIGD94Ua+EMHWMYeLWkFEZ59xYSa29
 +TlzJmY76dXcga5ks/abFGUF1SIHxphw5X11gGIOPCqjRdPe4Y9i5x3poFSN2J185twS
 VvDfAidms/61/wpPQkKZn5/AR8xmGUmpwaOcYbYdwY2LhQ67NPbzNFLkEAn1zjPlo6mE
 K1BTC4sb8lE7jmGtVgcPzjVU1zYnwfKceVjKadFcIktumokpuB54CX72iTCRNKklMdbW
 mDhCjndJqZ5iKJlZjHgf9ZluAmE4/5tNPBzvfx177ugjs0SkZGq25/0QgkxT1jfI2jDH
 lU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093328; x=1756698128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyCttTjauCF/rRgEUd7SYtkPK+Fveuu99ApE36kY2kA=;
 b=D6kg/7tNPVT/6kqAJTlMbGepNHyD76KDbqOoEorEGo17riWLUngpYYCnQl+EdRiwau
 +YtLUyotzMobLnniXDfyLsK5qNmDrcUPMS7ONV2ltLDlRpnyqfVwHrWp3DdmjN0trMl6
 bUi9pTbSAUAUX0TKn51FIsojj8gAb4rHBUmI9bxtTrJqvCjKX+FFxNK2OE6+62OI28vr
 mzqPo95snbPSkjiH5eIhKKcHPs7jaN6AMGQhksJIq55fHuKknX9JDTlQWFxhv3m5oR4Q
 ntY4p0SngJua8y+lNcxd/K97EyhjJ9dOfh7FyGt2w6KwU6VQY89x1Qr9uCCusrMThz2p
 5WUQ==
X-Gm-Message-State: AOJu0YzzB2X7l3IEwJqnV0zpjLas9dLL1s+mzK0rKKw9o3j5I/JSgFpO
 EUD59flGhmsHc4+qOYB3wjRhn27f9aMK1EJfq3+fJ+uOlkLDBAj7bM2e9/YP3hhCjgPy9xlkN/2
 xIcYl
X-Gm-Gg: ASbGncuIxpx+pgTDcRDJvX9Hs58zkdu4u3bj3IGBknZJ4P/jF3HIH82ut972ZMG35BU
 ypn9DyvhN3WFzq6XDI5xLBZ3rLowU2ZX4i1GPbvsaElnOoojjD1HDHNH8oyBA7+hDea42JNzrMg
 5Hm67cA34Sa9ZWsnmJ9fD08Ni5KXhdiS1/ZDN7yJmoZShjWwuJomy9EpwPjys7502EpsZtp7/+T
 s8lwD+0BlXHOlHdJ0/RBA827VLqf6MA9P01DFUrPLRUtXces3STg/knao98oLCidNz48bi52VkJ
 h0TMteMm0kj9uDTH6Ie7qW8sjiBy+ZXaE6Q5GoLnRE+hIs5FvWpRcdcGYBVqNd0PwunR6I94WEU
 Tc2/SKTxdT21sdVZTQw4y3qoOKsvkh0W2y54eHNI0wI3Aim2WeHV/ewcjoQ+l7Jml0F2d+Cu5
X-Google-Smtp-Source: AGHT+IE6lhmGR9Haep+sbwBgTuhu8N6fnqe3//snHAspA097FtXnjZHc/9FEshAd34F8jCgl42xEMQ==
X-Received: by 2002:a05:6000:188d:b0:3c4:edc0:2895 with SMTP id
 ffacd0b85a97d-3c5dd0ecf7amr8388785f8f.62.1756093328279; 
 Sun, 24 Aug 2025 20:42:08 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 David Hunt <david.hunt@intel.com>, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 11/43] lib: remove use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:24 -0700
Message-ID: <20250825034126.12046-12-stephen@networkplumber.org>
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

Use the new rte_bsd_queue.h where needed but most files already
get the needed macros from rte_tailq.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/acl/rte_acl_osdep.h                  | 1 -
 lib/bbdev/rte_bbdev.c                    | 2 +-
 lib/bpf/bpf_load_elf.c                   | 1 -
 lib/bpf/bpf_pkt.c                        | 3 +--
 lib/cryptodev/cryptodev_pmd.c            | 1 -
 lib/cryptodev/rte_cryptodev.c            | 1 -
 lib/distributor/rte_distributor.c        | 2 +-
 lib/distributor/rte_distributor_single.c | 2 +-
 lib/efd/rte_efd.c                        | 1 -
 lib/fib/rte_fib.c                        | 1 -
 lib/fib/rte_fib6.c                       | 1 -
 lib/gpudev/gpudev_driver.h               | 1 -
 lib/graph/graph_private.h                | 1 -
 lib/hash/rte_cuckoo_hash.c               | 1 -
 lib/hash/rte_fbk_hash.c                  | 1 -
 lib/hash/rte_thash.c                     | 1 -
 lib/ip_frag/ip_frag_common.h             | 3 +--
 lib/log/log.c                            | 2 +-
 lib/lpm/rte_lpm.c                        | 1 -
 lib/lpm/rte_lpm6.c                       | 1 -
 lib/mbuf/rte_mbuf_dyn.c                  | 1 -
 lib/mempool/rte_mempool.c                | 1 -
 lib/mempool/rte_mempool.h                | 1 +
 lib/pipeline/rte_swx_ctl.c               | 1 -
 lib/pipeline/rte_swx_pipeline_internal.h | 3 ++-
 lib/pmu/pmu.c                            | 1 -
 lib/reorder/rte_reorder.c                | 1 -
 lib/rib/rte_rib.c                        | 1 -
 lib/rib/rte_rib6.c                       | 1 -
 lib/ring/rte_ring.c                      | 1 -
 lib/stack/rte_stack.c                    | 1 -
 lib/vhost/fd_man.h                       | 1 -
 lib/vhost/socket.c                       | 2 +-
 lib/vhost/vdpa.c                         | 2 --
 lib/vhost/vhost.h                        | 2 +-
 35 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/lib/acl/rte_acl_osdep.h b/lib/acl/rte_acl_osdep.h
index b2c262dee7..96e4f2908c 100644
--- a/lib/acl/rte_acl_osdep.h
+++ b/lib/acl/rte_acl_osdep.h
@@ -21,7 +21,6 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 
 /*
  * Common defines.
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index e0f8c8eb0d..8ef1c84f71 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -5,8 +5,8 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <eal_export.h>
 #include <rte_common.h>
 #include <rte_errno.h>
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index 1d30ba17e2..4e911c5083 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -12,7 +12,6 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/queue.h>
 #include <fcntl.h>
 
 #include <libelf.h>
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..e3cd56f961 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -7,8 +7,7 @@
 #include <errno.h>
 #include <stdint.h>
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
 #include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
diff --git a/lib/cryptodev/cryptodev_pmd.c b/lib/cryptodev/cryptodev_pmd.c
index d79d561bf6..1c6292ed1c 100644
--- a/lib/cryptodev/cryptodev_pmd.c
+++ b/lib/cryptodev/cryptodev_pmd.c
@@ -3,7 +3,6 @@
  */
 
 #include <stdlib.h>
-#include <sys/queue.h>
 
 #include <dev_driver.h>
 #include <eal_export.h>
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index bb7bab4dd5..833f809c03 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2015-2020 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/lib/distributor/rte_distributor.c b/lib/distributor/rte_distributor.c
index dde7ce2677..49ce882cdb 100644
--- a/lib/distributor/rte_distributor.c
+++ b/lib/distributor/rte_distributor.c
@@ -5,8 +5,8 @@
 #include <stdalign.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 #include <string.h>
+
 #include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_cycles.h>
diff --git a/lib/distributor/rte_distributor_single.c b/lib/distributor/rte_distributor_single.c
index d4b3e12648..804d6b8a71 100644
--- a/lib/distributor/rte_distributor_single.c
+++ b/lib/distributor/rte_distributor_single.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdio.h>
-#include <sys/queue.h>
+
 #include <rte_mbuf.h>
 #include <rte_memzone.h>
 #include <rte_errno.h>
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index b0e44e5c51..d7abdda303 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -7,7 +7,6 @@
 #include <stdlib.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_cpuflags.h>
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..e3da524236 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -5,7 +5,6 @@
 
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 93a1c7197b..b351d8cd69 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -5,7 +5,6 @@
 
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/gpudev/gpudev_driver.h b/lib/gpudev/gpudev_driver.h
index 37b6ae3149..6478814fce 100644
--- a/lib/gpudev/gpudev_driver.h
+++ b/lib/gpudev/gpudev_driver.h
@@ -12,7 +12,6 @@
 #define RTE_GPUDEV_DRIVER_H
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <dev_driver.h>
 
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 21912c0ae6..db74ff41d2 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -6,7 +6,6 @@
 #define _RTE_GRAPH_PRIVATE_H_
 
 #include <inttypes.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_eal.h>
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 2c92c51624..dbc0ddcf75 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 38b15a14d1..c4027bee26 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -6,7 +6,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_cpuflags.h>
diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 6c662bf14f..63930f67be 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -3,7 +3,6 @@
  */
 
 #include <stdalign.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_thash.h>
diff --git a/lib/ip_frag/ip_frag_common.h b/lib/ip_frag/ip_frag_common.h
index 51fc9d47fb..ecf29fc02b 100644
--- a/lib/ip_frag/ip_frag_common.h
+++ b/lib/ip_frag/ip_frag_common.h
@@ -5,8 +5,7 @@
 #ifndef _IP_FRAG_COMMON_H_
 #define _IP_FRAG_COMMON_H_
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
 #include <rte_common.h>
 
 #if defined(RTE_ARCH_ARM64)
diff --git a/lib/log/log.c b/lib/log/log.c
index 8ad5250a13..b785156bac 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -11,9 +11,9 @@
 #include <errno.h>
 #include <regex.h>
 #include <fnmatch.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
+#include <rte_bsd_queue.h>
 #include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 6dab86a05e..09d1e08263 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..781ec8de0b 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -6,7 +6,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 5987c9dee8..9a20033021 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -3,7 +3,6 @@
  */
 
 #include <stdalign.h>
-#include <sys/queue.h>
 #include <stdint.h>
 #include <limits.h>
 
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1021ede0c2..bf8e870151 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index aedc100964..e5492a9ce0 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -49,6 +49,7 @@
 #include <rte_ring.h>
 #include <rte_memcpy.h>
 #include <rte_common.h>
+#include <rte_tailq.h>
 
 #include "rte_mempool_trace_fp.h"
 
diff --git a/lib/pipeline/rte_swx_ctl.c b/lib/pipeline/rte_swx_ctl.c
index 4e9bb842a1..ca44adb126 100644
--- a/lib/pipeline/rte_swx_ctl.c
+++ b/lib/pipeline/rte_swx_ctl.c
@@ -5,7 +5,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
 #include <eal_export.h>
diff --git a/lib/pipeline/rte_swx_pipeline_internal.h b/lib/pipeline/rte_swx_pipeline_internal.h
index df864ea066..fa8dfa7d75 100644
--- a/lib/pipeline/rte_swx_pipeline_internal.h
+++ b/lib/pipeline/rte_swx_pipeline_internal.h
@@ -6,7 +6,7 @@
 
 #include <inttypes.h>
 #include <string.h>
-#include <sys/queue.h>
+
 
 #include <rte_bitops.h>
 #include <rte_byteorder.h>
@@ -14,6 +14,7 @@
 #include <rte_cycles.h>
 #include <rte_prefetch.h>
 #include <rte_meter.h>
+#include <rte_tailq.h>
 
 #include <rte_swx_table_selector.h>
 #include <rte_swx_table_learner.h>
diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 4c7271522a..6a18563c80 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
 
diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index be06530860..1c4751bee0 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -4,7 +4,6 @@
 
 #include <stdalign.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..bfb4c0e577 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -5,7 +5,6 @@
 
 #include <stdbool.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index ded5fd044f..1efe19e97c 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -5,7 +5,6 @@
 
 #include <stdbool.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index edd63aa535..b63820dcd2 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -13,7 +13,6 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/stack/rte_stack.c b/lib/stack/rte_stack.c
index 4c78fe4b4b..0b9223cd3f 100644
--- a/lib/stack/rte_stack.c
+++ b/lib/stack/rte_stack.c
@@ -4,7 +4,6 @@
 
 #include <stdalign.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
index eadcc6fb42..0f3f8fb430 100644
--- a/lib/vhost/fd_man.h
+++ b/lib/vhost/fd_man.h
@@ -6,7 +6,6 @@
 #define _FD_MAN_H_
 #include <pthread.h>
 #include <poll.h>
-#include <sys/queue.h>
 
 struct fdset;
 
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 9b4f332f94..107933bfd7 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -10,13 +10,13 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/queue.h>
 #include <errno.h>
 #include <fcntl.h>
 
 #include <eal_export.h>
 #include <rte_thread.h>
 #include <rte_log.h>
+#include <rte_tailq.h>
 
 #include "fd_man.h"
 #include "vduse.h"
diff --git a/lib/vhost/vdpa.c b/lib/vhost/vdpa.c
index bc2dd8d2e1..4e5fcf02be 100644
--- a/lib/vhost/vdpa.c
+++ b/lib/vhost/vdpa.c
@@ -8,8 +8,6 @@
  * Device specific vhost lib
  */
 
-#include <sys/queue.h>
-
 #include <dev_driver.h>
 #include <eal_export.h>
 #include <rte_class.h>
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 6ffc3f20c1..d42796a509 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -8,7 +8,6 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 #include <unistd.h>
 #include <linux/virtio_net.h>
 #include <sys/socket.h>
@@ -19,6 +18,7 @@
 #include <rte_ether.h>
 #include <rte_malloc.h>
 #include <rte_dmadev.h>
+#include <rte_tailq.h>
 
 #include "rte_vhost.h"
 #include "vdpa_driver.h"
-- 
2.47.2

