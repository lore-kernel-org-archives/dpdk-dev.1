Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92033C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7AD640697;
	Wed, 22 Jul 2026 20:34:01 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id C7258402D9
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:33:57 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c999f162c9aso8400768a12.3
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745237;
 x=1785350037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NzsdI6V9RO/klxdKckmO6SY1qNEgN1a6Mn7pZB/K1Yc=;
 b=dwRf+Xg7t+W95YyCSzXLQ/pYStGvre8E5nAnwQ7f6QEPBd/sS4WVQ227nNCspp0dlO
 iZBB32+pDu1HxvdqvgEahDxmVGgvGJvMkulS1cOUjCp2KF9vhbTL9X6o+G4FvHrZhbyO
 ECIDYf0KMOvnIlejDxqxgzVjaG4RCjYtY+vNZC5kHDHB3VCfiU44BypKeL+YyQ3JxjSd
 xPY5ryJqigsrWTxEky2GU9835BpmGeo5dxI0QK3E1kTk0N+Z5X6shSXQj7kXA4QDNCiK
 5s7n83FNiyVHjIqcWgDcuVeKedbBioOd2nQgZ5G6aK+fa2GSwNg7nR1hAo89W5frBj5P
 k8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745237; x=1785350037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NzsdI6V9RO/klxdKckmO6SY1qNEgN1a6Mn7pZB/K1Yc=;
 b=YzRitWq7ZtNjixEcq/eyqO8glh6LmCQkh32JsUbpZghfsRXD26uod3tm8am7nQHLQL
 sSyYYuk/QFHg5asvZSRZuJ0a+pbRHIz7FIq5UGWbrby5gt0kiNM+H1wjNq0wSEEv+l+q
 B0Z04lEs/XIM6PuWMfcHtwVsMjaoq9+q+3N3rWwmVRmrGDZh6JHptBXhgqZtpqYJtmMW
 cuW+MB8EczREo7TqvuGvfwq/fVk1ti7u1r9VM/INgrHmXbE788T5qAxOfNYKnitA6BRR
 dwe6tzRvzScimueM4hDUSg+XSG711LRs5I46DdG6Ai/jwfB89+KeGuc5tSvtNASAkIOZ
 n53w==
X-Gm-Message-State: AOJu0YwiDIRFhYA056lbpybcgXRTcIRU4w/513QOKMvSHTxxdunaZj7g
 u8MyVcKPo+l91x++FzE7EgCtI+RVYX3XZORMDe/AAKvMLI5Crj+0/XCZXqMeE2LSfQ2o5ZtIcrD
 nNX9u
X-Gm-Gg: AR+sD12kcjhimYI6A33EJmDzraw4sOKrEYqqvuFR4SZov07SyXiqjdi2ARtFZZDEBqE
 OvNUbIUdWRWlGXive+Zgmgd6cMzGMqHEVzs7BnUYNx24Nf9fHbnu7En5vjI5Ic0IORYjf3wgM/l
 f/YGL0uq8o2Cp+0yfMGhYcKCHFv8UCAjDwCC8AcArxC5zbMhDgDd28tFyfGs1DoHn/TBuOxLEjO
 d794xqAAChOwsm+Y6XVvMHJNWX2mEesAB2OnhdOx10IaOotpH9fKpnyx4v24n/55z1fiv3F2nl3
 iK6OVs8OVXVI2yjOcB6oDSU3zPKmgDfY/LXExsBRqVHUjpYwpgvDR30KZx67MeWGaufWXQ/zNTC
 QJHfc0+PikBiE4mQ3tLeXix3DzLUEYXRFl5955BKWirwsaKT/1UIIMCsKImTJMGhabkmu3BmC0B
 NBLCZoWrsfY9u0XMZ6pTbvQeErBwCcUzpmUs1ujegi
X-Received: by 2002:a05:6a20:cc0b:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3c3ad66a4ccmr26260078637.11.1784745236915; 
 Wed, 22 Jul 2026 11:33:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:33:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 03/10] bpf: mask shift count in interpreter per RFC 9669
Date: Wed, 22 Jul 2026 09:05:15 -0700
Message-ID: <20260722183351.633025-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722183351.633025-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260722183351.633025-1-stephen@networkplumber.org>
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

