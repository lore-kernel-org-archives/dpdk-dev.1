Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A013AC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:27:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B9DB4067D;
	Fri, 21 Aug 2026 21:27:35 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 76A0F4027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:27:33 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc149372c14so1070931a12.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340453;
 x=1787945253; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GNW6H1nDxdrS8cWtx7ubm57Ah3eA4mqQnrLxmBn3xlo=;
 b=UGxlkyEAcj6xMS55ssJj7SfqbLl0y7THr6UHhwMl52JDNO4Wr+BOZ92Y8yBxKbWNEO
 WM1q0lrG4vGZH5rKdgbHfmkryBX29U9N4K9KWpfBsQ6GpU7julFP+RHztSElnszgns0S
 HD/tQOOp6YBwAYPpuP8XwZh1HBZGMm6qOBsTAl4ocoiit6LK5JdOPqGjTRSbfa8v//c7
 jf4MBFy9Ub4czBi2CucE72Lh20c2rslG+kotjSOlFnaK862rp6z8WCzF4lpnEv/xTlUC
 sp5IFjQg5e8Z6/YTnJH0f4qLDxkKeLvEeNqaQ9gU3jnDk5+v4ej1KXon2E4jLoIydktV
 1FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340453; x=1787945253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GNW6H1nDxdrS8cWtx7ubm57Ah3eA4mqQnrLxmBn3xlo=;
 b=Wgcd+aV4TtAAcQVPVQ1BM7yKooJJVWokiOUQmntvNIPxLmQgSkB04LNgSgu7+c1vDZ
 JyI0mDwDef9ZIFEn0pRN/xXc2PSB7SVohL5ByelG00K8/Jy20QR28gFD2uzHYdHlCERh
 FcAjveUj+WWjIh3vnVXIEZIlaH+qoQzmlfXSK0OoGaSIvGFrP5NR/Kyn+938TLXIXdPS
 XexEQ4q5UAeBwy8HRSbexERz/Axt30YQ+gXsMXoGVtPjFJQ/hajiOeI2+ElCAHlGlzxX
 EsybaVsjfA/qXcfMqK0G9XunOSdTShaVgEysDRm5NlbDIPZG/w9MN8z0GES/gn18vkUW
 cHRg==
X-Gm-Message-State: AFuF++nQZw1t1sntlmg8Su1gHj28UtyX+3YkQOzi/Xp28wRZ7jUfxxYX
 rxRpZ5SEcQuvlhrMhJnFbN6SjGOdeS2MBzLWmxEnuJgZCpdK1XLVII/f7mRidogNEd+YVeF9JFy
 oS3iF
X-Gm-Gg: AR+sD12meauq5twWtBx92eBTmGe1z+cyPSR9MZexvjumWXkTgD2ln+dlGOLpyT5RbkW
 H1mNxBXaCCGXGHoCnRlXYbQAFBdDbIJMoE93+IGf7+4FpqmWyqYEhjO51YzxryFG0BIZOop/h7Y
 P6NC7V5C5nzna4FqsjgJfeO7nzwiXWT5BwUjYZEPNmWup9xgSZkt1LTEhvwHoCrffKlFyuHJ8Rc
 iIQNIZH05dh4PzczC5ofeGwRtkcE5WiL92XHegTjfF5BOIZaIQuLVOe9QWkPXtxp9qhQYJikj6g
 jjurvSpSd/kN22nN6bYVNkBtGPVQ1Z7bywmeTNYyZPlRQxZVtC63QAOydNLJMmKkgt8kLxLwnk6
 vn3yBXVVN6WyRwDajwhDACnVmEMVGgqpt056jaEQNq7oFUZoSGs4U9jfepZkvARXpyZoyc1RWKJ
 lufkYOLOHoJ1znnw94pvEDe2mFgdXy5+kw66E7qYBLU6sl5KpWN9NjPp9iRg+ZzCpQvv6HKsJES
 HcvsIQBlyUT/kV4k6WzcZYTwUY=
X-Received: by 2002:a05:6a21:918a:b0:3cc:841d:bb26 with SMTP id
 adf61e73a8af0-3cd301379e2mr16122408637.15.1787340452613; 
 Fri, 21 Aug 2026 12:27:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:27:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 02/68] lib: add missing include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:23:57 -0700
