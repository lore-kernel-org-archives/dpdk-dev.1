Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D1E98DFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 07:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E04C4025E;
	Mon, 23 Feb 2026 08:57:52 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id B9F734026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 12:48:44 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso1234230f8f.1
 for <dev@dpdk.org>; Fri, 20 Feb 2026 03:48:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771588124; cv=none;
 d=google.com; s=arc-20240605;
 b=QefLXnIWU05euwmEKNIoLmRT0BVHYqERTpB673YubIDflpoD7QSLlKLfWAa71IjhTm
 EF2aQOq3mOqLA2ZGo77xMrDGsYpEKze7LNiW55snBZ/T+/94cB5OkGdEvhjfAA8oaZlh
 lkzFBgeYUUmL9iutNz8fMmDECUWEPGcRyhY5TMqV7MkF7q4C04QgHpeXDf6/LLM+cFSX
 7F0Uzqpf4qgQT5cXSy4VIi+pe3/QqflN9IFGlcmf80sVCa/6I9fYWsx52TFueiED8xTn
 w6lUFNhirb3tQnrnKSVbi5soRVzbe8CtLP3QqdJcg/AEQrfdMT1DrK/njxDfYVEO0cGA
 /fKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=joo9Y4qLbCLEwjnvjSCGJ8qhNIYMb0XjSDqdBPS9XPU=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=jC7FM8xCG5Pcopdc2R24GPAc/PuBioczMT6BaI2vcUPkx584yJamighrTAQl8xMZXm
 97+YZUqbbT198N1NCEA9bRXcvCel44ygqyF1J8KC1dmcWfjnhR0kGJBw3Pp93fqGY24b
 OIkjpKYBIP5x9gNlhONPs3SPok0UYdTljvYLWVLgEgnjP1O9jopdJN3qBKGSOEzTKFeJ
 AmbNjjDkJ7HkD4OXEFwtdoPw1vqJ9+LEOg59uJgDl84YlCMvscfxmHnGUqs2IM2npQon
 vqEiHdDX8qMA0W8qHvaX7Y3xMeTSvCv/GuzjYjtjUw0TH0Uar6GILzofvNQUpV5k1ln3
 1jrg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771588124; x=1772192924; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=joo9Y4qLbCLEwjnvjSCGJ8qhNIYMb0XjSDqdBPS9XPU=;
 b=EoJcRJk6+QAi8YjNCd0bUxewPJ/OSEd0iMxnQ2IUbvcXZQmj9Z2/+rm4iU1l5TRmMc
 twNyZqsm0ycVsmkI5Dp9XGP/vZpRkogTzYiaOleqgGg5w8OKS0x0QjpyDVw82Xqch/NT
 b0kua34LvjMCjAuK1zhel8MRG6mKxabPYQoCu9+CEc9Vj0E5dRnvOWn0c0pXJ+WILFaM
 CmbyGWWOOLGBuN/uJwZhujRtWJGV4aduGLzVdAofkbQEx9qvwdQAL20SySCHLCLFwOCe
 jQfYlwHD28tqL7snh8EJGcUE3Rr4W8k+sPQvP+sXP2GWVj9/Y4x5UqzjdmKlGOYDRo8P
 5rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771588124; x=1772192924;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=joo9Y4qLbCLEwjnvjSCGJ8qhNIYMb0XjSDqdBPS9XPU=;
 b=DAvbMuRtjHmT1IWpe4rDareI5g2qCLP0qhbMs6GX111oz06JRu9cRvsPIkMZ8mj4zQ
 6v/0hqtpim8YztU7hf+PVernvQMdzmpEMNZgGjyP9WN76bmva3/IG1A2EvUlhCr/6rAb
 NwH5j1dcwnqg6JXztJfbfCYLeVurvdwWtHF/CXS6U1n8vdUBcDsn3b+uR/TRpZe4pAdF
 SvJJMp0TjLNpDhJ32Vpmd19GUsPO6hCmNP6jhIrtWwlDYpaoStvLFyVvjM16obM6xqTn
 /6sGi76ZiWN67xcl/rLEVKZ+eXvMb/wRbMM2uv2sw5khGOSjy6fu9z8CNAvqvlROmGkg
 ddPg==
X-Gm-Message-State: AOJu0YyHF9eQts3KWIdhX0k+mGvTBnQgenhbDNUoJkZg8rKA8b/ioYtN
 L0+jHjtSEIjJrywqewhj4M9Wh62Va/hK7oNyF3rvr0QO5aLpIXi40V2lmjqhgYcDHp+PKCyJI/x
 q12IiLxOEnGHmBpBKlBgmDKOfy5vDEl5u3jSuL4M=
