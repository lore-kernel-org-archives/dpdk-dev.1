Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19368CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE7854042E;
	Wed, 14 Oct 2026 00:34:57 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4A7DF40269
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:34:55 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so17557665ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930894;
 x=1792535694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+pUOAJABl2KbPmn0wk7iSeZ874SdIsQjZ/9d7IlcaGQ=;
 b=mQ23iN7WRxLjqE7ILEmUHtVfryCS86M5EiBMuxoQJfrH+k5AJii6eMOJAXmjD9uTKX
 k5vZsybkpi9O4UPNmaGpqVgJw5IPsjpIw4uQN0oao0S28lXewTdKqcs++gUNpb4KrJ6I
 1mlVbe9wUS9V6mFImEi7zjtuGrV7JDYT436yrruljM2vUfmUTwtqW3ecI01n+kgM4vu8
 SqyqJyx6W8eAwi+hNpafTxJ4C0DHl+w+SyYeBp9HtCl5hP7gHe3aSgB8Vpt7y33laW8i
 Ahyl8iz0SbFn6dw4q6wjc5V7TDHBikXoe2aVUjdh4SQcopgdWhyhkrE0eFCIjPjz45br
 vK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930894; x=1792535694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+pUOAJABl2KbPmn0wk7iSeZ874SdIsQjZ/9d7IlcaGQ=;
 b=V/5VCbHSROsx5f2y8KFZxwr+tutQDQwKpERzrujFzYuQCkrMehMFdvdKqiAhhEmUsp
 5WBKlRbrwSX6ZHtx7lFsrBocjVNstwyq1vUBPEG6L1tG603IQ9+qCg18qm4uJkc/EzwO
 P4Fyrz4Z7MnQibjAYQ1JIne1AYsdRRj5Tv+MOJLKHyruAhq05zhqAk6lN8h6MGFVWgpI
 QVVEuRL+KUIP6u3hWfs/qUqgblqc5c8yINCkJYw073Zook93kBUihiSTEhhN0Q3MZsmp
 MJ6dbyF2f77BIvCgq0qnGcEyeGUiIYfX8PNT/MT+JVvIi8s9o+HNUSBDcvLICih0W6SA
 Vrng==
X-Gm-Message-State: AFq9FYJ7oPVP9g/a53Wze7Z4wX8i/2lpdI9oHBdDQ8rCJ2mT40Tsxknb
 kIfINspHxxt2VVLuIieIXA/mhFdiqM5P+EXU1Q9hyKguuDbWYkBfDhBJy+8/xe850IpcWLhUSkQ
 7YTmBrBQ=
X-Gm-Gg: AYBFou1lPD3gq687U7wrG4n5mlmGvvjzBAeA4xJ4mLkWHOEjLrw0YJ0ejF+hs+UJxuX
 jij8CH91uGdt1nteSClabwBXZx5sZANGuZ5h6KYnAfmWrEX2f5qbw+zDG38trxpVX+vI10Z/48t
 Gx1q4eJic3nIJw3dWbvNqAn3KZwWwdCWetvNkizbrDhD2fGWAeCjw61ezCzaZhOmzI3eAW4Z0ox
 J0IlWT9Icr6V2m1H/wKHIjKzZQPmTnM/mCP+ncO3mXzyinP6BEtbB0Z4QPRW8ie3u+G+uEBQJWy
 Kf4FW8TjDgH3+t1NDCvTvJDE709CjIMUfEppzQJOHEYXZRMdDYosYBEELC8Q6AGJaFgsOeY2Rtl
 qzgkl0SPPj0G9SfTtciyhJoeoFFcWaP9zTNaXu4RXPXYtQRpwp49nMOsUt+kHdF7TGnAOnKTrh3
 rbT6S33urzdr0lLEBVojkNGrgt3hhWPWJGDGc3nXNv9xTmksDyST8n4CxmgsO66eMBQUSaHSF3X
 hSHJgrSK+zICrIt4oe/2g/lgrQtJ9uF4uwlMw==
X-Received: by 2002:a17:903:1a28:b0:2e8:40a0:6fa8 with SMTP id
 d9443c01a7336-2e842ac48e7mr87892585ad.14.1791930894364; 
 Tue, 13 Oct 2026 15:34:54 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:34:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v4 01/29] bpf: replace deprecated SMP barriers with C11 fences
Date: Tue, 13 Oct 2026 15:22:14 -0700
Message-ID: <20261013222410.2257622-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Convert the rx/tx callback use counter from rte_smp_mb() and
rte_smp_rmb() to C11 atomics.

The counter has a single writer per queue (MT_LOCKFREE tx is not
handled, before or after), so use a relaxed load and store instead
of a locked increment. Keep the seq_cst fence in inuse and wait for
the counter/cb store-load pair. Use a release store in unuse paired
with acquire loads in wait, so rte_bpf_destroy() is ordered after
the last datapath use. Drop the extra fence in unload.

With enable_stdatomic, x86 now does one locked instruction per burst
instead of three.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..f6acc69d25 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -80,9 +80,13 @@ static struct bpf_eth_cbh tx_cbh = {
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use++;
-	/* make sure no store/load reordering could happen */
-	rte_smp_mb();
+	uint32_t puse = rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed);
+
+	/* increment use count: does not need to be locked */
+	rte_atomic_store_explicit(&cbi->use, puse + 1, rte_memory_order_relaxed);
+
+	/* full barrier: count must be visible before cb is read */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 }
 
 /*
@@ -91,9 +95,10 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 static __rte_always_inline void
 bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
-	/* make sure all previous loads are completed */
-	rte_smp_rmb();
-	cbi->use++;
+	uint32_t puse =	rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed);
+
+	/* release: pairs with the acquire bpf_eth_cbi_wait() */
+	rte_atomic_store_explicit(&cbi->use, puse + 1, rte_memory_order_release);
 }
 
 /*
@@ -104,15 +109,15 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
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
 
@@ -439,7 +444,6 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
 	bc->cb = NULL;
-	rte_smp_mb();
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
-- 
2.53.0

