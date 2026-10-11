Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF6CA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 132BB402AC;
	Sun, 11 Oct 2026 20:22:51 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id F2EFA402AC
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:22:49 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6aaebeadf3cso1923570a12.3
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742969; x=1792347769; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dta+FCZ/l64EsAM7LFslwMPscZcnEsyk3AhFM56XajM=;
 b=L8CzzUPLGcaJDp5KUiwky1fkS0vKGxNxFcoJxQjNG5m9D7a6dQP7dbZ6vqTekZ6k7w
 NQOXOOwslKbkeeZaYM14e3/YysgxsxLsm4SAFR+S48lf/jfPchXfBYIJBDdi2LhOJvMI
 KCYPTpJ21FfxCz7NAHEFvZS/eZdYgiCGwpMdLLfI12rknmP6jCaySktZpOfCHOwGkfzk
 hBxQWngxE+5FC/IvzKfDzelgcTpAB5U5EOp+zQXG+YrkUD/JV8SW2HVvcRpyku2CxyzZ
 kPZzSodgGl1C6/dWp771GAL5yVGoGNy8vz6C3ADisSgDxO0/0YJCMy84ZO46fpHIuL3W
 en1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742969; x=1792347769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dta+FCZ/l64EsAM7LFslwMPscZcnEsyk3AhFM56XajM=;
 b=J8prKBMZECaB/WklRkEMyWzv1OiAJZ0qQI/ANz9aTXnOzSX2in6r5Vg/uAY0MUIsgl
 0w9IOZSBA24vGRkT04z1XGC7EGirE3Do14SALz+ACsA3l91pHU5rQW4iZeOjDcsXaDgv
 5ckGgNX3BXwUyn85P9QET5NQswpTD3wORmeQIT+K5Ei7Ukh1u1ZJGO86vcVwwuXcznva
 b/qwAQQRTCpwOhpmlgkrYlusNSIHIWUiegSVaBReqmknSlLE6NFN0vrmc6EFxU73fjTN
 ZTsm6VwkBKCQdwIMsbVYiyqt8HUGpHS+yH7yDJZB71xJuhI+qyXC88TLMQXSV79i+G8I
 Zc7A==
X-Gm-Message-State: AFq9FYLf/6ppNaRHsTgAxy8DO4fjxSAoS94KVIyTpLzo8g516Un5k8+p
 dhbcmiwSlVs7+7eFTFMRcAgtKoaUwB1+sFv+rPEbINN/cjnUNB3l/xV0zKdPLU2ixXc=
X-Gm-Gg: AYBFou1c099qmASdIRBDaR8VRoRGrpmhiN5/8jXXbveamYW4Doeeae/SNBvURu9PHLA
 l6BOH5NeDQQYwFiki+umuwdFRm9MG+Z8rTh+magTjfgQGKogJ6otkAp9KCVd/hGp+NZrOI+pJWK
 ZL9HiiWMtYmjOwevU6E2AbUyEpiR/+ZpXXyLN9znpoOWWGFvSy0tlrKgmszYWrLitpux8mSUT9F
 w/Z4VHD5sIwN7bZNc3ZRoMRHKI7EU2qzn1K1lHmGytdyIrra375HZBUWjILaVRui03E3s7qna7X
 Zylu5ShpW6ZpItEw/0W3INWcsETVB+sK+mxTR3a3XtbAFazv0yxd4AYjVQ7T+Lb2dE7zMnH7cxe
 mgRxhb/+ihun5IQjqCBB8g6WzQaOQcOhAjEE9NuP/y9++Bhc//7uzBRJjJkDnb0c25Q/W/mt+j1
 DNpMkvQbQRpwdbRH5LeXLSk1YanLofJeHWlJFqkQwVpPHpPrOrrzDZKPu80fM=
X-Received: by 2002:a05:6402:51cd:b0:6ab:c31:cb56 with SMTP id
 4fb4d7f45d1cf-6b17c295ce8mr6597628a12.17.1791742969187; 
 Sun, 11 Oct 2026 11:22:49 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:22:47 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 1/9] bpf: document packet callback unload sequence
