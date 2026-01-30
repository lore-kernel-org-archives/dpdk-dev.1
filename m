Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D1D49C92
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 10:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C6A2402D8;
	Fri, 30 Jan 2026 11:46:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 33AC1402D0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 11:46:29 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0C4872081A
 for <dev@dpdk.org>; Fri, 30 Jan 2026 11:46:29 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 30 Jan 2026 11:46:27 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 2/2] [RFC] net: introduce fast ethernet address comparison
 function
Date: Fri, 30 Jan 2026 10:46:17 +0000
Message-ID: <20260130104617.535413-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130104617.535413-1-mb@smartsharesystems.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jan 2026 10:46:27.0859 (UTC)
 FILETIME=[AFD95630:01DC91D5]
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

Added a fast ethernet address comparison function for 64-bit CPU
architectures without strict alignment requirements, loading the ethernet
addresses as 64-bit words and comparing the relevant 6 bytes.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/net/rte_ether.h | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
index 5552d3c1f6..1b640d81c2 100644
--- a/lib/net/rte_ether.h
+++ b/lib/net/rte_ether.h
@@ -114,6 +114,52 @@ static inline int rte_is_same_ether_addr(const struct rte_ether_addr *ea1,
 #endif
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Check if two Ethernet addresses are the same, performance optimized.
+ *
+ * @warning
+ * Intentional buffer overrun:
+ * The Ethernet addresses are loaded as 64-bit integers, i.e.
+ * two bytes past the memory holding the Ethernet addresses are loaded.
+ * The caller must ensure that this does not cause problems.
+ * If an Ethernet address 'ea' is a field in a structure 'S', it can be verified as follows:
+ * \code{.c}
+ *   static_assert(sizeof(struct S) >= offsetof(struct S, ea) + sizeof(uint64_t));
+ * \endcode
+ *
+ * @param ea1
+ *   A pointer to the first ether_addr structure containing the Ethernet address.
+ * @param ea2
+ *   A pointer to the second ether_addr structure containing the Ethernet address.
+ *
+ * @return
+ *   - true if the given two Ethernet addresses are the same;
+ *   - false otherwise.
+ */
+__rte_experimental
+__rte_pure
+static inline bool
+rte_is_same_ether_addr_fast(const struct rte_ether_addr *ea1,
+		const struct rte_ether_addr *ea2)
+{
+#if defined(RTE_ARCH_64) && !defined(RTE_ARCH_STRICT_ALIGN)
+	const unaligned_uint64_t * const a1 = (const unaligned_uint64_t *)ea1;
+	const unaligned_uint64_t * const a2 = (const unaligned_uint64_t *)ea2;
+#if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	return (*a1 ^ *a2) >> 16 == 0;
+#elif RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+	return (*a1 ^ *a2) << 16 == 0;
+#else
+#error "Unknown byte order."
+#endif /* RTE_BYTE_ORDER */
+#else
+	return rte_is_same_ether_addr(ea1, ea2);
+#endif
+}
+
 /**
  * Check if an Ethernet address is filled with zeros.
  *
-- 
2.43.0

