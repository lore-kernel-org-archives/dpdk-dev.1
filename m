Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA0D6101A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 14:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F422402C1;
	Thu, 29 Jan 2026 15:48:02 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 6CA56402BA
 for <dev@dpdk.org>; Thu, 29 Jan 2026 15:48:01 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id B43231D00109;
 Thu, 29 Jan 2026 09:47:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 29 Jan 2026 09:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1769698079; x=1769784479; bh=a/eWjnS+eOKJ+rwsy/2FC
 Oi4svEKmYs28jFUC2d/uKI=; b=FXDLZYSBeb9YSrebdeFO3sRZpLToK7UX/x0wa
 DylVC6QU17dKd4ImXYofThXfqIPMOYN9nPvggsjGXGzHV3MqHucgswtBA4LbDEjP
 0sz0VKD/q+XQcSGaENFZ3QbsrECFxCK3qzkOpqLhkSc17YwOoLCWSFvU+cNL8BJw
 WYW/8HHoAGAw2pbKeQVK/oqktIf5hgpXCtPU2yLCZ3G8ybNmEtH6l2/be6HQ6r8e
 6qkhM8kcouIrgZKsRn5obf030aaVAWJH9JoWoKC83fjh1sNXKTXMSXj/QOCcamFb
 Q0E/hhlEsYfsj3zI8UP/sOpVVrDw+pwvBOi4FHXrZHDOra7Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1769698079; x=1769784479; bh=a/eWjnS+eOKJ+rwsy/2FCOi4svEKmYs28jF
 UC2d/uKI=; b=jqcxQ5UG7IAzFSfvFfBHGp6iPjW83YaD0mcmUbEw48EzEF/nVy9
 NHVyrLviomq4R3F+kXMXgzEx9vxu5U6xMqU3VbzNM/ssBFdPZyWcn0WS7RjdV8J4
 JTo2ZeD8PprBE7hQKagPn8vr6ZjTCwHCvyUuZWdOPPwJWyt7s18wEUgqKcg+GFmE
 tCnS+qvf1DdWhy2chchaTGbUe/+2X2ND3KMN9H97n0fDAv4bR+NYXLTLJbmPmLcD
 7xaJUdzTdU6+RIHzIIZ1TuBuNKXR+s5Qqe8j5S8UaGu5XxWd9jpNC+o44f0ITqh5
 DZZtTpA08M7Ezjqpu+EFn45Tf57nt1as9ZA==
X-ME-Sender: <xms:HnN7adkqS7vCts7u-9xcezlXhwS_kwkDefCJvt70xgFZvCcQpvs_rg>
 <xme:HnN7aZyyxDF0DYV1NeQHDonf6UmK95Dxlh7LnqFLuWmJfa2BVypnCXDbBqY_kaV98
 HoR7AK91CKcH18KtY8szH7QrrlFnKXMGwRGLe6A8LoloHFtl8Pn_QQ>
X-ME-Received: <xmr:HnN7aT86tbdq1L_oucsAx9FpJMIftycBrnTdApIkOCF7oONVgG82jN7tXQVmlaYuP4N-rc_z11y6_yJ8OqF31Ng5FHnvgCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeigeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehn
 ihgtohhlrghsrdgthhgruhhtrhhusehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrth
 htihgrshdrrhhonhhnsghlohhmsegvrhhitghsshhonhdrtghomhdprhgtphhtthhopeho
 rhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthh
 gvnhhkohesohhkthgvthhlrggsshdrrhhupdhrtghpthhtohepjhgvrhhinhhjsehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtoheprghmihhtphhrrghkrghshhhssehmrghrvhgvlh
 hlrdgtohhmpdhrtghpthhtohepvhhlrgguihhmihhrrdhmvgguvhgvughkihhnsehinhht
 vghlrdgtohhm
X-ME-Proxy: <xmx:HnN7acAwFAx9-7UYiCsqx7sQkL_Oti4nI9wRpWni-jNZlORV161-fw>
 <xmx:HnN7aSrkWnMtZXO7oybyeIavd7mqg7GUFyvQPTZsLy_lHef_lrk0NA>
 <xmx:HnN7acmgrdK4jYrAml608wHS68sKtCXR4CzjPmDSOMDZGGUEcgqFdA>
 <xmx:HnN7adWnj_wt_c7GQfxxFmlinszKYo4MZ9M1vrR3C8vi-5bHZi1muw>
 <xmx:H3N7af7BZauSjFZ4H2v3SkwSdFvpFJRk-R20TqFmlT3XU7c3B-OKJ8qv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 09:47:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Chengwen Feng <fengchengwen@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Ori Kam <orika@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jerin Jacob <jerinj@marvell.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH] lib: remove extra characters ending comment blocks
