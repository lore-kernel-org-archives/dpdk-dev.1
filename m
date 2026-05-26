Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F039CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1E0A40665;
	Wed, 27 May 2026 01:25:53 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 1F25A4021F
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:51 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-303dbfbec77so13254441eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837950;
 x=1780442750; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bS/R0tz642QLrAglp5rvtM1bXLN7yAYyLtEfmBYfdJw=;
 b=fqNcJ+JOw4RmTAgfgTeu06UtgW9WWa6XBfIVha+ul0dBmg/Cv/TEqkzkbC3ucYVgMc
 eR2OQ03nmwxbzP9By/Fs/RavabwFvAnmemZoZ8pt3tgQGiummDZ7uCXtkqnMQ56lo/7C
 tEy+olZOFSJdPJn58vajVdYu7Of/cyzV8YrH7km/0Zp2Bzt84ToOV8Rrsi4DaWeDfbK6
 L1S7NXMdFo2uXJDQYiW4xfFdkhBXw2Sp6YIY2XAK+Jj+xjf0t6XpzgZ7OM9S9Sf4eLG3
 G8OpYkqeCBAbsrKluQULYvwlxeJ0Ac4GUQ6U+r0FnKf/dk6sWTlRYM3cl1VeTIR276p8
 +lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837950; x=1780442750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bS/R0tz642QLrAglp5rvtM1bXLN7yAYyLtEfmBYfdJw=;
 b=ZXgIs93hIXrT2u1wSlEvWoUMgnS6wb4zijfNfeLkj6rb/Ktse2GK0PeVjJkLl2jE/c
 ZCRaqjfibTyNNl4Onq/6dv/l03LuTM954C/7zrbHPUqy4WQKS+UREJ+XguVlnncL7q53
 Gzdrc9xqjQ/QMld50TZw2takSVqlmdIMNQEcvw4TyKpZmYrsIQmYvjqgAka/d8rx/sfz
 D3EKDs0IMDEH4lOp8+G2r8auJdC89R6WjmS1GrvzibtshAxXanewVHmMMk+4Mova9Rgc
 IQXxq056//b3pS4g74zjM+uGdfB+EKaYBwppwvdH7mkZ+oykfJ9nT7HmAYKWUAsy3Jkx
 SAgg==
X-Gm-Message-State: AOJu0YwsyiFGXpKqzJRBnq7/aRZGII7jad2VWkoGQ2wyWwD/h2MXGVh8
 tFoLNSVSqbo3oHw7qRZ3/XDT2eUWwbRX3Yg2Lp/BKjq9KlJOIDh/6k4elUw4JTV8eZAyv2o6vW7
 WXmSl
X-Gm-Gg: Acq92OGJ11JoAfSnsEYahXAhlK7PzliaR4GLp0IOfmTqwiB9fLRN20YT0sIztn3aDDs
 fgIX4w6/JuzAPRMzfr4vO3YOhN49KIX/8ZzAEp+b8yRuZaZiulFUqUY6xXqDOIFzcRG/htxFvOn
 zAWQtT0Z3r23jTaFez+7AiFeLMvneowFRIFbv8I56gSLgePJR3auBe4iy9vrED427Va9BiOOJzt
 X6x239Wm489HnBNGt6rdejGJovVy3o+Sc1zW0BnzGrMFDLIHTxlu4wNuAT8RYNaAe/o+Ps/znax
 53OLl/DnU8WvQSyWo9RYc2RKTUWT3ma2dTHXrf/GK1k9wLdr6xYmV75VcI8vyFkS3t+tCgKxb/y
 xM3vHIdPu8YwiJuMxdX4QXJr2f/2Id38jvhFdua9AXUIXooBOxAyWFVtJ92soPVK0Sb9r/dii78
 I6c0tjrp9RRS4+CTLJo4csGRi12bIg4xKy25AqDkvsygpdpdyLqBESvv6XFQNqYA==
X-Received: by 2002:a05:7300:3720:b0:2dd:8ac2:9f7a with SMTP id
 5a478bee46e88-30448f4ad54mr8911894eec.11.1779837950209; 
 Tue, 26 May 2026 16:25:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 04/27] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Date: Tue, 26 May 2026 16:23:54 -0700
Message-ID: <20260526232542.620966-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

The BPF_ST_ATOMIC_REG macro generated code with deprecated
rte_atomicNN_add and rte_atomicNN_exchange.

Replace this with the equivalent rte_stdatomic definitions.
Use memory order seq_cst to preserve the previous behavior of
rte_atomicNN_add() / rte_atomicNN_exchange() and matches
the Linux kernel BPF interpreter for these opcodes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_exec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index 18013753b1..ee6ec7516f 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -10,6 +10,7 @@
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <rte_byteorder.h>
+#include <rte_stdatomic.h>
 
 #include "bpf_impl.h"
 
@@ -65,16 +66,16 @@
 		(type)(reg)[(ins)->src_reg])
 
 #define BPF_ST_ATOMIC_REG(reg, ins, tp)	do { \
+	RTE_ATOMIC(uint##tp##_t) *dst = (RTE_ATOMIC(uint##tp##_t) *) \
+		(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off); \
 	switch (ins->imm) { \
 	case BPF_ATOMIC_ADD: \
-		rte_atomic##tp##_add((rte_atomic##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
+		rte_atomic_fetch_add_explicit(dst, \
+			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
 		break; \
 	case BPF_ATOMIC_XCHG: \
-		(reg)[(ins)->src_reg] = rte_atomic##tp##_exchange((uint##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
+		(reg)[(ins)->src_reg] = rte_atomic_exchange_explicit(dst, \
+			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
 		break; \
 	default: \
 		/* this should be caught by validator and never reach here */ \
-- 
2.53.0

