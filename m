Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B248BCD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 536A140A4B;
	Wed,  6 May 2026 19:39:22 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4976C40658
 for <dev@dpdk.org>; Wed,  6 May 2026 19:39:17 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jK65kTfzHnGjS
 for <dev@dpdk.org>; Thu,  7 May 2026 01:38:18 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id DD54540569
 for <dev@dpdk.org>; Thu,  7 May 2026 01:39:16 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:16 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 05/25] bpf/validate: introduce debugging interface
Date: Wed, 6 May 2026 18:38:23 +0100
Message-ID: <20260506173846.64914-6-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506173846.64914-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
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

Introduce debugging interface for BPF validator. New API lets one
observe evaluation of the validated BPF program, including step
evaluation, setting break- and catchpoints, inspecting possible jumps
and memory accesses in current state, as well as formatting current
state elements for the user. It can be used to build both automated
tests and interactive validation debuggers without tight coupling to a
specific validator implementation.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c           | 448 ++++++++++++++++++++-
 lib/bpf/bpf_validate.h           |  54 +++
 lib/bpf/bpf_validate_debug.c     | 663 +++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate_debug.h     |  86 ++++
 lib/bpf/bpf_value_set.c          | 403 +++++++++++++++++++
 lib/bpf/bpf_value_set.h          | 126 ++++++
 lib/bpf/meson.build              |   9 +-
 lib/bpf/rte_bpf.h                |   4 +
 lib/bpf/rte_bpf_validate_debug.h | 375 +++++++++++++++++
 9 files changed, 2163 insertions(+), 5 deletions(-)
 create mode 100644 lib/bpf/bpf_validate.h
 create mode 100644 lib/bpf/bpf_validate_debug.c
 create mode 100644 lib/bpf/bpf_validate_debug.h
 create mode 100644 lib/bpf/bpf_value_set.c
 create mode 100644 lib/bpf/bpf_value_set.h
 create mode 100644 lib/bpf/rte_bpf_validate_debug.h

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 362d00c77095..8dac908c394f 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -9,9 +9,13 @@
 #include <stdint.h>
 #include <inttypes.h>
 
+#include <rte_bpf_validate_debug.h>
 #include <rte_common.h>
 
 #include "bpf_impl.h"
+#include "bpf_validate.h"
+#include "bpf_validate_debug.h"
+#include "bpf_value_set.h"
 
 #define BPF_ARG_PTR_STACK RTE_BPF_ARG_RESERVED
 
