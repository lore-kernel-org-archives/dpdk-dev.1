Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF2CC61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1956E40682;
	Thu, 27 Aug 2026 23:43:00 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6F7194064E
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:42:58 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d049069377so4508365ad.0
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866977;
 x=1788471777; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NzsdI6V9RO/klxdKckmO6SY1qNEgN1a6Mn7pZB/K1Yc=;
 b=eCLTkyWHBKiXm3s01gzFm8bykSyo2awJS1Gf5GbRbS3+BKWN6pLWCISF0FQxJAZGEQ
 1WR9Spmj9OwuOnn/7D6Th26e4E2di6TsjudkYHgGXpFOsdcmAMIEhgw/aXcjzlDjwEBg
 S+FPe76aYM1GMb65tn8dooZG3PFSBzfxrFvG6bsGQxHs0A0nUvIgpSK57EsNPqZBuDRY
 4xuNf/+lZwb0TytUt6wL7euvVM+zo9uNa2q+6TJk1gPXEuY/FFSku6X7yyzfP5YTQtUe
 5ZyyWo6qzdx0SRnlf1BT2NM21IxHBf2pwrA68IEiFF6BgDAi6M5PcRJhDOt436aTljXv
 VnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866977; x=1788471777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NzsdI6V9RO/klxdKckmO6SY1qNEgN1a6Mn7pZB/K1Yc=;
 b=CXrYS0BU+MQj8LxqUbj+UY35O37dkRsfOfPHnFUOuN+jA5m6UTDseieFQrWu4V9Vx8
 GKg3ywPib9t8AJzMy/8MtrWTn3jP7eUI5Q85tQ7NKnWRn7FOun4vdqEoQVd7AiXfRu+z
 2/k2lgMtzRF/CBjBo4mcyXRDjaiqVE1pzSBLGFSg+bD1sxy40JGuBa9XEjqcVEVmeMDx
 ws+nSPgBcaN0jrVURUKeWBACkrDqTMF+4ihyiiekLvy3skLQI6YFaZjCY1hXius9U9qS
 mxGyGaVLC/HfJLW8Q3tJJ64o30YuQNe7cS41ablKkI59xBVphVcUIz+4MUm1Q6BKutwm
 /o9g==
X-Gm-Message-State: AFuF++kBkCSA17xbJOC63Q4R79/G2Jxmn3VjUFnbZ/AbqyIf5KuhUqDc
 GqeTkY0G8zUyACLaGefxdaRDrVf2JC4O2osJtEH1Gz+D9LnMSNAxLSXmeqD7uayr+qRXpCksw/g
 Pq9mS
X-Gm-Gg: AR+sD10zzQWFdyJTNtTn7Mecqt27ep/Mal6tf8yR6qomc0N/MuToV6MVKdvt5i7NOZU
 RMnzob+NwE4gchEiW5DaaC/Wkdhnrksaz6Uv1y2I+k4b4G810TIbO314vs0wM9UL3nDBeP96tLe
 wXB680dg5edFtlOrSoXZxUkNbbpWZALFKCPrdYKajKogJadNTyaoR0HYAlR8AmAV9TIsDdBqZMX
 D1anjfEv9d/1xFx/34atEAlhitWNlbkb4z6N3yaTa5LuZ5NR9Gada4GFPV6CuPxTe6qcbMYeKrT
 7uYG6OauqIgDRGs7gAIVULG1nGKDI6SYktW35Vmk6tIHvHmhJxJVhoKFmwZcBy305k8MKP44cpa
 2B90RvASx1CdHHe5dFGRwEu7XbE2NoXk25IviDmM2kVyjD4lAES9gf40DMn4xE8PecfIkKhhFz9
 HjORPaGGbInflguMavY3y8oswH4sSl6p26JxMWuT+yaLw91fdvLCNucOtoUOXr3jvncqnWz7Hjz
 5wpd8Tki21bFriroefZfWZcIzEi
X-Received: by 2002:a17:903:f8d:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2d74dbea25bmr41583135ad.1.1787866977508; 
 Thu, 27 Aug 2026 14:42:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:42:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 03/10] bpf: mask shift count in interpreter per RFC 9669
