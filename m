Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA93C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46D8C40B8C;
	Thu,  6 Aug 2026 19:16:56 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 549D040A75
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:55 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8ff20870ac7so15999336d6.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036615; x=1786641415; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tXYyj/X3q8jKPRPAzEHBj9mvQPfOxWBxK9iOgCO7LoU=;
 b=LfQ91dJRaERdXDQ66ENMuN6icTfrnmrTlmQDEOEkjf9MNbm1UQiTzYUOlS3+3s1bXI
 TEUjKpbu2XyEue3QXeTBjiXC9rhiv95UFUR73s9DxzTRkBGjVhfExzx+NIwvEMXR8F+R
 jAM654qqK/MLU+fLx94Cb/R801lBmQPB8r31E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036615; x=1786641415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tXYyj/X3q8jKPRPAzEHBj9mvQPfOxWBxK9iOgCO7LoU=;
 b=Gh9zN4MFf/IcS50hzzd4i17+3f0NMX6EwYod/ADkfZRBbg/eq4MHI3ZOj/3SsHMyhh
 ia29sKe3tGEddOhQTA8sdtYlx+6vvrRzVL7TB81lDXppUgXCJhzU67xvp1kL4fdKqz0r
 5fdCaKsx2DiFsRL5mE2Wgvt8Q6Co1HIOx8Yy8uILzUMWGPYE9DYHV3n9T8P5Isji4IPo
 u9XKg8Vmx6LjtYwdKX9vs/Hoqg7TAF7oMsbzBb6IPzLzHd4O23iLccBjfUFpP+JNTxYc
 HbSogerR/qMgJnklL7wRCQDFFwQmkQsp9uGxdpvdy9ftEk0r+G2QmAlhNBg9ommaAD5M
 LYiA==
X-Gm-Message-State: AOJu0YwYcGe1maEXC9NAKcOzHasKiw9I9/Ik7saMH7Oimdhad6zBP0rn
 8kH4F6Z3ZZGWR/UkwsOVQYac5EGWtRo6yTeMQCN97ziI473ZuLrVtxLiUAnfxJVmH82+HKgbEFd
 /15xfMxRk2U54ZBDWT7hVO6PIGCd69SCIkDTfgBYuUR3XAL7VNW3t9iksrLQt0xNNbin6nmLfDZ
 Vs/VONwAbhKheIcE07nq9jqA5AVB0=
X-Gm-Gg: AR+sD113Vfthkp3TBl5VaLdvHKDEshXHmgmgwYughnh0lSc9ogdXe96TJXE9GcK0S49
 gaJc0xeiNBliGDiF3JiMKpa0yHi2Outo1Xr1cC65B6zbC7C7eP0bB/nUVQXcm7So05YWICL6HLt
 Xy3jdzyj+jkDN8rxKQiuEzq6IZIsGxzmKJ341skHwvXekRVNs1Cm6nQyKMaxdpgt3mfgeURMrUh
 Pl0xW8OAC4YPLp+EUv+JStsiLVeTP26uYV+LrMj0Yupy3AW9W/5O8sFd9rM6hL+vyhYZ2vPo6/M
 svFEPlrlm8VLEeWteSQeNPkmcJlOg/LYvYwuD77E5vhrH62qv2xTUeljEIf1UOrvMZq1cgVIvGs
 a4qqJ28X/YrVmmibGKgh5Jrn0UNXikvTZZPfFkEFGF3hi4I7zLjghCMbu9r8gXFcWHJQx8RDNUC
 PYJfge8ArfR4l8JkSJG1ORkq/l/upvd975FQ8Q7VHFlzJe0ybwdJoJdcYrQ2pW+hBqWMCIxgmdv
 uUIeA9GJkre/icmnYBgoz8hzXrIyFPaXWVhOg9l
X-Received: by 2002:a05:6214:248b:b0:908:23fd:813f with SMTP id
 6a1803df08f44-9088125ec39mr194264886d6.15.1786036614328; 
 Thu, 06 Aug 2026 10:16:54 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:53 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Robin Jarry <rjarry@redhat.com>, David Marchand <david.marchand@redhat.com>
Subject: [PATCH v6 7/7] lib: remove ICMP and IPv6 deprecated functions and
 macros
Date: Thu,  6 Aug 2026 13:16:36 -0400
Message-ID: <20260806171636.656181-8-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806171636.656181-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
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

From: Robin Jarry <rjarry@redhat.com>

These symbols were marked as deprecated in DPDK 24.11. Remove them
completely.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/rel_notes/release_26_11.rst |  9 ++++
 lib/fib/rte_fib6.h                     |  5 --
 lib/lpm/rte_lpm6.h                     |  4 --
 lib/net/rte_icmp.h                     |  4 --
 lib/rib/rte_rib6.h                     | 74 --------------------------
 lib/table/rte_table_lpm_ipv6.h         |  3 --
 6 files changed, 9 insertions(+), 90 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca75..c8cc86295d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,15 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* Removed deprecated symbols:
