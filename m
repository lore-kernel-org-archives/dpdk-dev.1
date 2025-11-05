Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D06CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 11:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F1F940656;
	Wed,  5 Nov 2025 12:28:20 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5B59E400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 12:28:18 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 279EA2079A
 for <dev@dpdk.org>; Wed,  5 Nov 2025 12:28:18 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 5 Nov 2025 12:28:17 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mbuf: improve mbuf comments
Date: Wed,  5 Nov 2025 11:28:10 +0000
Message-ID: <20251105112810.20838-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Nov 2025 11:28:17.0486 (UTC)
 FILETIME=[482D86E0:01DC4E47]
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

Updated the comment preceding the 'rearm_data' fields to reflect that some
ethdev drivers don't really set the rearm_data fields on RX descriptor
rearm, but rather when pulling the packet from the descriptor.
By doing this, they avoid a store operation into the mbuf when they rearm
the TX descriptor, and instead postpone it to later, where it will be
combined with other store operations into the mbuf.

Updated the comment describing what the second cache line is used for, to
reflect that there are exceptions, where some fields are set on RX too.

Updated comments describing what needs to be updated when adding new RX
and TX offload flags.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf_core.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index a9caaf4e14..6d66eab11d 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -37,8 +37,8 @@ extern "C" {
  *   added to the right of the previously defined flags i.e. they should count
  *   downwards, not upwards.
  *
- * Keep these flags synchronized with rte_get_rx_ol_flag_name() and
- * rte_get_tx_ol_flag_name().
+ * Keep these flags synchronized with rte_get_rx_ol_flag_name(), rte_get_rx_ol_flag_list(),
+ * rte_get_tx_ol_flag_name(), and rte_get_tx_ol_flag_list().
  */
 
 /**
@@ -180,12 +180,20 @@ extern "C" {
 #define RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD	(1ULL << 22)
 #define RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID	((1ULL << 21) | (1ULL << 22))
 
-/* add new RX flags here, don't forget to update RTE_MBUF_F_FIRST_FREE */
+/*
+ * Add new RX flags here.
+ * Don't forget to update RTE_MBUF_F_FIRST_FREE,
+ * rte_get_rx_ol_flag_name(), and rte_get_rx_ol_flag_list().
+ */
 
 #define RTE_MBUF_F_FIRST_FREE (1ULL << 23)
 #define RTE_MBUF_F_LAST_FREE (1ULL << 40)
 
-/* add new TX flags here, don't forget to update RTE_MBUF_F_LAST_FREE  */
+/*
+ * Add new TX flags here.
+ * Don't forget to update RTE_MBUF_F_LAST_FREE, RTE_MBUF_F_TX_OFFLOAD_MASK,
+ * rte_get_tx_ol_flag_name(), and rte_get_tx_ol_flag_list().
+ */
 
 /**
  * Outer UDP checksum offload flag. This flag is used for enabling
@@ -485,7 +493,10 @@ struct __rte_cache_aligned rte_mbuf {
 	struct rte_mbuf *next;
 #endif
 
-	/* next 8 bytes are initialised on RX descriptor rearm */
+	/*
+	 * Next 8 bytes are initialised on RX descriptor rearm,
+	 * or on RX when pulling packet from descriptor.
+	 */
 	union {
 		uint64_t rearm_data[1];
 		__extension__
@@ -517,7 +528,7 @@ struct __rte_cache_aligned rte_mbuf {
 
 	uint64_t ol_flags;        /**< Offload features. */
 
-	/* remaining 24 bytes are set on RX when pulling packet from descriptor */
+	/* Remaining 24 bytes are set on RX when pulling packet from descriptor. */
 	union {
 		/* void * type of the array elements is retained for driver compatibility. */
 		void *rx_descriptor_fields1[24 / sizeof(void *)];
@@ -603,7 +614,11 @@ struct __rte_cache_aligned rte_mbuf {
 
 	struct rte_mempool *pool; /**< Pool from which mbuf was allocated. */
 
-	/* second cache line - fields only used in slow path or on TX */
+	/*
+	 * Second cache line - fields only used in slow path or on TX.
+	 * In special cases, some of these fields are also set on RX,
+	 * most notably the 'next' field is set on RX scattered packets.
+	 */
 #if RTE_IOVA_IN_MBUF
 	/**
 	 * Next segment of scattered packet. Must be NULL in the last
-- 
2.43.0

