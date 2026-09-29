Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA4CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A44840E19;
	Tue, 29 Sep 2026 09:36:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D8BDC4013F;
 Tue, 29 Sep 2026 09:36:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A5F15201FB;
 Tue, 29 Sep 2026 09:36:19 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 29 Sep 2026 09:36:19 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org, Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] net: revert add IPv6 traffic class and flow label fields
Date: Tue, 29 Sep 2026 07:36:01 +0000
Message-ID: <20260929073601.2971197-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922163640.1144749-1-mb@smartsharesystems.com>
References: <20260922163640.1144749-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Sep 2026 07:36:19.0236 (UTC)
 FILETIME=[37BF1E40:01DD4FE5]
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

The IPv6 header bitfields "version", "ds", "ecn", and "flow_label"
are not organized correctly on little endian architectures.
On little endian, a 32-bit bitfield is allocated from the least
significant bit of the host order word, but "vtc_flow" is stored in
network order. All four fields therefore read and write the wrong
bits. For example, setting "version" to 6 writes 0x60 into the last
byte of the word.

"ds" and "flow_label" are not contiguous in memory on little endian,
so no reordering of bitfields can express them.

Reverted the patch introducing these bitfields.

PS: There is a GCC attribute to fix this, but nothing similar is
offered by Clang or MSVC:
__attribute__((scalar_storage_order("big-endian")))

Bugzilla ID: 1679
Fixes: cba27998dc81 ("net: add IPv6 traffic class and flow label fields")
Cc: stable@dpdk.org

Reported-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2: Updated commit message and release notes. (AI advanced model)
---
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 lib/net/rte_ip6.h                      | 18 +-----------------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..52ccc8f787 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,11 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+  * net: Removed ``version``, ``ds``, ``ecn`` and ``flow_label``
+    bitfields from ``struct rte_ipv6_hdr``. They accessed the wrong
+    bits on little endian. Use ``vtc_flow`` with the
+    ``RTE_IPV6_HDR_*_MASK`` and ``RTE_IPV6_HDR_*_SHIFT`` macros.
+
 
 API Changes
 -----------
diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
index d1abf1f5d5..25be328955 100644
--- a/lib/net/rte_ip6.h
+++ b/lib/net/rte_ip6.h
@@ -467,23 +467,7 @@ rte_ether_mcast_from_ipv6(struct rte_ether_addr *mac, const struct rte_ipv6_addr
  * IPv6 Header
  */
 struct __rte_aligned(2) __rte_packed_begin rte_ipv6_hdr {
-	union {
-		rte_be32_t vtc_flow;        /**< IP version, traffic class & flow label. */
-		__extension__
-		struct {
-#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
-			uint32_t flow_label:20; /**< Flow label */
-			uint32_t ecn:2;         /**< ECN */
-			uint32_t ds:6;          /**< Differentiated services */
-			uint32_t version:4;     /**< Version */
-#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
-			uint32_t version:4;     /**< Version */
-			uint32_t ds:6;          /**< Differentiated services */
-			uint32_t ecn:2;         /**< ECN */
-			uint32_t flow_label:20; /**< Flow label */
-#endif
-		};
-	};
+	rte_be32_t vtc_flow;	/**< IP version, traffic class & flow label. */
 	rte_be16_t payload_len;	/**< IP payload size, including ext. headers */
 	uint8_t  proto;		/**< Protocol, next header. */
 	uint8_t  hop_limits;	/**< Hop limits. */
-- 
2.43.0

