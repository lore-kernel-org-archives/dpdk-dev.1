Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FBCCA600A
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6368442DCE;
	Wed,  7 Oct 2026 23:41:39 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id C816F42DD0
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:35 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e7006bbf77so3091305ad.0
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409295;
 x=1792014095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zl1ko9yctHbPzXAOcnbBnPCBQWdweW5YzVVbYlnb/nE=;
 b=0egH4qeBR5QiGf/2yRKbjuJu0vhPrf8SSrrBh+NkcJ+NQS4cNHQHtpSxyxgdnpfAK2
 1GTPOwd0BgafbOj+PcynojSUYf1yxTT1Jvh92C1Nj6kYgmgzS4weUPQQt17XodNqDUSR
 fCbBPcDm1dvJtDe72TlEGwaildEfgrtV1uxSc0LYes6FnkLiGRRg5fsjYtkqmIbb0nRd
 +dArHrzin+0YJY0lfE8PUq8feLBY5WJgbSZrSmi0W2sZZFrXjMktnsikCficE+c/zNh6
 eL2/Y6DfwaMIYKVi4JHap5wA1Nnc2ZZTPqHQW8D1qcQHWMkGEaDsuhen1FGq0YrmSR6J
 p7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409295; x=1792014095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zl1ko9yctHbPzXAOcnbBnPCBQWdweW5YzVVbYlnb/nE=;
 b=xNTsS2N12pjq7sJzR5i79WTZt2RvkYmClhoxhiCRUN3VYX/Do4QQvOBnrpQleSR3kD
 6mDBG+OHIuEu29SahD1AP8RBntLoOpJzDJuzN56LcoGTLDvDksIRjiVoBd5TImOJQ1+O
 qmYaCmy3O1OgQpL1HdM0KjlqcT/ABStiFAZG9iuJVei7gIgqXONO4Sqfb7E8fpNszTqm
 7Ft41aePjDrYhS7BEP0o4wsQBkTs4aUAD8MQNYcE6AKggNjCyq8F5QyTAyEyjnNIbfU+
 nEsbz9exIYgRGph6UPttMDb2KcOou3MEcb+Vt6q/bCI2+rT2Zi47Ydt5ahPyztSTiAUp
 nSaQ==
X-Gm-Message-State: AFq9FYL4SnbOymTmGI2GJu8IAkYVm0RO82bIjk4AmhcpraRgL1aljvqP
 Mz/W3NnCS/E1S+lXzrHzLyE5BoqfB95Yp9NQNzC6kb20ZXwABrSaKow9g61OS8TG+DXqE/cDld9
 6+3C96Ls=
X-Gm-Gg: AYBFou1vLesE4xrTRRQr3Yaqq3PppkfLI37lbwMqbOrnbTviJ1BzaJDQVvRSQx2IdhB
 zHi8A9S7AvxI1RT7p1dz2HiQ8drAL29Oqa+wp2MIInM6N1GX60/pRVhFWGcopWvjJhbBupaejPA
 lXgGszrypYvxlj0xFPjPmw92qtsUGmuUy50qjklUaJDsFN2v9EDjvAy/PhjAzze3E8qNKNkYjgA
 w/FdQzXBXIbeDDu/qBa4gCGLigvvY8VN4Vxb2djlk9ueU3jiduqZAvfp37+3xp6/aNJ6kA0FvTJ
 i2tty2JbDors+jaQiKxhMMSoIcUMOnN3Dcav6b/4RfXxaqs6BhQJyiT2vaUsroEz5qC5iXgwAIO
 txs0/2vs1rQtEcLNVhS+oylVYUTl/1LBzpJXbly4RAQ39PW39dLdlIW68WJmjqlr8KC9wKwWIEw
 hErMIirwvTTprww8/LH/BTO8IqHarhQ0bTP2FeSxS0MvfmVx1kQ3sD2LSN2u9k6TOS2gQ6hSiMw
 7eNgF3l9kd5lbGdwrllqJoVHhNRxc4H6u53dw==
X-Received: by 2002:a17:903:38cd:b0:2df:470d:d83f with SMTP id
 d9443c01a7336-2e6004bdabdmr33828785ad.34.1791409294645; 
 Wed, 07 Oct 2026 14:41:34 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 16/20] node: promote API to stable
Date: Wed,  7 Oct 2026 14:39:46 -0700
Message-ID: <20261007214115.3092715-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The node control path functions were added between 23.07 and 25.07 and
none of the prototypes have changed. They are used by the graph
application and the l3fwd-graph example.