Date: Thu, 27 Aug 2026 14:41:42 -0700
Message-ID: <20260827214236.1415047-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827214236.1415047-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260827214236.1415047-1-stephen@networkplumber.org>
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

The interpreter shifted by the raw immediate or register value, which
is undefined behavior in C when the count is >= the operand width and
trips UBSan. RFC 9669 masks shift counts (0x3f for 64-bit, 0x1f for
32-bit); mask the count in the LSH/RSH/ARSH cases.

Fixes: 94972f35a02e ("bpf: add BPF loading and execution framework")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_exec.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index d423ef28f5..bb03c9cc2c 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -4,6 +4,7 @@
 
 #include <stdio.h>
 #include <stdint.h>
+#include <limits.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
@@ -43,6 +44,16 @@
 	((reg)[(ins)->dst_reg] = \
 		(type)(reg)[(ins)->dst_reg] op (type)(ins)->imm)
 
+#define BPF_OP_SHIFT_IMM(reg, ins, op, type)	\
+	((reg)[(ins)->dst_reg] =		\
+		(type)(reg)[(ins)->dst_reg] op	\
+		((ins)->imm & (sizeof(type) * CHAR_BIT - 1)))
+
+#define BPF_OP_SHIFT_REG(reg, ins, op, type)	\
+	((reg)[(ins)->dst_reg] =		\
+		(type)(reg)[(ins)->dst_reg] op	\
+		((reg)[(ins)->src_reg] & (sizeof(type) * CHAR_BIT - 1)))
+
 #define BPF_DIV_ZERO_CHECK(bpf, reg, ins, type) do { \
 	if ((type)(reg)[(ins)->src_reg] == 0) { \
 		RTE_BPF_LOG_LINE(ERR, \
@@ -183,10 +194,10 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_IMM(reg, ins, |, uint32_t);
 			break;
 		case (BPF_ALU | BPF_LSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, <<, uint32_t);
+			BPF_OP_SHIFT_IMM(reg, ins, <<, uint32_t);
 			break;
 		case (BPF_ALU | BPF_RSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, >>, uint32_t);
+			BPF_OP_SHIFT_IMM(reg, ins, >>, uint32_t);
 			break;
 		case (BPF_ALU | BPF_XOR | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, ^, uint32_t);
@@ -217,10 +228,10 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_REG(reg, ins, |, uint32_t);
 			break;
 		case (BPF_ALU | BPF_LSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, <<, uint32_t);
+			BPF_OP_SHIFT_REG(reg, ins, <<, uint32_t);
 			break;
 		case (BPF_ALU | BPF_RSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, >>, uint32_t);
+			BPF_OP_SHIFT_REG(reg, ins, >>, uint32_t);
 			break;
 		case (BPF_ALU | BPF_XOR | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, ^, uint32_t);
@@ -262,13 +273,13 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_IMM(reg, ins, |, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_LSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, <<, uint64_t);
+			BPF_OP_SHIFT_IMM(reg, ins, <<, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_RSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, >>, uint64_t);
+			BPF_OP_SHIFT_IMM(reg, ins, >>, uint64_t);
 			break;
 		case (EBPF_ALU64 | EBPF_ARSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, >>, int64_t);
+			BPF_OP_SHIFT_IMM(reg, ins, >>, int64_t);
 			break;
 		case (EBPF_ALU64 | BPF_XOR | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, ^, uint64_t);
@@ -299,13 +310,13 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_REG(reg, ins, |, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_LSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, <<, uint64_t);
+			BPF_OP_SHIFT_REG(reg, ins, <<, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_RSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, >>, uint64_t);
+			BPF_OP_SHIFT_REG(reg, ins, >>, uint64_t);
 			break;
 		case (EBPF_ALU64 | EBPF_ARSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, >>, int64_t);
+			BPF_OP_SHIFT_REG(reg, ins, >>, int64_t);
 			break;
 		case (EBPF_ALU64 | BPF_XOR | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, ^, uint64_t);
-- 
2.53.0