Date: Sun, 11 Oct 2026 18:21:49 +0000
Message-ID: <20261011182158.124246-2-qm2k21@gmail.com>
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

Add a detailed comment with the sequence diagram to bpf_pkt.c describing
the current de-facto synchronization protocol on BPF program unload
between the control plane and the data plane.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..4223ef624e 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -21,9 +21,72 @@
 #include "bpf_impl.h"
 
 /*
- * information about installed BPF rx/tx callback
+ * CP-DP synchronization mechanism
+ *
+ * After the callback is installed to a port/queue, removing it safely is a non-trivial task.
+ * The `rte_bpf` object can only be destroyed while the callback is not being executed,
+ * while the number of synchronization calls in the packet callback must be minimized.
+ *
+ * APIs `rte_eth_remove_rx_callback` and `rte_eth_remove_tx_callback` remove the callback from
+ * the callback list and upon return guarantee that it will not be called again,
+ * but not that any existing invocation of the callback has completed.
+ *
+ * Current synchronization mechanism relies on the following per-port/queue entities:
+ * 1. List of installed port/queue callbacks ("cbs" on the diagram);
+ * 2. Member `cb` of struct `bpf_eth_cbi`;
+ * 3. Member `use` of struct `bpf_eth_cbi`;
+ *
+ * BPF program is only executed if the first two are set, and increments `use` at the start and
+ * end of the callback execution so that in the safe state its value is even.
+ * This relies on only one thread calling the per-port/queue callback at a time.
+ *
+ * Unload processing starts with clearing the first two entities,
+ * then waits for `use` to become even before destroying the BPF program.
+ * The whole operation is protected by a control-plane-only spinlock (not shown on the diagram).
+ *
+ * Typical sequence of synchronization actions between CP and DP on unload is shown below:
+ * ```
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ *   | CP |                | cbs |         | use |        | cb |         | bpf |          | DP |
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ *     |                      |               |              |              |                |
+ *     |                      |<---------------------- fetch callback -----------------------|
+ *     |                      |               |              |              |                |
+ *     |                      |               |<------------- increment to odd --------------|
+ *     |                      |               |              |              |                |
+ *     |-- remove callback -->|               |              |              |       rte_smp_mb()
+ *     |                      |               |              |              |                |
+ *     |                      |               |              |<------ fetch non-NULL --------|
+ *     |                      |               |              |              |                |
+ *     |------------------- store NULL --------------------->|              |                |
+ *     |                      |               |              |              |                |
+ *   rte_smp_mb()             |               |              |              |                |
+ *     |                      |               |              |              |                |
+ *   rte_smp_mb()             |               |              |              |                |
+ *     |                      |               |              |              |                |
+ *     +-if use is odd        |               |              |              | if cb not NULL-+
+ *     | |                    |               |              |              |              | |
+ *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
+ *     | |                    |               |              |              |  BPF program | |
+ *     | +-while use is same  |               |              |              |              +-+
+ *     | | |                  |               |              |              |                |
+ *     | | +---------- fetch odd ------------>|              |              |      rte_smp_rmb()
+ *     | | |                  |               |              |              |                |
+ *     +-+-+                  |               |<------------- increment to even -------------|
+ *     |                      |               |              |              |                |
+ *     |------------- fetch even ------------>|              |              |                |
+ *     |                      |               |              |              |                |
+ *     |----------------- destroy BPF program and cleanup ----------------->|                |
+ *     |                      |               |              |              |                |
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ *   | CP |                | cbs |         | use |        | cb |         | bpf |          | DP |
+ *   +----+                +-----+         +-----+        +----+         +-----+          +----+
+ * ```
  */
 
+/*
+ * information about installed BPF rx/tx callback
+ */
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
 	RTE_ATOMIC(uint32_t) use;    /*usage counter */
-- 
2.43.0