Most of the node headers carried a file level warning claiming that all
functions in the file may be changed or removed. That warning was
already wrong, since rte_node_ip4_route_add() and friends have been
stable for years while sitting under it.

Promote the whole library and drop those warnings. An API that cannot
be declared stable after several releases of use is not useful to
applications and should be removed instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 4 ++++
 lib/node/ethdev_ctrl.c                 | 2 +-
 lib/node/ip4_lookup_fib.c              | 4 ++--
 lib/node/ip4_reassembly.c              | 2 +-
 lib/node/ip6_lookup.c                  | 2 +-
 lib/node/ip6_lookup_fib.c              | 4 ++--
 lib/node/ip6_rewrite.c                 | 2 +-
 lib/node/node_mbuf_dynfield.c          | 2 +-
 lib/node/rte_node_eth_api.h            | 6 ------
 lib/node/rte_node_ip4_api.h            | 9 ---------
 lib/node/rte_node_ip6_api.h            | 9 ---------
 lib/node/rte_node_mbuf_dynfield.h      | 6 ------
 lib/node/rte_node_pkt_cls_api.h        | 4 ----
 lib/node/rte_node_udp4_input_api.h     | 8 --------
 lib/node/udp4_input.c                  | 4 ++--
 15 files changed, 15 insertions(+), 53 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index afe28eb754..009db40708 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -349,6 +349,10 @@ API Changes
     ``rte_event_port_profile_links_get`` and
     ``rte_event_port_profile_unlink``
 
+* node: Promoted the whole library API from experimental to stable.
+  The ``rte_node_*`` control path functions date from 23.07 to 25.07 and
+  are used by the graph application and the l3fwd-graph example.
+
 * pipeline: Promoted the SWX API from experimental to stable:
   the ``rte_swx_pipeline_*``, ``rte_swx_ctl_*`` and ``rte_swx_ipsec_*``
   functions in pipeline, the ``rte_swx_table_*`` symbols in table and
diff --git a/lib/node/ethdev_ctrl.c b/lib/node/ethdev_ctrl.c
index f717903731..3018920c79 100644
--- a/lib/node/ethdev_ctrl.c
+++ b/lib/node/ethdev_ctrl.c
@@ -141,7 +141,7 @@ rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ethdev_rx_next_update, 24.03)
+RTE_EXPORT_SYMBOL(rte_node_ethdev_rx_next_update)
 int
 rte_node_ethdev_rx_next_update(rte_node_t id, const char *edge_name)
 {
diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 0857d889fc..3757c2880f 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -193,7 +193,7 @@ ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 	return nb_objs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_create, 25.07)
+RTE_EXPORT_SYMBOL(rte_node_ip4_fib_create)
 int
 rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
 {
@@ -213,7 +213,7 @@ rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
+RTE_EXPORT_SYMBOL(rte_node_ip4_fib_route_add)
 int
 rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
 			   enum rte_node_ip4_lookup_next next_node)
diff --git a/lib/node/ip4_reassembly.c b/lib/node/ip4_reassembly.c
index b61ddfd7d1..f6d858bc70 100644
--- a/lib/node/ip4_reassembly.c
+++ b/lib/node/ip4_reassembly.c
@@ -128,7 +128,7 @@ ip4_reassembly_node_process(struct rte_graph *graph, struct rte_node *node, void
 	return idx;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_reassembly_configure, 23.11)
+RTE_EXPORT_SYMBOL(rte_node_ip4_reassembly_configure)
 int
 rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, uint16_t cnt)
 {
diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
index 83c0500c76..679405bc53 100644
--- a/lib/node/ip6_lookup.c
+++ b/lib/node/ip6_lookup.c
@@ -258,7 +258,7 @@ ip6_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 	return nb_objs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_route_add, 23.07)
+RTE_EXPORT_SYMBOL(rte_node_ip6_route_add)
 int
 rte_node_ip6_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
 		       enum rte_node_ip6_lookup_next next_node)
diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 40c5c753df..74e1127b32 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -187,7 +187,7 @@ ip6_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 	return nb_objs;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_create, 25.07)
+RTE_EXPORT_SYMBOL(rte_node_ip6_fib_create)
 int
 rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
 {
@@ -207,7 +207,7 @@ rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_route_add, 25.07)
+RTE_EXPORT_SYMBOL(rte_node_ip6_fib_route_add)
 int
 rte_node_ip6_fib_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
 			   enum rte_node_ip6_lookup_next next_node)