Message-ID: <20260821192646.146382-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

These files use rte_memcpy() but relied on rte_memcpy.h being
included indirectly via another header. Add the direct include
so that later patches which remove now-unnecessary includes of
rte_memcpy.h do not break the build.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/x86/include/rte_memcpy.h           | 1 +
 lib/graph/rte_graph_model_mcore_dispatch.c | 1 +
 lib/ipsec/esp_inb.c                        | 1 +
 lib/ipsec/esp_outb.c                       | 1 +
 lib/node/interface_tx_feature.c            | 1 +
 lib/node/ip4_local.c                       | 1 +
 lib/node/ip4_lookup.c                      | 1 +
 lib/node/ip4_lookup_fib.c                  | 1 +
 lib/node/ip4_reassembly.c                  | 1 +
 lib/node/ip4_rewrite.c                     | 1 +
 lib/node/ip6_lookup.c                      | 1 +
 lib/node/ip6_lookup_fib.c                  | 1 +
 lib/node/ip6_rewrite.c                     | 1 +
 lib/node/pkt_cls.c                         | 1 +
 lib/node/udp4_input.c                      | 1 +
 lib/port/rte_swx_port_source_sink.c        | 1 +
 lib/vhost/vhost.c                          | 1 +
 lib/vhost/vhost_crypto.c                   | 1 +
 18 files changed, 18 insertions(+)

diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 8ed8c55010..fabd0a286d 100644
--- a/lib/eal/x86/include/rte_memcpy.h
+++ b/lib/eal/x86/include/rte_memcpy.h
@@ -14,6 +14,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <string.h>
+#include <rte_memcpy.h>
 #include <rte_vect.h>
 #include <rte_common.h>
 #include <rte_config.h>
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_graph_model_mcore_dispatch.c
index 706b5469f0..4e42b7e96c 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.c
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c
@@ -5,6 +5,7 @@
 #include "graph_private.h"
 #include <eal_export.h>
 #include "rte_graph_model_mcore_dispatch.h"
