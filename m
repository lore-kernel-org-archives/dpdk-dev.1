Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B1C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 13:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 310E840EDC;
	Tue,  8 Apr 2025 15:00:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8A98F40A89
 for <dev@dpdk.org>; Tue,  8 Apr 2025 15:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744117252; x=1775653252;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zScej7K+7HON//W6yrUKa1+DTp0G3xSP93tyCzASMZg=;
 b=Muke+StEQtWHtWjPsw17BQmA/vMXpCHmvoG3hFymF/7pfc6vLN7HB3TT
 TGlQGNJsMPHHr73jTTAFXww/Vz8LDDGBBgo+8m+Ec4EjMA/jVT4/Th9+7
 mK6jwtdXK0AmjY8KcbBSLD/8tKif/MUOZwqmvIwySONLENXrHygE1eoVL
 g6b0VRW3q6pBsRy9KAtnnNDPVc+STn53BcQ15sob1pZAE8TTWBIJysJFf
 W+Rlwctm1nu+GXFHBIi9P1j5KvXj7V4MuLifKI2hamK+Id8o0r72PHyD2
 +3mpgMI7trfDGWaCRr8A6690toEaCPXXu9BNQGuqpN343LuV+F+YxZDqG w==;
X-CSE-ConnectionGUID: R3Px/Z7DT5a09km5lpu+4A==
X-CSE-MsgGUID: DkejteumRxOjxLOi6acFdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49204315"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="49204315"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 06:00:51 -0700
X-CSE-ConnectionGUID: SWEYlsdySnSIg7/mPD/C7w==
X-CSE-MsgGUID: qyAZnjbpQuq3hivbyvhNZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="159258962"
Received: from txanpdk03.an.intel.com ([10.123.117.78])
 by orviesa002.jf.intel.com with ESMTP; 08 Apr 2025 06:00:50 -0700
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, pravin.pathak@intel.com,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Subject: [PATCH v4] event/dlb2: consolidate AVX512 and SSE changes
Date: Tue,  8 Apr 2025 08:00:48 -0500
Message-Id: <20250408130048.3115648-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.39.1
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

Streamline code for AVX512 and SSE by consolidating the common code and
adding runtime check for selecting appropriate path based on CPU
capability.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

---
v4:
 - Modify some AVX512 instructions to resolve compilation error on
   older compliers
v3:
 - Simplified code for AVX/SSE paths
v2:
 - Addressed review comments [Bruce Richardson]
---
 drivers/event/dlb2/dlb2.c        |  78 ++++++++-
 drivers/event/dlb2/dlb2_avx512.c | 287 +++----------------------------
 drivers/event/dlb2/dlb2_priv.h   |  10 +-
 drivers/event/dlb2/dlb2_sse.c    | 242 +++-----------------------
 4 files changed, 127 insertions(+), 490 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 934fcafcfe..75bca62728 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -90,6 +90,9 @@ static struct rte_event_dev_info evdev_dlb2_default_info = {
 struct process_local_port_data
 dlb2_port[DLB2_MAX_NUM_PORTS_ALL][DLB2_NUM_PORT_TYPES];
 
+static void (*dlb2_build_qes)(struct dlb2_enqueue_qe *qe, const struct rte_event ev[],
+			      uint16_t *cmd_weight, uint16_t *sched_word);
+
 static void
 dlb2_free_qe_mem(struct dlb2_port *qm_port)
 {
@@ -2069,9 +2072,9 @@ dlb2_eventdev_port_setup(struct rte_eventdev *dev,
 
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512VL) &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
-		ev_port->qm_port.use_avx512 = true;
+		dlb2_build_qes = dlb2_build_qes_avx512;
 	else
-		ev_port->qm_port.use_avx512 = false;
+		dlb2_build_qes = dlb2_build_qes_sse;
 
 	return 0;
 }
@@ -2887,6 +2890,77 @@ dlb2_construct_token_pop_qe(struct dlb2_port *qm_port, int idx)
 	qm_port->owed_tokens = 0;
 }
 
