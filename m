Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E4D66B80
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 18:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4126540650;
	Wed, 17 Dec 2025 19:03:16 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id EE33940650;
 Wed, 17 Dec 2025 19:03:13 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWhTv3NymzJ46Bm;
 Thu, 18 Dec 2025 02:02:43 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 3662840565;
 Thu, 18 Dec 2025 02:03:13 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 19:03:12 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <stephen@networkplumber.org>, <jerinjacobk@gmail.com>,
 <mb@smartsharesystems.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v3 3/6] bpf: mark ARM opcodes with UINT32_C
Date: Wed, 17 Dec 2025 18:01:36 +0000
Message-ID: <20251217180141.60227-4-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217180141.60227-1-marat.khalili@huawei.com>
References: <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251217180141.60227-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500006.china.huawei.com (7.182.19.102) To
 frapema500003.china.huawei.com (7.182.19.114)
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

To prevent confusion as to whether operations with them will be executed
as signed or unsigned (and with what bit width) mark all ARM opcode
constants with UINT32_C.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_jit_arm64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 76df1e4ba1..9263234338 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -12,7 +12,7 @@
 #include "bpf_impl.h"
 
 #define A64_REG_MASK(r)		((r) & 0x1f)
-#define A64_INVALID_OP_CODE	(0xffffffff)
+#define A64_INVALID_OP_CODE	(UINT32_C(0xffffffff))
 
 #define TMP_REG_1		(EBPF_REG_10 + 1)
 #define TMP_REG_2		(EBPF_REG_10 + 2)
@@ -228,7 +228,7 @@ emit_insn(struct a64_jit_ctx *ctx, uint32_t insn, int error)
 static void
 emit_ret(struct a64_jit_ctx *ctx)
 {
-	emit_insn(ctx, 0xd65f03c0, 0);
+	emit_insn(ctx, UINT32_C(0xd65f03c0), 0);
 }
 
 static void
@@ -240,7 +240,7 @@ emit_add_sub_imm(struct a64_jit_ctx *ctx, bool is64, bool sub, uint8_t rd,
 	imm = mask_imm(12, imm12);
 	insn = RTE_SHIFT_VAL32(is64, 31);
 	insn |= RTE_SHIFT_VAL32(sub, 30);
-	insn |= 0x11000000;
+	insn |= UINT32_C(0x11000000);
 	insn |= rd;
 	insn |= RTE_SHIFT_VAL32(rn, 5);
 	insn |= RTE_SHIFT_VAL32(imm, 10);
@@ -281,7 +281,7 @@ emit_ls_pair_64(struct a64_jit_ctx *ctx, uint8_t rt, uint8_t rt2, uint8_t rn,
 
 	insn = RTE_SHIFT_VAL32(load, 22);
 	insn |= RTE_SHIFT_VAL32(pre_index, 24);
-	insn |= 0xa8800000;
+	insn |= UINT32_C(0xa8800000);
 	insn |= rt;
 	insn |= RTE_SHIFT_VAL32(rn, 5);
 	insn |= RTE_SHIFT_VAL32(rt2, 10);
@@ -637,7 +637,7 @@ emit_blr(struct a64_jit_ctx *ctx, uint8_t rn)
 {
 	uint32_t insn;
 
-	insn = 0xd63f0000;
+	insn = UINT32_C(0xd63f0000);
 	insn |= RTE_SHIFT_VAL32(rn, 5);
 
 	emit_insn(ctx, insn, check_reg(rn));
@@ -668,7 +668,7 @@ emit_rev(struct a64_jit_ctx *ctx, uint8_t rd, int32_t imm)
 {
 	uint32_t insn;
 
-	insn = 0xdac00000;
+	insn = UINT32_C(0xdac00000);
 	insn |= RTE_SHIFT_VAL32(rd, 5);
 	insn |= rd;
 
@@ -970,7 +970,7 @@ emit_stadd(struct a64_jit_ctx *ctx, bool is64, uint8_t rs, uint8_t rn)
 {
 	uint32_t insn;
 
-	insn = 0xb820001f;
+	insn = UINT32_C(0xb820001f);
 	insn |= RTE_SHIFT_VAL32(is64, 30);
 	insn |= RTE_SHIFT_VAL32(rs, 16);
 	insn |= RTE_SHIFT_VAL32(rn, 5);
@@ -983,7 +983,7 @@ emit_ldxr(struct a64_jit_ctx *ctx, bool is64, uint8_t rt, uint8_t rn)
 {
 	uint32_t insn;
 
-	insn = 0x885f7c00;
+	insn = UINT32_C(0x885f7c00);
 	insn |= RTE_SHIFT_VAL32(is64, 30);
 	insn |= RTE_SHIFT_VAL32(rn, 5);
 	insn |= rt;
@@ -997,7 +997,7 @@ emit_stxr(struct a64_jit_ctx *ctx, bool is64, uint8_t rs, uint8_t rt,
 {
 	uint32_t insn;
 
-	insn = 0x88007c00;
+	insn = UINT32_C(0x88007c00);
 	insn |= RTE_SHIFT_VAL32(is64, 30);
 	insn |= RTE_SHIFT_VAL32(rs, 16);
 	insn |= RTE_SHIFT_VAL32(rn, 5);
@@ -1042,8 +1042,8 @@ emit_xadd(struct a64_jit_ctx *ctx, uint8_t op, uint8_t tmp1, uint8_t tmp2,
 	}
 }
 
-#define A64_CMP 0x6b00000f
-#define A64_TST 0x6a00000f
+#define A64_CMP (UINT32_C(0x6b00000f))
+#define A64_TST (UINT32_C(0x6a00000f))
 static void
 emit_cmp_tst(struct a64_jit_ctx *ctx, bool is64, uint8_t rn, uint8_t rm,
 	     uint32_t opc)
-- 
2.43.0

