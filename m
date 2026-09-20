Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7784C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 231F140A81;
	Sun, 20 Sep 2026 20:13:56 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 0BD5C402D6
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:13:54 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so976080a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928033;
 x=1790532833; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A0byCcrqRG80fZtY3cCsJ7Lm958MapRpH13CsVKsrZc=;
 b=QYnPvkB74i2O8+k7lkNnjNuxubKIBrx/UJQxn3hotMGDA9wUf91+RGPIYQ83nGTQGO
 fjc7W+r1JRCQuhNkafbDg4fXmDhmyrNco6WGtzC5lOwBDi6aVhd0juxD5nh1DPoRnzUl
 HcTvEfG3zop2BfjJ4gF0I5L12LKm1NdJ/9MKYijD83rVFdWaAAnXsJjTGlwzRkZctVf2
 vQ7TgpPdapGXMY7MMbA0BcLHwl4oXsKiB/v1/9EeyS7Tj+3RCDjaa2OHKUrWH5Ja8sYb
 g8/32eeaSnsN5X2amNHcTeWqxjdVrQHESrP5Ch4HJpfmwTMg/YQwgaiUOmGfAbi6onPF
 ptGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928033; x=1790532833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A0byCcrqRG80fZtY3cCsJ7Lm958MapRpH13CsVKsrZc=;
 b=wM1iTcc9A/BcnNlGtqOVGN7eFAdtFYA5w7c2GpYOV1CWEaz06+/5qYfCwNJpRlZGre
 CRMVkfMCshYX8QwE7cAY3IMV5tXau/FvH53jkbWWNcnQ23J340mJh3pMrrhlwpLolFa5
 IsKGxWXRAw6U0gejWELP+GcM4FNiVVM8Tmc0tP4RPqVmfk8zMhYZLlZTOiUAB9Efcnmh
 bDcF+RJNLD8PMdkwZRmTLzGsK54/9GoCQAPayFzfS+aIBzaTqJ1KjS7iOcRA6jkd1PQO
 fAyzek+5hSaKt0Kv0LtlzirqDO2f5n1/gUpoWZYgwWbI/nFYbFTGcCcwB5C2/4v//jPU
 nljg==
X-Gm-Message-State: AFuF++lYaBlCqzVNPNzlg0dLxNjim/7bouOvZX6m8TRvDvOtQjESjNjX
 dSAYcYtjflEvXbyunhwmDya++yAkDwEqvzPHAZSc5+Ut+lOICij+F3+8jO4KAkAq7QNGKNqPwZF
 Um0n3
X-Gm-Gg: AYBFou2ADOccFBQJuPP5KU5NHTWteBTfm1wImlD1JEUNvIU9YbPXFAcwviS9+YxH0f4
 Vw/KpNQiAJp8gzXYuV2AoSy6PlGjeVUB8JySBXpFu+8aTh0k7Ag5xf/PtxzhKF8EUWeMVxuCHcX
 /udta1dJmWw81hzzqXEnZjlb4JwNK99uJ49eSKRszDbiJqXblUZ19JRILC+JvM+f0qk3ngdIXju
 Gb3d78fDoFnu8F+4ogOGoPVHFC9W7vF/e1OzNIctiv3KGWWavnd8TT2eb3meo+ezE2SXAmTGjpg
 NBrpFnB0xFWNRcpMHYZop6JtIVIHchcNmtFNzygzgc2XOJ+tmoHqmfhql0Be3OuBknbJAvOIEXO
 dH0wv2CL68u6hqh1mhLOdkodgzrz7bkMUNlojzD9ba0GDOuT4uxbt553wy/cEiemAqhUph9w1vA
 hvNXYY6MnKL+JqIdcSlfJVNrvBpkRXOYtfM0SfuTBaVRIqDm3gzbd34QEICeHLOlSjRfapkbR2Z
 nyeQDoSeEUpVixEtebYxlrVbUWsZCI6KpY8uw==
X-Received: by 2002:a17:90b:51c1:b0:39e:6c68:fd92 with SMTP id
 98e67ed59e1d1-39e6c68fee8mr4960377a91.39.1789928033003; 
 Sun, 20 Sep 2026 11:13:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v2 01/33] bpf: replace deprecated SMP barriers with C11 fences
Date: Sun, 20 Sep 2026 11:09:53 -0700
Message-ID: <20260920181347.747210-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

The use counter is a seqcount, not a reference count: odd means the
datapath is inside the callback, even means it is not. The two
barriers around it play different roles.

In bpf_eth_cbi_inuse() the counter goes odd and the following loads
of cb, bpf and jit must not be hoisted above that store. Ordering a
store against later loads needs a full barrier, so rte_smp_mb()
becomes a seq_cst thread fence.

In bpf_eth_cbi_unuse() the read barrier becomes an acquire fence.
What must not happen there is the critical section loads sinking
past the store that makes the counter even, which is load/store
ordering, and that is what a standalone acquire fence provides.
acq_rel would additionally order prior stores, but the read side
only loads from the cbi and so has nothing to publish; it would
only upgrade dmb ishld to dmb ish on the datapath for no benefit.

Same code generated on x86 and arm64.

Use relaxed loads and stores for the counter itself. With
enable_stdatomic, the plain increment of an RTE_ATOMIC() field
compiled to a seq_cst add, i.e. two locked operations per burst.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..c7b1019239 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -80,9 +80,11 @@ static struct bpf_eth_cbh tx_cbh = {
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use++;
+	rte_atomic_store_explicit(&cbi->use,
+		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
+		rte_memory_order_relaxed);
 	/* make sure no store/load reordering could happen */
-	rte_smp_mb();
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 }
 
 /*
@@ -91,9 +93,16 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 static __rte_always_inline void
 bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
-	/* make sure all previous loads are completed */
-	rte_smp_rmb();
-	cbi->use++;
+	/*
+	 * Make sure all previous loads are completed before the counter
+	 * goes even. Acquire is enough: the read side only loads from the
+	 * cbi, so there are no stores to publish and acq_rel would just
+	 * cost a stronger barrier on weakly ordered CPUs.
+	 */
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+	rte_atomic_store_explicit(&cbi->use,
+		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
+		rte_memory_order_relaxed);
 }
 
 /*
@@ -105,9 +114,9 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 	uint32_t puse;
 
 	/* make sure all previous loads and stores are completed */
-	rte_smp_mb();
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	puse = cbi->use;
+	puse = rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed);
 
 	/* in use, busy wait till current RX/TX iteration is finished */
 	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
@@ -439,7 +448,7 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
 	bc->cb = NULL;
-	rte_smp_mb();
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
-- 
2.53.0

