Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D128ACA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:10:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1899440695;
	Mon, 12 Oct 2026 23:10:11 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 7A463402DA
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:10:09 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49e73611928so27236235e9.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839409; x=1792444209; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=779+S6pOMElGNEzC0QJFMtO5inscG4w9SO7LoLWHINs=;
 b=PGlSHoWtrydLgq6fkOCoelN1cK20rvSIoAv7ql1NmzUEdKPn9SQExcj6P+Haw2JoQq
 +sNSwdBTkQ0LaTlwS+1/xis99M0baMUsBN0zB7jTCdDwR2ZfwiG9EosaG77AawSjZxL7
 nDMlhY8Re+Pm09jj12u+3y3pe87O0VTJTdKXcKKT8FC9qqGzyawbeBuFn+CZF27Aoyy4
 SGVj+W+5EhYONU1cNW2e5MamTPcsyyQNdRi5GtcDuQWQROJOCKZlffu0F2GaqH12KepB
 hrgmxyiKJzbsv93EM3RxnTLhRcGpdxU1Gyp9QV68NzcuVVZxiGFJZxy2z9CWzHjMVZqT
 2mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839409; x=1792444209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=779+S6pOMElGNEzC0QJFMtO5inscG4w9SO7LoLWHINs=;
 b=2F7fyXXyIq1VnzPUjdRAyAc6sBIaEXl90JSaMPObP27ouwL9yOofqRN4EcVz6s4jPq
 cAPxW1DMY3CERxKt7kpIFCtuecRGX+AYUe5+tHrhNyZiE0IRH2aoyNb2UQySI9jmdLy9
 UTaPRyiybzMyBbWcQ5kkR0/ppGvPKMcZwpeE7xJd3ROulcsAke1SBaXQQKUnS8ozQAwF
 EZCh+LUdQeoYgczS+ieWUjfAQYZ7pgwFGprxOPCRlbBEeCkaWbMHVkDpg7yGsP59lR4A
 zc2tUVJoOAUdi7Ce7YqWtbio/6Vq025PRNJO/aU+kiW289Nk72Azc7glRe/O/1sZOx+j
 slHg==
X-Gm-Message-State: AFq9FYLJLniOEg8h2dl70O9+XLbhN7F9JbiX+hP4oc2v9IwCDHBRpSXN
 W9r814Mu0f3wh0ci0+skd7CZHu5oNPfjS5C7+7jnDxjOIKNH/Z3MkD4hB0E3JeEVQ5o=
X-Gm-Gg: AYBFou04xArlO3vgGLjHrDNndVKX07IYAMRgJNrsG4R8HLuWKWAPQS4BUIuq08U9xJ9
 rksJr/+EG+qrj/2Q/lSS9V7PbsN1LCs3qK62q445JjKhGbfNcRWrpcbXhXhfiBByDdQDgiDSPY9
 ygTReGytVjBq+BtE/Jpi/tvb25VIfJCg/Cr9Km6ibpt0OpExfYckxz380awD/Ct9IJVBoCrVNgn
 DaD5uLiz/AjiN+F/Db43kkcpagpCxvmatg8/i7Ujk5lPDtu3fTvm5F7N9BH2tYmQsvf6c60p9qL
 sWsnWwetLjZtiasYOT4cTPP6hWR3MGYEUiAo6eFziSwFJFT/KL829mHn0dg/zOhbUgNrfKq7iQU
 DjZmKKMk852+nxKhwrZxgy6xZoi4wnncJecj8tWbAhXnPv1oFgkrAXmiWsha3mfV8Wq5ryozPla
 1W6szp3y+zaXeZNgCZTh9P8cxgYsZtGOL1ve6SF9sdF/B346VkuJ3eGmjeJ8IYKwRQPuw+Jw==
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a18e447d8bmr197641425e9.2.1791839409042; 
 Mon, 12 Oct 2026 14:10:09 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:10:08 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 8/9] bpf: make callback handle atomic with relaxed access
Date: Mon, 12 Oct 2026 21:09:15 +0000
Message-ID: <20261012210917.161343-9-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012210917.161343-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
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
index c5fa85bf84..0b59ce22f1 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -85,7 +85,7 @@
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
 	RTE_ATOMIC(bool) use;    /* usage flag: true when in use, false otherwise */
-	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
+	RTE_ATOMIC(const struct rte_eth_rxtx_callback *) cb;  /* callback handle */
 	struct rte_bpf *bpf;
 	struct rte_bpf_jit jit;
 	/* used by control path only */
@@ -313,7 +313,7 @@ bpf_rx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	cbi = user_param;
 
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -330,7 +330,7 @@ bpf_rx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -346,7 +346,7 @@ bpf_tx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -362,7 +362,7 @@ bpf_tx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -383,7 +383,7 @@ bpf_rx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -400,7 +400,7 @@ bpf_rx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 1) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -416,7 +416,7 @@ bpf_tx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -432,7 +432,7 @@ bpf_tx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 
 	cbi = user_param;
 	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
+	rc = (rte_atomic_load_explicit(&cbi->cb, rte_memory_order_relaxed) != NULL) ?
 		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 0) :
 		nb_pkts;
 	bpf_eth_cbi_unuse(cbi);
@@ -484,7 +484,7 @@ static void
 bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
-	bc->cb = NULL;
+	rte_atomic_store_explicit(&bc->cb, NULL, rte_memory_order_relaxed);
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
@@ -495,16 +495,21 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
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
@@ -581,6 +586,7 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	struct rte_bpf *bpf, uint32_t flags)
 {
 	int32_t rc;
+	const struct rte_eth_rxtx_callback *cb;
 	struct bpf_eth_cbi *bc;
 	rte_rx_callback_fn frx;
 	rte_tx_callback_fn ftx;
@@ -625,18 +631,20 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
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

