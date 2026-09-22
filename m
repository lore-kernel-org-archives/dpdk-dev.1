Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A76C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 16:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D3F42D26;
	Tue, 22 Sep 2026 18:37:22 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E79A14278B;
 Tue, 22 Sep 2026 18:37:20 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B10A5206D1;
 Tue, 22 Sep 2026 18:37:20 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 22 Sep 2026 18:37:18 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH] net: revert add IPv6 traffic class and flow label fields
Date: Tue, 22 Sep 2026 16:36:40 +0000
Message-ID: <20260922163640.1144749-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Sep 2026 16:37:18.0908 (UTC)
 FILETIME=[A253BFC0:01DD4AB0]
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

Reverted the patch introducing them.

The core problem is little endian's wrapping of the "ds" field in the
IPv6 header when the field crosses a byte border.

Let's consider a simplified struct for illustration:

struct example {
	union {
		rte_be32_t vtc_flow;
		struct {
			uint32_t version:4;
			uint32_t ds:6;
			uint32_t after:22;
			uint32_t after:22;
			uint32_t ds:6;
			uint32_t version:4;
		};
	};
};

struct example e;
e.vtc_flow = 0x00000000;
e.ds = 0x3F; // binary: 111111

With big endian:
Value of e: 0000 111111 0000000000000000000000 = 0F C0 00 00
Memory at e's location: 0F C0 00 00
As expected!

With little endian:
Memory at e's location: 00 00 C0 0F
The reason being that the bytes are filled with bits starting with the
LSB, so when crossing a byte border, the "ds" field doesn't continue at
the following bits, i.e. the MSB of the next byte, but at the four LSB
of the next byte.

This wrapping cannot even be fixed by having separate, dedicated structs
for each field (with each their own "before" and "after" filler fields)
in the vtc_flow union.

There is a GCC attribute to fix this, but nothing similar is offered by
Clang or MSVC:
__attribute__((scalar_storage_order("big-endian")))

Bugzilla ID: 1679
Fixes: cba27998dc81 ("net: add IPv6 traffic class and flow label fields")
Cc: stable@dpdk.org

Reported-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 lib/net/rte_ip6.h                      | 18 +-----------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..6b412ffaa6 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,9 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* Removed defect bitfields in IPv6 header (``struct rte_ipv6_hdr``):
+  ``version``, ``ds``, ``ecn``, ``flow_label``
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

