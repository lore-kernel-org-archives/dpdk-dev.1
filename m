Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA8606A320
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Nov 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AmrfLnVS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04802402EB;
	Sat, 21 Nov 2026 17:53:19 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 85DC1400D7
 for <dev@dpdk.org>; Sat, 21 Nov 2026 17:53:16 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3ada4c06b7bso1063476a91.2
 for <dev@dpdk.org>; Sat, 21 Nov 2026 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795279995;
 x=1795884795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=voqgQX4qjq12TP77ZeFhlihrSRxx1qwLfc6i5Bd6qBI=;
 b=AmrfLnVSdX5UfhdakFHdrOU/GBOtsOTQ+itK84QmKl9lWhy+afSmhTV/cUsQMMuhx5
 GmTeLfbtXOXbpbX9/GfQYBaD/id1fa6VnFU/ee/XOpFR/jkbr5tGbO/Szh7lfb9S94gQ
 UEunmW9DIL1jkU1jRUSfQx29sv/x43036imu0PToZdMiHzVqKrW5jH/aujk/S+QXM0BO
 NAO5AvD1NgFLA60M1tOxlpOiXRLTle2wyG6WUFeTnPLv8HDFNcCf0mi3dtSP2oYtXjny
 LSSOHEJBj6km2Hb68vH9ByOohI5DlmX3kupfginO0mpdjjfDB+yl++bW516Q+MnOgq1R
 NseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795279995; x=1795884795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=voqgQX4qjq12TP77ZeFhlihrSRxx1qwLfc6i5Bd6qBI=;
 b=OoXsxT80KSlL43/JafgWLxvyaCJXA/m0wre5+VLXHF6Sxmct04yrQ5Xxu/6S340bL9
 sJc0pd+ILKHkw/30k7Btpnj9CFIgiZGUYqBCjOXmlgE9mvxe/d7YIe1Q2vAo4I2DmRxR
 AIyMEZ+V/hQXI1HvbcsMBekkXnWd9fO/ZGixRO1vmzsz0Gw40O7eHOsX86Q77ALVn/qM
 /Rj1/kSmYW6GClY6bZoucaxtG98dFb71ajdic/T3sG9U/ZQ8k2fhIqCicjk1Cab9FhAO
 ipqoGUZeg5H+W013URfwbgKkEkrmjZO6Ces03bSdnY5kuRxUW7Zluw0eht8GbIe4iVzz
 BXDA==
X-Gm-Message-State: APuU4Z/1g7JZf3lp43/xtLUFb/KkigeAEpTJjt3BB0u/OM0r9cImqdUZ
 kMstb5i1R/dXRVcBtdUQo7MivjTwVTNm584JimZjxtQ7614xGue3hqRgrTXndwvH6eloBQnQGRJ
 m0HxbVKM=
X-Gm-Gg: AZFdTZet/bOaZbuVB8Oz3x7b4JAC++WNxIae3cf9TnSk7F0bstCICPfChDd3Py5bkrz
 aCaNLn46xZlnGTa1l4gRBlr2sH8mDQ/iYiq9Als9tsoeAJDF9vfHs9u98/N/89AqoZamefG+AtT
 3WVWKAHwKrgnO/95nWJHAtNNOn0GvEiy4x4fhI0vP8d2gOOJ+YcPfe4lzstZyhDWSygT/nXJxiQ
 yN98GCGhDmiyofC1uxY38cd0owrcxb3q6DX7i9/huebnAMmLBqtfM0Mck5BggwP34Fyh9f4fQy7
 4V/LpncaaN1Y7ULanKJMs53aLYFKERTxqA9A1OyZIxq01J4d+Jf4pzISh+zPprq7TcwAYP8SUku
 7BkaZVZEyOy/YD3Wve6TXSpcyqdcEX+lvBYQY11v0OEhr7x1dJFV6TS9RO/dZwG+2PBP7cS0gkX
 2jsBA9beghndpgjRgCJhOpPxAJI84uWr6ticV5PEfYLZ2Bxtc9D6o/u5cU4sNPUuwYVhIeO7c8g
 x9FzC8tXZ/GIowGxaHqyx758b/xDCm3EwX33f4wutzepg2Z+L3h2VGNBCHDFoquiH3D086XMrdY
 YPE2lkBz+4hxVCiljyf9ekal3ws757YiOm/qrL7ogOzTzDzZmidUDGD+yOsT5XbD6+gh