Date: Thu, 29 Jan 2026 15:47:48 +0100
Message-ID: <20260129144749.3637111-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
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

At the end of a comment, no need for an extra line.

This pattern was fixed with the following command:
git ls lib | xargs sed -i '/^ *\* *$/{N;/ *\*\/ *$/D;}'

A comment should always be terminated with */

Extra asterisks were found with this command:
git grep '\* *\*/' lib

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/argparse/rte_argparse.h              |  1 -
 lib/bbdev/rte_bbdev.h                    |  3 ---
 lib/eal/include/rte_bitset.h             |  1 -
 lib/ethdev/rte_flow.h                    |  1 -
 lib/eventdev/eventdev_pmd.h              |  4 ----
 lib/eventdev/rte_event_dma_adapter.h     |  1 -
 lib/eventdev/rte_eventdev.h              |  3 ---
 lib/fib/rte_fib.h                        |  2 +-
 lib/graph/rte_graph_feature_arc_worker.h |  1 -
 lib/hash/rte_hash_crc.c                  |  1 -
 lib/mempool/rte_mempool.h                |  5 ++---
 lib/node/rte_node_udp4_input_api.h       |  1 -
 lib/ptr_compress/rte_ptr_compress.h      | 16 ++++++++--------
 13 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 06df5b2b87..f184c9c37d 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -24,7 +24,6 @@
  * There are two ways to parse arguments:
  * 1) AutoSave: for which known value types, the way can be used.
  * 2) Callback: will invoke user callback to parse.
- *
  */
 
 #include <stdbool.h>
diff --git a/lib/bbdev/rte_bbdev.h b/lib/bbdev/rte_bbdev.h
index 4912bc7b6f..36dabf8fa6 100644
--- a/lib/bbdev/rte_bbdev.h
+++ b/lib/bbdev/rte_bbdev.h
@@ -1117,7 +1117,6 @@ rte_bbdev_enqueue_status_str(enum rte_bbdev_enqueue_status status);
  *   - 0 on success
  *   - ENOTSUP if interrupts are not supported by the identified device
  *   - negative value on failure - as returned from PMD
- *
  */
 __rte_experimental
 int
@@ -1141,7 +1140,6 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_index, FILE *file);
  *
  * @returns
  *   String describing the provided operation.
- *
  */
 __rte_experimental
 char *
