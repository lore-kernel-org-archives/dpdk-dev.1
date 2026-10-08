Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D49CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:36:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FEEE402BF;
	Fri,  9 Oct 2026 01:36:55 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id EAEE6402B8
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:36:53 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-86aecf49833so823715b3a.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502613;
 x=1792107413; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YsTF1Gck/RGTU2F5jGJOGpXHflgcgLJXFKYUo0812tU=;
 b=uwbVD/tjVKMyRIUDMbE0xi0e13Uln9Ga2db5PswcJrjUABjr7BmzLnqlfIZ2foDn7R
 MYnZfq6Y42LnuZdo5u22Ovz47jkPRZ52h0rAXpLMUNjdis5puoyMtQ/TyTEbav2wdl1E
 xUunNc0zQarcbsV9SAymBWAQ4aeOTJrvF76BJB6E0mn7Kd4eEJ0W6MsIRQ1+L9g2AqdL
 mSRIr8YFFJqSqu7L5eQsRGXSqycTBTh0YeiXjwJfxMtS8C/0z1YEv5WM3SfqAD2sZrGl
 4DZ032Y3pkx1a6p2beASfP4pVyZc3hYOnXC+wEXo4IoEz1ce3dyuwMx0pGlnZtqj7zOL
 RVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502613; x=1792107413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YsTF1Gck/RGTU2F5jGJOGpXHflgcgLJXFKYUo0812tU=;
 b=qNxnVruyhhHMYiQGk/AoK/Ze0jEYzyaCUcIYGpHn0NrpdKO1H4W7b4lzxLAoNBuAJ8
 2CBm4QyY4X6ZLY7ctv2GznUqRZfcaVBusWK8ZlUdLVVgHg4HJHaESKupR6C1X1EKwUFm
 dJ3mazFEImbK7QGEPDVznlx6ryHS7hC2/sFFs+tnxN9Qk9GvlwlDD7ws5qQtNiclOP4F
 TrfxreKBDjOfhg+rVYHoUdqZv5vLi1Qfopwt0Cx4PW7wiKQK7BnFWQA7mYGqKoiCubcr
 lB5nRYj9JOoj9y0PEBS/1f4IXTGO6ztxyHKdZP0fDUAgoUp0ag5TfmuZccQVAYxwr7JT
 rbvQ==
X-Gm-Message-State: AFq9FYKFqx+MSL/gEgz5Aky7NXnEFFz3T65yxYGeKeYtiij7ZZMFbMZv
 uH9DiZmGbI9cZv3OSNDyFSg9S0CzgHVx9GHCvGbAju3bSN99ohv6Ff6JdyMkBqUORZSCrTyw0EQ
 WLz7/spo=
X-Gm-Gg: AYBFou3p61CPNdRSuDHhNYNSOpdYvCPp0CJiJkr3xk8ZwD8AKMTbxOX5N7NKiw0P4jK
 Z9gie4GqjNTJt1FNW3kLi1ZIwtQQXaOAqtldrLYUsSlsxxbw9RYVATwjUHBb6Kk7ys3askGW/DJ
 CAtr1BPjLSrasbi/dYYr3ZShhJvEn4KYAiTDJA8uaDMpNsqS3vvV+zixWFkHuU5pjIH+Ywx4+Kd
 Gut1kP01zsYNO4nlvFddSJ0Q04MJsORN1Fl8XmpdgteGzVYYcWbvhNBX2chFQBC19IrwcbgFZnL
 siRxcy2rxelNGaFpp9eh+DdWPpNzmGI+mJDP4COFpvoCc2jvwLWTRV/t36j+07JCcdZ/k4jIFAF
 ONwioqzVO0B+ah4UH00xnS5m92Hy28RzUt+qacVss8Zg5qAe107vEkxxyutda6+SCtnLdWtBqHC
 3ASkAU+S0NyU6CKSB1hawJ55rgKyTOjOt7oLNGLnG+oSEcM2a38jkletg7FORjheW1xjQOCZRZq
 fMDctZ4kIEtEcIEvcn0/vocL0uPG2scJGEpnw==
