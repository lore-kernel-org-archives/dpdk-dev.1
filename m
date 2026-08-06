Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3150FC55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 540FC402F1;
	Thu,  6 Aug 2026 05:25:50 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 86695402BB
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:49 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2caced6038eso5960085ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986748;
 x=1786591548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TMoH7tCbDEP7NudaYmK0dbQ/hE3o4DkVJrzZnjsCBcA=;
 b=GmTAalpQdae/8BrNLt0f4pAAWi+Hte46wPQb2CnGg+XrMCfkjkNYrhv5OT1+s7/R8u
 hhYQcGqRIH9aeJsinjAbJvjJXDibvopvo50TEO/4846O+0HaYSyTY3zlQejh6AFMOgKs
 h3MtSQIEiUKazxtFx5Wc/XbKULJCBYTb5vhyJKxE6k3VV/L06WddLJ7KXNc/ZQ28X6Kk
 vUsL6iJx4S9lqgHtWYgjPc3LndhJSsLGTmEYnzH+iMHFOcFTCs8Rd130esI2rpGtorqd
 zEjSz9GejvX0rqVZunM9WJWgVKYDsUNmVE6muRm4L+ONAAiJ7Ws5bloNEw6pN5JPhpqK
 fgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986748; x=1786591548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TMoH7tCbDEP7NudaYmK0dbQ/hE3o4DkVJrzZnjsCBcA=;
 b=IANdnVVOrUMom8Dbrhml4mrmDrWTnajVU+91QNRbwstNcZ3CRgsSdlaYY6f40NMGha
 d9tpZR/iPW24CUdMbHmNf9HnwHz81jfDDYAB/xFQJdfofBOfv5R9J1PBWcx+XumHNbX+
 B4siPxlPhWqu/Il1IpLHKNc9llXg7VPYRCA1YzGW8FwJIsFBNf2jVFJtQKE3bVqb3Mad
 t1tW7Tlow1NjtCl3FPmmGT6BhEqiuOAe8FeOCLHHLXnqVAHGCxPSRjkuCEJELO9R5YN4
 TJB9hidtmGe9778qIufzsidY0x+U0jnZyvGVIyD+y7gje8zwQX34yfHyluwrOeyRRESX
 NqKg==
X-Gm-Message-State: AOJu0Yzk7q5vT2TySMNfqunns/LLWnsPB/nHO364n30P9FOj78ykuYm5
 tYOXRPhcfRS0BR45o85DzJudFI+yvEf5pbp/slE8txMshB4iLoSYGmpM0rTeTpMWMLyFI4J2KWi
 KSh6A4mU=
X-Gm-Gg: AR+sD13HfCx/gcPS7Fjsjt438JnXN2swsDTU5+O38QjwI1xYEt8RivWxP0IIm93U6/P
 +6kcio9hleGJErDHxF8mRMC4K/pnV6q8SqiKiHw5zbm1s81tSZ9+oWDF7s1adx2l+9JNqROFJhr
 73UQWUoRb6OZMpV/Y4XXtpE6B+0RMfA4mt2IElClmi/k+dYzFyeNclm1UGpMuwb0NU34cBJH2+7
 +Bi4/oSVOMkPvgVDKDjwkyEonBxjdGBcCe0TV4LA30poxG+dSef0ucE9lLYWCn7lLyH/ItdzryI
 orKdPVD0HVNr0WHDboAKMO90N9k5lsfArxdCqRpeoLvThXmyej709HyS5okj47Qgjn7A4f/87Nd
 0GK4y8jnH7Hho71w2gK1XwK5k5tdGmTtuvsXlz9vlp6x4iZlxUDkS0fJ+Mlpm3a2TOcKTIN3oQ2
 0HjJ3Q0cpbr7GWOoGgXksuepYETvOGSnaM2QmB0CtW4+hG5VbBOQML5u+NcsNd5STmLX+42muHv
 totM+ilC3lRkV+jEck29hqSKM90qf13A3/scw==
X-Received: by 2002:a17:903:41d2:b0:2cf:7ea3:7cf1 with SMTP id
 d9443c01a7336-2d0f18bee4amr44608935ad.5.1785986748550; 
 Wed, 05 Aug 2026 20:25:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v7 01/24] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Date: Wed,  5 Aug 2026 20:22:53 -0700
Message-ID: <20260806032544.21337-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_exec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index d423ef28f5..99b37ffa4e 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -11,6 +11,7 @@
 #include <rte_debug.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
+#include <rte_stdatomic.h>
 
 #include "bpf_impl.h"
 
@@ -66,16 +67,16 @@
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