@@ -92,6 +96,7 @@ struct bpf_verifier {
 	struct inst_node *evin;
 	struct evst_pool evst_sr_pool; /* for evst save/restore */
 	struct evst_pool evst_tp_pool; /* for evst track/prune */
+	struct rte_bpf_validate_debug *debug;
 };
 
 struct bpf_ins_check {
@@ -118,6 +123,409 @@ struct bpf_ins_check {
 /* For LD_IND R6 is an implicit CTX register. */
 #define	IND_SRC_REGS	(WRT_REGS ^ 1 << EBPF_REG_6)
 
+/*
+ * Debugging internal interface and helpers.
+ */
+
+static bool
+reg_val_range_is_valid(const struct bpf_reg_val *rv)
+{
+	if (rv->v.type == RTE_BPF_ARG_UNDEF)
+		return true;
+
+	if (rv->s.min > rv->s.max)
+		return false;
+
+	if (rv->u.min > rv->u.max)
+		return false;
+
+	/* If one of the ranges does not change sign, the other should match. */
+	if (rv->s.min >= 0 || rv->s.max < 0 ||
+			rv->u.min > INT64_MAX || rv->u.max <= INT64_MAX)
+		return rv->u.min == (uint64_t)rv->s.min &&
+			rv->u.max == (uint64_t)rv->s.max;
+
+	return true;
+}
+
+int
+__rte_bpf_validate_state_is_valid(const struct bpf_verifier *verifier)
+{
+	const struct bpf_eval_state *const st = verifier->evst;
+
+	for (int reg = 0; reg != RTE_DIM(st->rv); ++reg)
+		if (!reg_val_range_is_valid(st->rv + reg))
+			return false;
+
+	for (int var = 0; var != RTE_DIM(st->sv); ++var)
+		if (!reg_val_range_is_valid(st->sv + var))
+			return false;
+
+	return true;
+}
+
+int
+__rte_bpf_validate_can_access(const struct bpf_verifier *verifier,
+	const struct ebpf_insn *access, uint64_t off64)
+{
+	const struct bpf_eval_state *const st = verifier->evst;
+	const struct bpf_reg_val *rv;
+	/* Set of accessed byte offsets relative to memory area base. */
+	struct value_set access_set;
+	uint32_t opsz;
+
+	switch (BPF_CLASS(access->code)) {
+	case BPF_LDX:
+		rv = &st->rv[access->src_reg];
+		if (rv->v.type == BPF_ARG_PTR_STACK)
+			/* Not supporting stack access queries yet. */
+			return -ENOTSUP;
+		break;
+	case BPF_ST:
+		rv = &st->rv[access->dst_reg];
+		break;
+	case BPF_STX:
+		rv = &st->rv[access->dst_reg];
+		if (st->rv[access->src_reg].v.type == RTE_BPF_ARG_UNDEF)
+			return false;
+		break;
+	default:
+		return -ENOTSUP;
+	}
+
+	if (!RTE_BPF_ARG_PTR_TYPE(rv->v.type) || rv->v.size == 0)
+		return false;
+
+	access_set = value_set_from_pair(rv->s.min, rv->s.max, rv->u.min, rv->u.max);
+	value_set_translate(&access_set, off64);
+	opsz = bpf_size(BPF_SIZE(access->code));
+	value_set_add_contiguous(&access_set, 0, opsz - 1);
+
+	return value_set_is_covered_by_contiguous(&access_set, 0, rv->v.size - 1);
+}
+
+/* Return true if instruction `code` is supported by `may_jump`. */
+static bool
+may_jump_code_is_supported(uint8_t code)
+{
+	if (BPF_CLASS(code) != BPF_JMP)
+		return false;
+
+	switch (BPF_OP(code)) {
+	case BPF_JEQ:
+	case BPF_JGT:
+	case BPF_JGE:
+	case EBPF_JNE:
+	case EBPF_JSGT:
+	case EBPF_JSGE:
+	case EBPF_JLT:
+	case EBPF_JLE:
+	case EBPF_JSLT:
+	case EBPF_JSLE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Return true if instruction `code` corresponds to a signed comparison. */
+static bool
+may_jump_code_is_signed(uint8_t code)
+{
+	switch (BPF_OP(code)) {
+	case EBPF_JSGT:
+	case EBPF_JSGE:
+	case EBPF_JSLT:
+	case EBPF_JSLE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Return true the specified jump condition _may_ be true. */
+static bool
+may_jump(uint8_t code, const struct value_set *origin,
+	const struct value_set *dst_set, const struct value_set *src_set)
+{
+	switch (BPF_OP(code)) {
+	case BPF_JEQ:
+		return value_sets_intersect(dst_set, src_set);
+	case EBPF_JNE:
+		return !(value_set_is_singleton(dst_set) &&
+			value_sets_equal(dst_set, src_set));
+	case BPF_JGT:
+	case EBPF_JSGT:
+		return !value_sets_based_less_or_equal(origin, dst_set, src_set);
+	case BPF_JGE:
+	case EBPF_JSGE:
+		return !value_sets_based_less(origin, dst_set, src_set);
+	case EBPF_JLT:
+	case EBPF_JSLT:
+		return !value_sets_based_less_or_equal(origin, src_set, dst_set);
+	case EBPF_JSLE:
+	case EBPF_JLE:
+		return !value_sets_based_less(origin, src_set, dst_set);
+	}
+	/* may_jump_code_is_supported should have caught this */
+	RTE_ASSERT(false);
+	return false;
+}
+
+/* Return instruction code for jump condition complement (negated result). */
+static uint8_t
+may_jump_code_complement(uint8_t code)
+{
+	switch (BPF_OP(code)) {
+	case BPF_JEQ:
+	case EBPF_JNE:
+		return code ^ BPF_JEQ ^ EBPF_JNE;
+	case BPF_JGT:
+	case EBPF_JLE:
+		return code ^ BPF_JGT ^ EBPF_JLE;
+	case BPF_JGE:
+	case EBPF_JLT:
+		return code ^ BPF_JGE ^ EBPF_JLT;
+	case EBPF_JSGT:
+	case EBPF_JSLE:
+		return code ^ EBPF_JSGT ^ EBPF_JSLE;
+	case EBPF_JSGE:
+	case EBPF_JSLT:
+		return code ^ EBPF_JSGE ^ EBPF_JSLT;
+	}
+	/* may_jump_code_is_supported should have caught this */
+	RTE_ASSERT(false);
+	return 0;
+}
+
+int
+__rte_bpf_validate_may_jump(const struct bpf_verifier *verifier,
+	const struct ebpf_insn *jump, uint64_t imm64)
+{
+	const struct bpf_eval_state *const st = verifier->evst;
+	const struct bpf_reg_val *rd, *rs;
+	struct value_set dst_set, src_set, origin;
+	int result;
+
+	if (!may_jump_code_is_supported(jump->code))
+		return -ENOTSUP;
+
+	rd = &st->rv[jump->dst_reg];
+	dst_set = (rd->v.type == RTE_BPF_ARG_UNDEF) ? value_set_full :
+		value_set_from_pair(rd->s.min, rd->s.max, rd->u.min, rd->u.max);
+
+	rs = BPF_SRC(jump->code) == BPF_X ? &st->rv[jump->src_reg] : NULL;
+	src_set = rs == NULL ? value_set_singleton((int64_t)jump->imm) :
+		rs->v.type == RTE_BPF_ARG_UNDEF ? value_set_full :
+		value_set_from_pair(rs->s.min, rs->s.max, rs->u.min, rs->u.max);
+
+	value_set_translate(&src_set, imm64);
+
+	if (RTE_BPF_ARG_PTR_TYPE(rd->v.type) &&
+			(rs != NULL && RTE_BPF_ARG_PTR_TYPE(rs->v.type)) &&
+			rd->v.size == rs->v.size) {
+		/*
+		 * Both sides are pointers with the same memory area size.
+		 * Until tracking of memory areas is implemented we will consider them
+		 * pointing to the same memory area just because of this.
+		 * In this case our value sets represent offsets from the memory area base,
+		 * which is some unknown distance from the scalar zero (NULL).
+		 * We know however that the memory area cannot cross zero address.
+		 * Thus range of origin relative to memory base starts with 1 byte gap
+		 * after the memory area and ends just before it.
+		 */
+		origin = value_set_contiguous(rd->v.size + 1, -1);
+	} else {
+		/* Scalar value of a pointer depends on the memory area base address. */
+		if (RTE_BPF_ARG_PTR_TYPE(rd->v.type))
+			value_set_add_contiguous(&dst_set, 1, UINT64_MAX - rd->v.size);
+		if (rs != NULL && RTE_BPF_ARG_PTR_TYPE(rs->v.type))
+			value_set_add_contiguous(&dst_set, 1, UINT64_MAX - rs->v.size);
+		origin = value_set_singleton(0);
+	}
+
+	if (may_jump_code_is_signed(jump->code))
+		/* Shift origin to the minimal value for signed comparisons. */
+		value_set_translate(&origin, INT64_MIN);
+
+	result = 0;
+
+	if (may_jump(jump->code, &origin, &dst_set, &src_set))
+		result |= RTE_BPF_VALIDATE_DEBUG_MAY_BE_TRUE;
+
+	if (may_jump(may_jump_code_complement(jump->code), &origin, &dst_set, &src_set))
+		result |= RTE_BPF_VALIDATE_DEBUG_MAY_BE_FALSE;
+
+	return result;
+}
+
+/* Like snprintf, but advances (except for overflow) ptr and reduces szleft. */
+__attribute__((__format__ (__printf__, 3, 4)))
+static int
+buf_printf(char **ptr, ssize_t *szleft, const char *format, ...)
+{
+	va_list args;
+	int rc;
+
+	va_start(args, format);
+	rc = vsnprintf(*ptr, RTE_MAX(0, *szleft), format, args);
+	va_end(args);
+
+	if (rc > 0) {
+		*szleft -= rc;
+		if (*szleft > 0)
+			*ptr += rc;
+	}
+
+	return rc;
+}
+
+static int
+format_memory_area(char **ptr, ssize_t *szleft, const struct bpf_reg_val *rv)
+{
+	switch (rv->v.type) {
+	case RTE_BPF_ARG_RAW:
+		return 0;
+	case RTE_BPF_ARG_PTR:
+		return buf_printf(ptr, szleft, "%%buffer<%zu> + ",
+			(size_t)rv->v.size);
+	case RTE_BPF_ARG_PTR_MBUF:
+		return buf_printf(ptr, szleft, "%%mbuf<%zu, %zu> + ",
+			(size_t)rv->v.size, (size_t)rv->v.buf_size);
+	case BPF_ARG_PTR_STACK:
+		return buf_printf(ptr, szleft, "%%stack + ");
+	default:
+		return -ENOTSUP;
+	}
+}
+
+/* Format min..max interval using validate-debug API and updating ptr and szleft. */
+static int
+buf_print_interval(char **ptr, ssize_t *szleft, char format, uint64_t min, uint64_t max)
+{
+	int rc;
+
+	rc = rte_bpf_validate_debug_format_interval(*ptr, RTE_MAX(0, *szleft),
+		format, min, max);
+
+	if (rc > 0) {
+		*szleft -= rc;
+		if (*szleft > 0)
+			*ptr += rc;
+	}
+
+	return rc;
+}
+
+/* Format rv roughly as "<signed-range> INTERSECT <unsigned-hex-range>" */
+static int
+format_register_range(char **ptr, ssize_t *szleft, const struct bpf_reg_val *rv)
+{
+	int rc;
+	uint64_t expected_unsigned_min, expected_unsigned_max;
+	const bool valid = reg_val_range_is_valid(rv);
+
+	/* Print signed unless trivial. */
+	if (!valid || rv->s.min != INT64_MIN || rv->s.max != INT64_MAX) {
+		rc = buf_print_interval(ptr, szleft, 'd', rv->s.min, rv->s.max);
+		if (rc < 0)
+			return rc;
+
+		if (valid) {
+			/* Skip printing unsigned if it has expected values. */
+			if (rv->s.min >= 0 || rv->s.max < 0) {
+				expected_unsigned_min = (uint64_t)rv->s.min;
+				expected_unsigned_max = (uint64_t)rv->s.max;
+			} else {
+				expected_unsigned_min = 0;
+				expected_unsigned_max = UINT64_MAX;
+			}
+
+			if (rv->u.min == expected_unsigned_min &&
+					rv->u.max == expected_unsigned_max)
+				return 0;
+		}
+
+		rc = buf_printf(ptr, szleft, " INTERSECT ");
+		if (rc < 0)
+			return rc;
+	}
+
+	rc = buf_print_interval(ptr, szleft, 'x', rv->u.min, rv->u.max);
+	if (rc < 0)
+		return rc;
+
+	if (!valid) {
+		rc = buf_printf(ptr, szleft, " (!)");
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+/* Format rv roughly as "<memory-object> + <offsets-range>" */
+static int
+format_reg_val(char *buffer, size_t bufsz, const struct bpf_reg_val *rv)
+{
+	char *ptr = buffer;
+	ssize_t szleft = bufsz;
+	int rc;
+
+	if (rv->v.type == RTE_BPF_ARG_UNDEF)
+		return snprintf(buffer, bufsz, "%%undefined");
+
+	/* Print data area info, if any. */
+	rc = format_memory_area(&ptr, &szleft, rv);
+	if (rc < 0)
+		return rc;
+
+	rc = format_register_range(&ptr, &szleft, rv);
+	if (rc < 0)
+		return rc;
+
+	/* At least one snprintf was called and added terminating zero. */
+	RTE_ASSERT(szleft < (ssize_t)bufsz);
+	--szleft;
+
+	return bufsz - szleft;
+}
+
+int
+__rte_bpf_validate_format_register_info(const struct bpf_verifier *verifier,
+	char *buffer, size_t bufsz, uint8_t reg)
+{
+	if (reg >= EBPF_REG_NUM)
+		return -EINVAL;
+
+	return format_reg_val(buffer, bufsz, &verifier->evst->rv[reg]);
+}
+
+int
+__rte_bpf_validate_format_frame_info(const struct bpf_verifier *verifier,
+	char *buffer, size_t bufsz, int32_t offset)
+{
+	if (offset % sizeof(uint64_t) != 0)
+		return -EINVAL;
+
+	if (offset >= 0 || offset < -MAX_BPF_STACK_SIZE)
+		return -ERANGE;
+
+	offset = (MAX_BPF_STACK_SIZE + offset) / sizeof(uint64_t);
+
+	return format_reg_val(buffer, bufsz, &verifier->evst->sv[offset]);
+}
+
+int32_t
+__rte_bpf_validate_get_frame_size(const struct bpf_verifier *verifier)
+{
+	if (verifier->stack_sz > INT32_MAX)
+		return -ERANGE;
+
+	return verifier->stack_sz;
+}
+
+
 /*
  * check and evaluate functions for particular instruction types.
  */
@@ -2405,7 +2813,9 @@ evaluate(struct bpf_verifier *bvf)
 	const char *err;
 	const struct ebpf_insn *ins;
 	struct inst_node *next, *node;
-	int rc = 0;
+	int prev_nb_edge;  /* branching number of the previous instruction */
+	int rc, debug_rc;
+	struct rte_bpf_validate_debug *const debug = bvf->prm->debug;
 
 	struct {
 		uint32_t nb_eval;
@@ -2439,11 +2849,15 @@ evaluate(struct bpf_verifier *bvf)
 	ins = bvf->prm->raw.ins;
 	node = bvf->in;
 	next = node;
+	prev_nb_edge = 1;
 
 	memset(&stats, 0, sizeof(stats));
 
-	while (node != NULL) {
+	rc = __rte_bpf_validate_debug_evaluate_start(debug, bvf, bvf->prm);
+	if (rc < 0)
+		return rc;
 
+	while (node != NULL) {
 		/*
 		 * current node evaluation, make sure we evaluate
 		 * each node only once.
@@ -2464,6 +2878,13 @@ evaluate(struct bpf_verifier *bvf)
 			}
 
 			if (ins_chk[op].eval != NULL) {
+				rc = __rte_bpf_validate_debug_evaluate_step(
+					debug, idx, prev_nb_edge > 1 ?
+						RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER :
+						RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
+				if (rc < 0)
+					break;
+
 				err = ins_chk[op].eval(bvf, ins + idx);
 				stats.nb_eval++;
 				if (err != NULL) {
@@ -2499,10 +2920,17 @@ evaluate(struct bpf_verifier *bvf)
 			 */
 			if (node->nb_edge > 1 && prune_eval_state(bvf, node,
 					next) == 0) {
+				rc = __rte_bpf_validate_debug_evaluate_step(
+					debug, get_node_idx(bvf, next),
+					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE);
+				if (rc < 0)
+					break;
+
 				next = NULL;
 				stats.nb_prune++;
 			} else {
 				next->prev_node = node;
+				prev_nb_edge = node->nb_edge;
 				node = next;
 			}
 		} else {
@@ -2511,8 +2939,18 @@ evaluate(struct bpf_verifier *bvf)
 			 * mark it's @start state as safe for future references,
 			 * and proceed with parent.
 			 */
+
+			if (prev_nb_edge != 0) {
+				rc = __rte_bpf_validate_debug_evaluate_step(
+					debug, get_node_idx(bvf, node) + 1,
+					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN);
+				if (rc < 0)
+					break;
+			}
+
 			node->cur_edge = 0;
 			save_safe_eval_state(bvf, node);
+			prev_nb_edge = 0;
 			node = node->prev_node;
 
 			/* first node will not have prev, signalling finish */
@@ -2532,7 +2970,11 @@ evaluate(struct bpf_verifier *bvf)
 		__func__, bvf, rc,
 		stats.nb_eval, stats.nb_prune, stats.nb_save, stats.nb_restore);
 
-	return rc;
+	debug_rc = __rte_bpf_validate_debug_evaluate_finish(debug, rc);
+	rc = debug_rc < 0 ? debug_rc : rc;
+
+	/* Caller does not expect positive values. */
+	return RTE_MIN(0, rc);
 }
 
 static bool
diff --git a/lib/bpf/bpf_validate.h b/lib/bpf/bpf_validate.h
new file mode 100644
index 000000000000..c674ca414f96
--- /dev/null
+++ b/lib/bpf/bpf_validate.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _BPF_VALIDATE_H_
+#define _BPF_VALIDATE_H_
+
+/**
+ * @file bpf_validate.h
+ *
+ * Internal-use headers for eBPF validation observability.
+ */
+
+#include <bpf_def.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct bpf_verifier;
+
+/* Return true if the verifier passes internal self-check. */
+int
+__rte_bpf_validate_state_is_valid(const struct bpf_verifier *verifier);
+
+/* Return true the specified access instruction is valid. */
+int
+__rte_bpf_validate_can_access(const struct bpf_verifier *verifier,
+	const struct ebpf_insn *access, uint64_t off64);
+
+/* Get possible truth values of the specified jump condition. */
+int
+__rte_bpf_validate_may_jump(const struct bpf_verifier *verifier,
+	const struct ebpf_insn *jump, uint64_t imm64);
+
+/* Format known information about the register for the user. */
+int
+__rte_bpf_validate_format_register_info(const struct bpf_verifier *verifier,
+	char *buffer, size_t bufsz, uint8_t reg);
+
+/* Format known information about the frame location for the user. */
+int
+__rte_bpf_validate_format_frame_info(const struct bpf_verifier *verifier,
+	char *buffer, size_t bufsz, int32_t offset);
+
+/* Return frame size. */
+int32_t
+__rte_bpf_validate_get_frame_size(const struct bpf_verifier *verifier);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _BPF_VALIDATE_H_ */
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
new file mode 100644
index 000000000000..d1898ca4536c
--- /dev/null
+++ b/lib/bpf/bpf_validate_debug.c
@@ -0,0 +1,663 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "bpf_impl.h"
+#include "bpf_validate.h"
+#include "bpf_validate_debug.h"
+
+#include <eal_export.h>
+#include <rte_bpf_validate_debug.h>
+#include <rte_errno.h>
+#include <rte_per_lcore.h>
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdlib.h>
+
+#ifndef LIST_FOREACH_SAFE
+/* We need this macro which neither Linux nor EAL for Linux include yet. */
+#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = LIST_FIRST((head));				\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#else
+#ifdef RTE_EXEC_ENV_LINUX
+#error "Don't need LIST_FOREACH_SAFE in this version of DPDK anymore, remove it."
+#endif
+#endif
+
+#define EVENT_ARRAY_LENGTH RTE_BPF_VALIDATE_DEBUG_EVENT_END
+
+struct rte_bpf_validate_debug_point {
+	LIST_ENTRY(rte_bpf_validate_debug_point) list;
+	struct rte_bpf_validate_debug_callback callback;
+	uint32_t pc;
+};
+
+LIST_HEAD(point_list, rte_bpf_validate_debug_point);
+
+struct rte_bpf_validate_debug {
+	/* Accessible immediately after object creation. */
+	struct point_list pending_breakpoints;
+	struct point_list *catchpoint_lists;
+	struct rte_bpf_validate_debug_callback step_callback;
+
+	/* Accessible only after evaluate start. */
+	const struct bpf_verifier *verifier;
+	const struct rte_bpf_prm_ex *bpf_prm;
+	struct point_list *breakpoint_lists;
+	struct rte_bpf_validate_debug_point *last_point;
+	uint32_t pc;
+	/* Evaluate stage (only tracking `evaluate` part at the moment). */
+	bool evaluate_started;
+	bool evaluate_finished;
+	int evaluate_result;  /* Only valid if `evaluate_finished` is true. */
+};
+
+/* Point lists functions. */
+
+/* Destroy all points in the list. */
+static void
+point_list_destroy(struct point_list *point_list)
+{
+	struct rte_bpf_validate_debug_point *point, *next;
+
+	LIST_FOREACH_SAFE(point, point_list, list, next)
+		rte_bpf_validate_debug_point_destroy(point);
+
+	RTE_ASSERT(LIST_EMPTY(point_list));
+}
+
+/* Destroy all points in all lists in the array and free the array. */
+static void
+point_lists_destroy(struct point_list *point_lists, uint32_t length)
+{
+	if (point_lists == NULL)
+		return;
+
+	for (uint32_t pli = 0; pli != length; ++pli)
+		point_list_destroy(&point_lists[pli]);
+
+	free(point_lists);
+}
+
+/* Dynamically allocate and initialize an array of point lists. */
+static struct point_list *
+point_lists_create(uint32_t length)
+{
+	/* Allocate at least one element to avoid calloc(0, ...) shenanigans. */
+	struct point_list *const array =
+		calloc(RTE_MAX(1u, length), sizeof(*array));
+	if (array == NULL)
+		return NULL;
+
+	for (uint32_t pli = 0; pli != length; ++pli)
+		LIST_INIT(&array[pli]);
+
+	return array;
+}
+
+/* Move point to a different list. */
+static inline void
+point_move(struct rte_bpf_validate_debug_point *point,
+	struct point_list *destination)
+{
+	LIST_REMOVE(point, list);
+	LIST_INSERT_HEAD(destination, point, list);
+}
+
+/* Move all points between lists (the order is inverted). */
+static void
+points_move(struct point_list *source, struct point_list *destination)
+{
+	struct rte_bpf_validate_debug_point *point, *next;
+
+	LIST_FOREACH_SAFE(point, source, list, next)
+		point_move(point, destination);
+	RTE_ASSERT(LIST_EMPTY(source));
+}
+
+/* Pending breakpoints. */
+
+/* Return true if all pending breakpoints have pc less than nb_ins. */
+static bool
+debug_pending_breakpoints_are_valid(const struct rte_bpf_validate_debug *debug,
+	uint32_t nb_ins)
+{
+	const struct rte_bpf_validate_debug_point *breakpoint;
+
+	LIST_FOREACH(breakpoint, &debug->pending_breakpoints, list)
+		if (breakpoint->pc >= nb_ins)
+			return false;
+
+	return true;
+}
+
+/* Move all pending breakpoints to correct per-pc lists. */
+static void
+debug_pending_breakpoints_restore(struct rte_bpf_validate_debug *debug)
+{
+	struct rte_bpf_validate_debug_point *breakpoint, *next;
+	struct point_list breakpoints;
+
+	/* Invert the list first to preserve point order when we move them. */
+	LIST_INIT(&breakpoints);
+	points_move(&debug->pending_breakpoints, &breakpoints);
+
+	LIST_FOREACH_SAFE(breakpoint, &breakpoints, list, next)
+		point_move(breakpoint, &debug->breakpoint_lists[breakpoint->pc]);
+	RTE_ASSERT(LIST_EMPTY(&breakpoints));
+}
+
+/* Move all breakpoints from per-pc lists to the pending one. */
+static void
+debug_pending_breakpoints_save(struct rte_bpf_validate_debug *debug)
+{
+	struct point_list breakpoints;
+
+	LIST_INIT(&breakpoints);
+	for (uint32_t pc = 0; pc != debug->bpf_prm->raw.nb_ins; ++pc)
+		points_move(&debug->breakpoint_lists[pc], &breakpoints);
+
+	/* Invert the list to restore point order after we moved them. */
+	RTE_ASSERT(LIST_EMPTY(&debug->pending_breakpoints));
+	points_move(&breakpoints, &debug->pending_breakpoints);
+}
+
+/* Debug instance creation and destruction. */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_destroy, 26.07)
+void
+rte_bpf_validate_debug_destroy(struct rte_bpf_validate_debug *debug)
+{
+	if (debug == NULL)
+		return;
+
+	/* Cannot destroy the instance during validation. */
+	RTE_ASSERT(!debug->evaluate_started);
+
+	point_lists_destroy(debug->catchpoint_lists, EVENT_ARRAY_LENGTH);
+	point_list_destroy(&debug->pending_breakpoints);
+	free(debug);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_create, 26.07)
+struct rte_bpf_validate_debug *
+rte_bpf_validate_debug_create(void)
+{
+	struct rte_bpf_validate_debug *const debug = calloc(1, sizeof(*debug));
+	if (debug == NULL) {
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	LIST_INIT(&debug->pending_breakpoints);
+
+	debug->catchpoint_lists = point_lists_create(EVENT_ARRAY_LENGTH);
+	if (debug->catchpoint_lists == NULL) {
+		free(debug);
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	return debug;
+}
+
+/* Managing callbacks. */
+
+/* Call back the user function with correct arguments for a point. */
+static inline int
+debug_point_call_back(struct rte_bpf_validate_debug *debug,
+	struct rte_bpf_validate_debug_point *point)
+{
+	debug->last_point = point;
+	return point->callback.fn(debug, point->callback.ctx);
+}
+
+/* Call back all points in point_list. */
+static int
+debug_points_call_back(struct rte_bpf_validate_debug *debug,
+	const struct point_list *point_list)
+{
+	struct rte_bpf_validate_debug_point *point, *next;
+	int rc = 0;
+
+	LIST_FOREACH_SAFE(point, point_list, list, next)
+		rc = rc < 0 ? rc : debug_point_call_back(debug, point);
+
+	return rc;
+}
+
+/* Call back all catchpoints for the specified event. */
+static int
+debug_send_event(struct rte_bpf_validate_debug *debug, debug_event_t event)
+{
+	return debug_points_call_back(debug, &debug->catchpoint_lists[event]);
+}
+
+/* Create new point and insert it into the specified list. */
+static struct rte_bpf_validate_debug_point *
+point_list_insert(struct point_list *point_list,
+	const struct rte_bpf_validate_debug_callback *callback, uint32_t pc)
+{
+	struct rte_bpf_validate_debug_point *const point =
+		malloc(sizeof(*point));
+	if (point == NULL) {
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	LIST_INSERT_HEAD(point_list, point, list);
+	point->callback = *callback;
+	point->pc = pc;
+	return point;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_break, 26.07)
+struct rte_bpf_validate_debug_point *
+rte_bpf_validate_debug_break(struct rte_bpf_validate_debug *debug, uint32_t pc,
+	const struct rte_bpf_validate_debug_callback *callback)
+{
+	if (debug == NULL || callback == NULL || callback->fn == NULL) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	if (!debug->evaluate_started)
+		return point_list_insert(&debug->pending_breakpoints,
+			callback, pc);
+
+	if (pc >= debug->bpf_prm->raw.nb_ins) {
+		rte_errno = ENOENT;
+		return NULL;
+	}
+
+	return point_list_insert(&debug->breakpoint_lists[pc], callback, pc);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_catch, 26.07)
+struct rte_bpf_validate_debug_point *
+rte_bpf_validate_debug_catch(struct rte_bpf_validate_debug *debug,
+	debug_event_t event, const struct rte_bpf_validate_debug_callback *callback)
+{
+	if (debug == NULL || callback == NULL || callback->fn == NULL ||
+			event < 0 || event >= RTE_BPF_VALIDATE_DEBUG_EVENT_END) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	return point_list_insert(&debug->catchpoint_lists[event], callback, 0);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_point_destroy, 26.07)
+void
+rte_bpf_validate_debug_point_destroy(struct rte_bpf_validate_debug_point *point)
+{
+	if (point == NULL)
+		return;
+
+	LIST_REMOVE(point, list);
+	free(point);
+}
+
+/* Querying execution state. */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_bpf_param, 26.07)
+const struct rte_bpf_prm_ex *
+rte_bpf_validate_debug_get_bpf_param(const struct rte_bpf_validate_debug *debug)
+{
+	if (debug == NULL) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	if (!debug->evaluate_started) {
+		rte_errno = ECHILD;
+		return NULL;
+	}
+
+	return debug->bpf_prm;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_ins, 26.07)
+int
+rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
+	const struct ebpf_insn **ins, uint32_t *nb_ins)
+{
+	if (debug == NULL)
+		return -EINVAL;
+
+	if (!debug->evaluate_started)
+		return -ECHILD;
+
+	if (debug->bpf_prm->origin != RTE_BPF_ORIGIN_RAW)
+		return -ENOTSUP;
+
+	*ins = debug->bpf_prm->raw.ins;
+	*nb_ins = debug->bpf_prm->raw.nb_ins;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_last_point, 26.07)
+struct rte_bpf_validate_debug_point *
+rte_bpf_validate_debug_get_last_point(const struct rte_bpf_validate_debug *debug)
+{
+	if (debug == NULL) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	return debug->last_point;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_pc, 26.07)
+uint32_t
+rte_bpf_validate_debug_get_pc(const struct rte_bpf_validate_debug *debug)
+{
+	if (debug == NULL || !debug->evaluate_started)
+		return UINT32_MAX;
+
+	return debug->pc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_validation_result, 26.07)
+int
+rte_bpf_validate_debug_get_validation_result(const struct rte_bpf_validate_debug *debug,
+	int *result)
+{
+	if (debug == NULL)
+		return -EINVAL;
+
+	if (!debug->evaluate_finished)
+		return -EAGAIN;
+
+	*result = debug->evaluate_result;
+
+	return 0;
+}
+
+/* Querying VM state. */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_can_access, 26.07)
+int
+rte_bpf_validate_debug_can_access(const struct rte_bpf_validate_debug *debug,
+	const struct ebpf_insn *access, uint64_t off64)
+{
+	if (debug == NULL || access == NULL)
+		return -EINVAL;
+
+	if (!debug->evaluate_started)
+		return -ECHILD;
+
+	return __rte_bpf_validate_can_access(debug->verifier, access, off64);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_may_jump, 26.07)
+int
+rte_bpf_validate_debug_may_jump(const struct rte_bpf_validate_debug *debug,
+	const struct ebpf_insn *jump, uint64_t imm64)
+{
+	if (debug == NULL || jump == NULL)
+		return -EINVAL;
+
+	if (!debug->evaluate_started)
+		return -ECHILD;
+
+	return __rte_bpf_validate_may_jump(debug->verifier, jump, imm64);
+}
+
+/* Formatting VM state for user. */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_format_register_info, 26.07)
+int
+rte_bpf_validate_debug_format_register_info(const struct rte_bpf_validate_debug *debug,
+	char *buffer, size_t bufsz, uint8_t reg)
+{
+	if (debug == NULL)
+		return -EINVAL;
+
+	if (!debug->evaluate_started)
+		return -ECHILD;
+
+	return __rte_bpf_validate_format_register_info(debug->verifier, buffer,
+		bufsz, reg);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_format_frame_info, 26.07)
+int
+rte_bpf_validate_debug_format_frame_info(const struct rte_bpf_validate_debug *debug,
+	char *buffer, size_t bufsz, int32_t offset)
+{
+	if (debug == NULL)
+		return -EINVAL;
+
+	if (!debug->evaluate_started)
+		return -ECHILD;
+
+	return __rte_bpf_validate_format_frame_info(debug->verifier, buffer,
+		bufsz, offset);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_frame_size, 26.07)
+int32_t
+rte_bpf_validate_debug_get_frame_size(const struct rte_bpf_validate_debug *debug)
+{
+	if (debug == NULL)
+		return -EINVAL;
+
+	if (!debug->evaluate_started)
+		return -ECHILD;
+
+	return __rte_bpf_validate_get_frame_size(debug->verifier);
+}
+
+/* Courtesy formatting functions for user-supplied values. */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_format_value, 26.07)
+int
+rte_bpf_validate_debug_format_value(char *buffer, size_t bufsz, char format,
+	uint64_t value)
+{
+	static const struct {
+		uint64_t value;
+		const char *name;
+	} constants[] = {
+		{ .value = INT64_MIN, .name = "INT64_MIN" },
+		{ .value = INT32_MIN, .name = "INT32_MIN" },
+		{ .value = INT16_MIN, .name = "INT16_MIN" },
+		{ .value = INT8_MIN, .name = "INT8_MIN" },
+		{ .value = INT8_MAX, .name = "INT8_MAX" },
+		{ .value = UINT8_MAX, .name = "UINT8_MAX" },
+		{ .value = INT16_MAX, .name = "INT16_MAX" },
+		{ .value = UINT16_MAX, .name = "UINT16_MAX" },
+		{ .value = INT32_MAX, .name = "INT32_MAX" },
+		{ .value = UINT32_MAX, .name = "UINT32_MAX" },
+		{ .value = INT64_MAX, .name = "INT64_MAX" },
+		/* UINT64_MAX omitted on purpose, it looks better as -1 */
+	};
+
+	switch (format) {
+	case 'd':
+		for (int ci = 0; ci != RTE_DIM(constants); ++ci)
+			if (constants[ci].value == value)
+				return snprintf(buffer, bufsz, "%s", constants[ci].name);
+		/*
+		 * Special case numbers close to int32_t or int64_t range ends,
+		 * since they are hard to recognize in decimal otherwise.
+		 */
+		if (value - INT64_MIN < 1000000)
+			return snprintf(buffer, bufsz, "INT64_MIN+%" PRId64,
+				value - INT64_MIN);
+		if (INT64_MAX - value < 1000000)
+			return snprintf(buffer, bufsz, "INT64_MAX-%" PRId64,
+				INT64_MAX - value);
+		if (value - INT32_MIN < 1000)
+			return snprintf(buffer, bufsz, "INT32_MIN+%" PRId64,
+				value - INT32_MIN);
+		if (INT32_MAX - value < 1000)
+			return snprintf(buffer, bufsz, "INT32_MAX-%" PRId64,
+				INT32_MAX - value);
+		return snprintf(buffer, bufsz, "%" PRId64, value);
+	case 'x':
+		/* Special case only the common case of UINT64_MAX. */
+		if (value == UINT64_MAX)
+			return snprintf(buffer, bufsz, "%s", "UINT64_MAX");
+		return snprintf(buffer, bufsz, "%#" PRIx64, value);
+	default:
+		return -EINVAL;
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_format_interval, 26.07)
+int
+rte_bpf_validate_debug_format_interval(char *buffer, size_t bufsz, char format,
+	uint64_t min, uint64_t max)
+{
+	char min_buffer[32], max_buffer[32];
+	int rc;
+
+	if (min == max)
+		return rte_bpf_validate_debug_format_value(buffer, bufsz, format, min);
+
+	rc = rte_bpf_validate_debug_format_value(min_buffer, sizeof(min_buffer), format, min);
+	if (rc < 0)
+		return rc;
+
+	rc = rte_bpf_validate_debug_format_value(max_buffer, sizeof(max_buffer), format, max);
+	if (rc < 0)
+		return rc;
+
+	return snprintf(buffer, bufsz, "%s..%s", min_buffer, max_buffer);
+}
+
+/* Evaluation start and finish. */
+
+/* Free all resources associated with current evaluation. */
+static void
+debug_evaluate_close(struct rte_bpf_validate_debug *debug)
+{
+	RTE_ASSERT(debug->evaluate_started);
+	debug_pending_breakpoints_save(debug);
+	free(debug->breakpoint_lists);
+	debug->breakpoint_lists = NULL;
+	debug->evaluate_started = false;
+}
+
+int
+__rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
+	const struct bpf_verifier *verifier, const struct rte_bpf_prm_ex *bpf_prm)
+{
+	if (debug == NULL)
+		return 0;
+
+	if (verifier == NULL || bpf_prm == NULL ||
+			bpf_prm->origin != RTE_BPF_ORIGIN_RAW)
+		return -EINVAL;
+
+	if (debug->evaluate_started) {
+		RTE_BPF_LOG_FUNC_LINE(ERR, "already started");
+		return -EEXIST;
+	}
+
+	if (!debug_pending_breakpoints_are_valid(debug, bpf_prm->raw.nb_ins))
+		return -ENOENT;
+
+	debug->verifier = verifier;
+	debug->bpf_prm = bpf_prm;
+	debug->breakpoint_lists = point_lists_create(bpf_prm->raw.nb_ins);
+	if (debug->breakpoint_lists == NULL)
+		return -ENOMEM;
+	debug_pending_breakpoints_restore(debug);
+	debug->last_point = NULL;
+	debug->pc = 0;
+	debug->evaluate_started = true;
+
+	const int rc = debug_send_event(debug,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START);
+	if (rc < 0) {
+		debug_evaluate_close(debug);
+		return rc;
+	}
+
+	RTE_BPF_LOG_FUNC_LINE(DEBUG, "evaluate started");
+	return 0;
+}
+
+int
+__rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
+	uint32_t pc, debug_event_t event)
+{
+	int rc;
+
+	if (debug == NULL)
+		return 0;
+
+	if (!debug->evaluate_started) {
+		RTE_BPF_LOG_FUNC_LINE(ERR, "not started");
+		return -ECHILD;
+	}
+
+	if (pc > debug->bpf_prm->raw.nb_ins || event < 0 ||
+			event >= RTE_BPF_VALIDATE_DEBUG_EVENT_END)
+		return -EINVAL;
+
+	debug->pc = pc;
+
+	rc = __rte_bpf_validate_state_is_valid(debug->verifier);
+	if (rc == false)
+		rc = debug_send_event(debug,
+			RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE);
+
+	if (event != RTE_BPF_VALIDATE_DEBUG_EVENT_STEP)
+		rc = rc < 0 ? rc : debug_send_event(debug, event);
+
+	if (event == RTE_BPF_VALIDATE_DEBUG_EVENT_STEP ||
+			event == RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER)
+		/* Stepping into a real instruction to execute. */
+		rc = rc < 0 ? rc : debug_points_call_back(debug,
+			&debug->breakpoint_lists[pc]);
+
+	rc = rc < 0 ? rc : debug_send_event(debug,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
+
+	return rc;
+}
+
+int
+__rte_bpf_validate_debug_evaluate_finish(struct rte_bpf_validate_debug *debug,
+	int result)
+{
+	int rc = 0;
+	uint32_t pc;
+	debug_event_t event;
+
+	if (debug == NULL)
+		return 0;
+
+	if (!debug->evaluate_started) {
+		RTE_BPF_LOG_FUNC_LINE(ERR, "not started");
+		return -ECHILD;
+	}
+
+	debug->evaluate_finished = true;
+	debug->evaluate_result = result;
+
+	if (result != -ECANCELED) {
+		if (result < 0) {
+			/* Last known pc is the place we failed. */
+			pc = debug->pc;
+			event = RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE;
+		} else {
+			/* Show program end, not particular instruction. */
+			pc = debug->bpf_prm->raw.nb_ins;
+			event = RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS;
+		}
+
+		rc = __rte_bpf_validate_debug_evaluate_step(debug, pc, event);
+	}
+
+	debug_evaluate_close(debug);
+
+	return rc;
+}
diff --git a/lib/bpf/bpf_validate_debug.h b/lib/bpf/bpf_validate_debug.h
new file mode 100644
index 000000000000..a91f3e9c48b2
--- /dev/null
+++ b/lib/bpf/bpf_validate_debug.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _BPF_VALIDATE_DEBUG_H_
+#define _BPF_VALIDATE_DEBUG_H_
+
+/**
+ * @file bpf_validate_debug.h
+ *
+ * Internal-use headers for eBPF validation debug notifications.
+ */
+
+#include "rte_bpf_validate_debug.h"
+
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct rte_bpf_prm_ex;
+struct rte_bpf_validate_debug;
+struct bpf_verifier;
+
+/* Type alias for validation event enum. */
+typedef enum rte_bpf_validate_debug_event debug_event_t;
+
+/*
+ * Signal beginning of evaluation process.
+ *
+ * Immediately return 0 if debug is NULL.
+ *
+ * @param debug
+ *   Validate debug instance configured by user, can be NULL.
+ * @param verifier
+ *   Opaque pointer that can be used for calling bpf_validate.h API.
+ * @param bpf_prm
+ *   Parameters struct of the validated eBPF program, including code with all
+ *   patches and relocations applied.
+ * @return
+ *   Non-negative value on success, negative errno on failure.
+ */
+int
+__rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
+	const struct bpf_verifier *verifier, const struct rte_bpf_prm_ex *bpf_prm);
+
+/*
+ * Signal each instruction, branch end, or evaluation end.
+ *
+ * Immediately return 0 if debug is NULL.
+ *
+ * @param debug
+ *   Validate debug instance configured by user, can be NULL.
+ * @param pc
+ *   Current value of the program counter, or next after last instruction.
+ * @param event
+ *   Specific evaluation event if any, or RTE_BPF_VALIDATE_DEBUG_EVENT_STEP.
+ * @return
+ *   Non-negative value: evaluation should continue;
+ *   -ECANCELED: evaluation should fail without calling this API again;
+ *   Other negative value: evaluation should fail signalling failure;
+ */
+int
+__rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
+	uint32_t pc, debug_event_t event);
+
+/*
+ * Signal end of evaluation process.
+ *
+ * Immediately return 0 if debug is NULL.
+ *
+ * @param debug
+ *   Validate debug instance configured by user, can be NULL.
+ * @return
+ *   Non-negative value on success, negative errno on failure.
+ */
+int
+__rte_bpf_validate_debug_evaluate_finish(struct rte_bpf_validate_debug *debug,
+	int result);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _BPF_VALIDATE_DEBUG_H_ */
diff --git a/lib/bpf/bpf_value_set.c b/lib/bpf/bpf_value_set.c
new file mode 100644
index 000000000000..86f46de66f2f
--- /dev/null
+++ b/lib/bpf/bpf_value_set.c
@@ -0,0 +1,403 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#include "bpf_value_set.h"
+
+#include <rte_debug.h>
+
+/* Helper interval operations and checks.  */
+
+/* One of many possible full intervals. */
+static const struct value_set_interval canonical_full_interval = {
+	.first = 0,
+	.last = UINT64_MAX,
+};
+
+/* Translate ("shift") interval by `offset`. */
+static void
+interval_translate(struct value_set_interval *interval, uint64_t offset)
+{
+	interval->first += offset;
+	interval->last += offset;
+}
+
+/* Return true if the interval includes all possible values. */
+static bool
+interval_is_full(struct value_set_interval interval)
+{
+	return interval.last + 1 == interval.first;
+}
+
+/* Return true if the interval includes `value`. */
+static bool
+interval_contains(struct value_set_interval interval, uint64_t value)
+{
+	return value - interval.first <= interval.last - interval.first;
+}
+
+/* Return true if the interval `lhs` includes all values from `rhs`. */
+static bool
+interval_covers(struct value_set_interval lhs, struct value_set_interval rhs)
+{
+	const uint64_t offset = -lhs.first;
+	interval_translate(&lhs, offset);
+	interval_translate(&rhs, offset);
+	RTE_ASSERT(lhs.first == 0);
+
+	return lhs.last == UINT64_MAX ||
+		(lhs.last >= rhs.last && rhs.last >= rhs.first);
+}
+
+/* Return true if the interval includes step from UINT64_MAX to 0. */
+static bool
+interval_crosses_zero(struct value_set_interval interval)
+{
+	return interval.last < interval.first;
+}
+
+/* Return number of elements in a non-full elements, 0 for full interval. */
+static uint64_t
+interval_size(struct value_set_interval interval)
+{
+	return interval.last - interval.first + 1;
+}
+
+/* Return true if two intervals represent same sets of values. */
+static bool
+intervals_equal(struct value_set_interval lhs, struct value_set_interval rhs)
+{
+	return (interval_is_full(lhs) && interval_is_full(rhs)) ||
+		(lhs.first == rhs.first && lhs.last == rhs.last);
+}
+
+/* Return true if two intervals have common elements. */
+static bool
+intervals_intersect(struct value_set_interval lhs, struct value_set_interval rhs)
+{
+	return interval_contains(lhs, rhs.first) || interval_contains(rhs, lhs.first);
+}
+
+/* Return true if `rhs.first` follows `lhs.last` with some gap. Does not check other ends! */
+static bool
+intervals_follow_with_gap(struct value_set_interval lhs, struct value_set_interval rhs)
+{
+	return lhs.last != UINT64_MAX && rhs.first > lhs.last + 1;
+}
+
+/* Return true if `(l - o) < (r - o)` for all `(o in origin, l in lhs, r in rhs)`. */
+static bool
+intervals_based_less(struct value_set_interval origin, struct value_set_interval lhs,
+	struct value_set_interval rhs)
+{
+	/* Translate all intervals for the origin to start at 0. */
+	const uint64_t offset = -origin.first;
+	interval_translate(&origin, offset);
+	interval_translate(&lhs, offset);
+	interval_translate(&rhs, offset);
+	RTE_ASSERT(origin.first == 0);
+
+	return origin.last <= lhs.first &&
+		lhs.first <= lhs.last &&
+		lhs.last < rhs.first &&
+		rhs.first <= rhs.last;
+}
+
+/* Return true if `(l - o) <= (r - o)` for all `(o in origin, l in lhs, r in rhs)`. */
+static bool
+intervals_based_less_or_equal(struct value_set_interval origin, struct value_set_interval lhs,
+	struct value_set_interval rhs)
+{
+	/* Translate all intervals for the origin to start at 0. */
+	const uint64_t offset = -origin.first;
+	interval_translate(&origin, offset);
+	interval_translate(&lhs, offset);
+	interval_translate(&rhs, offset);
+	RTE_ASSERT(origin.first == 0);
+
+	/* Special cases. */
+	if (origin.last == 0 && lhs.first == 0 && lhs.last == 0)
+		return true;
+	if (origin.last == 0 && rhs.first == UINT64_MAX && rhs.last == UINT64_MAX)
+		return true;
+	if (lhs.first == lhs.last && lhs.last == rhs.first && rhs.first == rhs.last)
+		return true;
+
+	return origin.last <= lhs.first &&
+		lhs.first <= lhs.last &&
+		lhs.last <= rhs.first &&
+		rhs.first <= rhs.last;
+}
+
+/* Append interval rhs to list of intervals in lhs. */
+static void
+value_set_append(struct value_set *lhs, struct value_set_interval rhs)
+{
+	RTE_VERIFY(lhs->nb_interval < VALUE_SET_NB_INTERVAL_MAX);
+	RTE_VERIFY(lhs->nb_interval == 0 ||
+		intervals_follow_with_gap(lhs->interval[lhs->nb_interval - 1], rhs));
+	lhs->interval[lhs->nb_interval++] = rhs;
+}
+
+/*
+ * Helper operations on noncyclic value set and intervals.
+ * Noncyclic means no interval crosses zero,
+ * but in return last value set interval may touch first.
+ */
+
+static struct value_set
+noncyclic_value_set_union_interval(const struct value_set *lhs, const struct value_set_interval rhs)
+{
+	struct value_set result = {};
+	uint32_t index = 0;
+
+	RTE_ASSERT(lhs->nb_interval == 0 ||
+		!interval_crosses_zero(lhs->interval[lhs->nb_interval - 1]));
+	RTE_ASSERT(!interval_crosses_zero(rhs));
+
+	/* Append to result all lhs intervals preceding rhs. */
+	for (; index != lhs->nb_interval; ++index) {
+		const struct value_set_interval lhs_interval = lhs->interval[index];
+		if (!intervals_follow_with_gap(lhs_interval, rhs))
+			break;
+
+		value_set_append(&result, lhs_interval);
+	}
+
+	/* Appendinterval joined from rhs and all lhs intervals intersecting or touching it. */
+	struct value_set_interval joint_interval = rhs;
+	for (; index != lhs->nb_interval; ++index) {
+		const struct value_set_interval lhs_interval = lhs->interval[index];
+		if (intervals_follow_with_gap(rhs, lhs_interval))
+			break;
+
+		joint_interval.first = RTE_MIN(joint_interval.first, lhs_interval.first);
+		joint_interval.last = RTE_MAX(joint_interval.last, lhs_interval.last);
+	}
+	value_set_append(&result, joint_interval);
+
+	/* Append to result all lhs intervals following rhs. */
+	for (; index != lhs->nb_interval; ++index)
+		value_set_append(&result, lhs->interval[index]);
+
+	return result;
+}
+
+/* Make "normal" maximal disjoint interval value set out of noncyclic one. */
+static struct value_set
+value_set_from_noncyclic(const struct value_set *set)
+{
+	struct value_set result = {};
+	uint32_t index = 0;
+
+	if (set->nb_interval <= 1)
+		return *set;
+
+	struct value_set_interval last_interval = set->interval[set->nb_interval - 1];
+	if (last_interval.last == UINT64_MAX && set->interval[0].first == 0) {
+		/* Join first interval with the last one instead of copying it. */
+		last_interval.last = set->interval[0].last;
+		++index;
+	}
+
+	for (; index != set->nb_interval - 1; ++index)
+		value_set_append(&result, set->interval[index]);
+
+	value_set_append(&result, last_interval);
+
+	return result;
+}
+
+/* Make lhs a union of lhs and rhs. */
+static void
+value_set_union_interval(struct value_set *lhs, const struct value_set_interval rhs)
+{
+	struct value_set temp;
+
+	if (value_set_is_empty(lhs)) {
+		value_set_append(lhs, rhs);
+		return;
+	}
+
+	struct value_set_interval *const last_interval = &lhs->interval[lhs->nb_interval - 1];
+	const bool last_interval_crossed_zero = interval_crosses_zero(*last_interval);
+	const uint64_t wrapping_last = last_interval->last;
+
+	if (last_interval_crossed_zero)
+		/* Make value set noncyclic by removing crossing part of last interval. */
+		last_interval->last = UINT64_MAX;
+
+	if (interval_crosses_zero(rhs)) {
+		/* Add parts before and after zero separately. */
+		temp = noncyclic_value_set_union_interval(lhs,
+			(struct value_set_interval){
+				.first = rhs.first,
+				.last = UINT64_MAX,
+			});
+		temp = noncyclic_value_set_union_interval(lhs,
+			(struct value_set_interval){
+				.first = 0,
+				.last = rhs.last,
+			});
+	} else
+		temp = noncyclic_value_set_union_interval(lhs, rhs);
+
+	if (last_interval_crossed_zero)
+		/* Restore previously removed part. */
+		temp = noncyclic_value_set_union_interval(&temp,
+			(struct value_set_interval){
+				.first = 0,
+				.last = wrapping_last,
+			});
+
+	*lhs = value_set_from_noncyclic(&temp);
+}
+
+/* Set `lhs` to the set of possible sums between values from `lhs` and `rhs`. */
+static void
+value_set_add_interval(struct value_set *lhs, struct value_set_interval rhs)
+{
+	const struct value_set temp = *lhs;
+	lhs->nb_interval = 0;
+
+	for (uint32_t index = 0; index != temp.nb_interval; ++index) {
+		const struct value_set_interval interval = temp.interval[index];
+		if (interval_is_full(rhs) || interval_is_full(interval) ||
+				interval_size(interval) > UINT64_MAX - interval_size(rhs)) {
+			value_set_append(lhs, canonical_full_interval);
+			return;
+		}
+	}
+
+	for (uint32_t index = 0; index != temp.nb_interval; ++index)
+		value_set_union_interval(lhs, (struct value_set_interval){
+			/* Checked sizes above, so these interval expansions won't overflow. */
+			.first = temp.interval[index].first + rhs.first,
+			.last = temp.interval[index].last + rhs.last,
+		});
+}
+
+struct value_set
+value_set_singleton(uint64_t value)
+{
+	return value_set_contiguous(value, value);
+}
+
+struct value_set
+value_set_contiguous(uint64_t first, uint64_t last)
+{
+	return (struct value_set){
+		.nb_interval = 1,
+		.interval = {
+			{ .first = first, .last = last },
+		},
+	};
+}
+
+struct value_set
+value_set_from_pair(uint64_t first1, uint64_t last1, uint64_t first2, uint64_t last2)
+{
+	struct value_set result = {};
+
+	if (first1 - first2 <= last2 - first2)
+		/* Interval 1 starts within interval 2. */
+		value_set_union_interval(&result, (struct value_set_interval){
+				.first = first1,
+				.last = first1 + RTE_MIN(last1 - first1, last2 - first1),
+			});
+
+	if (first2 - first1 <= last1 - first1)
+		/* Interval 2 starts within interval 1. */
+		value_set_union_interval(&result, (struct value_set_interval){
+				.first = first2,
+				.last = first2 + RTE_MIN(last2 - first2, last1 - first2),
+			});
+
+	return result;
+}
+
+bool
+value_set_is_empty(const struct value_set *set)
+{
+	return set->nb_interval == 0;
+}
+
+bool
+value_set_is_singleton(const struct value_set *set)
+{
+	return set->nb_interval == 1 && interval_size(set->interval[0]) == 1;
+}
+
+bool
+value_sets_equal(const struct value_set *lhs, const struct value_set *rhs)
+{
+	if (lhs->nb_interval != rhs->nb_interval)
+		return false;
+
+	for (uint32_t index = 0; index != lhs->nb_interval; ++index)
+		if (!intervals_equal(lhs->interval[index], rhs->interval[index]))
+			return false;
+
+	return true;
+}
+
+bool
+value_sets_intersect(const struct value_set *lhs, const struct value_set *rhs)
+{
+	for (uint32_t lhs_index = 0; lhs_index != lhs->nb_interval; ++lhs_index)
+		for (uint32_t rhs_index = 0; rhs_index != rhs->nb_interval; ++rhs_index)
+			if (intervals_intersect(lhs->interval[lhs_index], rhs->interval[rhs_index]))
+				return true;
+
+	return false;
+}
+
+bool
+value_set_is_covered_by_contiguous(const struct value_set *lhs, uint64_t first, uint64_t last)
+{
+	const struct value_set_interval rhs = { .first = first, .last = last };
+	for (uint32_t lhs_index = 0; lhs_index != lhs->nb_interval; ++lhs_index)
+		if (!interval_covers(rhs, lhs->interval[lhs_index]))
+			return false;
+
+	return true;
+}
+
+bool
+value_sets_based_less(const struct value_set *origin, const struct value_set *lhs,
+	const struct value_set *rhs)
+{
+	for (uint32_t origin_index = 0; origin_index != origin->nb_interval; ++origin_index)
+		for (uint32_t lhs_index = 0; lhs_index != lhs->nb_interval; ++lhs_index)
+			for (uint32_t rhs_index = 0; rhs_index != rhs->nb_interval; ++rhs_index)
+				if (!intervals_based_less(origin->interval[origin_index],
+						lhs->interval[lhs_index], rhs->interval[rhs_index]))
+					return false;
+	return true;
+}
+
+bool
+value_sets_based_less_or_equal(const struct value_set *origin, const struct value_set *lhs,
+	const struct value_set *rhs)
+{
+	for (uint32_t origin_index = 0; origin_index != origin->nb_interval; ++origin_index)
+		for (uint32_t lhs_index = 0; lhs_index != lhs->nb_interval; ++lhs_index)
+			for (uint32_t rhs_index = 0; rhs_index != rhs->nb_interval; ++rhs_index)
+				if (!intervals_based_less_or_equal(origin->interval[origin_index],
+						lhs->interval[lhs_index], rhs->interval[rhs_index]))
+					return false;
+	return true;
+}
+
+void
+value_set_translate(struct value_set *set, uint64_t offset)
+{
+	for (uint32_t index = 0; index != set->nb_interval; ++index)
+		interval_translate(&set->interval[index], offset);
+}
+
+void
+value_set_add_contiguous(struct value_set *lhs, uint64_t first, uint64_t last)
+{
+	value_set_add_interval(lhs, (struct value_set_interval){ .first = first, .last = last });
+}
diff --git a/lib/bpf/bpf_value_set.h b/lib/bpf/bpf_value_set.h
new file mode 100644
index 000000000000..5e7f8e521f55
--- /dev/null
+++ b/lib/bpf/bpf_value_set.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _BPF_VALUE_SET_H_
+#define _BPF_VALUE_SET_H_
+
+/**
+ * @file value_set.h
+ *
+ * Value set operations for BPF validate debug.
+ *
+ * This is not a general use library, only minimal set of operations is provided
+ * that are necessary for implementing validate debug interface.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define VALUE_SET_NB_INTERVAL_MAX 3
+
+/*
+ * Cyclic interval on uint64_t.
+ *
+ * Cyclic means value of `last` might be numerically smaller than `first`,
+ * that is the interval may cross from UINT64_MAX to 0.
+ *
+ * Contains element `first` and all elements that can be obtained from it by
+ * adding 1 until the result reaches `last`, which is included.
+ * There is thus multiple representations of the full set and no representation
+ * of the empty set.
+ *
+ * When `first` and `last` are accepted separately as function arguments, the
+ * term _contiguous_ is being used. It means that values of `first` and `last`
+ * are used to create a contiguous set composed of a single cyclic interval
+ * defined by these points.
+ */
+struct value_set_interval {
+	uint64_t first;
+	uint64_t last;
+};
+
+/*
+ * Set of values represented as an ordered sequence of maximal disjoint cyclic intervals.
+ *
+ * Condition `maximal disjoint` means intervals do not intersect or touch each other.
+ *
+ * The sequence is ordered by member `first`. Only last interval may thus cross zero.
+ */
+struct value_set {
+	uint32_t nb_interval;
+	struct value_set_interval interval[VALUE_SET_NB_INTERVAL_MAX];
+};
+
+/* Empty value set. */
+static const struct value_set value_set_empty = {
+	.nb_interval = 0,
+};
+
+/* Full (including every possible value) value set. */
+static const struct value_set value_set_full = {
+	.nb_interval = 1,
+	.interval = {
+		{ .first = 0, .last = UINT64_MAX },
+	},
+};
+
+/* Return set containing only `value`. */
+struct value_set
+value_set_singleton(uint64_t value);
+
+/* Return set of all values between and including `first` and `last` (AKA first..last). */
+struct value_set
+value_set_contiguous(uint64_t first, uint64_t last);
+
+/* Return set of all values belonging to _both_ first1..last1 and first2..last. */
+struct value_set
+value_set_from_pair(uint64_t first1, uint64_t last1, uint64_t first2, uint64_t last2);
+
+/* Return true if the set is empty. */
+bool
+value_set_is_empty(const struct value_set *set);
+
+/* Return true if the set only contains one element. */
+bool
+value_set_is_singleton(const struct value_set *set);
+
+/* Return true if lhs and rhs represent the same set. */
+bool
+value_sets_equal(const struct value_set *lhs, const struct value_set *rhs);
+
+/* Return true if sets intersect (contain common elements). */
+bool
+value_sets_intersect(const struct value_set *lhs, const struct value_set *rhs);
+
+/* Return true if all elements in lhs belong to interval first..last */
+bool
+value_set_is_covered_by_contiguous(const struct value_set *lhs, uint64_t first, uint64_t last);
+
+/* Return true if `(l - o) < (r - o)` for all `(o in origin, l in lhs, r in rhs)`. */
+bool
+value_sets_based_less(const struct value_set *origin, const struct value_set *lhs,
+	const struct value_set *rhs);
+
+/* Return true if `(l - o) <= (r - o)` for all `(o in origin, l in lhs, r in rhs)`. */
+bool
+value_sets_based_less_or_equal(const struct value_set *origin, const struct value_set *lhs,
+	const struct value_set *rhs);
+
+/* Translate ("shift") all set elements by `offset`. */
+void
+value_set_translate(struct value_set *lhs, uint64_t rhs);
+
+/* Set `lhs` to the set of possible sums between values from `lhs` and `rhs`. */
+void
+value_set_add_contiguous(struct value_set *lhs, uint64_t first, uint64_t last);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _BPF_VALUE_SET_H */
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 7e8a300e3f87..b74a5c232107 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -24,6 +24,8 @@ sources = files(
         'bpf_load_elf.c',
         'bpf_pkt.c',
         'bpf_validate.c',
+        'bpf_validate_debug.c',
+        'bpf_value_set.c',
 )
 
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_64')
@@ -32,9 +34,12 @@ elif dpdk_conf.has('RTE_ARCH_ARM64')
     sources += files('bpf_jit_arm64.c')
 endif
 
-headers = files('bpf_def.h',
+headers = files(
+        'bpf_def.h',
         'rte_bpf.h',
-        'rte_bpf_ethdev.h')
+        'rte_bpf_ethdev.h',
+        'rte_bpf_validate_debug.h',
+)
 
 deps += ['mbuf', 'net', 'ethdev']
 
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 944e0b79ac8c..8fe0e9edf24d 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -118,6 +118,7 @@ enum rte_bpf_origin {
 };
 
 struct bpf_insn;
+struct rte_bpf_validate_debug;
 
 /**
  * Input parameters for loading eBPF code, extensible version.
@@ -158,6 +159,9 @@ struct rte_bpf_prm_ex {
 
 	struct rte_bpf_arg prog_arg[EBPF_FUNC_MAX_ARGS];  /**< program arguments */
 	uint32_t nb_prog_arg;  /**< program argument count */
+
+	/* Validate debug instance. */
+	struct rte_bpf_validate_debug *debug;
 };
 
 /**
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
new file mode 100644
index 000000000000..2e8275625d8e
--- /dev/null
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -0,0 +1,375 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _RTE_BPF_VALIDATE_DEBUG_H_
+#define _RTE_BPF_VALIDATE_DEBUG_H_
+
+/**
+ * @file rte_bpf_validate_debug.h
+ *
+ * Debugging interface for BPF validation.
+ *
+ * Can be used for debugging BPF validation problems as well as in tests.
+ */
+
+#include <bpf_def.h>
+#include <rte_compat.h>
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define RTE_BPF_VALIDATE_DEBUG_MAY_BE_FALSE	RTE_BIT32(0)
+#define RTE_BPF_VALIDATE_DEBUG_MAY_BE_TRUE	RTE_BIT32(1)
+
+/**
+ * Supported validate events.
+ *
+ * Valid events begin from 0 and end before `RTE_BPF_VALIDATE_DEBUG_EVENT_END`.
+ */
+enum rte_bpf_validate_debug_event {
+	/* Just before every instruction, at branch or validation end. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_STEP,
+	/* Validator has failed its internal self-checks. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE,
+	/* Start of validation. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START,
+	/* Successful finish of validation. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS,
+	/* Finish of validation with error. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE,
+	/* Beginning of a branch just after the jump. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER,
+	/* Pruning branch as verified earlier. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE,
+	/* End of branch verification, after the last verified instruction. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
+	/* Number of valid event values. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_END,
+};
+
+struct rte_bpf_validate_debug;
+struct rte_bpf_validate_debug_point;
+
+/** User callback description. */
+struct rte_bpf_validate_debug_callback {
+	int (*fn)(struct rte_bpf_validate_debug *debug, void *ctx);
+	void *ctx;
+};
+
+/** Invoked by rte_bpf_validate_debug_for_each_point for each breakpoint and catchpoint. */
+typedef int (*rte_bpf_validate_debug_point_process_t)(struct rte_bpf_validate_debug_point *point,
+	void *ctx);
+
+/**
+ * Create new debug instance.
+ *
+ * @return
+ *   Debug instance in case of success.
+ *   NULL with rte_errno set in case of a failure.
+ */
+__rte_experimental
+struct rte_bpf_validate_debug *
+rte_bpf_validate_debug_create(void);
+
+/**
+ * Destroy debug instance.
+ *
+ * Behavior is undefined if validation with this debug instance is ongoing.
+ *
+ * @param debug
+ *   Debug instance, or NULL.
+ */
+__rte_experimental
+void
+rte_bpf_validate_debug_destroy(struct rte_bpf_validate_debug *debug);
+
+/**
+ * Create new breakpoint at specified location.
+ *
+ * Can be called before the validation has started. If at validation start later
+ * the program will not have the specified instruction, the start will fail.
+ *
+ * It is allowed to create breakpoints for the same location a callback is
+ * currently executing for, but it will not be invoked in the same cycle.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param pc
+ *   Program counter to create breakpoint at.
+ * @param callback
+ *   Callback to invoke.
+ * @return
+ *   New breakpoint on success, NULL with rte_errno set on failure.
+ */
+__rte_experimental
+struct rte_bpf_validate_debug_point *
+rte_bpf_validate_debug_break(struct rte_bpf_validate_debug *debug, uint32_t pc,
+	const struct rte_bpf_validate_debug_callback *callback);
+
+/**
+ * Create new catchpoint for specified event.
+ *
+ * Can be called before the validation has started.
+ *
+ * It is allowed to create catchpoints for the same event a callback is
+ * currently executing for, but it will not be invoked in the same cycle.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param event
+ *   Validation event to create catchpoint for.
+ * @param callback
+ *   Callback to invoke.
+ * @return
+ *   New breakpoint on success, NULL with rte_errno set on failure.
+ */
+__rte_experimental
+struct rte_bpf_validate_debug_point *
+rte_bpf_validate_debug_catch(struct rte_bpf_validate_debug *debug,
+	enum rte_bpf_validate_debug_event event,
+	const struct rte_bpf_validate_debug_callback *callback);
+
+/**
+ * Delete breakpoint or catchpoint and free all associated resources.
+ *
+ * If a callback is currently being executed, calling this API is allowed for:
+ * - breakpoint or catchpoint the callback is executed for;
+ * - breakpoints or catchpoints for other locations or events;
+ * and NOT allowed for:
+ * - other breakpoints or catchpoints for the same location or event.
+ *
+ * @param point
+ *   Breakpoint or catchpoint to destroy, or NULL.
+ */
+__rte_experimental
+void
+rte_bpf_validate_debug_point_destroy(struct rte_bpf_validate_debug_point *point);
+
+/**
+ * Get effective eBPF parameters struct.
+ *
+ * @param debug
+ *   Debug instance.
+ * @return
+ *   Parameters struct of the validated eBPF program, including code with all
+ *   patches and relocations applied.
+ */
+__rte_experimental
+const struct rte_bpf_prm_ex *
+rte_bpf_validate_debug_get_bpf_param(const struct rte_bpf_validate_debug *debug);
+
+/**
+ * Get pointer to effective eBPF program instructions.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param ins
+ *   Upon return, program instructions with all patches and relocations applied.
+ * @param nb_ins
+ *   Upon return, number of program instructions.
+ * @return
+ *   Non-negative value on success, negative errno on failure.
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
+	const struct ebpf_insn **ins, uint32_t *nb_ins);
+
+/**
+ * Get last triggered breakpoint or catchpoint.
+ *
+ * Can be used to destroy currently processed breakpoint or catchpoint.
+ *
+ * The pointer may be invalid if the breakpoint or catchpoint has already been
+ * destroyed earlier.
+ *
+ * @param debug
+ *   Debug instance.
+ * @return
+ *   Last triggered breakpoint or callpoint, including one the callback is
+ *   currently executing for.
+ *   NULL of none were triggered in the current validation process.
+ */
+__rte_experimental
+struct rte_bpf_validate_debug_point *
+rte_bpf_validate_debug_get_last_point(const struct rte_bpf_validate_debug *debug);
+
+/**
+ * Get current instruction index, or one after last if finishing.
+ *
+ * @param debug
+ *   Debug instance.
+ * @return
+ *   Current program counter being validated, or one after last.
+ *   UINT32_MAX if no program is being validated.
+ */
+__rte_experimental
+uint32_t
+rte_bpf_validate_debug_get_pc(const struct rte_bpf_validate_debug *debug);
+
+/**
+ * Get the validation result, if it has finished.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param result
+ *   Upon successful return, the validation result (negative if validation failed).
+ * @return
+ *   Non-negative value if validation has finished and result variable was written;
+ *   -EAGAIN if validation is still ongoing;
+ *   other negative errno in case of failure;
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_get_validation_result(const struct rte_bpf_validate_debug *debug,
+	int *result);
+
+/**
+ * Check if specified memory access instruction is currently valid.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param access
+ *   Memory load or store eBPF instruction.
+ * @param off64
+ *   Additional 64-bit offset added to ins->off.
+ * @return
+ *   true if specified memory access is currently valid;
+ *   false if specified memory access is currently invalid;
+ *   negative errno in case of failure;
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_can_access(const struct rte_bpf_validate_debug *debug,
+	const struct ebpf_insn *access, uint64_t off64);
+
+/**
+ * Get possible truth values of the specified jump condition.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param jump
+ *   Conditional jump instruction specifying the condition.
+ * @param imm64
+ *   Additional 64-bit immediate added to the source.
+ * @return
+ *   in case of success, bitwise combination of:
+ *     RTE_BPF_VALIDATE_DEBUG_MAY_BE_FALSE if the jump condition may be false;
+ *     RTE_BPF_VALIDATE_DEBUG_MAY_BE_TRUE if the jump condition may be true;
+ *   negative errno in case of failure.
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_may_jump(const struct rte_bpf_validate_debug *debug,
+	const struct ebpf_insn *jump, uint64_t imm64);
+
+/**
+ * Format information about specified register for the user.
+ *
+ * Parameters buffer, bufsz and return value work the same way as for snprintf.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param buffer
+ *   Buffer to fill with register information.
+ * @param bufsz
+ *   Buffer size (including space for terminating zero).
+ * @param reg
+ *   Register to provide information about.
+ * @return
+ *   Number of characters needed _excluding_ terminating zero.
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_format_register_info(const struct rte_bpf_validate_debug *debug,
+	char *buffer, size_t bufsz, uint8_t reg);
+
+/**
+ * Format information about specified stack frame location for the user.
+ *
+ * Parameters buffer, bufsz and return value work the same way as for snprintf.
+ *
+ * @param debug
+ *   Debug instance.
+ * @param buffer
+ *   Buffer to fill with register information.
+ * @param bufsz
+ *   Buffer size (including space for terminating zero).
+ * @param offset
+ *   Stack frame offset to provide information about, in bytes.
+ *   Typically a negative multiple of 8.
+ * @return
+ *   Number of characters needed _excluding_ terminating zero.
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_format_frame_info(const struct rte_bpf_validate_debug *debug,
+	char *buffer, size_t bufsz, int32_t offset);
+
+/**
+ * Get program stack frame size.
+ *
+ * @param debug
+ *   Debug instance.
+ * @return
+ *   Program stack frame size in bytes.
+ */
+__rte_experimental
+int32_t
+rte_bpf_validate_debug_get_frame_size(const struct rte_bpf_validate_debug *debug);
+
+/**
+ * Format value following the style of register format function.
+ *
+ * Parameters buffer, bufsz and return value work the same way as for snprintf.
+ *
+ * @param buffer
+ *   Buffer to fill with register information.
+ * @param bufsz
+ *   Buffer size (including space for terminating zero).
+ * @param format
+ *   One of characters 'd' or 'x' for signed or hexadecimal format.
+ * @param value
+ *   Formatted value, can be signed typecast to unsigned.
+ * @return
+ *   Number of characters needed _excluding_ terminating zero.
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_format_value(char *buffer, size_t bufsz, char format,
+	uint64_t value);
+
+/**
+ * Format interval following the style of register format function.
+ *
+ * Parameters buffer, bufsz and return value work the same way as for snprintf.
+ *
+ * @param buffer
+ *   Buffer to fill with register information.
+ * @param bufsz
+ *   Buffer size (including space for terminating zero).
+ * @param format
+ *   One of characters 'd' or 'x' for signed or hexadecimal format.
+ * @param min
+ *   Minimum value of the interval, can be signed typecast to unsigned.
+ * @param max
+ *   Maximum value of the interval, can be signed typecast to unsigned.
+ * @return
+ *   Number of characters needed _excluding_ terminating zero.
+ */
+__rte_experimental
+int
+rte_bpf_validate_debug_format_interval(char *buffer, size_t bufsz, char format,
+	uint64_t min, uint64_t max);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_BPF_VALIDATE_DEBUG_H_ */
-- 
2.43.0