X-Received: by 2002:a05:6a00:7605:b0:857:73c3:446a with SMTP id
 d2e1a72fcca58-89695ec5cc5mr406877b3a.25.1791502612950; 
 Thu, 08 Oct 2026 16:36:52 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11 fences
Date: Thu,  8 Oct 2026 16:34:54 -0700
Message-ID: <20261008233649.1260843-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The rx/tx callback use counter relied on rte_smp_mb() and
rte_smp_rmb(), which are deprecated. Convert it to C11 atomics.

The counter is odd while the datapath is inside the callback and
even otherwise. Only one thread at a time does rx/tx burst on a
queue, so the counter has a single writer and is updated with a
plain load and store.

 - bpf_eth_cbi_inuse(): keep a full barrier after the store.
   The datapath stores the counter then loads cb; unload stores
   cb then loads the counter. A seq_cst fence on each side makes
   sure at least one of them sees the other's store.

 - bpf_eth_cbi_unuse(): use a release store instead of a read
   barrier before the increment.

 - bpf_eth_cbi_wait(): use acquire loads to pair with that store,
   so rte_bpf_destroy() is ordered after the datapath's last use
   of the program.

 - bpf_eth_cbi_unload(): drop the barrier; bpf_eth_cbi_wait()
   starts with one.

With enable_stdatomic the old cbi->use++ was a locked add. On x86
that build now does one locked instruction per burst instead of
three.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..95f76e47c7 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -36,10 +36,6 @@ struct __rte_cache_aligned bpf_eth_cbi {
 	uint16_t queue;
 };
 
-/*
- * Odd number means that callback is used by datapath.
- * Even number means that callback is not used by datapath.
- */
 #define BPF_ETH_CBI_INUSE  1
 
 /*
@@ -74,15 +70,34 @@ static struct bpf_eth_cbh tx_cbh = {
 	.type = BPF_ETH_TX,
 };
 
+/*
+ * Removing an rx/tx callback involves two steps (similar to RCU).
+ * The callback is first removed from the ethdev queue so that
+ * it will not be used by later burst.
+ * But the callback may still be in process or the core may have
+ * raced and seen the old callback.
+ * The use counter is used to indicate that it is not safe to
+ * free the BPF program yet.
+ * The datapath makes the counter odd on entry and even on exit.
+ * During unload, if the counter is odd then it indicates
+ * we must wait.
+ * This assumes that only one thread at a time may do rx/tx burst
+ * on a queue. Therefore the counter has a single writer and the
+ * increment need not be atomic.
+ */
+
 /*
  * Marks given callback as used by datapath.
  */
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use++;
-	/* make sure no store/load reordering could happen */
-	rte_smp_mb();
+	rte_atomic_store_explicit(&cbi->use,
+		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
+		rte_memory_order_relaxed);
+
+	/* full barrier: count must be visible before cb is read */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 }
 
 /*
@@ -91,9 +106,10 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 static __rte_always_inline void
 bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
-	/* make sure all previous loads are completed */
-	rte_smp_rmb();
-	cbi->use++;
+	/* release: pairs with the acquire bpf_eth_cbi_wait() */
+	rte_atomic_store_explicit(&cbi->use,
+		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
+		rte_memory_order_release);
 }
 
 /*
@@ -104,15 +120,15 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 {
 	uint32_t puse;
 
-	/* make sure all previous loads and stores are completed */
-	rte_smp_mb();
+	/* full barrier: cleared cb must be visible before counter is read */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	puse = cbi->use;
+	puse = rte_atomic_load_explicit(&cbi->use, rte_memory_order_acquire);
 
 	/* in use, busy wait till current RX/TX iteration is finished */
 	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
 		RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
-			UINT32_MAX, !=, puse, rte_memory_order_relaxed);
+			UINT32_MAX, !=, puse, rte_memory_order_acquire);
 	}
 }
 
@@ -439,7 +455,6 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
 	bc->cb = NULL;
-	rte_smp_mb();
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
-- 
2.53.0

