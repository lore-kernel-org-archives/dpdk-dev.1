Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9769AD715DB
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 09:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CC2140293;
	Sat, 24 Jan 2026 10:11:30 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 3746B4026F
 for <dev@dpdk.org>; Sat, 24 Jan 2026 10:11:29 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2b0ea1edf11so5253752eec.0
 for <dev@dpdk.org>; Sat, 24 Jan 2026 01:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769245888; x=1769850688; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZJhRPqIJPRRGkMi/6qlPhWuwTFHaeU8Sex0KT1Wpx4=;
 b=EfEGndjo3j/i0PwS9LXABTg1jKOgDfkYx6DLPNLTa/xeGBQo07wJHly7X1BBDhCyod
 VNIM9LUT2yzFpLreEVNMgf1/pDp1wu4idNvswTaAhWSwlMl2qGYDqXCbFtrnDRbshI+L
 oZr+Pc9nt8qX52C7Dpkq7ykOiwUh/bK3peHFkRts4+Svdehc4vIt6PS2aCTjGjrDiCHX
 43hyyctj9zC0szn+HnuMIm/dW9B6I0G0T7z3uyKyT17FmDI5/v0MXmGthLTtU/cGRkjT
 6Jx0YeCmj6bwBEhPM2HNsz9yC/NjVZK9RrgSkfB/I2YEanEFzuNTry+3wiBGJMDb/Nyx
 BERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769245888; x=1769850688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gZJhRPqIJPRRGkMi/6qlPhWuwTFHaeU8Sex0KT1Wpx4=;
 b=QrvR1FKj2A1/N3DPgCiSKpE5wCAhfZtLB86XQzTj6PSvUpXv0dTFIeTBOpVwzzBglC
 pqwjsoY7/vwElR+qiI2lxx3rqLl45lOqukUBcsaBOdkYCG3b85Z/72hkRKb2NFCbSgrL
 U7k3SITOW9NdUbz0boTt0RrvyDtRSqEBXVK3/nwLIkdH238JPBWPi+6/+y1K4xNPN7r5
 9H2kGr82rqqmV3u4JKNP3lq7cQATaK/QXuhrt+6lLoaNVQ8SMCKSkSJ0jPErrCv0YlBq
 w0RZLedGbUl0zVrpCmzcT5bT4T5qq8IN2/XRBYkJIse96Z+/740h7v6eVdyYIEZFDU7J
 IZAw==
X-Gm-Message-State: AOJu0YwwldSDMthKVAJuXJZTmnsx83vYxqZ6UrnoWtzD6WhWgGLQI++i
 +JHmJDCLFRjaoDpTIJj8jz0fiL0QPLEF/CgcrrhUghahWpS0ObjGn9B6k8ZWhw==
X-Gm-Gg: AZuq6aJVGX4LYzwq3FlJZ/riloF+u2O1Pjl23CqORGKQSCEPv1rr6Hul1XZMRZjUcOl
 GWkrG+MKAcD8hamAdG2nbT1TCGFZC7S4QIXwW4ZwgM1bH6jmM+R5sI3iDEoXD9IF2wgNDo8IalX
 GTn1IZSSbs50uelGIpmMbSJbmvXkkZtTro0bGCmYGTE6cNj0DUj2YV5JXGmTsExhs/1lckcMDAC
 f7a9aosbwPieZTa/WzooEaU8QjKW8SOdNxuwD7FLgXPmIcI6C4tDNPr5j31Q/2ly0BLsr7WQaoi
 56nw+Re7/BcY/qvwwRQtt2GV6LD99ZVJo7xY/A44APs7JkYXhS6QBrro2XjxkcTbtIzO9KL5h6F
 Q4pO1t9K2w4jcVxLSPEC0xFBThtxtr47Kl/s/iuXeBMNyAKv+C8V3c+O+O86mfKKCxqqse+8ZqE
 cVb+DVQcXCsLpJBif/yeURuovv4UNYP0Ws
X-Received: by 2002:a05:7301:578e:b0:2ae:53da:9787 with SMTP id
 5a478bee46e88-2b739beb0bamr2908063eec.40.1769245886794; 
 Sat, 24 Jan 2026 01:11:26 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73aa2b656sm6373555eec.33.2026.01.24.01.11.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jan 2026 01:11:26 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v11] eal: RTE_PTR_ADD/SUB API improvements
Date: Sat, 24 Jan 2026 01:11:21 -0800
Message-Id: <20260124091121.4042-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260123162742.69675-1-scott.k.mitch1@gmail.com>
References: <20260123162742.69675-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

RTE_PTR_ADD and RTE_PTR_SUB APIs have a few limitations:
1. ptr cast to uintptr_t drops pointer provenance and
prevents compiler optimizations
2. return cast to void* removes type safety and
discards qualifiers (const, volatile)
3. Accepts both "pointers" and "integers as pointers" which
overloads the use case and constrains the implementation
to address other challenges.

This patch splits the API on two dimensions:
1. pointer types
2. integer types that represent pointers

This split allows addressing each of the challenges above
and provides distinct APIs for the distinct use cases.
Examples:
1. Clang is able to optimize and improve __rte_raw_cksum
(which uses RTE_PTR_ADD) by ~40% (100 bytes) to ~8x (1.5k bytes)
TSC cycles/byte.
2. Refactoring discovered cases that dropped qualifiers (volatile)
which are likely bugs and warrant more explicit cast/handling.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
v11:
- Split API into PTR and INT_PTR variants, update all usage
of PTR API for new APIs.

v10:
- Use unit_test_suite_runner for easier subtest failure identification

v9:
- Fix include order: system includes, then DPDK includes, then application includes
- Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST (instead of true, true)

v8:
- Remove tests for types < 32-bit (bool, char, short, uint8_t, uint16_t)
- Merge test_ptr_add_sub_typedefs() into test_ptr_add_sub_integer_types()
- Separate RTE_PTR_ADD and RTE_PTR_SUB documentation
- Move Clang/GCC implementation note from Doxygen to regular comment
- Tests verify both intermediate ADD result and SUB round-trip
- Use uintptr_t cast consistently for all integer-to-pointer conversions
- Make TEST_RETVAL calculated from TEST_INITVAL + TEST_INCREMENT

v7:
- Fix tests: use TEST_BUFFER_SIZE macro for buffer allocation
- Fix tests: ADD then SUB same amount to avoid out-of-bounds pointer arithmetic
- All RTE_PTR_SUB tests now verify round-trip (ADD+SUB returns to original)

v6:
- Make char* optimization Clang-only to avoid GCC false positive warnings
- Improve tests: use named constants instead of magic numbers
- Improve tests: use void* casts on expected values instead of uintptr_t on results

v5:
- Initial implementation with char* arithmetic for all compilers

v4:
- Used _Generic for type-based dispatch with char* casts
- Had warnings on both Clang and GCC due to _Generic type-checking all branches

---
 app/test-eventdev/test_perf_common.h        |   7 +-
 app/test-pmd/cmdline_flow.c                 |   6 +-
 app/test-pmd/csumonly.c                     |   2 +-
 app/test/meson.build                        |   1 +
 app/test/test_common.c                      |  20 +-
 app/test/test_ptr_add_sub.c                 | 197 ++++++++++++++++++++
 drivers/bus/pci/linux/pci_vfio.c            |   2 +-
 drivers/common/cnxk/cnxk_security.c         |   2 +-
 drivers/common/cnxk/roc_cpt_debug.c         |   4 +-
 drivers/common/cnxk/roc_nix_bpf.c           |   2 +-
 drivers/common/cnxk/roc_nix_inl.h           |   4 +-
 drivers/common/cnxk/roc_nix_inl_dp.h        |   8 +-
 drivers/common/cnxk/roc_platform.h          |   6 +-
 drivers/common/cnxk/roc_se.c                |   2 +-
 drivers/common/cpt/cpt_ucode_asym.h         |  12 +-
 drivers/common/mlx5/linux/mlx5_nl.c         |  14 +-
 drivers/compress/mlx5/mlx5_compress.c       |   2 +-
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c    |   2 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c    |   2 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c       |   6 +-
 drivers/crypto/mlx5/mlx5_crypto_xts.c       |   2 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c |   2 +-
 drivers/dma/idxd/idxd_internal.h            |   1 +
 drivers/dma/idxd/idxd_pci.c                 |  11 +-
 drivers/dma/odm/odm_dmadev.c                |   4 +-
 drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
 drivers/ml/cnxk/cn10k_ml_model.c            |   2 +-
 drivers/ml/cnxk/cn10k_ml_ops.c              |   2 +-
 drivers/ml/cnxk/cnxk_ml_ops.c               |   2 +-
 drivers/net/ark/ark_ethdev.c                |   4 +-
 drivers/net/cxgbe/cxgbe_ethdev.c            |   6 +-
 drivers/net/gve/base/gve_adminq.c           |  12 +-
 drivers/net/intel/ice/ice_tm.c              |   4 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c        |   2 +-
 drivers/net/mlx5/mlx5_flow.c                |   4 +-
 drivers/net/mlx5/mlx5_flow_hw.c             |   4 +-
 drivers/net/mlx5/mlx5_tx.h                  |   4 +-
 drivers/net/mlx5/mlx5_txpp.c                |   4 +-
 drivers/net/sfc/sfc_mae.c                   |  10 +-
 drivers/net/virtio/virtio_rxtx.c            |   2 +-
 lib/eal/common/eal_common_memory.c          |  19 +-
 lib/eal/common/eal_common_options.c         |   2 +-
 lib/eal/common/malloc_elem.h                |   4 +-
 lib/eal/common/malloc_heap.c                |   6 +-
 lib/eal/include/rte_common.h                | 174 ++++++++++++++++-
 lib/ethdev/rte_ethdev.c                     |   6 +-
 lib/graph/graph_populate.c                  |   4 +-
 lib/graph/graph_stats.c                     |   2 +-
 lib/graph/rte_graph.h                       |   4 +-
 lib/graph/rte_graph_model_mcore_dispatch.c  |   2 +-
 lib/latencystats/rte_latencystats.c         |   2 +-
 lib/mbuf/rte_mbuf.c                         |   2 +-
 lib/member/rte_xxh64_avx512.h               |   6 +-
 lib/pdcp/pdcp_entity.h                      |   8 +-
 lib/reorder/rte_reorder.c                   |   2 +-
 55 files changed, 502 insertions(+), 131 deletions(-)
 create mode 100644 app/test/test_ptr_add_sub.c

diff --git a/app/test-eventdev/test_perf_common.h b/app/test-eventdev/test_perf_common.h
index 365464f269..2b0434b844 100644
--- a/app/test-eventdev/test_perf_common.h
+++ b/app/test-eventdev/test_perf_common.h
@@ -141,7 +141,7 @@ perf_mark_fwd_latency(enum evt_prod_type prod_type, struct rte_event *const ev)
 
 			pe = rte_pktmbuf_mtod(m, struct perf_elt *);
 		} else {
-			pe = RTE_PTR_ADD(op->asym->modex.result.data,
+			pe = RTE_PTR_ADD((void *)op->asym->modex.result.data,
 					 op->asym->modex.result.length);
 		}
 		pe->timestamp = rte_get_timer_cycles();
@@ -179,7 +179,8 @@ perf_elt_from_vec_get(struct rte_event_vector *vec)
 		m = cop->sym->m_dst == NULL ? cop->sym->m_src : cop->sym->m_dst;
 		return rte_pktmbuf_mtod(m, struct perf_elt *);
 	} else {
-		return RTE_PTR_ADD(cop->asym->modex.result.data, cop->asym->modex.result.length);
+		return RTE_PTR_ADD((void *)cop->asym->modex.result.data,
+				   cop->asym->modex.result.length);
 	}
 }
 
