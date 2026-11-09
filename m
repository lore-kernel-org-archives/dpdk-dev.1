Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B6606D806
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=EHYbpG5J
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 371F5402CF;
	Mon,  9 Nov 2026 14:37:17 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id 498C14026E;
 Mon,  9 Nov 2026 14:37:16 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 71696202AB53;
 Mon, 09 Nov 2026 18:37:15 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id B62F1202A87E;
 Mon, 09 Nov 2026 18:37:13 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru B62F1202A87E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794231434; bh=YS7WGKi9+5mibaZijmaXU6QAMjsb6G0VqK5GoATF9UQ=;
 h=From:To:Cc:Subject:Date;
 b=EHYbpG5JrwreZS93aLZerI6H0y2MiqW9BJbmITlAE9/Y+xBRT4Atw83qEuSRjCXNe
 +vVD+MEm0Wc2KU5FLW8i8j8BjqSCOFKtlH89MIoKUTKdfIXjh8Viq1DjZf3G391Wxh
 ahlEDqgf0iQSHpBrt+Jly5HGcWakFCTdgJIbIw5iFWB9LKWtS1VB+KexkncFM6/Abj
 TYAJga1RQ00RlG7jhdTeoTqw+EGX+i/dOFKE0T+xlxLiCbFs9aqg0TvN7MamQZbQId
 y3TTyAFip/livlvcoFrSgW19cgsmCul9phaBSCPnDHOOUiWMK3c37iYJm6O+6sF1Yi
 kBr5CUrXbZnDg==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, stable@dpdk.org,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH] net: fix tunnel parsing of non-IP packets
Date: Mon,  9 Nov 2026 18:37:12 +0500
Message-ID: <20261109133712.152780-1-a.mokrushin@ideco.ru>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the EtherType is neither IPv4 nor IPv6, rte_net_get_ptype()
skips the L3 parsing but then calls ptype_tunnel_without_udp() with
the EtherType still in proto. This function compares proto with IP
protocol numbers, so on little-endian EtherType 0x0400 (also an 802.3
length field), 0x2900 and 0x2F00 are taken as IPIP, IPv6 and GRE:
the packet is reported as an IP tunnel, and the data after the
Ethernet header is parsed as the inner packet.

Return after L2 for non-IP packets.

Fixes: d21d855464ff ("net: support GRE in software packet type parser")
Cc: stable@dpdk.org

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
 lib/net/rte_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 54bbafc..343eb88 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -464,6 +464,9 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 			return pkt_type;
 		}
 		pkt_type |= ptype_l4(proto);
+	} else {
+		/* not an IP packet: there is no L4 header or tunnel to parse */
+		return pkt_type;
 	}
 
 	if ((pkt_type & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP) {
-- 
2.56.0