X-Gm-Gg: AZuq6aKcJtd9bU9vrpJKPS5ATVWtiWc7pwq6HyBPH+rqkVxPWMAwDU2VCSwJBQ23r9r
 HSn6Hyx6bs0UtER4HDpeqMVL9faNYw6ACsUnja3wGtC5ej2gIdNPINBec5MMGoYeiHLeL1Ydzg0
 yi8dxjtaTO/I4c88sQYHdLABzZfEblhRfvJYQg4Axp19szAuoBtMvdNzjI7rgmjZr8+WEh5QV72
 GhmSYSzaMgkC2fJqx76iGB9IGLOcqEPI/Cyb+fgYXl0S6isnjhIez213Sr5SKDum1KjJYNTE7WX
 b1IjMFA=
X-Received: by 2002:a05:6000:2482:b0:432:586f:2a9d with SMTP id
 ffacd0b85a97d-43958e3bdffmr16535474f8f.32.1771588123881; Fri, 20 Feb 2026
 03:48:43 -0800 (PST)
MIME-Version: 1.0
From: Harsh raj Singh <singhharshraj215@gmail.com>
Date: Fri, 20 Feb 2026 17:18:32 +0530
X-Gm-Features: AaiRm53A8rqnWqWQlu6LyxkFWRXmUsy90KRJN9X6gVggA-BjxpuhGPU7uAlyEZs
Message-ID: <CAN33txFiMRpKpdEat+P+tqQmn4POTY3XafJRxnkjj6BAY6sAnw@mail.gmail.com>
Subject: [PATCH v2] examples/l2fwd_acl: add ACL-based L2 forwarding example
To: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:57:51 +0100
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

From 27423213cde0594243b96114d67ade6f51cdf764 Mon Sep 17 00:00:00 2001
From: Harsh Raj Singh <harshraj215@gmail.com>
Date: Thu, 19 Feb 2026 14:16:16 +0530
Subject: [PATCH v2] examples/l2fwd_acl: add ACL-based L2 forwarding example

This example demonstrates usage of the DPDK ACL library
to classify packets based on:

  - protocol
  - source IPv4
  - destination IPv4
  - source port
  - destination port

Packets matching ACL rules are forwarded,
others are dropped.

The example provides a minimal reference
for developers wanting to integrate ACL
classification into packet forwarding paths.

Signed-off-by: Harsh Raj Singh <harshraj215@gmail.com>

From 27423213cde0594243b96114d67ade6f51cdf764 Mon Sep 17 00:00:00 2001
From: Harsh Raj Singh <harshraj215@gmail.com>
Date: Thu, 19 Feb 2026 14:16:16 +0530
Subject: [PATCH] examples/l2fwd_acl: add ACL-based L2 forwarding example

This example demonstrates usage of the DPDK ACL library
to classify packets based on:

  - protocol
  - source IPv4
  - destination IPv4
  - source port
  - destination port

Packets matching ACL rules are forwarded,
others are dropped.

The example provides a minimal reference
for developers wanting to integrate ACL
classification into packet forwarding paths.

Signed-off-by: Harsh Raj Singh <harshraj215@gmail.com>
---
 examples/l2fwd_acl/README.md   |  18 +++
 examples/l2fwd_acl/main.c      | 247 +++++++++++++++++++++++++++++++++
 examples/l2fwd_acl/meson.build |   3 +
 examples/meson.build           |   1 +
 4 files changed, 269 insertions(+)
 create mode 100644 examples/l2fwd_acl/README.md
 create mode 100644 examples/l2fwd_acl/main.c
 create mode 100644 examples/l2fwd_acl/meson.build

