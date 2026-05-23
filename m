Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C9CCD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0643240696;
	Sat, 23 May 2026 21:58:52 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 5606F40664
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:47 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so28302556eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566326;
 x=1780171126; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qonbr/na+JlOn7zIBQWdNxb5li45kG0DqrVYjlxjLJU=;
 b=GyCGxzmm4U4vZk55HMba++5NkcD1SHe5ayPDWbSa4L9e2ykZbxLJGjGamodNFz/2EA
 4eOLyCfy0tHaFVoFD5dLsvsQkHLNvOWsgcAs9kh3W04V9d5McKe87BU9ancDNQmDK5tR
 F6yNLZDYAOa/JhAvnCMOzyKadJm6zy8otAsYM2VyxDhX2PFMyAuytwg6ge69Ki75pUeH
 Zeebca/94WPdikYVjGGxFXOVOK/nd7e3WQRcQX2BmmaYUt4a3QLdBwaaYyRDhai3+oMy
 lEzYySy1zJR2wghnhodp0QJ1ZBA6qH8V2aBNxDOJoYU2Z4c5IjEtZZ/3uuwOV+ew6+J8
 61Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566326; x=1780171126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qonbr/na+JlOn7zIBQWdNxb5li45kG0DqrVYjlxjLJU=;
 b=h0QYOpWoj7rtQjjcIhGxSOkHiuNDbGEuSvlF6/0aFOzf8unP09wCNFMzJp+PM+xvlO
 IBLOQSmOE4odrN7nQ9BNCxG6/TMG7Th3iqw4rv77KBu+2ChiDnNoWZYha2DqGPMUrknR
 8oEwCd+6G03m+coPoal/5BmwBAMrfdGgyrrsIaTY11QxMZjzUjubsnMqBQz0chtoNWTT
 xuMHQNq+jLZRnIj2wIE2kIND/fj0Me2pVRvwCKAw+uful02iwZldAPtlsKzSc98Khfrb
 cyPbbC5GcEA+8Tn0nlgNnqiasrG3djLgJkY/jlQzO7LAXXwgHxv7qfY7v0HCDfv2L3Td
 +pwQ==
X-Gm-Message-State: AOJu0YxdxVc17DRxPn5HEYVXEwA9IfZ/URhK0IiGaNtp5rcLi8Dzdt17
 Em5R1O/gDB9mzl23RuCCoda/32ikVO5mbbPDh2tq64owX8F0IU22+PK88Eclf7OqTGLTKspmyYS
 w5Qnu
X-Gm-Gg: Acq92OF1pxuiWDrVD+UtoH23yNMWJKjOcMzcoJks/SVL7P1RGvwbc6vf/LYT0Ts1Fkw
 2xjuwfIpQrWOrAvGKF2kBna9QPv/BbnsZDsMh2CZFtWyyTmX4hDA8IyZL3QB5UdfGaGeunecClD
 XaHftkTW4LFMLbqHzSwkvX8snoE9v1HQteHA7kF4TfnCpLda94jG+Z/kVyOwrnCSBox9Hy2s72s
 DGz5bXQiy4vQnDl6sqXh6rtMprCSvsd+sb9yG+DTYvbV2rtGqr7Vx7WP5EEf9lmUwlcGSOCcNV/
 QfKdWMal+DpbxZ5WX/w4l5N9N9VxAmvvq/hqPWacVlQaDCxA+BVdt9kjY0ppDofzxckbEIHmyIm
 mjnYP5xsDK0otyJmBBvsgM5ZF52+jvAS+9IgW6TVdNSUVJtTtKGo0YjxWqv0/2lokXcG3NPsTmH
 T7eSi7fpSe9Umtc59MUU4oNgqd4GLtz7SV2Ji321QNblKFNnCpIkY8BLKPq/dbU7VwsWPK/pHc
X-Received: by 2002:a05:7300:7fa6:b0:2f1:496c:94bf with SMTP id
 5a478bee46e88-30449101b61mr4522790eec.16.1779566326388; 
 Sat, 23 May 2026 12:58:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 04/27] bpf: replace atomic op macro with typed helpers
Date: Sat, 23 May 2026 12:56:18 -0700
Message-ID: <20260523195839.454952-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

The BPF_ST_ATOMIC_REG macro token-pasted the legacy rte_atomicNN_*()
API names. It also stacked three casts on the destination pointer
and reached a 'return 0' out of the macro into the caller's control
flow.

Replace it with two small static-inline helpers, bpf_atomic32() and
bpf_atomic64(), that dispatch on ins->imm internally and use the C11
atomic intrinsics directly. The destination is cast once, to a
properly __rte_atomic-qualified pointer. The helpers return a status
and the dispatch loop owns the early exit.

