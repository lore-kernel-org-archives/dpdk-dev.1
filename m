Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13680CD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:31:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 163BA402B6;
	Sat, 20 Jun 2026 04:31:41 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id 31F6C4028D
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:40 +0200 (CEST)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7e2fd65f968so27970187b3.3
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922699;
 x=1782527499; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1xHU9v/QTwgUnGZ5ALW+IdIfjG5Q9Eu1G3hYhO0PVs=;
 b=uvMcBm/980ZIF2Fx92BfZV3TSuLDXXrGRsoHP5q5M0ve8tQdUpvWuWjhbjFEIcTcPj
 t+ERRVhy7koPayS4rt+Q72BKiC/vsHFL9GLPEXp/Abuh4+gTyzB8w1ILR96pWbCbNCcJ
 eWOnj58HbFx4/BHvSlqUYKbmdtEN6kRlATg13jZA9Yk6lCjXXI9jswNr1ya1NX5na3lh
 84U1fv2P2OOIDPBjbhYhf12l7v+rXYC2WXo6N7IRVxyR+kLcpYcmdmnT9D+f84PPzTNN
 2XA3UvM7owMu374gLKpb1uUF5kMrLB6dHCXE96762IW4VxL0LQzvEOAu8RRPVYbxHLBE
 3ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922699; x=1782527499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1xHU9v/QTwgUnGZ5ALW+IdIfjG5Q9Eu1G3hYhO0PVs=;
 b=ouurRxNBkXq0roATW1ez/5JbpmMGF3+aI+tU7uOcpkQR7a8gLfSWynp3Kc2B7+5Mj8
 PumSPC/qzoBQlPHcBFAOgsxZI3TrxSw6jWV5hYxuRMhT4tkGaIycoe9Mpp3oWbRzrH07
 awoG5PMnReH/V2yf2wUnGYZuzWW6+nQX02hIa8eGt5AjaHmL8FhhPTCCMPB5fAq0GFD4
 qJ1FIrOq0OlXDr3IA7X5Be8kBL9A0UVFaZDxdIPegi7Fi7g0R8YwsUu1dJk0QUEfN28/
 9Nwt2w6v1zTk+6DR5hXfgMgdwz0c2wKhyrL2gPMNs1EE0IHlMmXaxLkDfyVfDuJJUeT8
 3Hpw==
X-Gm-Message-State: AOJu0YwaTowGbPTLMkBUnc2iTiah4ynwogNLUMo2sWTQA8j5npqSGIDy
 cL7UNQfiwOc6WFpd60VHtoBJ59XQ6qiFJu0z/NQ3GRgrXt6AIFQBrQpqddw0Ux9pp7jcrIBLrJz
 OZlh1
X-Gm-Gg: AfdE7ckX/Spq2GpiM8yQneTTgWqoUTNr1ERkvDiRntE2cIcFdG4JwJetnYzU9ZOvu1U
 6twhoLTWg2ULa7R0dWgoxa/oDXuBEMZB62KHNW2X0D62ph7u5ltVyeWiQ+6T+dteOLPuGY6aPd0
 EnsXY/ipGeL46PGqZHocq2DJr5Br+FWbSYCyikvVCRBmvhFoucS5C5Noclq3yLLHYBpwK4EWCed
 JmmID3jnUb2i+8BvkuSYcXcC5AT5bgtDHeUKopT88g0MY+6H9LObW40b7xtZ/1A6IDrWUnt5EP4
 T+Yzafda70F2H0/x2j5cXElfCGLtj6bRqDc+nKJQZFKu56Lscp3hKZy4MmNBpIcYlMOlr69U92U
 fsWv4ED0UQaEuK9n1Vk7Wd5tbWy5lDOxcadFQQsY7UvN7r0ZBDwdOzOXMLL1npAis+1aCm015Ok
 eXqB7lwqEf0rcjhP8exSipcOFiac6BLzQBgwIRnOia9QiSNhxaJTc=
X-Received: by 2002:a05:690c:d08:b0:7fe:1ab5:89f1 with SMTP id
 00721157ae682-802661640a6mr24907947b3.25.1781922699313; 
 Fri, 19 Jun 2026 19:31:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v5 01/24] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Date: Fri, 19 Jun 2026 19:28:26 -0700
Message-ID: <20260620023134.42877-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