diff --git a/examples/l2fwd_acl/README.md b/examples/l2fwd_acl/README.md
new file mode 100644
index 0000000000..5b5494e297
--- /dev/null
+++ b/examples/l2fwd_acl/README.md
@@ -0,0 +1,18 @@
+L2 Forwarding with ACL Example
+==============================
+
+This example demonstrates use of the DPDK ACL library
+to classify packets based on:
+
+- protocol
+- source IPv4
+- destination IPv4
+- source port
+- destination port
+
+Packets matching ACL rules are forwarded,
+others are dropped.
+
+Run:
+
+./dpdk-l2fwd-acl -l 0-2 -n 4 -- -p 0x1
diff --git a/examples/l2fwd_acl/main.c b/examples/l2fwd_acl/main.c
new file mode 100644
index 0000000000..6e05145b33
--- /dev/null
+++ b/examples/l2fwd_acl/main.c
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * l2fwd_acl example: demonstrates use of DPDK ACL library
+ */
+
+#include <stdbool.h>
+#include <signal.h>
+#include <getopt.h>
+#include <stdlib.h>
+
+#include <rte_acl.h>
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_mbuf.h>
+#include <rte_tcp.h>
+#include <rte_udp.h>
+#include <rte_log.h>
+
+#define NUM_FIELDS 5
+#define MAX_RULES  32
+#define NB_MBUF    8192
+#define BURST      32
+
+/* ---- Correct DPDK logging style ---- */
+#define RTE_LOGTYPE_L2FWD_ACL RTE_LOGTYPE_USER1
+#define LOGTYPE_L2FWD_ACL RTE_LOGTYPE_L2FWD_ACL
+
+RTE_ACL_RULE_DEF(acl_rule, NUM_FIELDS);
+
+struct pkt_key {
+    uint8_t  proto;
+    uint32_t src_ip;
+    uint32_t dst_ip;
+    uint16_t src_port;
+    uint16_t dst_port;
+};
+
+enum {
+    PROTO_FIELD,
+    SRC_FIELD,
+    DST_FIELD,
+    SPORT_FIELD,
+    DPORT_FIELD
+};
+
+static volatile bool force_quit;
+static uint32_t portmask = 0x1;
+
+static struct rte_acl_field_def field_defs[NUM_FIELDS] = {
+    { RTE_ACL_FIELD_TYPE_BITMASK, sizeof(uint8_t),  PROTO_FIELD, 0,
offsetof(struct pkt_key, proto) },
+    { RTE_ACL_FIELD_TYPE_MASK,    sizeof(uint32_t), SRC_FIELD,   1,
offsetof(struct pkt_key, src_ip) },
+    { RTE_ACL_FIELD_TYPE_MASK,    sizeof(uint32_t), DST_FIELD,   2,
offsetof(struct pkt_key, dst_ip) },
+    { RTE_ACL_FIELD_TYPE_RANGE,   sizeof(uint16_t), SPORT_FIELD, 3,
offsetof(struct pkt_key, src_port) },
+    { RTE_ACL_FIELD_TYPE_RANGE,   sizeof(uint16_t), DPORT_FIELD, 3,
offsetof(struct pkt_key, dst_port) },
+};
+
+static void
+signal_handler(int sig)
+{
+    if (sig == SIGINT || sig == SIGTERM)
+        force_quit = true;
+}
+
+static int
+parse_args(int argc, char **argv)
+{
+    int opt;
+    while ((opt = getopt(argc, argv, "p:")) != -1) {
+        switch (opt) {
+        case 'p':
+            portmask = strtoul(optarg, NULL, 16);
+            break;
+        default:
+            return -1;
+        }
+    }
+    return 0;
+}
+
+/* ---------------- ACL INITIALIZATION ---------------- */
+
+static struct rte_acl_ctx *
+init_acl(void)
+{
+    struct rte_acl_param prm = {
+        .name = "acl_ctx",
+        .socket_id = rte_socket_id(),
+        .rule_size = RTE_ACL_RULE_SZ(NUM_FIELDS),
+        .max_rule_num = MAX_RULES
+    };
+
+    struct rte_acl_ctx *ctx = rte_acl_create(&prm);
+    if (!ctx)
+        rte_exit(EXIT_FAILURE, "ACL create failed\n");
+
+    struct acl_rule rule;
+    memset(&rule, 0, sizeof(rule));
+
+    rule.data.priority = 10;
+    rule.data.category_mask = 1;
+    rule.data.userdata = 1;
+
+    rule.field[PROTO_FIELD].value.u8 = IPPROTO_TCP;
+    rule.field[PROTO_FIELD].mask_range.u8 = 0xFF;
+
+    rule.field[SRC_FIELD].value.u32 =
+        rte_be_to_cpu_32(RTE_IPV4(172,17,166,200));
+    rule.field[SRC_FIELD].mask_range.u32 = 32;
+
+    rule.field[DST_FIELD].value.u32 = 0;
+    rule.field[DST_FIELD].mask_range.u32 = 0;
+
+    rule.field[SPORT_FIELD].value.u16 = 0;
+    rule.field[SPORT_FIELD].mask_range.u16 = 65535;
+
+    rule.field[DPORT_FIELD].value.u16 = 0;
+    rule.field[DPORT_FIELD].mask_range.u16 = 65535;
+
+    if (rte_acl_add_rules(ctx, (struct rte_acl_rule *)&rule, 1) < 0)
+        rte_exit(EXIT_FAILURE, "ACL rule add failed\n");
+
+    struct rte_acl_config cfg;
+    memset(&cfg, 0, sizeof(cfg));
+    cfg.num_categories = 1;
+    cfg.num_fields = NUM_FIELDS;
+    memcpy(cfg.defs, field_defs, sizeof(field_defs));
+
+    if (rte_acl_build(ctx, &cfg) != 0)
+        rte_exit(EXIT_FAILURE, "ACL build failed\n");
+
+    RTE_LOG(INFO, L2FWD_ACL, "ACL ready\n");
+    return ctx;
+}
+
+/* ---------------- MAIN ---------------- */
+
+int main(int argc, char **argv)
+{
+    force_quit = false;
+    signal(SIGINT, signal_handler);
+    signal(SIGTERM, signal_handler);
+
+    int ret = rte_eal_init(argc, argv);
+    if (ret < 0)
+        rte_exit(EXIT_FAILURE, "EAL init failed\n");
+
+    argc -= ret;
+    argv += ret;
+
+    if (parse_args(argc, argv) < 0)
+        rte_exit(EXIT_FAILURE, "Invalid arguments\n");
+
+    struct rte_acl_ctx *acl_ctx = init_acl();
+
+    struct rte_mempool *mp = rte_pktmbuf_pool_create(
+        "mbuf_pool", NB_MBUF, 256, 0,
+        RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+
+    if (!mp)
+        rte_exit(EXIT_FAILURE, "mempool failed\n");
+
+    uint16_t port_id;
+    RTE_ETH_FOREACH_DEV(port_id) {
+
+        if (!(portmask & (1 << port_id)))
+            continue;
+
+        struct rte_eth_conf conf = {0};
+
+        if (rte_eth_dev_configure(port_id, 1, 1, &conf) < 0)
+            rte_exit(EXIT_FAILURE, "port configure failed\n");
+
+        if (rte_eth_rx_queue_setup(port_id, 0, 1024,
+            rte_eth_dev_socket_id(port_id), NULL, mp) < 0)
+            rte_exit(EXIT_FAILURE, "rx setup failed\n");
+
+        if (rte_eth_tx_queue_setup(port_id, 0, 1024,
+            rte_eth_dev_socket_id(port_id), NULL) < 0)
+            rte_exit(EXIT_FAILURE, "tx setup failed\n");
+
+        if (rte_eth_dev_start(port_id) < 0)
+            rte_exit(EXIT_FAILURE, "port start failed\n");
+
+        rte_eth_promiscuous_enable(port_id);
+
+        RTE_LOG(INFO, L2FWD_ACL, "Started port %u\n", port_id);
+    }
+
+    struct rte_mbuf *bufs[BURST];
+
+    while (!force_quit) {
+
+        RTE_ETH_FOREACH_DEV(port_id) {
+
+            if (!(portmask & (1 << port_id)))
+                continue;
+
+            uint16_t nb = rte_eth_rx_burst(port_id, 0, bufs, BURST);
+            if (!nb) continue;
+
+            for (int i = 0; i < nb; i++) {
+
+                struct rte_mbuf *m = bufs[i];
+                struct rte_ether_hdr *eth =
+                    rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+
+                if (eth->ether_type !=
+                    rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4)) {
+                    rte_pktmbuf_free(m);
+                    continue;
+                }
+
+                struct rte_ipv4_hdr *ip =
+                    (struct rte_ipv4_hdr *)(eth + 1);
+
+                struct pkt_key key = {0};
+                key.proto  = ip->next_proto_id;
+                key.src_ip = rte_be_to_cpu_32(ip->src_addr);
+                key.dst_ip = rte_be_to_cpu_32(ip->dst_addr);
+
+                uint8_t *l4 = (uint8_t *)ip + (ip->ihl * 4);
+
+                if (key.proto == IPPROTO_TCP) {
+                    struct rte_tcp_hdr *tcp = (struct rte_tcp_hdr *)l4;
+                    key.src_port = rte_be_to_cpu_16(tcp->src_port);
+                    key.dst_port = rte_be_to_cpu_16(tcp->dst_port);
+                } else if (key.proto == IPPROTO_UDP) {
+                    struct rte_udp_hdr *udp = (struct rte_udp_hdr *)l4;
+                    key.src_port = rte_be_to_cpu_16(udp->src_port);
+                    key.dst_port = rte_be_to_cpu_16(udp->dst_port);
+                }
+
+                const uint8_t *data[1] = {(const uint8_t *)&key};
+                uint32_t res[1];
+
+                rte_acl_classify(acl_ctx, data, res, 1, 1);
+
+                if (res[0])
+                    rte_eth_tx_burst(port_id, 0, &m, 1);
+                else
+                    rte_pktmbuf_free(m);
+            }
+        }
+    }
+
+    return 0;
diff --git a/examples/l2fwd_acl/meson.build b/examples/l2fwd_acl/meson.build
new file mode 100644
index 0000000000..331dd545e9
--- /dev/null
+++ b/examples/l2fwd_acl/meson.build
@@ -0,0 +1,3 @@
+sources = files('main.c')
+
+deps += ['acl', 'ethdev', 'mbuf', 'net']
diff --git a/examples/meson.build b/examples/meson.build
index 25d9c88457..bce2982229 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -24,6 +24,7 @@ all_examples = [
         'ipsec-secgw',
         'ipv4_multicast',
         'l2fwd',
+        'l2fwd_acl',
         'l2fwd-cat',
         'l2fwd-crypto',
         'l2fwd-event',
-- 
2.43.0
