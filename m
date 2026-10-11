Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3671CA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B09A7402B3;
	Sun, 11 Oct 2026 20:23:11 +0200 (CEST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id A7E4940679
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:23:09 +0200 (CEST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so870025a12.3
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742989; x=1792347789; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EInIEqe2qN0QmAFoOBmNLVtVXduBjCoXh2vn2xyu2Ok=;
 b=SPB7tmR5B9qyecglTKSx7s5YfJIAcfuEsjSEY5TT6Z5dbzhzRA6CJPD6svpHRcjWl7
 T6e+tXHpVlWL+OQOVOTIfUmbbhilfY38IQKLTI0LBDF12sTuTfjoQfCOZCkl0IZoE/xg
 HDWNHjh1C2XEdmYeanqXqp0VIJ4dL9EneCL5htnNM+BUV4cfocqXY+LhVEbXYjW0YzVk
 DH/LnkQwywWQFhj+Ns2o9Ra2p2H81zmlVMwWaS2lEz8uSGhgV4wO2PXdcFVD2bzTUspj
 7P1ImpveICOINhYcWXRscjeVH1/KzusEUQYu7V2qSQ3+lXvydyDnU8BbGDbDxWlUFdL6
 As3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742989; x=1792347789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EInIEqe2qN0QmAFoOBmNLVtVXduBjCoXh2vn2xyu2Ok=;
 b=yKRCb8Qmdk9VK2cDxCMxD1logcRWMYOWQk9yNXUVBOEs0auh4DFphj3OQ0PTKaBbxI
 KrIraQveKGCcqJULsRgS5TPReNyzp6ArW+PU10f2PqIS+6wD6KkfYV8IyEb6IIRw3o+f
 G5tbcgZTvYL0yiFieL/YOxyCJoImW8sVr/ElbX36vs47k/mlu1CpLsh1qLxnxUH3Jln/
 JYQO/bKkAtTCKLNMGx87dQ4vR35KPg6L8UWl+FDhid9w/zoZzwnHP3LCS9l8LTMmugxo
 8P1JhZ1F0FnXqqZsqsyjxLt6utPH/eARyJj2QTvvgI6FOTtcmaA5P7C7rkppmOJ+AhF2
 Rnpg==
X-Gm-Message-State: AFq9FYLuJ+ZpbcN7mBIV1MOpIrHxHS9crDIdhP9IeeIwubufVE8sdfu1
 Avk2FBkuk9FoiAaVw/5o20qFJNNzZrep+EUlRz1Xf4Ts1G+h3prnuzXFvm4xdHgXCdQ=
X-Gm-Gg: AYBFou2M3UTF+rACZmJmWE41UMeEmapELQ1zXS8bqPItA6kvoyuyvemUmX7eLUvzZOy
 +s/TOW+CeI+iZbFWcaR+qS+L3gWeIJc7J1CXT7k4R1FW5dcrd9ikBhJEwXcPWMM0+SpeCpk+1G0
 /ZbesYAkfGK4yDaGbeyUouppfZ5VDu68Z8TMXw6E3OSzmnewNoss+TOepgyXnzLn0Flr2zTsnVA
 1IWNvMZ3e1QWkp6ykC0fuVFblJUZnLMvjJe1YBuVAjRgi4DgXoHNc2hMhVEvoYDdBq+k+yaFIxS
 dmQx6z2KNqyn1qpDq+l0eZXEqHWOwtKmaNeGjBV/afbXfeCgy2owFEc49u0mcugZ2Xtvo1Fxf4v
 5omgKJ/l4Gg718tYfXt1dIDzf0QPRrXB4HLQhmEF93/OLJ7KZDOWQr3HPkSg7MMVojMsyk/+HZ1
 JLmhmq73GRxAU8FOI6Gq0dkCBh89zZlo0qxNCGrOGNpi5KjHq4/3/22w010TQ=
X-Received: by 2002:a05:6402:c4e0:10b0:6b1:a86c:73 with SMTP id
 4fb4d7f45d1cf-6b1a86c024cmr1605253a12.36.1791742989126; 
 Sun, 11 Oct 2026 11:23:09 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:23:07 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 9/9] bpf: make callback handle atomic with relaxed access
Date: Sun, 11 Oct 2026 18:21:57 +0000
Message-ID: <20261011182158.124246-10-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182158.124246-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
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

The callback handle member cb of struct bpf_eth_cbi is concurrently
cleared by the control plane on unload and read by the datapath to
decide whether to execute the BPF filter program. Without atomic typing,
this concurrent access constitutes a data race in the C11 memory model,
even though hardware pointer accesses are single-copy atomic and untorn.

Change cb to RTE_ATOMIC and use rte_atomic_load_explicit() and
rte_atomic_store_explicit() with rte_memory_order_relaxed for all its
accesses. On modern architectures this produces the exact same machine
code while eliminating undefined behavior.

In addition, marking cb as atomic improves code self-documentation by
making it immediately evident that cb is an active part of the cross-
thread synchronization mechanism on par with use.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 9dee001f0f..fabdb52d7e 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -84,7 +84,7 @@
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
 	RTE_ATOMIC(uint32_t) use;    /* usage flag: 1 when in use, 0 otherwise */
-	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
+	RTE_ATOMIC(const struct rte_eth_rxtx_callback *) cb;  /* callback handle */
 	struct rte_bpf *bpf;
 	struct rte_bpf_jit jit;
 	/* used by control path only */
@@ -318,7 +318,7 @@ bpf_rx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	cbi = user_param;
 
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -335,7 +335,7 @@ bpf_rx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -351,7 +351,7 @@ bpf_tx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -367,7 +367,7 @@ bpf_tx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -388,7 +388,7 @@ bpf_rx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -405,7 +405,7 @@ bpf_rx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -421,7 +421,7 @@ bpf_tx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -437,7 +437,7 @@ bpf_tx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -489,7 +489,7 @@ static void
 bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
-	bc->cb = NULL;
+	rte_atomic_store_explicit(&bc->cb, NULL, rte_memory_order_relaxed);
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
@@ -500,16 +500,21 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 static void
 bpf_eth_unload(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
 {
+	const struct rte_eth_rxtx_callback *cb;
 	struct bpf_eth_cbi *bc;
 
 	bc = bpf_eth_cbh_find(cbh, port, queue);
-	if (bc == NULL || bc->cb == NULL)
+	if (bc == NULL)
+		return;
+
+	cb = rte_atomic_load_explicit(&bc->cb, rte_memory_order_relaxed);
+	if (cb == NULL)
 		return;
 
 	if (cbh->type == BPF_ETH_RX)
-		rte_eth_remove_rx_callback(port, queue, bc->cb);
+		rte_eth_remove_rx_callback(port, queue, cb);
 	else
-		rte_eth_remove_tx_callback(port, queue, bc->cb);
+		rte_eth_remove_tx_callback(port, queue, cb);
 
 	bpf_eth_cbi_unload(bc);
 }
@@ -586,6 +591,7 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	struct rte_bpf *bpf, uint32_t flags)
 {
 	int32_t rc;
+	const struct rte_eth_rxtx_callback *cb;
 	struct bpf_eth_cbi *bc;
 	rte_rx_callback_fn frx;
 	rte_tx_callback_fn ftx;
@@ -632,18 +638,20 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 		return -ENOMEM;
 
 	/* remove old one, if any */
-	if (bc->cb != NULL)
+	if (rte_atomic_load_explicit(&bc->cb, rte_memory_order_relaxed) != NULL)
 		bpf_eth_unload(cbh, port, queue);
 
 	bc->bpf = bpf;
 	bc->jit = jit;
 
 	if (cbh->type == BPF_ETH_RX)
-		bc->cb = rte_eth_add_rx_callback(port, queue, frx, bc);
+		cb = rte_eth_add_rx_callback(port, queue, frx, bc);
 	else
-		bc->cb = rte_eth_add_tx_callback(port, queue, ftx, bc);
+		cb = rte_eth_add_tx_callback(port, queue, ftx, bc);
+
+	rte_atomic_store_explicit(&bc->cb, cb, rte_memory_order_relaxed);
 
-	if (bc->cb == NULL) {
+	if (cb == NULL) {
 		rc = -rte_errno;
 		bpf_eth_cbi_cleanup(bc);
 	} else
-- 
2.43.0

