Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4054BD49C92
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 10:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3451840274;
	Fri, 30 Jan 2026 11:46:28 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F2D0440150
 for <dev@dpdk.org>; Fri, 30 Jan 2026 11:46:26 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 253982081A
 for <dev@dpdk.org>; Fri, 30 Jan 2026 11:46:26 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 30 Jan 2026 11:46:24 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 1/2] net: ethernet address comparison optimizations
Date: Fri, 30 Jan 2026 10:46:16 +0000
Message-ID: <20260130104617.535413-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jan 2026 10:46:24.0281 (UTC)
 FILETIME=[ADB76090:01DC91D5]
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

For CPU architectures without strict alignment requirements, operations on
6-byte Ethernet addresses using three 2-byte operations were replaced by a
4-byte and a 2-byte operation, i.e. two operations instead of three.

Comparison functions are pure, so added __rte_pure.

Removed superfluous parentheses. (No functional change.)

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/net/rte_ether.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
index c9a0b536c3..5552d3c1f6 100644
--- a/lib/net/rte_ether.h
+++ b/lib/net/rte_ether.h
@@ -99,13 +99,19 @@ static_assert(alignof(struct rte_ether_addr) == 2,
  *  True  (1) if the given two ethernet address are the same;
  *  False (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_same_ether_addr(const struct rte_ether_addr *ea1,
 				     const struct rte_ether_addr *ea2)
 {
+#if !defined(RTE_ARCH_STRICT_ALIGN)
+	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const unaligned_uint32_t *)ea2)[0]) |
+			(((const uint16_t *)ea1)[2] ^ ((const uint16_t *)ea2)[2])) == 0;
+#else
 	const uint16_t *w1 = (const uint16_t *)ea1;
 	const uint16_t *w2 = (const uint16_t *)ea2;
 
 	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^ w2[2])) == 0;
+#endif
 }
 
 /**
@@ -118,11 +124,16 @@ static inline int rte_is_same_ether_addr(const struct rte_ether_addr *ea1,
  *   True  (1) if the given ethernet address is filled with zeros;
  *   false (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_zero_ether_addr(const struct rte_ether_addr *ea)
 {
+#if !defined(RTE_ARCH_STRICT_ALIGN)
+	return (((const unaligned_uint32_t *)ea)[0] | ((const uint16_t *)ea)[2]) == 0;
+#else
 	const uint16_t *w = (const uint16_t *)ea;
 
 	return (w[0] | w[1] | w[2]) == 0;
+#endif
 }
 
 /**
@@ -135,6 +146,7 @@ static inline int rte_is_zero_ether_addr(const struct rte_ether_addr *ea)
  *   True  (1) if the given ethernet address is a unicast address;
  *   false (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_unicast_ether_addr(const struct rte_ether_addr *ea)
 {
 	return (ea->addr_bytes[0] & RTE_ETHER_GROUP_ADDR) == 0;
@@ -150,6 +162,7 @@ static inline int rte_is_unicast_ether_addr(const struct rte_ether_addr *ea)
  *   True  (1) if the given ethernet address is a multicast address;
  *   false (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_multicast_ether_addr(const struct rte_ether_addr *ea)
 {
 	return ea->addr_bytes[0] & RTE_ETHER_GROUP_ADDR;
@@ -165,6 +178,7 @@ static inline int rte_is_multicast_ether_addr(const struct rte_ether_addr *ea)
  *   True  (1) if the given ethernet address is a broadcast address;
  *   false (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_broadcast_ether_addr(const struct rte_ether_addr *ea)
 {
 	const uint16_t *w = (const uint16_t *)ea;
@@ -182,6 +196,7 @@ static inline int rte_is_broadcast_ether_addr(const struct rte_ether_addr *ea)
  *   True  (1) if the given ethernet address is a universally assigned address;
  *   false (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_universal_ether_addr(const struct rte_ether_addr *ea)
 {
 	return (ea->addr_bytes[0] & RTE_ETHER_LOCAL_ADMIN_ADDR) == 0;
@@ -197,6 +212,7 @@ static inline int rte_is_universal_ether_addr(const struct rte_ether_addr *ea)
  *   True  (1) if the given ethernet address is a locally assigned address;
  *   false (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_local_admin_ether_addr(const struct rte_ether_addr *ea)
 {
 	return (ea->addr_bytes[0] & RTE_ETHER_LOCAL_ADMIN_ADDR) != 0;
@@ -213,9 +229,10 @@ static inline int rte_is_local_admin_ether_addr(const struct rte_ether_addr *ea)
  *   True  (1) if the given ethernet address is valid;
  *   false (0) otherwise.
  */
+__rte_pure
 static inline int rte_is_valid_assigned_ether_addr(const struct rte_ether_addr *ea)
 {
-	return rte_is_unicast_ether_addr(ea) && (!rte_is_zero_ether_addr(ea));
+	return rte_is_unicast_ether_addr(ea) && !rte_is_zero_ether_addr(ea);
 }
 
 /**
-- 
2.43.0