+#include <rte_memcpy.h>
 
 int
 graph_sched_wq_create(struct graph *_graph, struct graph *_parent_graph,
diff --git a/lib/ipsec/esp_inb.c b/lib/ipsec/esp_inb.c
index f159bf7460..ca836ec63c 100644
--- a/lib/ipsec/esp_inb.c
+++ b/lib/ipsec/esp_inb.c
@@ -6,6 +6,7 @@
 #include <rte_esp.h>
 #include <rte_errno.h>
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 
 #include "sa.h"
 #include "ipsec_sqn.h"
diff --git a/lib/ipsec/esp_outb.c b/lib/ipsec/esp_outb.c
index 617fc52b21..5f4279102f 100644
--- a/lib/ipsec/esp_outb.c
+++ b/lib/ipsec/esp_outb.c
@@ -4,6 +4,7 @@
 
 #include <rte_ipsec.h>
 #include <rte_esp.h>
+#include <rte_memcpy.h>
 #include <rte_udp.h>
 #include <rte_errno.h>
 #include <rte_cryptodev.h>
diff --git a/lib/node/interface_tx_feature.c b/lib/node/interface_tx_feature.c
index c8809d5f91..fe2b6800fd 100644
--- a/lib/node/interface_tx_feature.c
+++ b/lib/node/interface_tx_feature.c
@@ -9,6 +9,7 @@
 #include <rte_ether.h>
 #include <rte_graph_feature_arc_worker.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_ip4_api.h"
 #include "node_private.h"
diff --git a/lib/node/ip4_local.c b/lib/node/ip4_local.c
index 288f9399ff..e9c6607e50 100644
--- a/lib/node/ip4_local.c
+++ b/lib/node/ip4_local.c
@@ -15,6 +15,7 @@
 #include <rte_fbk_hash.h>
 #include <rte_jhash.h>
 #include <rte_hash_crc.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_ip4_api.h"
 
diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
index 42db993142..0aeeb203b7 100644
--- a/lib/node/ip4_lookup.c
+++ b/lib/node/ip4_lookup.c
@@ -12,6 +12,7 @@
 #include <rte_graph_worker.h>
 #include <rte_ip.h>
 #include <rte_lpm.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_ip4_api.h"
 
diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 0857d889fc..f62701c623 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -11,6 +11,7 @@
 #include <rte_graph.h>
 #include <rte_graph_worker.h>
 #include <rte_ip.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_ip4_api.h"
 
diff --git a/lib/node/ip4_reassembly.c b/lib/node/ip4_reassembly.c
index b61ddfd7d1..55c785b400 100644
--- a/lib/node/ip4_reassembly.c
+++ b/lib/node/ip4_reassembly.c
@@ -16,6 +16,7 @@
 #include <rte_ip.h>
 #include <rte_ip_frag.h>
 #include <rte_mbuf.h>
+#include <rte_memcpy.h>
 #include <rte_tcp.h>
 #include <rte_udp.h>
 
diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
index 37bc3a511f..7ce95061d2 100644
--- a/lib/node/ip4_rewrite.c
+++ b/lib/node/ip4_rewrite.c
@@ -9,6 +9,7 @@
 #include <rte_graph_feature_arc_worker.h>
 #include <rte_ip.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_vect.h>
 
 #include "rte_node_ip4_api.h"
diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
index 83c0500c76..5583e27439 100644
--- a/lib/node/ip6_lookup.c
+++ b/lib/node/ip6_lookup.c
@@ -12,6 +12,7 @@
 #include <rte_graph_worker.h>
 #include <rte_ip.h>
 #include <rte_lpm6.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_ip6_api.h"
 
diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 40c5c753df..600acde535 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -11,6 +11,7 @@
 #include <rte_graph.h>
 #include <rte_graph_worker.h>
 #include <rte_ip.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_ip6_api.h"
 
diff --git a/lib/node/ip6_rewrite.c b/lib/node/ip6_rewrite.c
index d5488e7fa3..debd7a0fc0 100644
--- a/lib/node/ip6_rewrite.c
+++ b/lib/node/ip6_rewrite.c
@@ -9,6 +9,7 @@
 #include <rte_graph_worker.h>
 #include <rte_ip.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_vect.h>
 
 #include "rte_node_ip6_api.h"
diff --git a/lib/node/pkt_cls.c b/lib/node/pkt_cls.c
index ca323ea573..ea257128b5 100644
--- a/lib/node/pkt_cls.c
+++ b/lib/node/pkt_cls.c
@@ -6,6 +6,7 @@
 
 #include <rte_graph.h>
 #include <rte_graph_worker.h>
+#include <rte_memcpy.h>
 
 #include "pkt_cls_priv.h"
 #include "node_private.h"
diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..55477dd6df 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -16,6 +16,7 @@
 #include <rte_fbk_hash.h>
 #include <rte_jhash.h>
 #include <rte_hash_crc.h>
+#include <rte_memcpy.h>
 
 #include "rte_node_udp4_input_api.h"
 
diff --git a/lib/port/rte_swx_port_source_sink.c b/lib/port/rte_swx_port_source_sink.c
index af8b9ec68d..7ff80fc506 100644
--- a/lib/port/rte_swx_port_source_sink.c
+++ b/lib/port/rte_swx_port_source_sink.c
@@ -13,6 +13,7 @@
 #include <rte_common.h>
 #include <rte_mbuf.h>
 #include <rte_hexdump.h>
+#include <rte_memcpy.h>
 
 #include "rte_swx_port_source_sink.h"
 
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 7e68b2c3be..18fcbb7708 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -15,6 +15,7 @@
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_log.h>
+#include <rte_memcpy.h>
 #include <rte_memory.h>
 #include <rte_malloc.h>
 #include <rte_vhost.h>
diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 648e2d731b..71c6d747b8 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -8,6 +8,7 @@
 #include <rte_log.h>
 #include <rte_mbuf.h>
 #include <rte_cryptodev.h>
+#include <rte_memcpy.h>
 
 #include "iotlb.h"
 #include "rte_vhost_crypto.h"
-- 
2.53.0

