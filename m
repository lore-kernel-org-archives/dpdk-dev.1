Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74235CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952BC4064F;
	Mon, 12 Oct 2026 23:10:02 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 1578440430
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:10:01 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so14165145e9.2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839401; x=1792444201; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FgHUPqKWr/RTBy3Wa5jhHVdHbMrv2uFPh8gjHavbtUc=;
 b=ZWHqzqCG/t7VEvGaFQ0GBSho9vV4oM63bdhCT47gBicwhjEa99X2Mv4T7tlPYhFDvg
 QBf1x3QXK9lthfHCK1LuF3bBtTK3CJY4IrKBx57tkvcnMGner2OvFtyLbqwkSjnbLetm
 Dn/lSiayAL15eElics8nAUfw8J6wQiGLAqEp7h4cGhw8vQ/ah9XFYn0y+TIdekf5GkNq
 +yfoWunxnYbrLWddJQNYmlZuzs0I38PcLZv6mlDuSWAsngCHF/L3+BLYyI27rCi0HH6d
 dXyzlhxJi5YYU0Usq2/yDqrzG8n3NSYxzpFnPG9aClnwmPP4SxHXRmSALidgJX/71Ah3
 v6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839401; x=1792444201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FgHUPqKWr/RTBy3Wa5jhHVdHbMrv2uFPh8gjHavbtUc=;
 b=RQNi8RclJZaXgZhbSMVGXfFk6dfjt6ZZxSMTg4a+NP/OFnj+ANnkEsRQVpiGbNAB8/
 Q7LnCe2YsMo1aboY21yPwV6RlH74pKcsWcTRBd3uRr5CcP8Gp5l9m2MRBJQtC/IdJTzo
 wTmmeozFCF5TG1+KXw8hsX791ZXItiog73J/8dYfpjV/C/Xzh2dJxCwrQqpmJDrrzwv+
 RA1G6sFE9lj802riXNCRovhzd2iTmGVRE1XQIIivTbbhxIs+QwIsCnCGOTPymGWLj4Ym
 39OPvR0QtpTn8r3NW+S/irzlzJv3DDfV68sLu1OvI+QmIILqEkBimSbAsJlNRKOtR4Uc
 BOAQ==
X-Gm-Message-State: AFq9FYJIM+1Cwcp1RSio+hL94odawu2/ddV8GU/IoqaSsaD89H2dJ451
 nblCHeouFrVDSAgQcICl4hPL1Wyg5LkDGDcFYqmPyStjPitS7Kqn/uBG
X-Gm-Gg: AYBFou3NYwsuwSsyejVPljfcnjH2Kw7jSTvA+WSvefkkqkrvbC/h0WqOVYx5rBvMQI+
 KA95g0dad02hZYXpgaOlgiOLAygzrO6UeOmSlG7MIxA7B2k8r8Z0houTtyQKDAq67riOlPgTVNk
 aLkdI9GAvoFEq9Cw33oKnlFg0kZCrphDXqTj/EpQ7twI+8/juK6nfjDLJdcUQC85TPYi38tyYqy
 /6Bxm3KRd3SYtwr2fK7F2w00LoVlq471xnEif3ulWp1f/yScSgiTB0q+y2mBiIhCwwJVmYS8HXX
 8IY6/+4Fu2TYOrS0Vb5ivjyh7Blob2SfM+hwhZYMz3SVpwcIqLEq/GWVS5/mcQXRRBGKQeP9kl+
 pP/RGDrGocy1WLoQ0tla9K7lnBc7j21Dv8pPWjmVn5Xsag3Ync3Nw2ZulRyyHaYtBIWRwaQd+lq
 FY7F83ZoCZJXqjV932whU0kOOLmeU7KhZ0Fe7vHio4ZiL4BOCoLW+d43lcvKQ=
X-Received: by 2002:a05:600c:a088:b0:4a0:333:253a with SMTP id
 5b1f17b1804b1-4a18e49c331mr206876615e9.14.1791839400428; 
 Mon, 12 Oct 2026 14:10:00 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:09:58 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH v2 5/9] bpf: simplify callback inuse tracking to boolean flag
Date: Mon, 12 Oct 2026 21:09:12 +0000
Message-ID: <20261012210917.161343-6-qm2k21@gmail.com>
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

The even/odd usage counter semantics in struct bpf_eth_cbi was
originally used to detect when in-flight packet callbacks complete.
However, with at most one thread running the callback per port/queue
pair and no risk of the ABA problem, a boolean flag (true for in use,
false for idle) suffices.

