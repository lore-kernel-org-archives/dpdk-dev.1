Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D17FC53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B124840609;
	Wed, 29 Jul 2026 19:57:21 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 205ED40144
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:20 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so110990b3a.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347839;
 x=1785952639; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6No1KSk5d+6fIzv/JYyl3+PhFvmgS+8ISs275yB8wZg=;
 b=vCJlgbXEzocHSnHIG99iHU39oPOgWa6U2M59t6EHDNK6XAZ9Iw16sxT2T7hberTOE2
 6pySsOzyQzg+NvSduFQOo0eSfBT3nfM8TdpJyk9Q3bkCzS/MG3V8v02rXqaOVKgyLv7W
 WIwxs/imxzHraD4KBQ0cOcQUTxVpQDJzo359FvyFluxtGsEAbol+RtwNJoM8qqT6t0K2
 AKkZRnOmfMytP2vvtyTKjfWJMyasQb8FksSOmPStXqHWJHQpWf31fDDE3OWBBxfCF1E/
 0wT+tJqGlp/ReIbofLgInh9iZAsuflEJ0g+Ih3e5XprPIsFhNeFfrl6NZmBbD0jFU4+1
 M7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347839; x=1785952639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6No1KSk5d+6fIzv/JYyl3+PhFvmgS+8ISs275yB8wZg=;
 b=mUG6bIDqSEgZURGvG1Qka1/p8+sOo7mmvR3KGXP2OPfhJLJf2qwx7eHP/GMUnf9ARd
 RMRgg1qA/WPZ6IF9meDGiejbf+9FBnhj7LhhO+ZeMIjdzmQ0eBKirHnlAbxPi60OpcFm
 +gXpUJjkeaPougYiXOxY1GOQoCkt3t8VA4SKywlVeKqReU+SZd+Ej5WEcIA2CCWk8VEY
 3+LXAFjsRvXLYdxTpFGtB4G8lbUc4M+U2jrmnq5VN7ipKIlBt9IxNPWq0EKptjiSrDRA
 V02iOM3bGXa70v/twEjBTxqgCS7I4W3o22z/DpjtihN/QNuBBmAFzclr4j/gLrX+gXQP
 xrgA==
X-Gm-Message-State: AOJu0YxpGBXzRBehIBnKQdukeqDf+kO9qpdk++PHnHRALZqE5gm65MGP
 u6DfLq30gXgw2ultzBHxk6b/Sk60fctJiRx8p6RutqIVEgM4iwN3herfm5TIYYMKWcbOUNl3EUM
 KVOYC
X-Gm-Gg: AR+sD10VQlc16LA5kVJfAwQEVgCL/hN8dbegUyxS/w6dfYPpd4qovGneZW7lmo/2ECA
 g7XCqgdTJax22fuPMBF5qyE6cG52EORrq+qEvGBJWOgaZlZfjwYm8aXswu18Q2roWTuMuhTdol4
 QVOSWL0TJCGr1bYdChsNCK8HDuxndOcU9W8e7YvAwhbbfVFZhgEtFmb84E1zXGCplDDk1f9zxO/
 lMvc/DDeD/Og7r+Ue1Vv9XXJWb3VCZcnEzx2qztccHM7iRBZ/o2NmUAamrxPdY4XPs7s62ZS+Pb
 ZQcF9Xpnwq5NGQeBkZHOpe9nsMEjiLvUqGJffhLP/Gi7ycvj1PzVKL+UrogxYi1gww7K9hY4fzs
 L9YL/vLdWlPFIKpxD4d7g3z7vXMrwr2yGVmqfLEh3GhpbPURQ+Vxmlc1OjHzz0wIPU/5IUtxsup
 DrwRDXZp+Z74WkIsbK/71vf+gUfAwQ7vNTYFxWXfYhWspGjigsMoeqRT7kfAFtiOrhWIrpQyHrr
 l0iqQH55mXuM4DdmDv65hodMO78zrO/aaWTPb+JALWubl3bag==
X-Received: by 2002:a05:6a20:2585:b0:3c4:2f75:719 with SMTP id
 adf61e73a8af0-3c8e4934873mr2875016637.37.1785347839217; 
 Wed, 29 Jul 2026 10:57:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [RFC 01/32] bpf: replace deprecated SMP barriers with C11 fences
Date: Wed, 29 Jul 2026 10:53:54 -0700
Message-ID: <20260729175715.165120-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The use counter handshake is a store-load pattern, so rte_smp_mb()
becomes a seq_cst thread fence; the read barrier in
bpf_eth_cbi_unuse() becomes an acquire fence. Same code generated
on x86 and arm64.

Use relaxed loads and stores for the counter itself. With
enable_stdatomic, the plain increment of an RTE_ATOMIC() field
compiled to a seq_cst add, i.e. two locked operations per burst.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..a831b5ad86 100644
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
@@ -92,8 +94,10 @@ static __rte_always_inline void
 bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
 	/* make sure all previous loads are completed */
-	rte_smp_rmb();
-	cbi->use++;
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+	rte_atomic_store_explicit(&cbi->use,
+		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
+		rte_memory_order_relaxed);
 }
 
 /*
@@ -105,9 +109,9 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 	uint32_t puse;
 
 	/* make sure all previous loads and stores are completed */
-	rte_smp_mb();
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	puse = cbi->use;
+	puse = rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed);
 
 	/* in use, busy wait till current RX/TX iteration is finished */
 	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
@@ -439,7 +443,7 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
 	bc->cb = NULL;
-	rte_smp_mb();
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
-- 
2.53.0