@@ -297,7 +298,7 @@ perf_process_last_stage_latency(struct rte_mempool *const pool, enum evt_prod_ty
 			to_free_in_bulk = m;
 			pe = rte_pktmbuf_mtod(m, struct perf_elt *);
 		} else {
-			pe = RTE_PTR_ADD(op->asym->modex.result.data,
+			pe = RTE_PTR_ADD((void *)op->asym->modex.result.data,
 					 op->asym->modex.result.length);
 			to_free_in_bulk = op->asym->modex.result.data;
 		}
diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index ebc036b14b..01a45fb807 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -12468,7 +12468,7 @@ parse_meter_color(struct context *ctx, const struct token *token,
 
 		if (!arg)
 			return -1;
-		*(int *)RTE_PTR_ADD(action->conf, arg->offset) = i;
+		*(int *)RTE_PTR_ADD((void *)action->conf, arg->offset) = i;
 	} else {
 		((struct rte_flow_item_meter_color *)
 			ctx->object)->color = (enum rte_color)i;
@@ -13343,7 +13343,7 @@ indirect_action_flow_conf_create(const struct buffer *in)
 		goto end;
 	indlst_conf->id = in->args.vc.attr.group;
 	indlst_conf->conf_num = in->args.vc.actions_n - 1;
-	indlst_conf->actions = RTE_PTR_ADD(indlst_conf, base);
+	indlst_conf->actions = RTE_PTR_ADD((void *)indlst_conf, base);
 	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, indlst_conf->actions,
 			    len, src, NULL);
 	if (ret <= 0) {
@@ -13351,7 +13351,7 @@ indirect_action_flow_conf_create(const struct buffer *in)
 		indlst_conf = NULL;
 		goto end;
 	}
-	indlst_conf->conf = RTE_PTR_ADD(indlst_conf, base + len);
+	indlst_conf->conf = (const void **)RTE_PTR_ADD((void *)indlst_conf, base + len);
 	for (i = 0; i < indlst_conf->conf_num; i++)
 		indlst_conf->conf[i] = indlst_conf->actions[i].conf;
 	SLIST_INSERT_HEAD(&indlst_conf_head, indlst_conf, next);
diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index c841651756..24866e563f 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -488,7 +488,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
 		return _htons(RTE_ETHER_TYPE_IPV6);
 	default:
 		ethertype = eth_hdr->ether_type;
-		vlan_hdr = RTE_PTR_ADD(eth_hdr, offsetof(struct rte_ether_hdr, ether_type));
+		vlan_hdr = RTE_PTR_ADD((void *)eth_hdr, offsetof(struct rte_ether_hdr, ether_type));
 		max_vlans = vlan_hdr + MAX_VLAN_HEADERS;
 		while ((ethertype == _htons(RTE_ETHER_TYPE_VLAN) ||
 				ethertype == _htons(RTE_ETHER_TYPE_QINQ)) &&
diff --git a/app/test/meson.build b/app/test/meson.build
index f4d04a6e42..aa56fc4297 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -152,6 +152,7 @@ source_file_deps = {
     'test_power_intel_uncore.c': ['power', 'power_intel_uncore'],
     'test_power_kvm_vm.c': ['power', 'power_kvm_vm'],
     'test_prefetch.c': [],
+    'test_ptr_add_sub.c': [],
     'test_ptr_compress.c': ['ptr_compress'],
     'test_rand_perf.c': [],
     'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
diff --git a/app/test/test_common.c b/app/test/test_common.c
index 3e1c7df0c1..cc0ce50bbc 100644
--- a/app/test/test_common.c
+++ b/app/test/test_common.c
@@ -37,10 +37,10 @@ test_macros(int __rte_unused unused_parm)
 	RTE_SWAP(smaller, bigger);
 	RTE_TEST_ASSERT(smaller == BIGGER && bigger == SMALLER,
 		"RTE_SWAP");
-	RTE_TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(SMALLER, PTR_DIFF), BIGGER,
-		"RTE_PTR_ADD");
-	RTE_TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_SUB(BIGGER, PTR_DIFF), SMALLER,
-		"RTE_PTR_SUB");
+	RTE_TEST_ASSERT_EQUAL(RTE_INT_PTR_ADD(SMALLER, PTR_DIFF), BIGGER,
+		"RTE_INT_PTR_ADD");
+	RTE_TEST_ASSERT_EQUAL(RTE_INT_PTR_SUB(BIGGER, PTR_DIFF), SMALLER,
+		"RTE_INT_PTR_SUB");
 	RTE_TEST_ASSERT_EQUAL(RTE_PTR_DIFF(BIGGER, SMALLER), PTR_DIFF,
 		"RTE_PTR_DIFF");
 	RTE_TEST_ASSERT_EQUAL(RTE_MAX(SMALLER, BIGGER), BIGGER,
@@ -188,18 +188,18 @@ test_align(void)
 			if (RTE_ALIGN_FLOOR((uintptr_t)i, p) % p)
 				FAIL_ALIGN("RTE_ALIGN_FLOOR", i, p);
 
-			val = RTE_PTR_ALIGN_FLOOR((uintptr_t) i, p);
+			val = RTE_INT_PTR_ALIGN_FLOOR((uintptr_t) i, p);
 			if (ERROR_FLOOR(val, i, p))
-				FAIL_ALIGN("RTE_PTR_ALIGN_FLOOR", i, p);
+				FAIL_ALIGN("RTE_INT_PTR_ALIGN_FLOOR", i, p);
 
 			val = RTE_ALIGN_FLOOR(i, p);
 			if (ERROR_FLOOR(val, i, p))
 				FAIL_ALIGN("RTE_ALIGN_FLOOR", i, p);
 
 			/* align ceiling */
-			val = RTE_PTR_ALIGN((uintptr_t) i, p);
+			val = RTE_INT_PTR_ALIGN((uintptr_t) i, p);
 			if (ERROR_CEIL(val, i, p))
-				FAIL_ALIGN("RTE_PTR_ALIGN", i, p);
+				FAIL_ALIGN("RTE_INT_PTR_ALIGN", i, p);
 
 			val = RTE_ALIGN(i, p);
 			if (ERROR_CEIL(val, i, p))
@@ -209,9 +209,9 @@ test_align(void)
 			if (ERROR_CEIL(val, i, p))
 				FAIL_ALIGN("RTE_ALIGN_CEIL", i, p);
 
-			val = RTE_PTR_ALIGN_CEIL((uintptr_t)i, p);
+			val = RTE_INT_PTR_ALIGN_CEIL((uintptr_t)i, p);
 			if (ERROR_CEIL(val, i, p))
-				FAIL_ALIGN("RTE_PTR_ALIGN_CEIL", i, p);
+				FAIL_ALIGN("RTE_INT_PTR_ALIGN_CEIL", i, p);
 
 			/* by this point we know that val is aligned to p */
 			if (!rte_is_aligned((void*)(uintptr_t) val, p))
diff --git a/app/test/test_ptr_add_sub.c b/app/test/test_ptr_add_sub.c
new file mode 100644
index 0000000000..d7ed36e40e
--- /dev/null
+++ b/app/test/test_ptr_add_sub.c
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Apple Inc.
+ */
+
+#include <stdint.h>
+
+#include <rte_common.h>
+
+#include "test.h"
+
+/* Test constants */
+#define TEST_INITVAL 0x1000
+#define TEST_INCREMENT 100
+#define TEST_RETVAL ((void *)(TEST_INITVAL + TEST_INCREMENT))
+
+/* Buffer size for pointer tests */
+#define TEST_BUFFER_SIZE (TEST_INCREMENT + 256)
+
+/* Test RTE_INT_PTR_ADD/SUB with integer types and NULL */
+static int
+test_int_ptr_add_sub(void)
+{
+	/* Test NULL + offset (primary use case for RTE_INT_PTR_*) */
+	uintptr_t uptr_result = RTE_INT_PTR_ADD((uintptr_t)NULL, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(uptr_result, (uintptr_t)TEST_INCREMENT,
+		"RTE_INT_PTR_ADD failed for NULL");
+
+	uptr_result = RTE_INT_PTR_SUB((uintptr_t)NULL, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(uptr_result, (uintptr_t)(-TEST_INCREMENT),
+		"RTE_INT_PTR_SUB failed for NULL");
+
+	/* Test with various integer types that could represent pointers */
+	unsigned long long ull = TEST_INITVAL;
+	unsigned long long ull_result = RTE_INT_PTR_ADD(ull, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ull_result, (unsigned long long)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for unsigned long long");
+	ull_result = RTE_INT_PTR_SUB(ull_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ull_result, ull,
+		"RTE_INT_PTR_SUB round-trip failed for unsigned long long");
+
+	long long ll = TEST_INITVAL;
+	long long ll_result = RTE_INT_PTR_ADD(ll, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ll_result, (long long)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for long long");
+	ll_result = RTE_INT_PTR_SUB(ll_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ll_result, ll,
+		"RTE_INT_PTR_SUB round-trip failed for long long");
+
+	unsigned long ul = TEST_INITVAL;
+	unsigned long ul_result = RTE_INT_PTR_ADD(ul, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ul_result, (unsigned long)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for unsigned long");
+	ul_result = RTE_INT_PTR_SUB(ul_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ul_result, ul,
+		"RTE_INT_PTR_SUB round-trip failed for unsigned long");
+
+	long l = TEST_INITVAL;
+	long l_result = RTE_INT_PTR_ADD(l, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(l_result, (long)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for long");
+	l_result = RTE_INT_PTR_SUB(l_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(l_result, l,
+		"RTE_INT_PTR_SUB round-trip failed for long");
+
+	unsigned int ui = TEST_INITVAL;
+	unsigned int ui_result = RTE_INT_PTR_ADD(ui, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ui_result, (unsigned int)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for unsigned int");
+	ui_result = RTE_INT_PTR_SUB(ui_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ui_result, ui,
+		"RTE_INT_PTR_SUB round-trip failed for unsigned int");
+
+	int i = TEST_INITVAL;
+	int i_result = RTE_INT_PTR_ADD(i, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(i_result, (int)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for int");
+	i_result = RTE_INT_PTR_SUB(i_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(i_result, i,
+		"RTE_INT_PTR_SUB round-trip failed for int");
+
+	uint64_t u64 = TEST_INITVAL;
+	uint64_t u64_result = RTE_INT_PTR_ADD(u64, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(u64_result, (uint64_t)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for uint64_t");
+	u64_result = RTE_INT_PTR_SUB(u64_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(u64_result, u64,
+		"RTE_INT_PTR_SUB round-trip failed for uint64_t");
+
+	uint32_t u32 = TEST_INITVAL;
+	uint32_t u32_result = RTE_INT_PTR_ADD(u32, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(u32_result, (uint32_t)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for uint32_t");
+	u32_result = RTE_INT_PTR_SUB(u32_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(u32_result, u32,
+		"RTE_INT_PTR_SUB round-trip failed for uint32_t");
+
+	uintptr_t uptr = TEST_INITVAL;
+	uptr_result = RTE_INT_PTR_ADD(uptr, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(uptr_result, (uintptr_t)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for uintptr_t");
+	uptr_result = RTE_INT_PTR_SUB(uptr, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(uptr_result, uptr - TEST_INCREMENT,
+		"RTE_INT_PTR_SUB failed for uintptr_t");
+
+	size_t sz = TEST_INITVAL;
+	size_t sz_result = RTE_INT_PTR_ADD(sz, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(sz_result, (size_t)(TEST_INITVAL + TEST_INCREMENT),
+		"RTE_INT_PTR_ADD failed for size_t");
+	sz_result = RTE_INT_PTR_SUB(sz_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(sz_result, sz,
+		"RTE_INT_PTR_SUB round-trip failed for size_t");
+
+	return 0;
+}
+
+/* Test RTE_PTR_ADD/SUB with pointer types and type preservation */
+static int
+test_ptr_add_sub(void)
+{
+	char buffer[TEST_BUFFER_SIZE];
+
+	/* Test void* */
+	void *vp = buffer;
+	void *result = RTE_PTR_ADD(vp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for void*");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, vp,
+		"RTE_PTR_SUB round-trip failed for void*");
+
+	/* Test const void* - verifies const preservation */
+	const void *cvp = buffer;
+	const void *cvp_result = RTE_PTR_ADD(cvp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(cvp_result, (const void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for const void*");
+	cvp_result = RTE_PTR_SUB(cvp_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(cvp_result, cvp,
+		"RTE_PTR_SUB round-trip failed for const void*");
+
+	/* Test char* - verifies type preservation */
+	char *cp = buffer;
+	char *cp_result = RTE_PTR_ADD(cp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(cp_result, buffer + TEST_INCREMENT,
+		"RTE_PTR_ADD failed for char*");
+	cp_result = RTE_PTR_SUB(cp_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(cp_result, cp,
+		"RTE_PTR_SUB round-trip failed for char*");
+
+	/* Test const char* - verifies type and const preservation */
+	const char *ccp = buffer;
+	const char *ccp_result = RTE_PTR_ADD(ccp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ccp_result, buffer + TEST_INCREMENT,
+		"RTE_PTR_ADD failed for const char*");
+	ccp_result = RTE_PTR_SUB(ccp_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(ccp_result, ccp,
+		"RTE_PTR_SUB round-trip failed for const char*");
+
+	/* Test uint32_t* - verifies typed pointer preservation */
+	uint32_t *u32p = (uint32_t *)buffer;
+	uint32_t *u32p_result = RTE_PTR_ADD(u32p, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(u32p_result, (uint32_t *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for uint32_t*");
+	u32p_result = RTE_PTR_SUB(u32p_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(u32p_result, u32p,
+		"RTE_PTR_SUB round-trip failed for uint32_t*");
+
+	/* Test const uint32_t* - verifies typed pointer and const preservation */
+	const uint32_t *cu32p = (const uint32_t *)buffer;
+	const uint32_t *cu32p_result = RTE_PTR_ADD(cu32p, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(cu32p_result, (const uint32_t *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for const uint32_t*");
+	cu32p_result = RTE_PTR_SUB(cu32p_result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(cu32p_result, cu32p,
+		"RTE_PTR_SUB round-trip failed for const uint32_t*");
+
+	return 0;
+}
+
+static struct unit_test_suite ptr_add_sub_test_suite = {
+	.suite_name = "ptr add/sub autotest",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_int_ptr_add_sub),
+		TEST_CASE(test_ptr_add_sub),
+		TEST_CASES_END()
+	}
+};
+
+/* Main test function that runs all subtests */
+static int
+test_ptr_add_sub_suite(void)
+{
+	return unit_test_suite_runner(&ptr_add_sub_test_suite);
+}
+
+REGISTER_FAST_TEST(ptr_add_sub_autotest, NOHUGE_OK, ASAN_OK, test_ptr_add_sub_suite);
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 242f567ed7..004cb3cf91 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -672,7 +672,7 @@ pci_vfio_info_cap(struct vfio_region_info *info, int cap)
 
 	offset = info->cap_offset;
 	while (offset != 0) {
-		h = RTE_PTR_ADD(info, offset);
+		h = RTE_PTR_ADD((void *)info, offset);
 		if (h->id == cap)
 			return h;
 		offset = h->next;
diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 600098ae1c..4e2105aaa6 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -965,7 +965,7 @@ on_fill_ipsec_common_sa(struct rte_security_ipsec_xform *ipsec,
 		else if (crypto_xform->aead.algo == RTE_CRYPTO_AEAD_AES_CCM) {
 			ccm_flag = 0x07 & ~ROC_CPT_AES_CCM_CTR_LEN;
 			*common_sa->iv.gcm.nonce = ccm_flag;
-			memcpy(PLT_PTR_ADD(common_sa->iv.gcm.nonce, 1), &ipsec->salt, 3);
+			memcpy(PLT_PTR_ADD(&common_sa->iv.gcm.nonce[0], 1), &ipsec->salt, 3);
 		}
 		cipher_key = crypto_xform->aead.key.data;
 		cipher_key_len = crypto_xform->aead.key.length;
diff --git a/drivers/common/cnxk/roc_cpt_debug.c b/drivers/common/cnxk/roc_cpt_debug.c
index 28aedf088e..ff27a2ede9 100644
--- a/drivers/common/cnxk/roc_cpt_debug.c
+++ b/drivers/common/cnxk/roc_cpt_debug.c
@@ -56,7 +56,7 @@ cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 	/* offset of 0 implies 256B, otherwise it implies offset*32B */
 	offset = cpth->w2.ptr_offset;
 	offset = (((offset - 1) & 0x7) + 1) * 32;
-	frag_info = PLT_PTR_ADD(cpth, offset);
+	frag_info = PLT_PTR_ADD((void *)cpth, offset);
 
 	if (cpth->w0.num_frags > 0) {
 		cpt_dump(file, "CPT Fraginfo_0 \t%p:", frag_info);
@@ -162,7 +162,7 @@ cpt_cn10k_parse_hdr_dump(FILE *file, const struct cpt_cn10k_parse_hdr_s *cpth)
 	/* offset of 0 implies 256B, otherwise it implies offset*8B */
 	offset = cpth->w2.fi_offset;
 	offset = (((offset - 1) & 0x1f) + 1) * 8;
-	frag_info = PLT_PTR_ADD(cpth, offset);
+	frag_info = PLT_PTR_ADD((void *)cpth, offset);
 
 	cpt_dump(file, "CPT Fraginfo \t0x%p:", frag_info);
 
diff --git a/drivers/common/cnxk/roc_nix_bpf.c b/drivers/common/cnxk/roc_nix_bpf.c
index 98c9855a5b..985b318fdd 100644
--- a/drivers/common/cnxk/roc_nix_bpf.c
+++ b/drivers/common/cnxk/roc_nix_bpf.c
@@ -160,7 +160,7 @@ nix_precolor_conv_table_write(struct roc_nix *roc_nix, uint64_t val,
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	int64_t *addr;
 
-	addr = PLT_PTR_ADD(nix->base, off);
+	addr = PLT_PTR_ADD((void *)nix->base, off);
 	plt_write64(val, addr);
 }
 
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 7970ac2258..9fe1417756 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -59,7 +59,7 @@ roc_nix_inl_on_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_ON_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return PLT_PTR_ADD((void *)base, off);
 }
 
 static inline struct roc_ie_on_outb_sa *
@@ -67,7 +67,7 @@ roc_nix_inl_on_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_ON_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return PLT_PTR_ADD((void *)base, off);
 }
 
 static inline void *
diff --git a/drivers/common/cnxk/roc_nix_inl_dp.h b/drivers/common/cnxk/roc_nix_inl_dp.h
index eb101db179..d7737cb7ca 100644
--- a/drivers/common/cnxk/roc_nix_inl_dp.h
+++ b/drivers/common/cnxk/roc_nix_inl_dp.h
@@ -49,7 +49,7 @@ roc_nix_inl_ot_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OT_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return PLT_PTR_ADD((void *)base, off);
 }
 
 static inline struct roc_ot_ipsec_outb_sa *
@@ -57,7 +57,7 @@ roc_nix_inl_ot_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return PLT_PTR_ADD((void *)base, off);
 }
 
 static inline void *
@@ -77,7 +77,7 @@ roc_nix_inl_ow_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return PLT_PTR_ADD((void *)base, off);
 }
 
 static inline struct roc_ow_ipsec_outb_sa *
@@ -85,7 +85,7 @@ roc_nix_inl_ow_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return PLT_PTR_ADD((void *)base, off);
 }
 
 static inline void *
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index e22a50d47a..1bee272dde 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -47,6 +47,8 @@
 #define PLT_PTR_ADD		 RTE_PTR_ADD
 #define PLT_PTR_SUB		 RTE_PTR_SUB
 #define PLT_PTR_DIFF		 RTE_PTR_DIFF
+#define PLT_INT_PTR_ADD		 RTE_INT_PTR_ADD
+#define PLT_INT_PTR_SUB		 RTE_INT_PTR_SUB
 #define PLT_MAX_RXTX_INTR_VEC_ID RTE_MAX_RXTX_INTR_VEC_ID
 #define PLT_INTR_VEC_RXTX_OFFSET RTE_INTR_VEC_RXTX_OFFSET
 #define PLT_MIN			 RTE_MIN
@@ -84,8 +86,8 @@
 #define PLT_U16_CAST(val) ((uint16_t)(val))
 
 /* Add / Sub pointer with scalar and cast to uint64_t */
-#define PLT_PTR_ADD_U64_CAST(__ptr, __x) PLT_U64_CAST(PLT_PTR_ADD(__ptr, __x))
-#define PLT_PTR_SUB_U64_CAST(__ptr, __x) PLT_U64_CAST(PLT_PTR_SUB(__ptr, __x))
+#define PLT_PTR_ADD_U64_CAST(__ptr, __x) PLT_U64_CAST(PLT_INT_PTR_ADD(__ptr, __x))
+#define PLT_PTR_SUB_U64_CAST(__ptr, __x) PLT_U64_CAST(PLT_INT_PTR_SUB(__ptr, __x))
 
 /** Divide ceil */
 #define PLT_DIV_CEIL(x, y)			\
diff --git a/drivers/common/cnxk/roc_se.c b/drivers/common/cnxk/roc_se.c
index f71832ff3a..445e2a66dc 100644
--- a/drivers/common/cnxk/roc_se.c
+++ b/drivers/common/cnxk/roc_se.c
@@ -635,7 +635,7 @@ roc_se_ctx_init(struct roc_se_ctx *roc_se_ctx)
 	ctx_len = PLT_ALIGN_CEIL(ctx_len, 8);
 
 	/* Skip w0 for swap */
-	uc_ctx = PLT_PTR_ADD(ctx, sizeof(ctx->w0));
+	uc_ctx = PLT_PTR_ADD((void *)ctx, sizeof(ctx->w0));
 	for (i = 0; i < (ctx_len / 8); i++)
 		uc_ctx[i] = plt_cpu_to_be_64(((uint64_t *)uc_ctx)[i]);
 
diff --git a/drivers/common/cpt/cpt_ucode_asym.h b/drivers/common/cpt/cpt_ucode_asym.h
index 5122378ec7..85654600c8 100644
--- a/drivers/common/cpt/cpt_ucode_asym.h
+++ b/drivers/common/cpt/cpt_ucode_asym.h
@@ -251,7 +251,7 @@ cpt_modex_prep(struct asym_op_params *modex_params,
 	total_key_len = mod_len + exp_len;
 
 	/* Input buffer */
-	dptr = RTE_PTR_ADD(req, sizeof(struct cpt_request_info));
+	dptr = RTE_PTR_ADD((void *)req, sizeof(struct cpt_request_info));
 	memcpy(dptr, mod->modulus.data, total_key_len);
 	dptr += total_key_len;
 	memcpy(dptr, mod_op.base.data, base_len);
@@ -314,7 +314,7 @@ cpt_rsa_prep(struct asym_op_params *rsa_params,
 	total_key_len  = mod_len + exp_len;
 
 	/* Input buffer */
-	dptr = RTE_PTR_ADD(req, sizeof(struct cpt_request_info));
+	dptr = RTE_PTR_ADD((void *)req, sizeof(struct cpt_request_info));
 	memcpy(dptr, rsa->n.data, total_key_len);
 	dptr += total_key_len;
 
@@ -399,7 +399,7 @@ cpt_rsa_crt_prep(struct asym_op_params *rsa_params,
 	total_key_len = p_len + q_len + dP_len + dQ_len + qInv_len;
 
 	/* Input buffer */
-	dptr = RTE_PTR_ADD(req, sizeof(struct cpt_request_info));
+	dptr = RTE_PTR_ADD((void *)req, sizeof(struct cpt_request_info));
 	memcpy(dptr, rsa->qt.q.data, total_key_len);
 	dptr += total_key_len;
 
@@ -665,7 +665,7 @@ cpt_ecdsa_sign_prep(struct rte_crypto_ecdsa_op_param *ecdsa,
 	pk_offset = prime_len - pkey_len;
 
 	/* Input buffer */
-	dptr = RTE_PTR_ADD(req, sizeof(struct cpt_request_info));
+	dptr = RTE_PTR_ADD((void *)req, sizeof(struct cpt_request_info));
 
 	/*
 	 * Set dlen = sum(sizeof(fpm address), ROUNDUP8(scalar len, input len),
@@ -773,7 +773,7 @@ cpt_ecdsa_verify_prep(struct rte_crypto_ecdsa_op_param *ecdsa,
 	s_offset = prime_len - s_len;
 
 	/* Input buffer */
-	dptr = RTE_PTR_ADD(req, sizeof(struct cpt_request_info));
+	dptr = RTE_PTR_ADD((void *)req, sizeof(struct cpt_request_info));
 
 	/*
 	 * Set dlen = sum(sizeof(fpm address), ROUNDUP8(message len),
@@ -884,7 +884,7 @@ cpt_ecpm_prep(struct rte_crypto_ecpm_op_param *ecpm,
 	prime_len = ec_grp[curveid].prime.length;
 
 	/* Input buffer */
-	dptr = RTE_PTR_ADD(req, sizeof(struct cpt_request_info));
+	dptr = RTE_PTR_ADD((void *)req, sizeof(struct cpt_request_info));
 
 	p_align = RTE_ALIGN_CEIL(prime_len, 8);
 	scalar_align = RTE_ALIGN_CEIL(ecpm->scalar.length, 8);
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index d53543a113..65f553c20b 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -1654,8 +1654,8 @@ static int
 mlx5_nl_family_id_cb(struct nlmsghdr *nh, void *arg)
 {
 
-	struct nlattr *tail = RTE_PTR_ADD(nh, nh->nlmsg_len);
-	struct nlattr *nla = RTE_PTR_ADD(nh, NLMSG_ALIGN(sizeof(*nh)) +
+	struct nlattr *tail = RTE_PTR_ADD((void *)nh, nh->nlmsg_len);
+	struct nlattr *nla = RTE_PTR_ADD((void *)nh, NLMSG_ALIGN(sizeof(*nh)) +
 					NLMSG_ALIGN(sizeof(struct genlmsghdr)));
 
 	for (; nla->nla_len && nla < tail;
@@ -1752,8 +1752,8 @@ mlx5_nl_roce_cb(struct nlmsghdr *nh, void *arg)
 
 	int ret = -EINVAL;
 	int *enable = arg;
-	struct nlattr *tail = RTE_PTR_ADD(nh, nh->nlmsg_len);
-	struct nlattr *nla = RTE_PTR_ADD(nh, NLMSG_ALIGN(sizeof(*nh)) +
+	struct nlattr *tail = RTE_PTR_ADD((void *)nh, nh->nlmsg_len);
+	struct nlattr *nla = RTE_PTR_ADD((void *)nh, NLMSG_ALIGN(sizeof(*nh)) +
 					NLMSG_ALIGN(sizeof(struct genlmsghdr)));
 
 	while (nla->nla_len && nla < tail) {
@@ -2049,8 +2049,8 @@ mlx5_nl_esw_multiport_cb(struct nlmsghdr *nh, void *arg)
 
 	int ret = -EINVAL;
 	int *enable = arg;
-	struct nlattr *tail = RTE_PTR_ADD(nh, nh->nlmsg_len);
-	struct nlattr *nla = RTE_PTR_ADD(nh, NLMSG_ALIGN(sizeof(*nh)) +
+	struct nlattr *tail = RTE_PTR_ADD((void *)nh, nh->nlmsg_len);
+	struct nlattr *nla = RTE_PTR_ADD((void *)nh, NLMSG_ALIGN(sizeof(*nh)) +
 					NLMSG_ALIGN(sizeof(struct genlmsghdr)));
 
 	while (nla->nla_len && nla < tail) {
@@ -2261,7 +2261,7 @@ mlx5_nl_get_mtu_bounds_cb(struct nlmsghdr *nh, void *arg)
 	struct mlx5_mtu *out = arg;
 
 	while (off < nh->nlmsg_len) {
-		struct rtattr *ra = RTE_PTR_ADD(nh, off);
+		struct rtattr *ra = RTE_PTR_ADD((void *)nh, off);
 		uint32_t *payload;
 
 		switch (ra->rta_type) {
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index e5325c6150..cfac5dc6c1 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -626,7 +626,7 @@ mlx5_compress_cqe_err_handle(struct mlx5_compress_qp *qp,
 								    qp->qp.wqes;
 	volatile union mlx5_gga_compress_opaque *opaq = qp->opaque_mr.addr;
 
-	volatile uint32_t *synd_word = RTE_PTR_ADD(cqe, MLX5_ERROR_CQE_SYNDROME_OFFSET);
+	volatile uint32_t *synd_word = RTE_PTR_ADD((void *)cqe, MLX5_ERROR_CQE_SYNDROME_OFFSET);
 	switch (*synd_word) {
 	case MLX5_GGA_COMP_OUT_OF_SPACE_SYNDROME_BE:
 		op->status = RTE_COMP_OP_STATUS_OUT_OF_SPACE_TERMINATED;
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index 5551e40cb0..d1c68436ac 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -528,7 +528,7 @@ cn9k_cpt_sec_post_process(struct rte_crypto_op *cop,
 		hdr = rte_pktmbuf_mtod(m, struct roc_ie_on_inb_hdr *);
 
 		if (likely(m->next == NULL)) {
-			ip = PLT_PTR_ADD(hdr, ROC_IE_ON_INB_RPTR_HDR);
+			ip = PLT_PTR_ADD((void *)hdr, ROC_IE_ON_INB_RPTR_HDR);
 		} else {
 			ip = (struct rte_ipv4_hdr *)hdr;
 			hdr = infl_req->mdata;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 370f311dd3..07abeb5a52 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -523,7 +523,7 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 			goto exit;
 		}
 
-		qp->pend_q.req_queue = PLT_PTR_ADD(
+		qp->pend_q.req_queue = PLT_PTR_ADD((void *)
 			qp->lf.cq_vaddr, ROC_CPT_CQ_ENTRY_SIZE_UNIT << qp->lf.cq_entry_size);
 	}
 
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 89f32c7722..2c06183416 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -370,7 +370,7 @@ mlx5_crypto_gcm_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		goto err;
 	}
 	qp->opaque_addr = qp->mr.addr;
-	qp->klm_array = RTE_PTR_ADD(qp->opaque_addr, opaq_size);
+	qp->klm_array = RTE_PTR_ADD((void *)qp->opaque_addr, opaq_size);
 	/*
 	 * Triple the CQ size as UMR QP which contains UMR and SEND_EN WQE
 	 * will share this CQ .
@@ -733,8 +733,8 @@ static __rte_always_inline void
 mlx5_crypto_gcm_build_send_en(struct mlx5_crypto_qp *qp)
 {
 	uint32_t wqe_offset = (qp->umr_pi & (qp->umr_wqbbs - 1)) * MLX5_SEND_WQE_BB;
-	struct mlx5_wqe_cseg *cs = RTE_PTR_ADD(qp->umr_qp_obj.wqes, wqe_offset);
-	struct mlx5_wqe_qseg *qs = RTE_PTR_ADD(cs, sizeof(struct mlx5_wqe_cseg));
+	struct mlx5_wqe_cseg *cs = RTE_PTR_ADD((void *)qp->umr_qp_obj.wqes, wqe_offset);
+	struct mlx5_wqe_qseg *qs = RTE_PTR_ADD((void *)cs, sizeof(struct mlx5_wqe_cseg));
 
 	cs->opcode = rte_cpu_to_be_32(MLX5_OPCODE_SEND_EN | ((uint32_t)qp->umr_pi << 8));
 	cs->sq_ds = rte_cpu_to_be_32((qp->umr_qp_obj.qp->id << 8) | 2);
diff --git a/drivers/crypto/mlx5/mlx5_crypto_xts.c b/drivers/crypto/mlx5/mlx5_crypto_xts.c
index 1c914caa85..a9f8ab2e4d 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_xts.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_xts.c
@@ -291,7 +291,7 @@ mlx5_crypto_xts_wqe_set(struct mlx5_crypto_priv *priv,
 	qp->db_pi += priv->umr_wqe_stride;
 	/* Set RDMA_WRITE WQE. */
 	cseg = RTE_PTR_ADD(cseg, priv->umr_wqe_size);
-	klms = RTE_PTR_ADD(cseg, sizeof(struct mlx5_rdma_write_wqe));
+	klms = RTE_PTR_ADD((void *)cseg, sizeof(struct mlx5_rdma_write_wqe));
 	if (!ipl) {
 		klm_n = mlx5_crypto_xts_klms_set(qp, op, op->sym->m_src, klms);
 		if (unlikely(klm_n == 0))
diff --git a/drivers/crypto/octeontx/otx_cryptodev_ops.c b/drivers/crypto/octeontx/otx_cryptodev_ops.c
index 88657f49cc..dde216787f 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_ops.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_ops.c
@@ -446,7 +446,7 @@ otx_cpt_enq_single_asym(struct cpt_instance *instance,
 	cop[1] = (uintptr_t)op;
 	cop[2] = cop[3] = 0ULL;
 
-	params.req = RTE_PTR_ADD(cop, 4 * sizeof(uintptr_t));
+	params.req = RTE_PTR_ADD((void *)cop, 4 * sizeof(uintptr_t));
 	params.req->op = cop;
 
 	/* Adjust meta_buf by crypto_op data  and request_info struct */
diff --git a/drivers/dma/idxd/idxd_internal.h b/drivers/dma/idxd/idxd_internal.h
index b80a113455..064aeb45f3 100644
--- a/drivers/dma/idxd/idxd_internal.h
+++ b/drivers/dma/idxd/idxd_internal.h
@@ -56,6 +56,7 @@ struct idxd_dmadev {
 	unsigned short batch_start; /* start+size == write pointer for hdls/desc */
 	unsigned short batch_size;
 
+	/* FIXME: cast drops volatile propagation that should happen to idxd_dmadev.portal */
 	void *portal; /* address to write the batch descriptor */
 
 	struct idxd_completion *batch_comp_ring;
diff --git a/drivers/dma/idxd/idxd_pci.c b/drivers/dma/idxd/idxd_pci.c
index 214f6f22d5..8109ac14b2 100644
--- a/drivers/dma/idxd/idxd_pci.c
+++ b/drivers/dma/idxd/idxd_pci.c
@@ -59,7 +59,7 @@ idxd_pci_dev_command(struct idxd_dmadev *idxd, enum rte_idxd_cmds command)
 	return err_code;
 }
 
-static uint32_t *
+static volatile uint32_t *
 idxd_get_wq_cfg(struct idxd_pci_common *pci, uint8_t wq_idx)
 {
 	return RTE_PTR_ADD(pci->wq_regs_base,
@@ -69,7 +69,7 @@ idxd_get_wq_cfg(struct idxd_pci_common *pci, uint8_t wq_idx)
 static int
 idxd_is_wq_enabled(struct idxd_dmadev *idxd)
 {
-	uint32_t state = idxd_get_wq_cfg(idxd->u.pci, idxd->qid)[wq_state_idx];
+	volatile uint32_t state = idxd_get_wq_cfg(idxd->u.pci, idxd->qid)[wq_state_idx];
 	return ((state >> WQ_STATE_SHIFT) & WQ_STATE_MASK) == 0x1;
 }
 
@@ -205,9 +205,9 @@ init_pci_device(struct rte_pci_device *dev, struct idxd_dmadev *idxd,
 	pci->regs = dev->mem_resource[0].addr;
 	version = pci->regs->version;
 	grp_offset = (uint16_t)pci->regs->offsets[0];
-	pci->grp_regs = RTE_PTR_ADD(pci->regs, grp_offset * 0x100);
+	pci->grp_regs = RTE_PTR_ADD((volatile void *)pci->regs, grp_offset * 0x100);
 	wq_offset = (uint16_t)(pci->regs->offsets[0] >> 16);
-	pci->wq_regs_base = RTE_PTR_ADD(pci->regs, wq_offset * 0x100);
+	pci->wq_regs_base = RTE_PTR_ADD((volatile void *)pci->regs, wq_offset * 0x100);
 	pci->portals = dev->mem_resource[2].addr;
 	pci->wq_cfg_sz = (pci->regs->wqcap >> 24) & 0x0F;
 
@@ -395,7 +395,8 @@ idxd_dmadev_probe_pci(struct rte_pci_driver *drv, struct rte_pci_device *dev)
 		/* add the queue number to each device name */
 		snprintf(qname, sizeof(qname), "%s-q%d", name, qid);
 		idxd.qid = qid;
-		idxd.portal = RTE_PTR_ADD(idxd.u.pci->portals,
+		/* FIXME: cast drops volatile propagation to idxd_dmadev.portal */
+		idxd.portal = RTE_PTR_ADD((void *)idxd.u.pci->portals,
 				qid * IDXD_PORTAL_SIZE);
 		if (idxd_is_wq_enabled(&idxd))
 			IDXD_PMD_ERR("Error, WQ %u seems enabled", qid);
diff --git a/drivers/dma/odm/odm_dmadev.c b/drivers/dma/odm/odm_dmadev.c
index a2f4ed9a8e..6e64998230 100644
--- a/drivers/dma/odm/odm_dmadev.c
+++ b/drivers/dma/odm/odm_dmadev.c
@@ -434,7 +434,7 @@ odm_dmadev_completed(void *dev_private, uint16_t vchan, const uint16_t nb_cpls,
 	}
 
 	for (cnt = 0; cnt < nb_cpls; cnt++) {
-		cmpl_ptr = RTE_PTR_ADD(base_addr, cring_head * sizeof(cmpl));
+		cmpl_ptr = RTE_PTR_ADD((void *)base_addr, cring_head * sizeof(cmpl));
 		cmpl.u = rte_atomic_load_explicit((RTE_ATOMIC(uint32_t) *)cmpl_ptr,
 						  rte_memory_order_relaxed);
 		if (!cmpl.s.valid)
@@ -501,7 +501,7 @@ odm_dmadev_completed_status(void *dev_private, uint16_t vchan, const uint16_t nb
 #endif
 
 	for (cnt = 0; cnt < nb_cpls; cnt++) {
-		cmpl_ptr = RTE_PTR_ADD(base_addr, cring_head * sizeof(cmpl));
+		cmpl_ptr = RTE_PTR_ADD((void *)base_addr, cring_head * sizeof(cmpl));
 		cmpl.u = rte_atomic_load_explicit((RTE_ATOMIC(uint32_t) *)cmpl_ptr,
 						  rte_memory_order_relaxed);
 		if (!cmpl.s.valid)
diff --git a/drivers/mempool/bucket/rte_mempool_bucket.c b/drivers/mempool/bucket/rte_mempool_bucket.c
index c0b480bfc7..6fee10176b 100644
--- a/drivers/mempool/bucket/rte_mempool_bucket.c
+++ b/drivers/mempool/bucket/rte_mempool_bucket.c
@@ -376,8 +376,8 @@ count_underfilled_buckets(struct rte_mempool *mp,
 	uintptr_t align;
 	uint8_t *iter;
 
-	align = (uintptr_t)RTE_PTR_ALIGN_CEIL(memhdr->addr, bucket_page_sz) -
-		(uintptr_t)memhdr->addr;
+	align = RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(memhdr->addr, bucket_page_sz),
+			     memhdr->addr);
 
 	for (iter = (uint8_t *)memhdr->addr + align;
 	     iter < (uint8_t *)memhdr->addr + memhdr->len;
@@ -602,8 +602,7 @@ bucket_populate(struct rte_mempool *mp, unsigned int max_objs,
 		return -EINVAL;
 
 	bucket_page_sz = rte_align32pow2(bd->bucket_mem_size);
-	align = RTE_PTR_ALIGN_CEIL((uintptr_t)vaddr, bucket_page_sz) -
-		(uintptr_t)vaddr;
+	align = RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(vaddr, bucket_page_sz), vaddr);
 
 	bucket_header_sz = bd->header_size - mp->header_size;
 	if (iova != RTE_BAD_IOVA)
diff --git a/drivers/ml/cnxk/cn10k_ml_model.c b/drivers/ml/cnxk/cn10k_ml_model.c
index 12a2dda800..cb47027ee6 100644
--- a/drivers/ml/cnxk/cn10k_ml_model.c
+++ b/drivers/ml/cnxk/cn10k_ml_model.c
@@ -555,7 +555,7 @@ cn10k_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	metadata = &model->glow.metadata;
 	info = PLT_PTR_CAST(model->info);
-	input = PLT_PTR_ADD(info, sizeof(struct rte_ml_model_info));
+	input = PLT_PTR_ADD((void *)info, sizeof(struct rte_ml_model_info));
 	output = PLT_PTR_ADD(input, ML_CNXK_MODEL_MAX_INPUT_OUTPUT * sizeof(struct rte_ml_io_info));
 
 	/* Set model info */
diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index b30af7c7a4..8a3fcf78eb 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -702,7 +702,7 @@ cn10k_ml_layer_load(void *device, uint16_t model_id, const char *layer_name, uin
 	layer->glow.req = PLT_PTR_ADD(mz->addr, layer_object_size + layer_scratch_size);
 
 	/* Reset burst and sync stats */
-	layer->glow.burst_xstats = PLT_PTR_ADD(
+	layer->glow.burst_xstats = PLT_PTR_ADD((void *)
 		layer->glow.req, PLT_ALIGN_CEIL(sizeof(struct cnxk_ml_req), ML_CN10K_ALIGN_SIZE));
 	for (qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs + 1; qp_id++) {
 		layer->glow.burst_xstats[qp_id].hw_latency_tot = 0;
diff --git a/drivers/ml/cnxk/cnxk_ml_ops.c b/drivers/ml/cnxk/cnxk_ml_ops.c
index 9958945670..ba2c4909f9 100644
--- a/drivers/ml/cnxk/cnxk_ml_ops.c
+++ b/drivers/ml/cnxk/cnxk_ml_ops.c
@@ -1211,7 +1211,7 @@ cnxk_ml_model_load(struct rte_ml_dev *dev, struct rte_ml_model_params *params, u
 	model->cnxk_mldev = cnxk_mldev;
 	model->type = type;
 	model->model_id = lcl_model_id;
-	model->info = PLT_PTR_ADD(
+	model->info = PLT_PTR_ADD((void *)
 		model, PLT_ALIGN_CEIL(sizeof(struct cnxk_ml_model), dev_info.align_size));
 	dev->data->models[lcl_model_id] = model;
 
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 8b25ed948f..9c34597c81 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -713,8 +713,8 @@ ark_dev_info_get(struct rte_eth_dev *dev,
 		     struct rte_eth_dev_info *dev_info)
 {
 	struct ark_adapter *ark = dev->data->dev_private;
-	struct ark_mpu_t *tx_mpu = RTE_PTR_ADD(ark->bar0, ARK_MPU_TX_BASE);
-	struct ark_mpu_t *rx_mpu = RTE_PTR_ADD(ark->bar0, ARK_MPU_RX_BASE);
+	struct ark_mpu_t *tx_mpu = RTE_PTR_ADD((void *)ark->bar0, ARK_MPU_TX_BASE);
+	struct ark_mpu_t *rx_mpu = RTE_PTR_ADD((void *)ark->bar0, ARK_MPU_RX_BASE);
 	uint16_t ports = ark->num_ports;
 
 	dev_info->max_rx_pktlen = ARK_RX_MAX_PKT_LEN;
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 0c337a6cc8..f405d60449 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -940,7 +940,7 @@ static int cxgbe_dev_xstats(struct rte_eth_dev *dev,
 				 sizeof(xstats_names[count].name),
 				 "%s", xstats_str[i].name);
 		if (xstats != NULL) {
-			stats_ptr = RTE_PTR_ADD(&ps,
+			stats_ptr = RTE_PTR_ADD((void *)&ps,
 						xstats_str[i].offset);
 			xstats[count].value = *stats_ptr;
 			xstats[count].id = count;
@@ -959,7 +959,7 @@ static int cxgbe_dev_xstats(struct rte_eth_dev *dev,
 					 "tx_q%u_%s",
 					 qid, xstats_str[i].name);
 			if (xstats != NULL) {
-				stats_ptr = RTE_PTR_ADD(&txq->stats,
+				stats_ptr = RTE_PTR_ADD((void *)&txq->stats,
 							xstats_str[i].offset);
 				xstats[count].value = *stats_ptr;
 				xstats[count].id = count;
@@ -979,7 +979,7 @@ static int cxgbe_dev_xstats(struct rte_eth_dev *dev,
 					 "rx_q%u_%s",
 					 qid, xstats_str[i].name);
 			if (xstats != NULL) {
-				stats_ptr = RTE_PTR_ADD(&rxq->stats,
+				stats_ptr = RTE_PTR_ADD((void *)&rxq->stats,
 							xstats_str[i].offset);
 				xstats[count].value = *stats_ptr;
 				xstats[count].id = count;
diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index bc1759f006..0180baefc2 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -75,7 +75,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			PMD_DRV_LOG(WARNING,
 				    GVE_DEVICE_OPTION_TOO_BIG_FMT, "GQI RDA");
 		}
-		*dev_op_gqi_rda = RTE_PTR_ADD(option, sizeof(*option));
+		*dev_op_gqi_rda = RTE_PTR_ADD((void *)option, sizeof(*option));
 		break;
 	case GVE_DEV_OPT_ID_GQI_QPL:
 		if (option_length < sizeof(**dev_op_gqi_qpl) ||
@@ -91,7 +91,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			PMD_DRV_LOG(WARNING,
 				    GVE_DEVICE_OPTION_TOO_BIG_FMT, "GQI QPL");
 		}
-		*dev_op_gqi_qpl = RTE_PTR_ADD(option, sizeof(*option));
+		*dev_op_gqi_qpl = RTE_PTR_ADD((void *)option, sizeof(*option));
 		break;
 	case GVE_DEV_OPT_ID_DQO_RDA:
 		if (option_length < sizeof(**dev_op_dqo_rda) ||
@@ -107,7 +107,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			PMD_DRV_LOG(WARNING,
 				    GVE_DEVICE_OPTION_TOO_BIG_FMT, "DQO RDA");
 		}
-		*dev_op_dqo_rda = RTE_PTR_ADD(option, sizeof(*option));
+		*dev_op_dqo_rda = RTE_PTR_ADD((void *)option, sizeof(*option));
 		break;
 	case GVE_DEV_OPT_ID_MODIFY_RING:
 		/* Min ring size bound is optional. */
@@ -127,7 +127,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 				    GVE_DEVICE_OPTION_TOO_BIG_FMT,
 				    "Modify Ring");
 		}
-		*dev_op_modify_ring = RTE_PTR_ADD(option, sizeof(*option));
+		*dev_op_modify_ring = RTE_PTR_ADD((void *)option, sizeof(*option));
 
 		/* Min ring size included; set the minimum ring size. */
 		if (option_length == sizeof(**dev_op_modify_ring))
@@ -149,7 +149,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 				    GVE_DEVICE_OPTION_TOO_BIG_FMT,
 				    "Jumbo Frames");
 		}
-		*dev_op_jumbo_frames = RTE_PTR_ADD(option, sizeof(*option));
+		*dev_op_jumbo_frames = RTE_PTR_ADD((void *)option, sizeof(*option));
 		break;
 	default:
 		/* If we don't recognize the option just continue
@@ -175,7 +175,7 @@ gve_process_device_options(struct gve_priv *priv,
 	int i;
 
 	/* The options struct directly follows the device descriptor. */
-	dev_opt = RTE_PTR_ADD(descriptor, sizeof(*descriptor));
+	dev_opt = RTE_PTR_ADD((void *)descriptor, sizeof(*descriptor));
 	for (i = 0; i < num_options; i++) {
 		struct gve_device_option *next_opt;
 
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index f2d8e12181..f9d86ab800 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -456,7 +456,7 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->parent = NULL;
 		tm_node->reference_count = 0;
 		tm_node->shaper_profile = shaper_profile;
-		tm_node->children = RTE_PTR_ADD(tm_node, sizeof(struct ice_tm_node));
+		tm_node->children = RTE_PTR_ADD((void *)tm_node, sizeof(struct ice_tm_node));
 		tm_node->params = *params;
 		pf->tm_conf.root = tm_node;
 		return 0;
@@ -518,7 +518,7 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->parent = parent_node;
 	tm_node->level = level_id;
 	tm_node->shaper_profile = shaper_profile;
-	tm_node->children = RTE_PTR_ADD(tm_node, sizeof(struct ice_tm_node));
+	tm_node->children = RTE_PTR_ADD((void *)tm_node, sizeof(struct ice_tm_node));
 	tm_node->parent->children[tm_node->parent->reference_count++] = tm_node;
 	tm_node->params = *params;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index a7583c178a..92fa9ddd96 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2852,7 +2852,7 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 				 RTE_CACHE_LINE_SIZE, socket_id);
 	if (txq == NULL)
 		return -ENOMEM;
-	txq->ctx_cache = RTE_PTR_ADD(txq, sizeof(struct ci_tx_queue));
+	txq->ctx_cache = RTE_PTR_ADD((void *)txq, sizeof(struct ci_tx_queue));
 
 	/*
 	 * Allocate TX ring hardware descriptors. A memzone large enough to
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 2c48f1b01b..a40f5ef47a 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -8326,9 +8326,9 @@ flow_alloc_thread_workspace(void)
 		DRV_LOG(ERR, "Failed to allocate flow workspace memory.");
 		return NULL;
 	}
-	data->rss_desc.queue = RTE_PTR_ADD(data, data_size);
+	data->rss_desc.queue = RTE_PTR_ADD((void *)data, data_size);
 #ifdef HAVE_MLX5_HWS_SUPPORT
-	data->table = RTE_PTR_ADD(data->rss_desc.queue, rss_queue_array_size);
+	data->table = RTE_PTR_ADD((void *)data->rss_desc.queue, rss_queue_array_size);
 #endif
 	return data;
 }
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c41b99746f..15599f47e3 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -126,7 +126,7 @@ mlx5_flow_hw_aux(uint16_t port_id, struct rte_flow_hw *flow)
 		if (rte_flow_template_table_resizable(port_id, &table->cfg.attr)) {
 			size_t offset = sizeof(struct rte_flow_hw) + mlx5dr_rule_get_handle_size();
 
-			return RTE_PTR_ADD(flow, offset);
+			return RTE_PTR_ADD((void *)flow, offset);
 		} else {
 			return &table->flow_aux[flow->idx - 1];
 		}
@@ -8123,7 +8123,7 @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
 	at->src_off = RTE_PTR_ADD(at->dr_off,
 				  RTE_ALIGN(act_num * sizeof(*at->dr_off), 16));
 	memcpy(at->src_off, src_off, act_num * sizeof(at->src_off[0]));
-	at->orig_actions = RTE_PTR_ADD(at->src_off,
+	at->orig_actions = RTE_PTR_ADD((void *)at->src_off,
 				       RTE_ALIGN(act_num * sizeof(*at->src_off), 16));
 	orig_act_len = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, at->orig_actions, orig_act_len,
 				     actions, error);
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 16307206e2..3f7bc3c607 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -897,7 +897,7 @@ mlx5_tx_qseg_init(struct mlx5_txq_data *restrict txq,
 {
 	struct mlx5_wqe_qseg *qs;
 
-	qs = RTE_PTR_ADD(wqe, MLX5_WSEG_SIZE);
+	qs = RTE_PTR_ADD((void *)wqe, MLX5_WSEG_SIZE);
 	qs->max_index = rte_cpu_to_be_32(wci);
 	qs->qpn_cqn = rte_cpu_to_be_32(txq->sh->txpp.clock_queue.cq_obj.cq->id);
 	qs->reserved0 = RTE_BE32(0);
@@ -928,7 +928,7 @@ mlx5_tx_wseg_init(struct mlx5_txq_data *restrict txq,
 {
 	struct mlx5_wqe_wseg *ws;
 
-	ws = RTE_PTR_ADD(wqe, MLX5_WSEG_SIZE);
+	ws = RTE_PTR_ADD((void *)wqe, MLX5_WSEG_SIZE);
 	ws->operation = rte_cpu_to_be_32(MLX5_WAIT_COND_CYCLIC_SMALLER);
 	ws->lkey = RTE_BE32(0);
 	ws->va_high = RTE_BE32(0);
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index 0e99b58bde..ac1a17476c 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -194,7 +194,7 @@ mlx5_txpp_fill_wqe_rearm_queue(struct mlx5_dev_ctx_shared *sh)
 		cs->flags = RTE_BE32(MLX5_COMP_ALWAYS <<
 				     MLX5_COMP_MODE_OFFSET);
 		cs->misc = RTE_BE32(0);
-		qs = RTE_PTR_ADD(cs, sizeof(struct mlx5_wqe_cseg));
+		qs = RTE_PTR_ADD((void *)cs, sizeof(struct mlx5_wqe_cseg));
 		index = (i * MLX5_TXPP_REARM / 2 + MLX5_TXPP_REARM) &
 			((1 << MLX5_WQ_INDEX_WIDTH) - 1);
 		qs->max_index = rte_cpu_to_be_32(index);
@@ -207,7 +207,7 @@ mlx5_txpp_fill_wqe_rearm_queue(struct mlx5_dev_ctx_shared *sh)
 		cs->flags = RTE_BE32(MLX5_COMP_ONLY_ERR <<
 				     MLX5_COMP_MODE_OFFSET);
 		cs->misc = RTE_BE32(0);
-		qs = RTE_PTR_ADD(cs, sizeof(struct mlx5_wqe_cseg));
+		qs = RTE_PTR_ADD((void *)cs, sizeof(struct mlx5_wqe_cseg));
 		index = (i * MLX5_TXPP_REARM / 2 + MLX5_TXPP_REARM / 2) &
 			((1 << MLX5_CQ_INDEX_WIDTH) - 1);
 		qs->max_index = rte_cpu_to_be_32(index);
diff --git a/drivers/net/sfc/sfc_mae.c b/drivers/net/sfc/sfc_mae.c
index b0e8b02b41..f31e406fb2 100644
--- a/drivers/net/sfc/sfc_mae.c
+++ b/drivers/net/sfc/sfc_mae.c
@@ -4097,7 +4097,7 @@ sfc_mae_header_force_item_masks(uint8_t *header_buf,
 
 		for (ofst = 0; ofst < proto_header_size;
 		     ofst += sizeof(rte_be16_t)) {
-			rte_be16_t *wp = RTE_PTR_ADD(header_buf, ofst);
+			rte_be16_t *wp = RTE_PTR_ADD((void *)header_buf, ofst);
 			const rte_be16_t *w_maskp;
 			const rte_be16_t *w_specp;
 
@@ -4231,10 +4231,10 @@ sfc_mae_rule_parse_action_vxlan_encap(
 
 			proto_header_size = sizeof(struct rte_vlan_hdr);
 
-			ethertypep = RTE_PTR_ADD(buf, eth_ethertype_ofst);
+			ethertypep = RTE_PTR_ADD((void *)buf, eth_ethertype_ofst);
 			*ethertypep = RTE_BE16(RTE_ETHER_TYPE_QINQ);
 
-			ethertypep = RTE_PTR_ADD(buf, ethertype_ofst);
+			ethertypep = RTE_PTR_ADD((void *)buf, ethertype_ofst);
 			*ethertypep = RTE_BE16(RTE_ETHER_TYPE_VLAN);
 
 			ethertype_ofst =
@@ -4255,7 +4255,7 @@ sfc_mae_rule_parse_action_vxlan_encap(
 
 			proto_header_size = sizeof(struct rte_ipv4_hdr);
 
-			ethertypep = RTE_PTR_ADD(buf, ethertype_ofst);
+			ethertypep = RTE_PTR_ADD((void *)buf, ethertype_ofst);
 			*ethertypep = RTE_BE16(RTE_ETHER_TYPE_IPV4);
 
 			next_proto_ofst =
@@ -4274,7 +4274,7 @@ sfc_mae_rule_parse_action_vxlan_encap(
 
 			proto_header_size = sizeof(struct rte_ipv6_hdr);
 
-			ethertypep = RTE_PTR_ADD(buf, ethertype_ofst);
+			ethertypep = RTE_PTR_ADD((void *)buf, ethertype_ofst);
 			*ethertypep = RTE_BE16(RTE_ETHER_TYPE_IPV6);
 
 			next_proto_ofst = bounce_eh->size +
diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio_rxtx.c
index edecd2011f..089811160b 100644
--- a/drivers/net/virtio/virtio_rxtx.c
+++ b/drivers/net/virtio/virtio_rxtx.c
@@ -414,7 +414,7 @@ virtio_tso_fix_cksum(struct rte_mbuf *m)
 
 		iph = rte_pktmbuf_mtod_offset(m,
 					struct rte_ipv4_hdr *, m->l2_len);
-		th = RTE_PTR_ADD(iph, m->l3_len);
+		th = RTE_PTR_ADD((void *)iph, m->l3_len);
 
 		/*
 		 * Calculate IPv4 header checksum with current total length value
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..a1414e790c 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -332,6 +332,8 @@ virt2memseg_list(const void *addr)
 		msl = &mcfg->memsegs[msl_idx];
 
 		start = msl->base_va;
+		if (start == NULL)
+			continue;
 		end = RTE_PTR_ADD(start, msl->len);
 		if (addr >= start && addr < end)
 			break;
@@ -680,10 +682,9 @@ RTE_EXPORT_SYMBOL(rte_mem_lock_page)
 int
 rte_mem_lock_page(const void *virt)
 {
-	uintptr_t virtual = (uintptr_t)virt;
 	size_t page_size = rte_mem_page_size();
-	uintptr_t aligned = RTE_PTR_ALIGN_FLOOR(virtual, page_size);
-	return rte_mem_lock((void *)aligned, page_size);
+	const void *aligned = RTE_PTR_ALIGN_FLOOR(virt, page_size);
+	return rte_mem_lock(aligned, page_size);
 }
 
 RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe)
@@ -1447,7 +1448,7 @@ handle_eal_memseg_info_request(const char *cmd __rte_unused,
 
 	ms_iova = ms->iova;
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = RTE_INT_PTR_ADD(ms_start_addr, ms->len);
 	ms_size = ms->len;
 	hugepage_size = ms->hugepage_sz;
 	ms_socket_id = ms->socket_id;
@@ -1519,7 +1520,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 	}
 
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = RTE_INT_PTR_ADD(ms_start_addr, ms->len);
 	rte_mcfg_mem_read_unlock();
 
 	rte_tel_data_start_dict(d);
@@ -1530,8 +1531,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 	elem = heap->first;
 	while (elem) {
 		elem_start_addr = (uint64_t)elem;
-		elem_end_addr =
-			(uint64_t)RTE_PTR_ADD(elem_start_addr, elem->size);
+		elem_end_addr = RTE_INT_PTR_ADD(elem_start_addr, elem->size);
 
 		if ((uint64_t)elem_start_addr >= ms_start_addr &&
 		    (uint64_t)elem_end_addr <= ms_end_addr)
@@ -1597,7 +1597,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 	}
 
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = RTE_INT_PTR_ADD(ms_start_addr, ms->len);
 
 	rte_mcfg_mem_read_unlock();
 
@@ -1609,8 +1609,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 	elem = heap->first;
 	while (elem) {
 		elem_start_addr = (uint64_t)elem;
-		elem_end_addr =
-			(uint64_t)RTE_PTR_ADD(elem_start_addr, elem->size);
+		elem_end_addr = RTE_INT_PTR_ADD(elem_start_addr, elem->size);
 
 		if (elem_start_addr < ms_start_addr ||
 				elem_end_addr > ms_end_addr) {
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 485655865d..d62011b037 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1656,7 +1656,7 @@ eal_parse_base_virtaddr(const char *arg)
 	 * on x86 and other architectures.
 	 */
 	internal_conf->base_virtaddr =
-		RTE_PTR_ALIGN_CEIL((uintptr_t)addr, (size_t)RTE_PGSIZE_16M);
+		RTE_INT_PTR_ALIGN_CEIL((uintptr_t)addr, (size_t)RTE_PGSIZE_16M);
 
 	return 0;
 }
diff --git a/lib/eal/common/malloc_elem.h b/lib/eal/common/malloc_elem.h
index c7ff6718f8..22bfe96883 100644
--- a/lib/eal/common/malloc_elem.h
+++ b/lib/eal/common/malloc_elem.h
@@ -309,10 +309,10 @@ malloc_elem_from_data(const void *data)
 	if (data == NULL)
 		return NULL;
 
-	struct malloc_elem *elem = RTE_PTR_SUB(data, MALLOC_ELEM_HEADER_LEN);
+	struct malloc_elem *elem = RTE_PTR_SUB((void *)data, MALLOC_ELEM_HEADER_LEN);
 	if (!malloc_elem_cookies_ok(elem))
 		return NULL;
-	return elem->state != ELEM_PAD ? elem:  RTE_PTR_SUB(elem, elem->pad);
+	return elem->state != ELEM_PAD ? elem : RTE_PTR_SUB((void *)elem, elem->pad);
 }
 
 /*
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 39240c261c..bae6de58c4 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -1390,7 +1390,11 @@ malloc_heap_destroy(struct malloc_heap *heap)
 
 	/* Reset all of the heap but the (hold) lock so caller can release it. */
 	RTE_BUILD_BUG_ON(offsetof(struct malloc_heap, lock) != 0);
-	memset(RTE_PTR_ADD(heap, sizeof(heap->lock)), 0,
+	/* Cast to void* to avoid compiler alignment assumptions from typed pointer.
+	 * RTE_PTR_ADD preserves type, but heap+sizeof(lock) is misaligned for
+	 * struct malloc_heap, which can cause crashes with vectorized memset.
+	 */
+	memset((void *)RTE_PTR_ADD(heap, sizeof(heap->lock)), 0,
 		sizeof(*heap) - sizeof(heap->lock));
 
 	return 0;
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..d09704035c 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -549,14 +549,104 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 /*********** Macros for pointer arithmetic ********/
 
 /**
- * add a byte-value offset to a pointer
+ * Add a byte-value offset to an integer representing a pointer address.
+ * Use this when working with pointer values as integers (e.g., uintptr_t),
+ * or when the pointer value may be NULL.
+ *
+ * @param intptr
+ *   Integer representation of a pointer address
+ * @param x
+ *   Byte offset to add
+ * @return
+ *   Result as the same type as intptr
  */
-#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
+#define RTE_INT_PTR_ADD(intptr, x) \
+	((typeof(intptr))((uintptr_t)(intptr) + (x)))
 
 /**
- * subtract a byte-value offset from a pointer
+ * Subtract a byte-value offset from an integer representing a pointer address.
+ * Use this when working with pointer values as integers (e.g., uintptr_t),
+ * or when the pointer value may be NULL.
+ *
+ * @param intptr
+ *   Integer representation of a pointer address
+ * @param x
+ *   Byte offset to subtract
+ * @return
+ *   Result as the same type as intptr
  */
-#define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
+#define RTE_INT_PTR_SUB(intptr, x) \
+	((typeof(intptr))((uintptr_t)(intptr) - (x)))
+
+/**
+ * Add a byte-value offset to a pointer.
+ * Returns a pointer of the same type and const-qualification as the input.
+ *
+ * The pointer must be non-NULL for defined behavior. For NULL-safe operations
+ * or integer pointer arithmetic, use RTE_INT_PTR_ADD instead.
+ *
+ * @warning
+ * Type preservation means the compiler may assume alignment based on the
+ * returned pointer type. When doing raw memory operations (memset, memcpy)
+ * or pointer arithmetic across struct boundaries, cast the result to (void *)
+ * to prevent the compiler from making incorrect alignment assumptions that
+ * could cause crashes with vectorized instructions.
+ *
+ * @param ptr
+ *   The pointer (must be non-NULL)
+ * @param x
+ *   Byte offset to add
+ * @return
+ *   Pointer with offset applied, preserving input type and qualifiers
+ */
+#ifndef RTE_TOOLCHAIN_MSVC
+#define RTE_PTR_ADD(ptr, x) \
+(__extension__ ({ \
+	__rte_diagnostic_push \
+	__rte_diagnostic_ignored_wcast_qual \
+	typeof(ptr) __rte_ptr_add_result = \
+		(typeof(ptr))((char *)(ptr) + (x)); \
+	__rte_diagnostic_pop \
+	__rte_ptr_add_result; \
+}))
+#else
+#define RTE_PTR_ADD(ptr, x) ((typeof(ptr))((uintptr_t)(ptr) + (x)))
+#endif
+
+/**
+ * Subtract a byte-value offset from a pointer.
+ * Returns a pointer of the same type and const-qualification as the input.
+ *
+ * The pointer must be non-NULL for defined behavior. For NULL-safe operations
+ * or integer pointer arithmetic, use RTE_INT_PTR_SUB instead.
+ *
+ * @warning
+ * Type preservation means the compiler may assume alignment based on the
+ * returned pointer type. When doing raw memory operations (memset, memcpy)
+ * or pointer arithmetic across struct boundaries, cast the result to (void *)
+ * to prevent the compiler from making incorrect alignment assumptions that
+ * could cause crashes with vectorized instructions.
+ *
+ * @param ptr
+ *   The pointer (must be non-NULL)
+ * @param x
+ *   Byte offset to subtract
+ * @return
+ *   Pointer with offset applied, preserving input type and qualifiers
+ */
+#ifndef RTE_TOOLCHAIN_MSVC
+#define RTE_PTR_SUB(ptr, x) \
+(__extension__ ({ \
+	__rte_diagnostic_push \
+	__rte_diagnostic_ignored_wcast_qual \
+	typeof(ptr) __rte_ptr_sub_result = \
+		(typeof(ptr))((char *)(ptr) - (x)); \
+	__rte_diagnostic_pop \
+	__rte_ptr_sub_result; \
+}))
+#else
+#define RTE_PTR_SUB(ptr, x) ((typeof(ptr))((uintptr_t)(ptr) - (x)))
+#endif
 
 /**
  * get the difference between two pointer values, i.e. how far apart
@@ -607,8 +697,37 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
  * point to an address no higher than the first parameter. Second parameter
  * must be a power-of-two value.
  */
+#ifndef RTE_TOOLCHAIN_MSVC
+#define RTE_PTR_ALIGN_FLOOR(ptr, align) \
+(__extension__ ({ \
+	__auto_type __rte_ptr_align_floor_tmp = (ptr); \
+	typeof(__rte_ptr_align_floor_tmp) __rte_ptr_align_floor_result = \
+		(typeof(__rte_ptr_align_floor_tmp)) \
+		RTE_ALIGN_FLOOR((uintptr_t)(__rte_ptr_align_floor_tmp), align); \
+	__rte_ptr_align_floor_result; \
+}))
+#else
 #define RTE_PTR_ALIGN_FLOOR(ptr, align) \
 	((typeof(ptr))RTE_ALIGN_FLOOR((uintptr_t)(ptr), align))
+#endif
+
+/**
+ * Align an integer address down to a given power-of-two.
+ * The resultant value will be no higher than the first parameter.
+ * Second parameter must be a power-of-two value.
+ *
+ * Use this when working with numeric addresses (e.g., uintptr_t, uint64_t),
+ * not actual pointer variables. For pointers, use RTE_PTR_ALIGN_FLOOR.
+ *
+ * @param intptr
+ *   Integer representation of an address
+ * @param align
+ *   Power-of-two alignment value
+ * @return
+ *   Integer address aligned down to the specified boundary
+ */
+#define RTE_INT_PTR_ALIGN_FLOOR(intptr, align) \
+	((typeof(intptr))RTE_ALIGN_FLOOR((uintptr_t)(intptr), align))
 
 /**
  * Macro to align a value to a given power-of-two. The resultant value
@@ -625,8 +744,36 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
  * point to an address no lower than the first parameter. Second parameter
  * must be a power-of-two value.
  */
+#ifndef RTE_TOOLCHAIN_MSVC
 #define RTE_PTR_ALIGN_CEIL(ptr, align) \
-	RTE_PTR_ALIGN_FLOOR((typeof(ptr))RTE_PTR_ADD(ptr, (align) - 1), align)
+(__extension__ ({ \
+	__auto_type __rte_ptr_align_ceil_tmp = (ptr); \
+	__auto_type __rte_ptr_align_tmp = RTE_PTR_ADD( \
+		__rte_ptr_align_ceil_tmp, (align) - 1); \
+	RTE_PTR_ALIGN_FLOOR(__rte_ptr_align_tmp, align); \
+}))
+#else
+#define RTE_PTR_ALIGN_CEIL(ptr, align) \
+	RTE_PTR_ALIGN_FLOOR(RTE_PTR_ADD(ptr, (align) - 1), align)
+#endif
+
+/**
+ * Align an integer address up to a given power-of-two.
+ * The resultant value will be no lower than the first parameter.
+ * Second parameter must be a power-of-two value.
+ *
+ * Use this when working with numeric addresses (e.g., uintptr_t, uint64_t),
+ * not actual pointer variables. For pointers, use RTE_PTR_ALIGN_CEIL.
+ *
+ * @param intptr
+ *   Integer representation of an address
+ * @param align
+ *   Power-of-two alignment value
+ * @return
+ *   Integer address aligned up to the specified boundary
+ */
+#define RTE_INT_PTR_ALIGN_CEIL(intptr, align) \
+	((typeof(intptr))RTE_ALIGN_CEIL((uintptr_t)(intptr), align))
 
 /**
  * Macro to align a value to a given power-of-two. The resultant value
@@ -646,6 +793,23 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
  */
 #define RTE_PTR_ALIGN(ptr, align) RTE_PTR_ALIGN_CEIL(ptr, align)
 
+/**
+ * Align an integer address to a given power-of-two (rounds up).
+ * This is an alias for RTE_INT_PTR_ALIGN_CEIL.
+ *
+ * Use this when working with numeric addresses (e.g., uintptr_t, uint64_t),
+ * not actual pointer variables. For pointers, use RTE_PTR_ALIGN.
+ *
+ * @param intptr
+ *   Integer representation of an address
+ * @param align
+ *   Power-of-two alignment value
+ * @return
+ *   Integer address aligned up to the specified boundary
+ */
+#define RTE_INT_PTR_ALIGN(intptr, align) \
+	RTE_INT_PTR_ALIGN_CEIL(intptr, align)
+
 /**
  * Macro to align a value to a given power-of-two. The resultant
  * value will be of the same type as the first parameter, and
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2659e8d9eb..05d5b52faa 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3711,7 +3711,7 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 
 	/* global stats */
 	for (i = 0; i < RTE_NB_STATS; i++) {
-		stats_ptr = RTE_PTR_ADD(&eth_stats,
+		stats_ptr = RTE_PTR_ADD((void *)&eth_stats,
 					eth_dev_stats_strings[i].offset);
 		val = *stats_ptr;
 		xstats[count++].value = val;
@@ -3723,7 +3723,7 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 	/* per-rxq stats */
 	for (q = 0; q < nb_rxqs; q++) {
 		for (i = 0; i < RTE_NB_RXQ_STATS; i++) {
-			stats_ptr = RTE_PTR_ADD(&queue_stats,
+			stats_ptr = RTE_PTR_ADD((void *)&queue_stats,
 					eth_dev_rxq_stats_strings[i].offset +
 					q * sizeof(uint64_t));
 			val = *stats_ptr;
@@ -3734,7 +3734,7 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 	/* per-txq stats */
 	for (q = 0; q < nb_txqs; q++) {
 		for (i = 0; i < RTE_NB_TXQ_STATS; i++) {
-			stats_ptr = RTE_PTR_ADD(&queue_stats,
+			stats_ptr = RTE_PTR_ADD((void *)&queue_stats,
 					eth_dev_txq_stats_strings[i].offset +
 					q * sizeof(uint64_t));
 			val = *stats_ptr;
diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c
index 026daecb21..4ec20c26b1 100644
--- a/lib/graph/graph_populate.c
+++ b/lib/graph/graph_populate.c
@@ -62,7 +62,7 @@ graph_header_popluate(struct graph *_graph)
 	graph->head = (int32_t)-_graph->src_node_count;
 	graph->cir_mask = _graph->cir_mask;
 	graph->nb_nodes = _graph->node_count;
-	graph->cir_start = RTE_PTR_ADD(graph, _graph->cir_start);
+	graph->cir_start = RTE_PTR_ADD((void *)graph, _graph->cir_start);
 	graph->nodes_start = _graph->nodes_start;
 	graph->socket = _graph->socket;
 	graph->id = _graph->id;
@@ -81,7 +81,7 @@ graph_nodes_populate(struct graph *_graph)
 	rte_node_t pid;
 
 	STAILQ_FOREACH(graph_node, &_graph->node_list, next) {
-		struct rte_node *node = RTE_PTR_ADD(graph, off);
+		struct rte_node *node = RTE_PTR_ADD((void *)graph, off);
 		memset(node, 0, sizeof(*node));
 		node->fence = RTE_GRAPH_FENCE;
 		node->off = off;
diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index b87b5707f7..e7b56966eb 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -501,7 +501,7 @@ cluster_node_arregate_stats(struct cluster_node *cluster, bool dispatch)
 
 		if (node->xstat_off == 0)
 			continue;
-		xstat = RTE_PTR_ADD(node, node->xstat_off);
+		xstat = RTE_PTR_ADD((void *)node, node->xstat_off);
 		for (i = 0; i < stat->xstat_cntrs; i++)
 			stat->xstat_count[i] += xstat[i];
 	}
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index 7e433f4661..7eb7495eae 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -407,9 +407,9 @@ void rte_graph_obj_dump(FILE *f, struct rte_graph *graph, bool all);
 /** Macro to browse rte_node object after the graph creation */
 #define rte_graph_foreach_node(count, off, graph, node)                        \
 	for (count = 0, off = graph->nodes_start,                              \
-	     node = RTE_PTR_ADD(graph, off);                                   \
+	     node = RTE_PTR_ADD((void *)graph, off);                           \
 	     count < graph->nb_nodes;                                          \
-	     off = node->next, node = RTE_PTR_ADD(graph, off), count++)
+	     off = node->next, node = RTE_PTR_ADD((void *)graph, off), count++)
 
 /**
  * Get node object with in graph from id.
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_graph_model_mcore_dispatch.c
index 706b5469f0..cd3fc130d3 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.c
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c
@@ -154,7 +154,7 @@ __rte_graph_mcore_dispatch_sched_wq_process(struct rte_graph *graph)
 
 	for (i = 0; i < n; i++) {
 		wq_node = wq_nodes[i];
-		node = RTE_PTR_ADD(graph, wq_node->node_off);
+		node = RTE_PTR_ADD((void *)graph, wq_node->node_off);
 		RTE_ASSERT(node->fence == RTE_GRAPH_FENCE);
 		idx = node->idx;
 		free_space = node->size - idx;
diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index f61d5a273f..cc27205500 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -105,7 +105,7 @@ latencystats_collect(uint64_t values[])
 	const uint64_t *stats;
 
 	for (i = 0; i < NUM_LATENCY_STATS; i++) {
-		stats = RTE_PTR_ADD(glob_stats, lat_stats_strings[i].offset);
+		stats = RTE_PTR_ADD((void *)glob_stats, lat_stats_strings[i].offset);
 		scale = lat_stats_strings[i].scale;
 
 		/* used to mark samples which are not a time interval */
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 0d931c7a15..61d174cba3 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -215,7 +215,7 @@ __rte_pktmbuf_init_extmem(struct rte_mempool *mp,
 	m->next = NULL;
 
 	/* init external buffer shared info items */
-	shinfo = RTE_PTR_ADD(m, mbuf_size);
+	shinfo = RTE_PTR_ADD((void *)m, mbuf_size);
 	m->shinfo = shinfo;
 	shinfo->free_cb = rte_pktmbuf_free_pinned_extmem;
 	shinfo->fcb_opaque = m;
diff --git a/lib/member/rte_xxh64_avx512.h b/lib/member/rte_xxh64_avx512.h
index 58f896ebb8..774b26d8df 100644
--- a/lib/member/rte_xxh64_avx512.h
+++ b/lib/member/rte_xxh64_avx512.h
@@ -58,7 +58,7 @@ rte_xxh64_sketch_avx512(const void *key, uint32_t key_len,
 			 _mm512_set1_epi64(key_len));
 
 	while (remaining >= 8) {
-		input = _mm512_set1_epi64(*(uint64_t *)RTE_PTR_ADD(key, offset));
+		input = _mm512_set1_epi64(*(const uint64_t *)RTE_PTR_ADD(key, offset));
 		v_hash = _mm512_xor_epi64(v_hash,
 				xxh64_round_avx512(_mm512_setzero_si512(), input));
 		v_hash = _mm512_madd52lo_epu64(_mm512_set1_epi64(PRIME64_4),
@@ -71,7 +71,7 @@ rte_xxh64_sketch_avx512(const void *key, uint32_t key_len,
 
 	if (remaining >= 4) {
 		input = _mm512_set1_epi64
-			(*(uint32_t *)RTE_PTR_ADD(key, offset));
+			(*(const uint32_t *)RTE_PTR_ADD(key, offset));
 		v_hash = _mm512_xor_epi64(v_hash,
 			_mm512_mullo_epi64(input,
 				_mm512_set1_epi64(PRIME64_1)));
@@ -86,7 +86,7 @@ rte_xxh64_sketch_avx512(const void *key, uint32_t key_len,
 
 	while (remaining != 0) {
 		input = _mm512_set1_epi64
-			(*(uint8_t *)RTE_PTR_ADD(key, offset));
+			(*(const uint8_t *)RTE_PTR_ADD(key, offset));
 		v_hash = _mm512_xor_epi64(v_hash,
 			_mm512_mullo_epi64(input,
 				_mm512_set1_epi64(PRIME64_5)));
diff --git a/lib/pdcp/pdcp_entity.h b/lib/pdcp/pdcp_entity.h
index f854192e98..e8251cbdbc 100644
--- a/lib/pdcp/pdcp_entity.h
+++ b/lib/pdcp/pdcp_entity.h
@@ -198,17 +198,19 @@ struct entity_priv_ul_part {
 
 static inline struct entity_priv *
 entity_priv_get(const struct rte_pdcp_entity *entity) {
-	return RTE_PTR_ADD(entity, sizeof(struct rte_pdcp_entity));
+	return RTE_PTR_ADD((void *)entity, sizeof(struct rte_pdcp_entity));
 }
 
 static inline struct entity_priv_dl_part *
 entity_dl_part_get(const struct rte_pdcp_entity *entity) {
-	return RTE_PTR_ADD(entity, sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
+	return RTE_PTR_ADD((void *)entity,
+			   sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
 }
 
 static inline struct entity_priv_ul_part *
 entity_ul_part_get(const struct rte_pdcp_entity *entity) {
-	return RTE_PTR_ADD(entity, sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
+	return RTE_PTR_ADD((void *)entity,
+			   sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
 }
 
 static inline int
diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index be06530860..5caebf20d4 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -120,7 +120,7 @@ rte_reorder_init(struct rte_reorder_buffer *b, unsigned int bufsize,
 	b->order_buf.size = b->ready_buf.size = size;
 	b->order_buf.mask = b->ready_buf.mask = size - 1;
 	b->ready_buf.entries = (void *)&b[1];
-	b->order_buf.entries = RTE_PTR_ADD(&b[1],
+	b->order_buf.entries = RTE_PTR_ADD((void *)&b[1],
 			size * sizeof(b->ready_buf.entries[0]));
 
 	return b;
-- 
2.39.5 (Apple Git-154)