@@ -1155,7 +1153,6 @@ rte_bbdev_ops_param_string(void *op, enum rte_bbdev_op_type op_type, char *str,
  *
  *  @param op_type
  *    Operation type enum.
- *
  */
 __rte_experimental
 void
diff --git a/lib/eal/include/rte_bitset.h b/lib/eal/include/rte_bitset.h
index 116121eec4..4e6d44874a 100644
--- a/lib/eal/include/rte_bitset.h
+++ b/lib/eal/include/rte_bitset.h
@@ -27,7 +27,6 @@
  * All functions modifying a bitset may overwrite any unused bits of
  * the last word. Such unused bits are ignored by all functions reading
  * bits.
- *
  */
 
 #include <limits.h>
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 3d2ccdeb92..ba3bcc89a3 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4274,7 +4274,6 @@ rte_flow_dynf_metadata_set(struct rte_mbuf *m, uint32_t v)
  * RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX
  *
  * Redirects packets to a particular index in a flow table.
- *
  */
 struct rte_flow_action_jump_to_table_index {
 	struct rte_flow_template_table *table;
diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index dda8ad82c9..d13cc433a7 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -1427,7 +1427,6 @@ typedef int (*eventdev_eth_tx_adapter_queue_stop)
  *   - 0: Success, driver provides event adapter capabilities for the
  *	dmadev.
  *   - <0: Error code returned by the driver function.
- *
  */
 typedef int (*eventdev_dma_adapter_caps_get_t)(const struct rte_eventdev *dev,
 					       const int16_t dma_dev_id, uint32_t *caps);
@@ -1454,7 +1453,6 @@ typedef int (*eventdev_dma_adapter_caps_get_t)(const struct rte_eventdev *dev,
  * @return
  *   - 0: Success, dmadev vchan added successfully.
  *   - <0: Error code returned by the driver function.
- *
  */
 typedef int (*eventdev_dma_adapter_vchan_add_t)(const struct rte_eventdev *dev,
 						const int16_t dma_dev_id,
@@ -1478,7 +1476,6 @@ typedef int (*eventdev_dma_adapter_vchan_add_t)(const struct rte_eventdev *dev,
  * @return
  *   - 0: Success, dmadev vchan deleted successfully.
  *   - <0: Error code returned by the driver function.
- *
  */
 typedef int (*eventdev_dma_adapter_vchan_del_t)(const struct rte_eventdev *dev,
 						const int16_t dma_dev_id,
@@ -1570,7 +1567,6 @@ typedef int (*eventdev_dma_adapter_stats_reset)(const struct rte_eventdev *dev,
  *
  * @return
  *   Return 0 on success.
- *
  */
 typedef int (*eventdev_vector_adapter_caps_get_t)(const struct rte_eventdev *dev, uint32_t *caps,
 						  const struct event_vector_adapter_ops **ops);
diff --git a/lib/eventdev/rte_event_dma_adapter.h b/lib/eventdev/rte_event_dma_adapter.h
index b442de0034..9e1d0bf40c 100644
--- a/lib/eventdev/rte_event_dma_adapter.h
+++ b/lib/eventdev/rte_event_dma_adapter.h
@@ -138,7 +138,6 @@
  * rte_event_dma_adapter_vchan_del() APIs. If HW supports the capability
  * RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND, event information must be passed to the
  * add API.
- *
  */
 
 #include <stdint.h>
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 88c52a5520..4e13a38d89 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -1951,7 +1951,6 @@ rte_event_crypto_adapter_caps_get(uint8_t dev_id, uint8_t cdev_id,
  *   - 0: Success, driver provides event adapter capabilities for the
  *     dmadev device.
  *   - <0: Error code returned by the driver function.
- *
  */
 __rte_experimental
 int
@@ -2209,7 +2208,6 @@ rte_event_port_unlink(uint8_t dev_id, uint8_t port_id,
  * (EDQUOT) Quota exceeded(Application tried to link the queue configured with
  *  RTE_EVENT_QUEUE_CFG_SINGLE_LINK to more than one event ports)
  * (EINVAL) Invalid parameter
- *
  */
 __rte_experimental
 int
@@ -2262,7 +2260,6 @@ rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t
  * If return value is less than *nb_unlinks* then implementation shall update
  * the rte_errno accordingly, Possible rte_errno values are
  * (EINVAL) Invalid parameter
- *
  */
 __rte_experimental
 int
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index 874bf1688b..b16a653535 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -109,7 +109,7 @@ struct rte_fib_conf {
 			uint32_t	num_tbl8;
 		} dir24_8;
 	};
-	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* **/
+	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* */
 };
 
 /** FIB RCU QSBR configuration structure. */
diff --git a/lib/graph/rte_graph_feature_arc_worker.h b/lib/graph/rte_graph_feature_arc_worker.h
index 680b2ae8b8..93b87a1371 100644
--- a/lib/graph/rte_graph_feature_arc_worker.h
+++ b/lib/graph/rte_graph_feature_arc_worker.h
@@ -573,7 +573,6 @@ rte_graph_feature_data_first_feature_get(struct rte_graph_feature_arc *arc,
  * @return
  *  0: If no feature enabled
  *  Non-Zero: Bitmask of features enabled.
- *
  */
 __rte_experimental
 static __rte_always_inline uint64_t
diff --git a/lib/hash/rte_hash_crc.c b/lib/hash/rte_hash_crc.c
index 9fe90d6425..523be0bf92 100644
--- a/lib/hash/rte_hash_crc.c
+++ b/lib/hash/rte_hash_crc.c
@@ -26,7 +26,6 @@ uint8_t rte_hash_crc32_alg = CRC32_SW;
  *   - (CRC32_SSE42) Use SSE4.2 intrinsics if available
  *   - (CRC32_SSE42_x64) Use 64-bit SSE4.2 intrinsic if available (default x86)
  *   - (CRC32_ARM64) Use ARMv8 CRC intrinsic if available (default ARMv8)
- *
  */
 RTE_EXPORT_SYMBOL(rte_hash_crc_set_alg)
 void
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index aedc100964..1144dca58a 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1955,7 +1955,7 @@ struct rte_mempool_mem_range_info {
  *   and whether these addresses are contiguous.
  * @return
  *   0 on success, -EINVAL if mempool is not valid or mem_range is NULL.
- **/
+ */
 __rte_experimental
 int
 rte_mempool_get_mem_range(const struct rte_mempool *mp,
@@ -1971,8 +1971,7 @@ rte_mempool_get_mem_range(const struct rte_mempool *mp,
  *   Pointer to a mempool.
  * @return
  *   Object alignment if mp is valid. 0 if mp is NULL.
- *
- **/
+ */
 __rte_experimental
 size_t
 rte_mempool_get_obj_alignment(const struct rte_mempool *mp);
diff --git a/lib/node/rte_node_udp4_input_api.h b/lib/node/rte_node_udp4_input_api.h
index 694660bd6a..c52dded337 100644
--- a/lib/node/rte_node_udp4_input_api.h
+++ b/lib/node/rte_node_udp4_input_api.h
@@ -14,7 +14,6 @@
  *
  * This API allows to control path functions of udp4_* nodes
  * like udp4_input.
- *
  */
 #include <rte_common.h>
 #include <rte_compat.h>
diff --git a/lib/ptr_compress/rte_ptr_compress.h b/lib/ptr_compress/rte_ptr_compress.h
index 231d96c518..908aefce14 100644
--- a/lib/ptr_compress/rte_ptr_compress.h
+++ b/lib/ptr_compress/rte_ptr_compress.h
@@ -52,7 +52,7 @@ extern "C" {
  *   Length of the memory region the pointers are constrained to.
  * @return
  *   Number of bits required to store a value.
- **/
+ */
 #define RTE_PTR_COMPRESS_BITS_NEEDED_FOR_POINTER_WITHIN_RANGE(mem_length) \
 	(((uint64_t)mem_length) < 2 ? 1 : \
 		(sizeof(uint64_t) * CHAR_BIT - \
@@ -66,7 +66,7 @@ extern "C" {
  *   Memory alignment.
  * @return
  *   Size of shift allowed without dropping any information from the pointer.
- **/
+ */
 #define RTE_PTR_COMPRESS_BIT_SHIFT_FROM_ALIGNMENT(alignment) \
 	((alignment) == 0 ? 0 : rte_ctz64((uint64_t)alignment))
 
@@ -81,7 +81,7 @@ extern "C" {
  *   The alignment of objects pointed to.
  * @return
  *   1 if function can be used, 0 otherwise.
- **/
+ */
 #define RTE_PTR_COMPRESS_CAN_COMPRESS_16_SHIFT(mem_length, obj_alignment) \
 	((RTE_PTR_COMPRESS_BITS_NEEDED_FOR_POINTER_WITHIN_RANGE(mem_length) - \
 	RTE_PTR_COMPRESS_BIT_SHIFT_FROM_ALIGNMENT(obj_alignment)) <= 16 ? 1 : 0)
@@ -97,7 +97,7 @@ extern "C" {
  *   The alignment of objects pointed to.
  * @return
  *   1 if function can be used, 0 otherwise.
- **/
+ */
 #define RTE_PTR_COMPRESS_CAN_COMPRESS_32_SHIFT(mem_length, obj_alignment) \
 	((RTE_PTR_COMPRESS_BITS_NEEDED_FOR_POINTER_WITHIN_RANGE(mem_length) - \
 	RTE_PTR_COMPRESS_BIT_SHIFT_FROM_ALIGNMENT(obj_alignment)) <= 32 ? 1 : 0)
@@ -124,7 +124,7 @@ extern "C" {
  *   Byte alignment of memory pointed to by the pointers allows for
  *   bits to be dropped from the offset and hence widen the memory region that
  *   can be covered. This controls how many bits are right shifted.
- **/
+ */
 static __rte_always_inline void
 rte_ptr_compress_32_shift(void *ptr_base, void * const *src_table,
 		uint32_t *dest_table, size_t n, uint8_t bit_shift)
@@ -185,7 +185,7 @@ rte_ptr_compress_32_shift(void *ptr_base, void * const *src_table,
  *   bits to be dropped from the offset and hence widen the memory region that
  *   can be covered. This controls how many bits are left shifted when pointers
  *   are recovered from the offsets.
- **/
+ */
 static __rte_always_inline void
 rte_ptr_decompress_32_shift(void *ptr_base, uint32_t const *src_table,
 		void **dest_table, size_t n, uint8_t bit_shift)
@@ -249,7 +249,7 @@ rte_ptr_decompress_32_shift(void *ptr_base, uint32_t const *src_table,
  *   Byte alignment of memory pointed to by the pointers allows for
  *   bits to be dropped from the offset and hence widen the memory region that
  *   can be covered. This controls how many bits are right shifted.
- **/
+ */
 static __rte_always_inline void
 rte_ptr_compress_16_shift(void *ptr_base, void * const *src_table,
 		uint16_t *dest_table, size_t n, uint8_t bit_shift)
@@ -293,7 +293,7 @@ rte_ptr_compress_16_shift(void *ptr_base, void * const *src_table,
  *   bits to be dropped from the offset and hence widen the memory region that
  *   can be covered. This controls how many bits are left shifted when pointers
  *   are recovered from the offsets.
- **/
+ */
 static __rte_always_inline void
 rte_ptr_decompress_16_shift(void *ptr_base, uint16_t const *src_table,
 		void **dest_table, size_t n, uint8_t bit_shift)
-- 
2.52.0