diff --git a/lib/node/ip6_rewrite.c b/lib/node/ip6_rewrite.c
index d5488e7fa3..2f43cbefe5 100644
--- a/lib/node/ip6_rewrite.c
+++ b/lib/node/ip6_rewrite.c
@@ -273,7 +273,7 @@ ip6_rewrite_set_next(uint16_t port_id, uint16_t next_index)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_rewrite_add, 23.07)
+RTE_EXPORT_SYMBOL(rte_node_ip6_rewrite_add)
 int
 rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			 uint8_t rewrite_len, uint16_t dst_port)
diff --git a/lib/node/node_mbuf_dynfield.c b/lib/node/node_mbuf_dynfield.c
index 9dbc80f7e5..a018a66b38 100644
--- a/lib/node/node_mbuf_dynfield.c
+++ b/lib/node/node_mbuf_dynfield.c
@@ -20,7 +20,7 @@ static const struct rte_mbuf_dynfield node_mbuf_dynfield_desc = {
 	.align = alignof(rte_node_mbuf_dynfield_t),
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register, 25.07);
+RTE_EXPORT_SYMBOL(rte_node_mbuf_dynfield_register)
 int rte_node_mbuf_dynfield_register(void)
 {
 	struct node_mbuf_dynfield_mz *f = NULL;
diff --git a/lib/node/rte_node_eth_api.h b/lib/node/rte_node_eth_api.h
index e9221d113b..1b74706ad9 100644
--- a/lib/node/rte_node_eth_api.h
+++ b/lib/node/rte_node_eth_api.h
@@ -8,15 +8,10 @@
 /**
  * @file rte_node_eth_api.h
  *
- * @warning
- * @b EXPERIMENTAL:
- * All functions in this file may be changed or removed without prior notice.
- *
  * This API allows setting up ethdev_rx and ethdev_tx nodes
  * and its queue associations.
  */
 
-#include <rte_compat.h>
 #include <rte_common.h>
 #include <rte_graph.h>
 #include <rte_mempool.h>
@@ -72,7 +67,6 @@ int rte_node_eth_config(struct rte_node_ethdev_config *cfg,
  *   - ENOMEM: If memory allocation failed
  *   - 0 on successful initialization.
  */
-__rte_experimental
 int rte_node_ethdev_rx_next_update(rte_node_t id, const char *edge_name);
 
 #ifdef __cplusplus
diff --git a/lib/node/rte_node_ip4_api.h b/lib/node/rte_node_ip4_api.h
index b7bb9216b1..5c1d9013d4 100644
--- a/lib/node/rte_node_ip4_api.h
+++ b/lib/node/rte_node_ip4_api.h
@@ -8,16 +8,10 @@
 /**
  * @file rte_node_ip4_api.h
  *
- * @warning
- * @b EXPERIMENTAL:
- * All functions in this file may be changed or removed without prior notice.
- *
  * This API allows performing control path functions of ip4_* nodes
  * like ip4_lookup, ip4_rewrite.
  */
 #include <rte_common.h>
-#include <rte_compat.h>
-
 #include <rte_fib.h>
 #include <rte_graph.h>
 
@@ -119,7 +113,6 @@ int rte_node_ip4_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, uint16_t cnt);
 
 /**
@@ -133,7 +126,6 @@ int rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, u
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf);
 
 /**
@@ -151,7 +143,6 @@ int rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf);
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
 			       enum rte_node_ip4_lookup_next next_node);
 
diff --git a/lib/node/rte_node_ip6_api.h b/lib/node/rte_node_ip6_api.h
index c0cdc3926a..0be90c93de 100644
--- a/lib/node/rte_node_ip6_api.h
+++ b/lib/node/rte_node_ip6_api.h
@@ -8,15 +8,10 @@
 /**
  * @file rte_node_ip6_api.h
  *
- * @warning
- * @b EXPERIMENTAL:
- * All functions in this file may be changed or removed without prior notice.
- *
  * This API allows performing control path functions of ip6_* nodes
  * like ip6_lookup, ip6_rewrite.
  */
 #include <rte_common.h>
-#include <rte_compat.h>
 #include <rte_fib6.h>
 #include <rte_ip6.h>
 
@@ -49,7 +44,6 @@ enum rte_node_ip6_lookup_next {
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_ip6_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
 			   enum rte_node_ip6_lookup_next next_node);
 
@@ -68,7 +62,6 @@ int rte_node_ip6_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			     uint8_t rewrite_len, uint16_t dst_port);
 