Use memory order seq_cst to preserve the previous behavior of
rte_atomicNN_add() / rte_atomicNN_exchange() and matches
the Linux kernel BPF interpreter for these opcodes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_exec.c | 91 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 24 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index 18013753b1..b8116db191 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -64,28 +64,6 @@
 	(*(type *)(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off) = \
 		(type)(reg)[(ins)->src_reg])
 
-#define BPF_ST_ATOMIC_REG(reg, ins, tp)	do { \
-	switch (ins->imm) { \
-	case BPF_ATOMIC_ADD: \
-		rte_atomic##tp##_add((rte_atomic##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
-		break; \
-	case BPF_ATOMIC_XCHG: \
-		(reg)[(ins)->src_reg] = rte_atomic##tp##_exchange((uint##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
-		break; \
-	default: \
-		/* this should be caught by validator and never reach here */ \
-		RTE_BPF_LOG_LINE(ERR, \
-			"%s(%p): unsupported atomic operation at pc: %#zx;", \
-			__func__, bpf, \
-			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.ins); \
-		return 0; \
-	} \
-} while (0)
-
 /* BPF_LD | BPF_ABS/BPF_IND */
 
 #define	NOP(x)	(x)
@@ -105,6 +83,69 @@
 	reg[EBPF_REG_0] = op(p[0]); \
 } while (0)
 
+/*
+ * Atomic ops on the BPF target memory.
+ *
+ * BPF atomic instructions encode the destination as base register +
+ * signed offset, with the value to combine taken from src_reg.
+ *
+ * Memory order: seq_cst preserves the previous behavior of
+ * rte_atomicNN_add() / rte_atomicNN_exchange() and matches what the
+ * Linux kernel BPF interpreter does for these opcodes.
+ *
+ * Returns 0 on unsupported sub-op (validator should have rejected it),
+ * 1 otherwise.
+ */
+static inline int
+bpf_atomic32(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
+	     const struct ebpf_insn *ins)
+{
+	/* need to casts to make bpf memory suitable for C11 atomic */
+	uint32_t __rte_atomic *dst
+		= (uint32_t __rte_atomic *)(uintptr_t)(reg[ins->dst_reg] + ins->off);
+	uint32_t val = (uint32_t)reg[ins->src_reg];
+
+	switch (ins->imm) {
+	case BPF_ATOMIC_ADD:
+		rte_atomic_fetch_add_explicit(dst, val, rte_memory_order_seq_cst);
+		return 1;
+	case BPF_ATOMIC_XCHG:
+		reg[ins->src_reg] = rte_atomic_exchange_explicit(dst, val,
+								 rte_memory_order_seq_cst);
+		return 1;
+	default:
+		RTE_BPF_LOG_LINE(ERR,
+			"%s(%p): unsupported atomic operation at pc: %#zx;",
+			__func__, bpf,
+			(uintptr_t)ins - (uintptr_t)bpf->prm.ins);
+		return 0;
+	}
+}
+
+static inline int
+bpf_atomic64(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
+	const struct ebpf_insn *ins)
+{
+	uint64_t __rte_atomic *dst
+		= (uint64_t __rte_atomic *)(uintptr_t) (reg[ins->dst_reg] + ins->off);
+	uint64_t val = reg[ins->src_reg];
+
+	switch (ins->imm) {
+	case BPF_ATOMIC_ADD:
+		rte_atomic_fetch_add_explicit(dst, val,	rte_memory_order_seq_cst);
+		return 1;
+	case BPF_ATOMIC_XCHG:
+		reg[ins->src_reg] = rte_atomic_exchange_explicit(dst, val,
+								 rte_memory_order_seq_cst);
+		return 1;
+	default:
+		RTE_BPF_LOG_LINE(ERR,
+			"%s(%p): unsupported atomic operation at pc: %#zx;",
+			__func__, bpf,
+			(uintptr_t)ins - (uintptr_t)bpf->prm.ins);
+		return 0;
+	}
+}
 
 static inline void
 bpf_alu_be(uint64_t reg[EBPF_REG_NUM], const struct ebpf_insn *ins)
@@ -392,10 +433,12 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			break;
 		/* atomic instructions */
 		case (BPF_STX | EBPF_ATOMIC | BPF_W):
-			BPF_ST_ATOMIC_REG(reg, ins, 32);
+			if (bpf_atomic32(bpf, reg, ins) == 0)
+				return 0;
 			break;
 		case (BPF_STX | EBPF_ATOMIC | EBPF_DW):
-			BPF_ST_ATOMIC_REG(reg, ins, 64);
+			if (bpf_atomic64(bpf, reg, ins) == 0)
+				return 0;
 			break;
 		/* jump instructions */
 		case (BPF_JMP | BPF_JA):
-- 
2.53.0