+static inline void
+dlb2_event_build_hcws(struct dlb2_port *qm_port,
+		      const struct rte_event ev[],
+		      int num,
+		      uint8_t *sched_type,
+		      uint8_t *queue_id)
+{
+	static uint8_t cmd_byte_map[DLB2_NUM_PORT_TYPES][DLB2_NUM_HW_SCHED_TYPES] = {
+		{
+			/* Load-balanced cmd bytes */
+			[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
+			[RTE_EVENT_OP_FORWARD] = DLB2_FWD_CMD_BYTE,
+			[RTE_EVENT_OP_RELEASE] = DLB2_COMP_CMD_BYTE,
+		},
+		{
+			/* Directed cmd bytes */
+			[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
+			[RTE_EVENT_OP_FORWARD] = DLB2_NEW_CMD_BYTE,
+			[RTE_EVENT_OP_RELEASE] = DLB2_NOOP_CMD_BYTE,
+		},
+	};
+	struct dlb2_enqueue_qe *qe = qm_port->qe4;
+	bool dir = qm_port->is_directed;
+	int i;
+
+	switch (num) {
+	case 4: {
+		uint16_t cmd_wt[4] = {
+		    cmd_byte_map[dir][ev[0].op] << 8 | RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[0]) << 1,
+		    cmd_byte_map[dir][ev[1].op] << 8 | RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[1]) << 1,
+		    cmd_byte_map[dir][ev[2].op] << 8 | RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[2]) << 1,
+		    cmd_byte_map[dir][ev[3].op] << 8 | RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[3]) << 1};
+		uint16_t sched_word[4] = {
+		    EV_TO_DLB2_PRIO(ev[0].priority) << 10 | sched_type[0] << 8 | queue_id[0],
+		    EV_TO_DLB2_PRIO(ev[1].priority) << 10 | sched_type[1] << 8 | queue_id[1],
+		    EV_TO_DLB2_PRIO(ev[2].priority) << 10 | sched_type[2] << 8 | queue_id[2],
+		    EV_TO_DLB2_PRIO(ev[3].priority) << 10 | sched_type[3] << 8 | queue_id[3]
+		};
+
+		dlb2_build_qes(qe, ev, cmd_wt, sched_word);
+		break;
+	}
+	case 3:
+	case 2:
+	case 1:
+		for (i = 0; i < num; i++) {
+			qe[i].cmd_byte =
+				cmd_byte_map[qm_port->is_directed][ev[i].op];
+			qe[i].sched_type = sched_type[i];
+			qe[i].data = ev[i].u64;
+			qe[i].qid = queue_id[i];
+			qe[i].priority = EV_TO_DLB2_PRIO(ev[i].priority);
+			qe[i].lock_id = ev[i].flow_id;
+			if (sched_type[i] == DLB2_SCHED_DIRECTED) {
+				struct dlb2_msg_info *info =
+					(struct dlb2_msg_info *)&qe[i].lock_id;
+
+				info->qid = queue_id[i];
+				info->sched_type = DLB2_SCHED_DIRECTED;
+				info->priority = qe[i].priority;
+			}
+			qe[i].u.event_type.major = ev[i].event_type;
+			qe[i].u.event_type.sub = ev[i].sub_event_type;
+			qe[i].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[i]);
+		}
+		break;
+	case 0:
+		break;
+	}
+}
+
 static inline int
 dlb2_event_enqueue_prep(struct dlb2_eventdev_port *ev_port,
 			struct dlb2_port *qm_port,
diff --git a/drivers/event/dlb2/dlb2_avx512.c b/drivers/event/dlb2/dlb2_avx512.c
index 4f8c490f8c..028a3cf552 100644
--- a/drivers/event/dlb2/dlb2_avx512.c
+++ b/drivers/event/dlb2/dlb2_avx512.c
@@ -1,13 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2022 Intel Corporation
  */
-
-#include <stdint.h>
-#include <stdbool.h>
-
 #include "dlb2_priv.h"
-#include "dlb2_iface.h"
-#include "dlb2_inline_fns.h"
 
 /*
  * This source file is used when the compiler on the build machine
@@ -15,262 +9,31 @@
  * executing those instructions.
  */
 
-static uint8_t cmd_byte_map[DLB2_NUM_PORT_TYPES][DLB2_NUM_HW_SCHED_TYPES] = {
-	{
-		/* Load-balanced cmd bytes */
-		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
-		[RTE_EVENT_OP_FORWARD] = DLB2_FWD_CMD_BYTE,
-		[RTE_EVENT_OP_RELEASE] = DLB2_COMP_CMD_BYTE,
-	},
-	{
-		/* Directed cmd bytes */
-		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
-		[RTE_EVENT_OP_FORWARD] = DLB2_NEW_CMD_BYTE,
-		[RTE_EVENT_OP_RELEASE] = DLB2_NOOP_CMD_BYTE,
-	},
-};
-
-void
-dlb2_event_build_hcws(struct dlb2_port *qm_port,
-		      const struct rte_event ev[],
-		      int num,
-		      uint8_t *sched_type,
-		      uint8_t *queue_id)
-{
-	struct dlb2_enqueue_qe *qe;
-	uint16_t sched_word[4];
-	__m128i sse_qe[2];
-	int i;
-
-	qe = qm_port->qe4;
-
-	sse_qe[0] = _mm_setzero_si128();
-	sse_qe[1] = _mm_setzero_si128();
-
-	switch (num) {
-	case 4:
-		/* Construct the metadata portion of two HCWs in one 128b SSE
-		 * register. HCW metadata is constructed in the SSE registers
-		 * like so:
-		 * sse_qe[0][63:0]:   qe[0]'s metadata
-		 * sse_qe[0][127:64]: qe[1]'s metadata
-		 * sse_qe[1][63:0]:   qe[2]'s metadata
-		 * sse_qe[1][127:64]: qe[3]'s metadata
-		 */
-
-		/* Convert the event operation into a command byte and store it
-		 * in the metadata:
-		 * sse_qe[0][63:56]   = cmd_byte_map[is_directed][ev[0].op]
-		 * sse_qe[0][127:120] = cmd_byte_map[is_directed][ev[1].op]
-		 * sse_qe[1][63:56]   = cmd_byte_map[is_directed][ev[2].op]
-		 * sse_qe[1][127:120] = cmd_byte_map[is_directed][ev[3].op]
-		 */
-#define DLB2_QE_CMD_BYTE 7
-		sse_qe[0] = _mm_insert_epi8(sse_qe[0],
-				cmd_byte_map[qm_port->is_directed][ev[0].op],
-				DLB2_QE_CMD_BYTE);
-		sse_qe[0] = _mm_insert_epi8(sse_qe[0],
-				cmd_byte_map[qm_port->is_directed][ev[1].op],
-				DLB2_QE_CMD_BYTE + 8);
-		sse_qe[1] = _mm_insert_epi8(sse_qe[1],
-				cmd_byte_map[qm_port->is_directed][ev[2].op],
-				DLB2_QE_CMD_BYTE);
-		sse_qe[1] = _mm_insert_epi8(sse_qe[1],
-				cmd_byte_map[qm_port->is_directed][ev[3].op],
-				DLB2_QE_CMD_BYTE + 8);
-
-		/* Store priority, scheduling type, and queue ID in the sched
-		 * word array because these values are re-used when the
-		 * destination is a directed queue.
-		 */
-		sched_word[0] = EV_TO_DLB2_PRIO(ev[0].priority) << 10 |
-				sched_type[0] << 8 |
-				queue_id[0];
-		sched_word[1] = EV_TO_DLB2_PRIO(ev[1].priority) << 10 |
-				sched_type[1] << 8 |
-				queue_id[1];
-		sched_word[2] = EV_TO_DLB2_PRIO(ev[2].priority) << 10 |
-				sched_type[2] << 8 |
-				queue_id[2];
-		sched_word[3] = EV_TO_DLB2_PRIO(ev[3].priority) << 10 |
-				sched_type[3] << 8 |
-				queue_id[3];
-
-		/* Store the event priority, scheduling type, and queue ID in
-		 * the metadata:
-		 * sse_qe[0][31:16] = sched_word[0]
-		 * sse_qe[0][95:80] = sched_word[1]
-		 * sse_qe[1][31:16] = sched_word[2]
-		 * sse_qe[1][95:80] = sched_word[3]
-		 */
-#define DLB2_QE_QID_SCHED_WORD 1
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     sched_word[0],
-					     DLB2_QE_QID_SCHED_WORD);
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     sched_word[1],
-					     DLB2_QE_QID_SCHED_WORD + 4);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     sched_word[2],
-					     DLB2_QE_QID_SCHED_WORD);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     sched_word[3],
-					     DLB2_QE_QID_SCHED_WORD + 4);
-
-		/* If the destination is a load-balanced queue, store the lock
-		 * ID. If it is a directed queue, DLB places this field in
-		 * bytes 10-11 of the received QE, so we format it accordingly:
-		 * sse_qe[0][47:32]  = dir queue ? sched_word[0] : flow_id[0]
-		 * sse_qe[0][111:96] = dir queue ? sched_word[1] : flow_id[1]
-		 * sse_qe[1][47:32]  = dir queue ? sched_word[2] : flow_id[2]
-		 * sse_qe[1][111:96] = dir queue ? sched_word[3] : flow_id[3]
-		 */
-#define DLB2_QE_LOCK_ID_WORD 2
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-				(sched_type[0] == DLB2_SCHED_DIRECTED) ?
-					sched_word[0] : ev[0].flow_id,
-				DLB2_QE_LOCK_ID_WORD);
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-				(sched_type[1] == DLB2_SCHED_DIRECTED) ?
-					sched_word[1] : ev[1].flow_id,
-				DLB2_QE_LOCK_ID_WORD + 4);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-				(sched_type[2] == DLB2_SCHED_DIRECTED) ?
-					sched_word[2] : ev[2].flow_id,
-				DLB2_QE_LOCK_ID_WORD);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-				(sched_type[3] == DLB2_SCHED_DIRECTED) ?
-					sched_word[3] : ev[3].flow_id,
-				DLB2_QE_LOCK_ID_WORD + 4);
-
-		/* Store the event type and sub event type in the metadata:
-		 * sse_qe[0][15:0]  = flow_id[0]
-		 * sse_qe[0][79:64] = flow_id[1]
-		 * sse_qe[1][15:0]  = flow_id[2]
-		 * sse_qe[1][79:64] = flow_id[3]
-		 */
-#define DLB2_QE_EV_TYPE_WORD 0
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     ev[0].sub_event_type << 4 |
-						ev[0].event_type << 12,
-					     DLB2_QE_EV_TYPE_WORD);
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     ev[1].sub_event_type << 4 |
-						ev[1].event_type << 12,
-					     DLB2_QE_EV_TYPE_WORD + 4);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     ev[2].sub_event_type << 4 |
-						ev[2].event_type << 12,
-					     DLB2_QE_EV_TYPE_WORD);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     ev[3].sub_event_type << 4 |
-						ev[3].event_type << 12,
-					     DLB2_QE_EV_TYPE_WORD + 4);
-
-		if (qm_port->use_avx512) {
-
-			/*
-			 * 1) Build avx512 QE store and build each
-			 *    QE individually as XMM register
-			 * 2) Merge the 4 XMM registers/QEs into single AVX512
-			 *    register
-			 * 3) Store single avx512 register to &qe[0] (4x QEs
-			 *    stored in 1x store)
-			 */
-
-			__m128i v_qe0 = _mm_setzero_si128();
-			uint64_t meta = _mm_extract_epi64(sse_qe[0], 0);
-			v_qe0 = _mm_insert_epi64(v_qe0, ev[0].u64, 0);
-			v_qe0 = _mm_insert_epi64(v_qe0, meta, 1);
-
-			__m128i v_qe1 = _mm_setzero_si128();
-			meta = _mm_extract_epi64(sse_qe[0], 1);
-			v_qe1 = _mm_insert_epi64(v_qe1, ev[1].u64, 0);
-			v_qe1 = _mm_insert_epi64(v_qe1, meta, 1);
-
-			__m128i v_qe2 = _mm_setzero_si128();
-			meta = _mm_extract_epi64(sse_qe[1], 0);
-			v_qe2 = _mm_insert_epi64(v_qe2, ev[2].u64, 0);
-			v_qe2 = _mm_insert_epi64(v_qe2, meta, 1);
-
-			__m128i v_qe3 = _mm_setzero_si128();
-			meta = _mm_extract_epi64(sse_qe[1], 1);
-			v_qe3 = _mm_insert_epi64(v_qe3, ev[3].u64, 0);
-			v_qe3 = _mm_insert_epi64(v_qe3, meta, 1);
-
-			/* we have 4x XMM registers, one per QE. */
-			__m512i v_all_qes = _mm512_setzero_si512();
-			v_all_qes = _mm512_inserti32x4(v_all_qes, v_qe0, 0);
-			v_all_qes = _mm512_inserti32x4(v_all_qes, v_qe1, 1);
-			v_all_qes = _mm512_inserti32x4(v_all_qes, v_qe2, 2);
-			v_all_qes = _mm512_inserti32x4(v_all_qes, v_qe3, 3);
-
-			/*
-			 * store the 4x QEs in a single register to the scratch
-			 * space of the PMD
-			 */
-			_mm512_store_si512(&qe[0], v_all_qes);
-
-		} else {
-
-			/*
-			 * Store the metadata to memory (use the double-precision
-			 * _mm_storeh_pd because there is no integer function for
-			 * storing the upper 64b):
-			 * qe[0] metadata = sse_qe[0][63:0]
-			 * qe[1] metadata = sse_qe[0][127:64]
-			 * qe[2] metadata = sse_qe[1][63:0]
-			 * qe[3] metadata = sse_qe[1][127:64]
-			 */
-			_mm_storel_epi64((__m128i *)&qe[0].u.opaque_data,
-					 sse_qe[0]);
-			_mm_storeh_pd((double *)&qe[1].u.opaque_data,
-				      (__m128d)sse_qe[0]);
-			_mm_storel_epi64((__m128i *)&qe[2].u.opaque_data,
-					 sse_qe[1]);
-			_mm_storeh_pd((double *)&qe[3].u.opaque_data,
-				      (__m128d)sse_qe[1]);
-
-			qe[0].data = ev[0].u64;
-			qe[1].data = ev[1].u64;
-			qe[2].data = ev[2].u64;
-			qe[3].data = ev[3].u64;
-		}
-
-			/* will only be set for DLB 2.5 + */
-		if (qm_port->dlb2->enable_cq_weight) {
-			qe[0].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[0]);
-			qe[1].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[1]);
-			qe[2].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[2]);
-			qe[3].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[3]);
-		}
+/* Upper 64-bits of mask to set flow-id, event type, subtype with zeroed out
+ * cmd word, QID, sched_type etc.
+ */
+#define UMASK 0xffff0100ffff0302
+/* Lower 64-bits of mask setting event data */
+#define LMASK 0xf0e0d0c0b0a0908
 