@@ -83,7 +76,6 @@ int rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf);
 
 /**
@@ -101,7 +93,6 @@ int rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf);
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_ip6_fib_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
 			       enum rte_node_ip6_lookup_next next_node);
 
diff --git a/lib/node/rte_node_mbuf_dynfield.h b/lib/node/rte_node_mbuf_dynfield.h
index 09254c585a..f9edaee8c2 100644
--- a/lib/node/rte_node_mbuf_dynfield.h
+++ b/lib/node/rte_node_mbuf_dynfield.h
@@ -12,9 +12,6 @@
 /**
  * @file: rte_node_mbuf_dynfield.h
  *
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Defines rte_node specific mbuf dynamic field region [rte_node_mbuf_dynfield_t]
  * which can be used by both DPDK built-in and out-of-tree nodes
  * for storing per-mbuf fields for graph walk.
@@ -102,7 +99,6 @@ typedef struct rte_node_mbuf_dynfield {
  * @return
  *  Pointer to node specific mbuf dynamic field structure
  */
-__rte_experimental
 static __rte_always_inline rte_node_mbuf_dynfield_t *
 rte_node_mbuf_dynfield_get(struct rte_mbuf *m, const int offset)
 {
@@ -120,7 +116,6 @@ rte_node_mbuf_dynfield_get(struct rte_mbuf *m, const int offset)
  * @return
  * Pointer to node mbuf overloadable fields
  */
-__rte_experimental
 static __rte_always_inline rte_node_mbuf_overload_fields_t *
 rte_node_mbuf_overload_fields_get(struct rte_mbuf *m, const int offset)
 {
@@ -148,7 +143,6 @@ rte_node_mbuf_overload_fields_get(struct rte_mbuf *m, const int offset)
  *    - ENOMEM - no memory
  *   >=0 on success: dynamic field offset
  */
-__rte_experimental
 int rte_node_mbuf_dynfield_register(void);
 
 #ifdef __cplusplus
diff --git a/lib/node/rte_node_pkt_cls_api.h b/lib/node/rte_node_pkt_cls_api.h
index 6f824b4f1f..6785626d11 100644
--- a/lib/node/rte_node_pkt_cls_api.h
+++ b/lib/node/rte_node_pkt_cls_api.h
@@ -8,10 +8,6 @@
 /**
  * @file rte_node_pkt_cls_api.h
  *
- * @warning
- * @b EXPERIMENTAL:
- * All functions in this file may be changed or removed without prior notice.
- *
  * This API allows performing control path functions of pkt_cls node.
  */
 
diff --git a/lib/node/rte_node_udp4_input_api.h b/lib/node/rte_node_udp4_input_api.h
index 50f37b8bd9..72cb188721 100644
--- a/lib/node/rte_node_udp4_input_api.h
+++ b/lib/node/rte_node_udp4_input_api.h
@@ -8,16 +8,10 @@
 /**
  * @file rte_node_udp4_input_api.h
  *
- * @warning
- * @b EXPERIMENTAL:
- * All functions in this file may be changed or removed without prior notice.
- *
  * This API allows performing control path functions of udp4_* nodes
  * like udp4_input.
  */
 #include <rte_common.h>
-#include <rte_compat.h>
-
 #include "rte_graph.h"
 
 #ifdef __cplusplus
@@ -37,7 +31,6 @@ enum rte_node_udp4_input_next {
  * @param usr_node
  * Node registered by user to receive data.
  */
-__rte_experimental
 int rte_node_udp4_usr_node_add(const char *usr_node);
 
 /**
@@ -50,7 +43,6 @@ int rte_node_udp4_usr_node_add(const char *usr_node);
  * @return
  *   0 on success, negative otherwise.
  */
-__rte_experimental
 int rte_node_udp4_dst_port_add(uint32_t dst_port, rte_edge_t next_node);
 
 #ifdef __cplusplus
diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..2dc0c7a6da 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -56,7 +56,7 @@ static struct rte_hash_parameters udp4_params = {
 	.socket_id = 0,
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_dst_port_add, 23.11)
+RTE_EXPORT_SYMBOL(rte_node_udp4_dst_port_add)
 int
 rte_node_udp4_dst_port_add(uint32_t dst_port, rte_edge_t next_node)
 {
@@ -78,7 +78,7 @@ rte_node_udp4_dst_port_add(uint32_t dst_port, rte_edge_t next_node)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_usr_node_add, 23.11)
+RTE_EXPORT_SYMBOL(rte_node_udp4_usr_node_add)
 int
 rte_node_udp4_usr_node_add(const char *usr_node)
 {
-- 
2.53.0

