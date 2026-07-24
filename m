Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD39C531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 08:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19682402A7;
	Fri, 24 Jul 2026 10:49:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2234029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 10:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784882967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tpKQedSgBpqdlqhV3JzdC/QnMpyCDIg0jYerCeKp0qA=;
 b=aN+PTbGR58be88+3haMTCSi3uZQi9xCBPrknKyomyVDuPEXXup4qSlt99hIUN8JBhrsSKV
 kwZx4ykm1NTrxbiFMpUvhojbz8xqCXfulOpkd+UV++m6DGw4vp4COBOhy85thxHok+3jV9
 WW8MsK/0Qgrdo3OOCyXq5N1rPyWP7Yc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-cgNodqLyM1WFamZXhfDiFA-1; Fri,
 24 Jul 2026 04:49:24 -0400
X-MC-Unique: cgNodqLyM1WFamZXhfDiFA-1
X-Mimecast-MFC-AGG-ID: cgNodqLyM1WFamZXhfDiFA_1784882963
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9C001955DA5; Fri, 24 Jul 2026 08:49:22 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.252])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD448195605F; Fri, 24 Jul 2026 08:49:20 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH dpdk] lpm6, fib6, rib6,
 table: remove deprecated functions and macros
Date: Fri, 24 Jul 2026 10:49:17 +0200
Message-ID: <20260724084917.1045026-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XfNWoHPO2F4HQTEPaOz9Zyn6Y4O-oT-DLuCDXhDrRak_1784882963
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

These function were marked as deprecated in DPDK 24.11. Remove them
completely.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 doc/guides/rel_notes/release_26_11.rst | 11 ++++
 lib/fib/rte_fib6.h                     |  4 --
 lib/lpm/rte_lpm6.h                     |  3 --
 lib/rib/rte_rib6.h                     | 73 --------------------------
 lib/table/rte_table_lpm_ipv6.h         |  2 -
 5 files changed, 11 insertions(+), 82 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca7542..fb9cde591695 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,17 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* Deprecated functions removed:
+
+  - ``RTE_FIB6_IPV6_ADDR_SIZE``
+  - ``RTE_FIB6_MAXDEPTH``
+  - ``RTE_LPM6_IPV6_ADDR_SIZE``
+  - ``RTE_LPM6_MAX_DEPTH``
+  - ``RTE_LPM_IPV6_ADDR_SIZE``
+  - ``RTE_RIB6_IPV6_ADDR_SIZE``
+  - ``get_msk_part``
+  - ``rte_rib6_copy_addr``
+  - ``rte_rib6_is_equal``
 
 API Changes
 -----------
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index 4527328bf00d..890a155a533a 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -25,10 +25,6 @@
 extern "C" {
 #endif
 
-#define RTE_FIB6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_FIB6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
-/** Maximum depth value possible for IPv6 FIB. */
-#define RTE_FIB6_MAXDEPTH (RTE_DEPRECATED(RTE_FIB6_MAXDEPTH) RTE_IPV6_MAX_DEPTH)
-
 /* Maximum length of a FIB name. */
 #define RTE_FIB6_NAMESIZE	64
 
diff --git a/lib/lpm/rte_lpm6.h b/lib/lpm/rte_lpm6.h
index 08b561861348..f7fd10e8a338 100644
--- a/lib/lpm/rte_lpm6.h
+++ b/lib/lpm/rte_lpm6.h
@@ -18,9 +18,6 @@
 extern "C" {
 #endif
 
-
-#define RTE_LPM6_MAX_DEPTH (RTE_DEPRECATED(RTE_LPM6_MAX_DEPTH) RTE_IPV6_MAX_DEPTH)
-#define RTE_LPM6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_LPM6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
 /** Max number of characters in LPM name. */
 #define RTE_LPM6_NAMESIZE                 32
 
diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index d66d9e7c07c6..88d949e1db9a 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -22,8 +22,6 @@
 extern "C" {
 #endif
 
-#define RTE_RIB6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_RIB6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
-
 /**
  * rte_rib6_get_nxt() flags
  */
@@ -49,77 +47,6 @@ struct rte_rib6_conf {
 	int	max_nodes;
 };
 
-/**
- * Copy IPv6 address from one location to another
- *
- * @param dst
- *  pointer to the place to copy
- * @param src
- *  pointer from where to copy
- */
-static inline void rte_rib6_copy_addr(uint8_t *dst, const uint8_t *src)
-	__rte_deprecated_msg("use direct struct assignment");
-
-static inline void
-rte_rib6_copy_addr(uint8_t *dst, const uint8_t *src)
-{
-	if ((dst == NULL) || (src == NULL))
-		return;
-	rte_memcpy(dst, src, RTE_IPV6_ADDR_SIZE);
-}
-
-/**
- * Compare two IPv6 addresses
- *
- * @param ip1
- *  pointer to the first ipv6 address
- * @param ip2
- *  pointer to the second ipv6 address
- *
- * @return
- *  1 if equal
- *  0 otherwise
- */
-static inline int rte_rib6_is_equal(const uint8_t *ip1, const uint8_t *ip2)
-	__rte_deprecated_msg("use rte_ipv6_addr_eq");
-
-static inline int
-rte_rib6_is_equal(const uint8_t *ip1, const uint8_t *ip2) {
-	int i;
-
-	if ((ip1 == NULL) || (ip2 == NULL))
-		return 0;
-	for (i = 0; i < RTE_IPV6_ADDR_SIZE; i++) {
-		if (ip1[i] != ip2[i])
-			return 0;
-	}
-	return 1;
-}
-
-/**
- * Get 8-bit part of 128-bit IPv6 mask
- *
- * @param depth
- *  ipv6 prefix length
- * @param byte
- *  position of a 8-bit chunk in the 128-bit mask
- *
- * @return
- *  8-bit chunk of the 128-bit IPv6 mask
- */
-static inline uint8_t get_msk_part(uint8_t depth, int byte) __rte_deprecated;
-
-static inline uint8_t
-get_msk_part(uint8_t depth, int byte) {
-	uint8_t part;
-
-	byte &= 0xf;
-	depth = RTE_MIN(depth, 128);
-	part = RTE_MAX((int16_t)depth - (byte * 8), 0);
-	part = (part > 8) ? 8 : part;
-	return (uint16_t)(~UINT8_MAX) >> part;
-}
-
 /**
  * Lookup an IP into the RIB structure
  *
diff --git a/lib/table/rte_table_lpm_ipv6.h b/lib/table/rte_table_lpm_ipv6.h
index 3ea888360635..8687e2612480 100644
--- a/lib/table/rte_table_lpm_ipv6.h
+++ b/lib/table/rte_table_lpm_ipv6.h
@@ -48,8 +48,6 @@
 extern "C" {
 #endif
 
-#define RTE_LPM_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_LPM_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
-
 /** LPM table parameters */
 struct rte_table_lpm_ipv6_params {
 	/** Table name */
-- 
2.55.0