X-Received: by 2002:a17:90a:e70c:b0:3b4:22d:e078 with SMTP id
 98e67ed59e1d1-3b41c7c238fmr6182855a91.1.1795279994936; 
 Sat, 21 Nov 2026 08:53:14 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ec698dsm12104874a91.14.2026.11.21.08.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 08:53:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 1/2] ip_frag: generate a fragment identification for IPv6
Date: Sat, 21 Nov 2026 08:51:52 -0800
Message-ID: <20261121165311.1547352-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121165311.1547352-1-stephen@networkplumber.org>
References: <20261121165311.1547352-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The current ip_frag library always writes id of zero in the
fragment header. This can cause problems at receiver because all
fragments between the same addresses are then interchangeable,
so a lost fragment splices two datagrams instead of timing out.

The existing code does not follow the relevant RFC's for this.
RFC 8200 section 4.5 wants an Identification distinct from
other recent packets between those addresses,
RFC 7739 an unpredictable one.

Bugzilla ID: 2153
Fixes: 0aa31d7a5929 ("ip_frag: add IPv6 fragmentation support")
Cc: stable@dpdk.org

Reported-by: Anthropic OSS scanner (ANT-2026-70V47B5Y)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/rte_ipv6_fragmentation.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c b/lib/ip_frag/rte_ipv6_fragmentation.c
index 791193f181..69ac9012b1 100644
--- a/lib/ip_frag/rte_ipv6_fragmentation.c
+++ b/lib/ip_frag/rte_ipv6_fragmentation.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 
 #include <eal_export.h>
+#include <rte_random.h>
 
 #include "ip_frag_common.h"
 
@@ -19,7 +20,7 @@
 static inline void
 __fill_ipv6hdr_frag(struct rte_ipv6_hdr *dst,
 		const struct rte_ipv6_hdr *src, uint16_t len, uint16_t fofs,
-		uint32_t mf)
+		uint32_t mf, rte_be32_t id)
 {
 	struct rte_ipv6_fragment_ext *fh;
 
@@ -31,7 +32,7 @@ __fill_ipv6hdr_frag(struct rte_ipv6_hdr *dst,
 	fh->next_header = src->proto;
 	fh->reserved = 0;
 	fh->frag_data = rte_cpu_to_be_16(RTE_IPV6_SET_FRAG_DATA(fofs, mf));
-	fh->id = 0;
+	fh->id = id;
 }
 
 static inline void
@@ -78,6 +79,7 @@ rte_ipv6_fragment_packet(struct rte_mbuf *pkt_in,
 	uint32_t more_in_segs;
 	uint16_t fragment_offset, frag_size;
 	uint64_t frag_bytes_remaining;
+	rte_be32_t frag_id;
 
 	/*
 	 * Formal parameter checking.
@@ -117,6 +119,12 @@ rte_ipv6_fragment_packet(struct rte_mbuf *pkt_in,
 	out_pkt_pos = 0;
 	fragment_offset = 0;
 
+	/*
+	 * An unfragmented packet carries no Identification, so generate one.
+	 * RFC 8200 wants it distinct per packet, RFC 7739 unpredictable.
+	 */
+	frag_id = (rte_be32_t)rte_rand();
+
 	more_in_segs = 1;
 	while (likely(more_in_segs)) {
 		struct rte_mbuf *out_pkt = NULL, *out_seg_prev = NULL;
@@ -188,7 +196,7 @@ rte_ipv6_fragment_packet(struct rte_mbuf *pkt_in,
 
 		__fill_ipv6hdr_frag(out_hdr, in_hdr,
 		    (uint16_t) out_pkt->pkt_len - sizeof(struct rte_ipv6_hdr),
-		    fragment_offset, more_in_segs);
+		    fragment_offset, more_in_segs, frag_id);
 
 		fragment_offset = (uint16_t)(fragment_offset +
 		    out_pkt->pkt_len - sizeof(struct rte_ipv6_hdr)
-- 
2.53.0

