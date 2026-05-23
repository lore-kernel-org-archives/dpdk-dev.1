Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A4CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:56:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E300B40664;
	Sat, 23 May 2026 21:56:15 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id ED630402D9
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:11 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f7020a928eso12249663eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566171;
 x=1780170971; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qonbr/na+JlOn7zIBQWdNxb5li45kG0DqrVYjlxjLJU=;
 b=kjKBUtdAUsR3vlrSiBZQ6AKviSJVN08z1owfLfypw+yTKu3rpTZK+ooSAnz4ATABSj
 U0zzm9DhPuSE+pI9bIt28jx5YqI7c0bQle+OUECSuMf4IslQDMBkhNiI03bRsVDI8IJ6
 Lo633/+9Mc+mq+jV3CROgAyuMiPXscrP3JFeNLHyuHHBmmCJVV1tqmZFNycdLqLxqaW7
 x3JIEnPZy3P+PbuECf7JUPbZvHgkGzVAWfwZfmvcwOT3ziVEauCw3gHh4CkPilhmseVV
 hYGWu7kiU10ufXjV1UPcLsSEzjGm7eM4TvCVLR0063zC4ujRywyytWiCiMMbPu6A64v+
 gyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566171; x=1780170971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qonbr/na+JlOn7zIBQWdNxb5li45kG0DqrVYjlxjLJU=;
 b=iQExQpxE4PrGulnIMfxVMXS8rtK8XTDlmpfKmB+i/reWM89coWh6u/9T2tu+36yUwu
 By3LV4kTQr0m3OaQnzNKk8Ks1xFQJoNsczeKMwYPefs1dVbKR1R2V4KclP8LVXwJw5Je
 V1dwPFmKX68P4v5dBrWuZBv3Lm52KKRmMnV9XVfcjh1KlL6mbX0eE6NDzAC0/mBXceQQ
 V85iLkFMiMPVjiJUTdrNIw737aswqROYJ2aQbw52SGlxsei1pyU4B0HjGUjcdHyDfZNg
 nqxSeY46D7tJx7eCKbJi6N1bCveelG+OjrKE04Ldj89bioqBkudPGtkNlPdHu2hnrWc1
 OoAQ==
X-Gm-Message-State: AOJu0YycCxk4138jTY8tYF6F361AdPsPkE1x+FIILxy0S0Q5gVCSQ6gv
 IuqCro7NT1RtGiPE8ET7dhHRDvFc/s8zZ8uAeelmTIOpkgYwD0c8x0wYfwv3pVCF8y49aPQEAAQ
 CbA8d
X-Gm-Gg: Acq92OEU11Bi9JXxBcnVifh2v/e4WhVhoVCYlID8Szr3XAez4PXVNtehRhAnKt84WcP
 9dyq5AGX2aN7aBPZ4YrwGQlLT4YYpe0WJ1QMQfJi9rUblhma54OvTaL4r4v9B7qHDDc5dztqchC
 /9J57bkllOu0S0Kt1rTxg4VhZpT2qufSupobqvDgX4ViXuFzb/1iizlfpJdabmHx0ZZZQf4kvo/
 nxv/SAQIxo0re7QpLh0jrF+PZcXmftwH/KE9ONJuv7yEon0Ohk+O126m34zGNGxMtS84M9fIgW2
 u/ymJd/ul6MlFfhx1Sq+/S5kn8BG9L0cHlxEMfzpBwcWw5yXKj9XI3Fbv4BME212YpXn2LhJRGY
 YZ98qBVgmdVtjyuAU0qfFnjt+NRboK4C8l0nW4Nj7UQjck1NRiyXNl5apaNVV2+ZRROxiMGqMk2
 6Y2fcpGJOFSIrI23PAfMD2VU3lTedHwO88+skLNxGERuZXaQO0983S0bpkysyYog==
X-Received: by 2002:a05:7300:fd11:b0:2da:1a81:588 with SMTP id
 5a478bee46e88-3044909065fmr3719003eec.14.1779566170950; 
 Sat, 23 May 2026 12:56:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 04/27] bpf: replace atomic op macro with typed helpers
Date: Sat, 23 May 2026 12:16:06 -0700
Message-ID: <20260523195604.441947-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195604.441947-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
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

