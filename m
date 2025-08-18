Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F9CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 457D640A6C;
	Tue, 19 Aug 2025 01:33:29 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 46EFC40657
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:27 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso38494995e9.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560007;
 x=1756164807; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/mFHrtNJjlAo51mhVaekN8vwNA90gESjV1x+Esp4QE=;
 b=nHZ3oaxz+m9xyhzb+OIVGCeqGYrAfZuL6Q6vWtckWt1/H2NSbZqINJ3BK7fvFYrlhR
 3XpeDbVAfTxopp5OmLbmyZnGyeHUiKj0XD7NXWP50xM1Cjh3yB7/JFmZ+lZsY1COJXlH
 SD5TPSAe+7p8Q3p9ZM2AsrSdEidXyaMaMCdPKyMzzgqDqqf6paGcgzPMurBnInecnNL5
 +fq2365GcqO9tBQGBiyXux/P7lncnyzLe/AC7RCrllXOlowzyuACN0ul+Axl9dMI0LBH
 7/BkNpWPmHNTc+G1M+W/XXd2AMSjZ3aIXZ/FAEsXksFY3gvYxXTGgs4yTZzv0esaM4Rk
 KADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560007; x=1756164807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/mFHrtNJjlAo51mhVaekN8vwNA90gESjV1x+Esp4QE=;
 b=YpCuybkZWIZPcmZ7xOskqv83Yzdhzbu5dz8nVjxymYe4R5X4jBFESrdiWxVUoslLkM
 P2sO/fQjMNuhL5DNMr1kZkrcJSczRX1dBTyoE+T5y/O6oBZfzXtTnOfN/sa5/rSVn4y8
 PjhVz0TZQVIuJvQ++pXbgsAjkuX1xwhVohEWt1M7vj7AEKYA0arX6LzGU4hgfN1dtaAI
 tuRuwbGMgy+S2IN0ogTyJ2GCsGo5u6pZ5vrF5gW3uR8LdSuv9ox0Q+t23WBXuH9ljtQH
 6Srp5SpgxDIGWTdFkUUzD9e/df7j0Ed4QEA0Weqe838VFrvRfCM+LrLu3moR71U+tGIQ
 YXlQ==
X-Gm-Message-State: AOJu0YxT5SFKQb9ZOx82unnzHPN+CSngYiPgC4pM65q70XSSoCiUkqTF
 A33KdegpYM2HnJq/xLcXhceHMEKHdH9hDd0xoO8BTiIXT/2WbW+okwaGaLKIZHpslBwiaDCvyW0
 i53Df
X-Gm-Gg: ASbGncvBIIfRDogs9vaqUt9829WdQhbBcWqdWqr5ndUJWP+Lkg9K9pQOzlO87ftNJBl
 hU1zzpHZ67c0LbhchhqC++nwi84yITxIRoh6E/8cnnBJ6Mb3w+gz4nHqLUIQ0QhqlVhHW/iHt8A
 +wz+Kpf+7NNrXnEbNJ5EZ70Sxu/qOz1JR7EfNQ9SrAZH+G38iwS7Lsp1kHo6tO0bJrwWkE9/iaO
 oa1j6mJYGI1Xis/0ose1+/99Rw+njaUPqKQKYfFGxABITn9vIk9D3U8dAsBg5CKHXm/Kslrl0/E
 9jp+n9BwGMg+XVVRVF65K9J3dXvT4kLbzhc70nKtVocHukUThy8AD3gAZWKCuAGmdLokB4+gETG
 9zqBNdrmrU9kO+DCX9d9saZzTlDWZ8rA/r4JCvRcQ7G5WByYv9jdiiD/rMQUY8Gtio0eaknS2
X-Google-Smtp-Source: AGHT+IG70edrmErDXPd58jY9NG6bZBuhKwVvKrA2KYg1gGNHxCh/DYHqRD3LtNlMUIzz/XYdYX5iuw==
X-Received: by 2002:a05:600c:1f83:b0:455:fc16:9eb3 with SMTP id
 5b1f17b1804b1-45b43e10c10mr2083965e9.33.1755560006857; 
 Mon, 18 Aug 2025 16:33:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:26 -0700 (PDT)
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
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC 19/47] lib: remove use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:30 -0700
Message-ID: <20250818233102.180207-20-stephen@networkplumber.org>
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

Use the new bsd_queue.h where needed but most files already
get the needed macros from rte_tailq.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/acl/rte_acl_osdep.h                  | 1 -
 lib/bbdev/rte_bbdev.c                    | 2 +-
 lib/cryptodev/cryptodev_pmd.c            | 1 -
 lib/cryptodev/rte_cryptodev.c            | 1 -
 lib/distributor/rte_distributor.c        | 2 +-
 lib/distributor/rte_distributor_single.c | 2 +-
 lib/efd/rte_efd.c                        | 1 -
 lib/fib/rte_fib.c                        | 1 -
 lib/fib/rte_fib6.c                       | 1 -
 lib/gpudev/gpudev_driver.h               | 1 -
 lib/graph/graph_private.h                | 1 -
 lib/ip_frag/ip_frag_common.h             | 3 +--
 lib/mbuf/rte_mbuf_dyn.c                  | 1 -
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
 25 files changed, 8 insertions(+), 27 deletions(-)

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
index e0f8c8eb0d..a781c7d14c 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -5,8 +5,8 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <rte_common.h>
 #include <rte_errno.h>
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
diff --git a/lib/ip_frag/ip_frag_common.h b/lib/ip_frag/ip_frag_common.h
index 51fc9d47fb..72128b0241 100644
--- a/lib/ip_frag/ip_frag_common.h
+++ b/lib/ip_frag/ip_frag_common.h
@@ -5,8 +5,7 @@
 #ifndef _IP_FRAG_COMMON_H_
 #define _IP_FRAG_COMMON_H_
 
-#include <sys/queue.h>
-
+#include <bsd_queue.h>
 #include <rte_common.h>
 
 #if defined(RTE_ARCH_ARM64)
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