+
+  * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``
+  * lpm: ``RTE_LPM6_IPV6_ADDR_SIZE``, ``RTE_LPM6_MAX_DEPTH``
+  * net: ``RTE_IP_ICMP_ECHO_REPLY``, ``RTE_IP_ICMP_ECHO_REQUEST``
+  * rib: ``RTE_RIB6_IPV6_ADDR_SIZE``, ``get_msk_part``, ``rte_rib6_copy_addr``,
+    ``rte_rib6_is_equal``
+  * table: ``RTE_LPM_IPV6_ADDR_SIZE``
+
 
 API Changes
 -----------
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index 4527328bf0..fcbd10de15 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -17,7 +17,6 @@
 
 #include <stdint.h>
 
-#include <rte_common.h>
 #include <rte_ip6.h>
 #include <rte_rcu_qsbr.h>
 
@@ -25,10 +24,6 @@
 extern "C" {
 #endif
 
-#define RTE_FIB6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_FIB6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
-/** Maximum depth value possible for IPv6 FIB. */
-#define RTE_FIB6_MAXDEPTH (RTE_DEPRECATED(RTE_FIB6_MAXDEPTH) RTE_IPV6_MAX_DEPTH)
-
 /* Maximum length of a FIB name. */
 #define RTE_FIB6_NAMESIZE	64
 
diff --git a/lib/lpm/rte_lpm6.h b/lib/lpm/rte_lpm6.h
index 08b5618613..c5928b9d88 100644
--- a/lib/lpm/rte_lpm6.h
+++ b/lib/lpm/rte_lpm6.h
@@ -11,16 +11,12 @@
 
 #include <stdint.h>
 
-#include <rte_common.h>
 #include <rte_ip6.h>
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-
-#define RTE_LPM6_MAX_DEPTH (RTE_DEPRECATED(RTE_LPM6_MAX_DEPTH) RTE_IPV6_MAX_DEPTH)
-#define RTE_LPM6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_LPM6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
 /** Max number of characters in LPM name. */
 #define RTE_LPM6_NAMESIZE                 32
 
diff --git a/lib/net/rte_icmp.h b/lib/net/rte_icmp.h
index cca73b3733..a504c921de 100644
--- a/lib/net/rte_icmp.h
+++ b/lib/net/rte_icmp.h
@@ -51,13 +51,9 @@ struct __rte_packed_begin rte_icmp_hdr {
 
 /* ICMP packet types */
 #define RTE_ICMP_TYPE_ECHO_REPLY 0
-#define RTE_IP_ICMP_ECHO_REPLY \
-	(RTE_DEPRECATED(RTE_IP_ICMP_ECHO_REPLY) RTE_ICMP_TYPE_ECHO_REPLY)
 #define RTE_ICMP_TYPE_DEST_UNREACHABLE 3
 #define RTE_ICMP_TYPE_REDIRECT 5
 #define RTE_ICMP_TYPE_ECHO_REQUEST 8
-#define RTE_IP_ICMP_ECHO_REQUEST \
-	(RTE_DEPRECATED(RTE_IP_ICMP_ECHO_REQUEST) RTE_ICMP_TYPE_ECHO_REQUEST)
 #define RTE_ICMP_TYPE_TTL_EXCEEDED 11
 #define RTE_ICMP_TYPE_PARAM_PROBLEM 12
 #define RTE_ICMP_TYPE_TIMESTAMP_REQUEST 13
diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index d66d9e7c07..e3fb464ae6 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -15,15 +15,12 @@
  */
 
 #include <rte_memcpy.h>
-#include <rte_common.h>
 #include <rte_ip6.h>
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-#define RTE_RIB6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_RIB6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
-
 /**
  * rte_rib6_get_nxt() flags
  */
@@ -49,77 +46,6 @@ struct rte_rib6_conf {
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
index 3ea8883606..a9fbc906f3 100644
--- a/lib/table/rte_table_lpm_ipv6.h
+++ b/lib/table/rte_table_lpm_ipv6.h
@@ -39,7 +39,6 @@
 
 #include <stdint.h>
 
-#include <rte_common.h>
 #include <rte_ip6.h>
 
 #include "rte_table.h"
@@ -48,8 +47,6 @@
 extern "C" {
 #endif
 
-#define RTE_LPM_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_LPM_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
-
 /** LPM table parameters */
 struct rte_table_lpm_ipv6_params {
 	/** Table name */
-- 
2.55.0