Change member use to bool and replace the counter increment in the
datapath with stores of true and false. Simplify bpf_eth_cbi_wait()
to a direct pause loop waiting until the flag is false, removing the
now unnecessary RTE_WAIT_UNTIL_MASKED macro and casts. Update the
documentation and synchronization sequence diagram accordingly.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 49 ++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index b1e25e4e7c..429feb76ad 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stdbool.h>
 
 #include <sys/queue.h>
 
@@ -36,12 +37,12 @@
  * 2. Member `cb` of struct `bpf_eth_cbi`;
  * 3. Member `use` of struct `bpf_eth_cbi`;
  *
- * BPF program is only executed if the first two are set, and increments `use` at the start and
- * end of the callback execution so that in the safe state its value is even.
+ * BPF program is only executed if the first two are set, and sets `use` to true at the start and
+ * to false at the end of the callback execution.
  * This relies on only one thread calling the per-port/queue callback at a time.
  *
  * Unload processing starts with clearing the first two entities,
- * then waits for `use` to become even before destroying the BPF program.
+ * then waits for `use` to become false before destroying the BPF program.
  * The whole operation is protected by a control-plane-only spinlock (not shown on the diagram).
  *
  * Typical sequence of synchronization actions between CP and DP on unload is shown below:
@@ -52,7 +53,7 @@
  *     |                      |               |              |              |                |
  *     |                      |<---------------------- fetch callback -----------------------|
  *     |                      |               |              |              |                |
- *     |                      |               |<------------- increment to odd --------------|
+ *     |                      |               |<------------ store true ---------------------|
  *     |                      |               |              |              |                |
  *     |-- remove callback -->|               |              |              |       rte_smp_mb()
  *     |                      |               |              |              |                |
@@ -62,17 +63,17 @@
  *     |                      |               |              |              |                |
  *   rte_smp_mb()             |               |              |              |                |
  *     |                      |               |              |              |                |
- *     +-if use is odd        |               |              |              | if cb not NULL-+
+ *     +-while use is true    |               |              |              | if cb not NULL-+
  *     | |                    |               |              |              |              | |
- *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
+ *     | +----------- fetch true ------------>|              |              |<-- execute --+ |
  *     | |                    |               |              |              |  BPF program | |
- *     | +-while use is same  |               |              |              |              +-+
- *     | | |                  |               |              |              |                |
- *     | | +---------- fetch odd ------------>|              |              |      rte_smp_rmb()
- *     | | |                  |               |              |              |                |
- *     +-+-+                  |               |<------------- increment to even -------------|
+ *     | |                    |               |              |              |              +-+
+ *     | |                    |               |              |              |                |
+ *     | |                    |               |              |              |      rte_smp_rmb()
+ *     | |                    |               |              |              |                |
+ *     +-+                    |               |<------------ store false --------------------|
  *     |                      |               |              |              |                |
- *     |------------- fetch even ------------>|              |              |                |
+ *     |------------ fetch false ------------>|              |              |                |
  *     |                      |               |              |              |                |
  *     |----------------- destroy BPF program and cleanup ----------------->|                |
  *     |                      |               |              |              |                |
@@ -87,7 +88,7 @@
  */
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
-	RTE_ATOMIC(uint32_t) use;    /*usage counter */
+	RTE_ATOMIC(bool) use;    /* usage flag: true when in use, false otherwise */
 	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
 	struct rte_bpf *bpf;
 	struct rte_bpf_jit jit;
@@ -97,12 +98,6 @@ struct __rte_cache_aligned bpf_eth_cbi {
 	uint16_t queue;
 };
 
-/*
- * Odd number means that callback is used by datapath.
- * Even number means that callback is not used by datapath.
- */
-#define BPF_ETH_CBI_INUSE  1
-
 /*
  * List to manage RX/TX installed callbacks.
  */
@@ -141,20 +136,20 @@ static struct bpf_eth_cbh tx_cbh = {
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use++;
+	cbi->use = true;
 	/* make sure no store/load reordering could happen */
 	rte_smp_mb();
 }
 
 /*
- * Marks given callback list as not used by datapath.
+ * Marks given callback as not used by datapath.
  */
 static __rte_always_inline void
 bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
 	/* make sure all previous loads are completed */
 	rte_smp_rmb();
-	cbi->use++;
+	cbi->use = false;
 }
 
 /*
@@ -163,18 +158,12 @@ bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 static void
 bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 {
-	uint32_t puse;
-
 	/* make sure all previous loads and stores are completed */
 	rte_smp_mb();
 
-	puse = cbi->use;
-
 	/* in use, busy wait till current RX/TX iteration is finished */
-	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
-		RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
-			UINT32_MAX, !=, puse, rte_memory_order_relaxed);
-	}
+	while (cbi->use)
+		rte_pause();
 }
 
 static void
-- 
2.43.0