-		break;
-	case 3:
-	case 2:
-	case 1:
-		for (i = 0; i < num; i++) {
-			qe[i].cmd_byte =
-				cmd_byte_map[qm_port->is_directed][ev[i].op];
-			qe[i].sched_type = sched_type[i];
-			qe[i].data = ev[i].u64;
-			qe[i].qid = queue_id[i];
-			qe[i].priority = EV_TO_DLB2_PRIO(ev[i].priority);
-			qe[i].lock_id = ev[i].flow_id;
-			if (sched_type[i] == DLB2_SCHED_DIRECTED) {
-				struct dlb2_msg_info *info =
-					(struct dlb2_msg_info *)&qe[i].lock_id;
+#define SET_SCH_CMD(a, b) (((uint64_t)a << 48) | b << 16)
 
-				info->qid = queue_id[i];
-				info->sched_type = DLB2_SCHED_DIRECTED;
-				info->priority = qe[i].priority;
-			}
-			qe[i].u.event_type.major = ev[i].event_type;
-			qe[i].u.event_type.sub = ev[i].sub_event_type;
-			qe[i].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[i]);
-		}
-		break;
-	case 0:
-		break;
-	}
+void dlb2_build_qes_avx512(struct dlb2_enqueue_qe *qe, const struct rte_event ev[],
+			   uint16_t *cmd_weight, uint16_t *sched_word)
+{
+	/* _mm512_shuffle_epi8() shuffles within each 128-bit lane. So set the same mask for each
+	 * 128-bit lane.
+	 */
+	__m512i shuffle_mask = _mm512_set_epi64(UMASK, LMASK, UMASK, LMASK,
+						UMASK, LMASK, UMASK, LMASK);
+	__m512i sched_cmd = _mm512_set_epi64(SET_SCH_CMD(cmd_weight[3], sched_word[3]), 0,
+					     SET_SCH_CMD(cmd_weight[2], sched_word[2]), 0,
+					     SET_SCH_CMD(cmd_weight[1], sched_word[1]), 0,
+					     SET_SCH_CMD(cmd_weight[0], sched_word[0]), 0);
+	__m512i tmp = _mm512_loadu_si512((const __m512i *)ev);
+
+	tmp = _mm512_shuffle_epi8(tmp, shuffle_mask);
+	tmp = _mm512_or_si512(tmp, sched_cmd);
+
+	_mm512_storeu_si512(qe, tmp);
 }
diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 52da31ed31..d258d4d5bc 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -387,7 +387,6 @@ struct dlb2_port {
 	struct dlb2_eventdev_port *ev_port; /* back ptr */
 	bool use_scalar; /* force usage of scalar code */
 	uint16_t hw_credit_quanta;
-	bool use_avx512;
 	bool is_producer; /* True if port is of type producer */
 	uint8_t reorder_id; /* id used for reordering events coming back into the scheduler */
 	bool reorder_en;
@@ -731,11 +730,10 @@ int dlb2_parse_params(const char *params,
 		      struct dlb2_devargs *dlb2_args,
 		      uint8_t version);
 
-void dlb2_event_build_hcws(struct dlb2_port *qm_port,
-			   const struct rte_event ev[],
-			   int num,
-			   uint8_t *sched_type,
-			   uint8_t *queue_id);
+void dlb2_build_qes_sse(struct dlb2_enqueue_qe *qe, const struct rte_event ev[],
+			uint16_t *cmd_weight, uint16_t *sched_word);
+void dlb2_build_qes_avx512(struct dlb2_enqueue_qe *qe, const struct rte_event ev[],
+			   uint16_t *cmd_weight, uint16_t *sched_word);
 
 /* Extern functions */
 extern int rte_eal_parse_coremask(const char *coremask, int *cores);
diff --git a/drivers/event/dlb2/dlb2_sse.c b/drivers/event/dlb2/dlb2_sse.c
index fefd7acdb3..ee1c9bb375 100644
--- a/drivers/event/dlb2/dlb2_sse.c
+++ b/drivers/event/dlb2/dlb2_sse.c
@@ -2,231 +2,33 @@
  * Copyright(c) 2022 Intel Corporation
  */
 
-#include <stdint.h>
-#include <stdbool.h>
-
-#ifndef CC_AVX512_SUPPORT
-
 #include "dlb2_priv.h"
-#include "dlb2_iface.h"
-#include "dlb2_inline_fns.h"
-
 /*
  * This source file is only used when the compiler on the build machine
- * does not support AVX512VL.
+ * does not support AVX512.
  */
 
-static uint8_t cmd_byte_map[DLB2_NUM_PORT_TYPES][DLB2_NUM_HW_SCHED_TYPES] = {
-	{
-		/* Load-balanced cmd bytes */
-		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
-		[RTE_EVENT_OP_FORWARD] = DLB2_FWD_CMD_BYTE,
-		[RTE_EVENT_OP_RELEASE] = DLB2_COMP_CMD_BYTE,
-	},
-	{
-		/* Directed cmd bytes */
-		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
-		[RTE_EVENT_OP_FORWARD] = DLB2_NEW_CMD_BYTE,
-		[RTE_EVENT_OP_RELEASE] = DLB2_NOOP_CMD_BYTE,
-	},
-};
-
-void
-dlb2_event_build_hcws(struct dlb2_port *qm_port,
-		      const struct rte_event ev[],
-		      int num,
-		      uint8_t *sched_type,
-		      uint8_t *queue_id)
+void dlb2_build_qes_sse(struct dlb2_enqueue_qe *qe, const struct rte_event ev[],
+			uint16_t *cmd_weight, uint16_t *sched_word)
 {
-	struct dlb2_enqueue_qe *qe;
-	uint16_t sched_word[4];
-	__m128i sse_qe[2];
-	int i;
-
-	qe = qm_port->qe4;
-
-	sse_qe[0] = _mm_setzero_si128();
-	sse_qe[1] = _mm_setzero_si128();
-
-	switch (num) {
-	case 4:
-		/* Construct the metadata portion of two HCWs in one 128b SSE
-		 * register. HCW metadata is constructed in the SSE registers
-		 * like so:
-		 * sse_qe[0][63:0]:   qe[0]'s metadata
-		 * sse_qe[0][127:64]: qe[1]'s metadata
-		 * sse_qe[1][63:0]:   qe[2]'s metadata
-		 * sse_qe[1][127:64]: qe[3]'s metadata
-		 */
-
-		/* Convert the event operation into a command byte and store it
-		 * in the metadata:
-		 * sse_qe[0][63:56]   = cmd_byte_map[is_directed][ev[0].op]
-		 * sse_qe[0][127:120] = cmd_byte_map[is_directed][ev[1].op]
-		 * sse_qe[1][63:56]   = cmd_byte_map[is_directed][ev[2].op]
-		 * sse_qe[1][127:120] = cmd_byte_map[is_directed][ev[3].op]
-		 */
-#define DLB2_QE_CMD_BYTE 7
-		sse_qe[0] = _mm_insert_epi8(sse_qe[0],
-				cmd_byte_map[qm_port->is_directed][ev[0].op],
-				DLB2_QE_CMD_BYTE);
-		sse_qe[0] = _mm_insert_epi8(sse_qe[0],
-				cmd_byte_map[qm_port->is_directed][ev[1].op],
-				DLB2_QE_CMD_BYTE + 8);
-		sse_qe[1] = _mm_insert_epi8(sse_qe[1],
-				cmd_byte_map[qm_port->is_directed][ev[2].op],
-				DLB2_QE_CMD_BYTE);
-		sse_qe[1] = _mm_insert_epi8(sse_qe[1],
-				cmd_byte_map[qm_port->is_directed][ev[3].op],
-				DLB2_QE_CMD_BYTE + 8);
-
-		/* Store priority, scheduling type, and queue ID in the sched
-		 * word array because these values are re-used when the
-		 * destination is a directed queue.
-		 */
-		sched_word[0] = EV_TO_DLB2_PRIO(ev[0].priority) << 10 |
-				sched_type[0] << 8 |
-				queue_id[0];
-		sched_word[1] = EV_TO_DLB2_PRIO(ev[1].priority) << 10 |
-				sched_type[1] << 8 |
-				queue_id[1];
-		sched_word[2] = EV_TO_DLB2_PRIO(ev[2].priority) << 10 |
-				sched_type[2] << 8 |
-				queue_id[2];
-		sched_word[3] = EV_TO_DLB2_PRIO(ev[3].priority) << 10 |
-				sched_type[3] << 8 |
-				queue_id[3];
-
-		/* Store the event priority, scheduling type, and queue ID in
-		 * the metadata:
-		 * sse_qe[0][31:16] = sched_word[0]
-		 * sse_qe[0][95:80] = sched_word[1]
-		 * sse_qe[1][31:16] = sched_word[2]
-		 * sse_qe[1][95:80] = sched_word[3]
-		 */
-#define DLB2_QE_QID_SCHED_WORD 1
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     sched_word[0],
-					     DLB2_QE_QID_SCHED_WORD);
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     sched_word[1],
-					     DLB2_QE_QID_SCHED_WORD + 4);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     sched_word[2],
-					     DLB2_QE_QID_SCHED_WORD);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     sched_word[3],
-					     DLB2_QE_QID_SCHED_WORD + 4);
-
-		/* If the destination is a load-balanced queue, store the lock
-		 * ID. If it is a directed queue, DLB places this field in
-		 * bytes 10-11 of the received QE, so we format it accordingly:
-		 * sse_qe[0][47:32]  = dir queue ? sched_word[0] : flow_id[0]
-		 * sse_qe[0][111:96] = dir queue ? sched_word[1] : flow_id[1]
-		 * sse_qe[1][47:32]  = dir queue ? sched_word[2] : flow_id[2]
-		 * sse_qe[1][111:96] = dir queue ? sched_word[3] : flow_id[3]
-		 */
-#define DLB2_QE_LOCK_ID_WORD 2
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-				(sched_type[0] == DLB2_SCHED_DIRECTED) ?
-					sched_word[0] : ev[0].flow_id,
-				DLB2_QE_LOCK_ID_WORD);
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-				(sched_type[1] == DLB2_SCHED_DIRECTED) ?
-					sched_word[1] : ev[1].flow_id,
-				DLB2_QE_LOCK_ID_WORD + 4);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-				(sched_type[2] == DLB2_SCHED_DIRECTED) ?
-					sched_word[2] : ev[2].flow_id,
-				DLB2_QE_LOCK_ID_WORD);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-				(sched_type[3] == DLB2_SCHED_DIRECTED) ?
-					sched_word[3] : ev[3].flow_id,
-				DLB2_QE_LOCK_ID_WORD + 4);
-
-		/* Store the event type and sub event type in the metadata:
-		 * sse_qe[0][15:0]  = flow_id[0]
-		 * sse_qe[0][79:64] = flow_id[1]
-		 * sse_qe[1][15:0]  = flow_id[2]
-		 * sse_qe[1][79:64] = flow_id[3]
-		 */
-#define DLB2_QE_EV_TYPE_WORD 0
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     ev[0].sub_event_type << 8 |
-						ev[0].event_type,
-					     DLB2_QE_EV_TYPE_WORD);
-		sse_qe[0] = _mm_insert_epi16(sse_qe[0],
-					     ev[1].sub_event_type << 8 |
-						ev[1].event_type,
-					     DLB2_QE_EV_TYPE_WORD + 4);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     ev[2].sub_event_type << 8 |
-						ev[2].event_type,
-					     DLB2_QE_EV_TYPE_WORD);
-		sse_qe[1] = _mm_insert_epi16(sse_qe[1],
-					     ev[3].sub_event_type << 8 |
-						ev[3].event_type,
-					     DLB2_QE_EV_TYPE_WORD + 4);
-
-		/*
-		 * Store the metadata to memory (use the double-precision
-		 * _mm_storeh_pd because there is no integer function for
-		 * storing the upper 64b):
-		 * qe[0] metadata = sse_qe[0][63:0]
-		 * qe[1] metadata = sse_qe[0][127:64]
-		 * qe[2] metadata = sse_qe[1][63:0]
-		 * qe[3] metadata = sse_qe[1][127:64]
-		 */
-		_mm_storel_epi64((__m128i *)&qe[0].u.opaque_data,
-				 sse_qe[0]);
-		_mm_storeh_pd((double *)&qe[1].u.opaque_data,
-			      (__m128d)sse_qe[0]);
-		_mm_storel_epi64((__m128i *)&qe[2].u.opaque_data,
-				 sse_qe[1]);
-		_mm_storeh_pd((double *)&qe[3].u.opaque_data,
-				      (__m128d)sse_qe[1]);
-
-		qe[0].data = ev[0].u64;
-		qe[1].data = ev[1].u64;
-		qe[2].data = ev[2].u64;
-		qe[3].data = ev[3].u64;
-
-		/* will only be set for DLB 2.5 + */
-		if (qm_port->dlb2->enable_cq_weight) {
-			qe[0].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[0]);
-			qe[1].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[1]);
-			qe[2].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[2]);
-			qe[3].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[3]);
-		}
-
-		break;
-	case 3:
-	case 2:
-	case 1:
-		for (i = 0; i < num; i++) {
-			qe[i].cmd_byte =
-				cmd_byte_map[qm_port->is_directed][ev[i].op];
-			qe[i].sched_type = sched_type[i];
-			qe[i].weight = RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[i]);
-			qe[i].data = ev[i].u64;
-			qe[i].qid = queue_id[i];
-			qe[i].priority = EV_TO_DLB2_PRIO(ev[i].priority);
-			qe[i].lock_id = ev[i].flow_id;
-			if (sched_type[i] == DLB2_SCHED_DIRECTED) {
-				struct dlb2_msg_info *info =
-					(struct dlb2_msg_info *)&qe[i].lock_id;
-
-				info->qid = queue_id[i];
-				info->sched_type = DLB2_SCHED_DIRECTED;
-				info->priority = qe[i].priority;
-			}
-			qe[i].u.event_type.major = ev[i].event_type;
-			qe[i].u.event_type.sub = ev[i].sub_event_type;
-		}
-		break;
-	case 0:
-		break;
+	__m128i shuffle_mask =
+	    _mm_set_epi8(0xFF, 0xFF, /* zero out cmd word */
+			 1, 0,	     /* low 16-bits of flow id */
+			 0xFF, 0xFF, /* zero QID, sched_type etc fields to be filled later */
+			 3, 2,	     /* top of flow id, event type and subtype */
+			 15, 14, 13, 12, 11, 10, 9, 8 /* data from end of event goes at start */
+	    );
+
+	for (int i = 0; i < 4; ++i) {
+		/* event may not be 16 byte aligned. Use 16 byte unaligned load */
+		__m128i tmp = _mm_lddqu_si128((const __m128i *)&ev[i]);
+
+		tmp = _mm_shuffle_epi8(tmp, shuffle_mask);
+		/* set the cmd field */
+		tmp = _mm_insert_epi16(tmp, cmd_weight[i], 7);
+		/* insert missing 16-bits with qid, sched_type and priority */
+		tmp = _mm_insert_epi16(tmp, sched_word[i], 5);
+		/* Finally, store to qes*/
+		_mm_storeu_si128((__m128i *)&qe[i], tmp);
 	}
 }
-
-#endif /* !CC_AVX512_SUPPORT */
-- 
2.39.1

