Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EE606A325
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=AQ3eV5hU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F9C9402BC;
	Mon,  9 Nov 2026 10:27:49 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id B9EEB40294;
 Mon,  9 Nov 2026 10:27:47 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 3240920236F7;
 Mon, 09 Nov 2026 14:27:47 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 99D6020236DD;
 Mon, 09 Nov 2026 14:27:43 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 99D6020236DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794216466; bh=0HHDnyaJ8sEk+wN7xXaX2hLsKdYlsRxCbYNTpQidveA=;
 h=From:To:Cc:Subject:Date;
 b=AQ3eV5hUJLK/2Cyb0VE808V4+QKfRk6e19RlNZazTHTaEmGSBRZ0sLa+kLbREegXO
 cqa5WSoElNHF6Jl78xWvDLyhNSgNfuJqYbTnvmOIH5zkIS5aFxJuGvqoqovSIHsMsm
 9orDKjxccNyOk6tmPFn4LEODN/POTArShLuwNgGmDBAv2Jv5XGuUe6hrFUP2eq5sHt
 1Ai5TpX69ZLCyY5CUS8XVQPIErQCMm2K49hSvlL0rO8BjTSDg12U6OQ6S76QJbV6sU
 J+nSAYneAwvTfZvJZioGRk2AupmVBd4wqU0SMuE9m4ypU2YOicki5jm0lBmsqt8crY
 fUpiw5wp2q0Dg==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: Jiayu Hu <hujiayu.hu@foxmail.com>, stable@dpdk.org,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH] gso: fix segmentation of unsupported tunnel packets
Date: Mon,  9 Nov 2026 14:27:42 +0500
Message-ID: <20261109092742.77701-1-a.mokrushin@ideco.ru>
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

IS_IPV4_TCP() and IS_IPV4_UDP() do not check the tunnel type bits.
A tunnel packet that does not match any of the tunnel cases (IPIP,
GENEVE, IPv6 outer header, VXLAN or GRE without its type in gso_types)
is segmented as a plain TCP/IPv4 or UDP/IPv4 packet. For a tunnel
packet, l2_len, l3_len and l4_len describe the inner headers, so the
segments get wrong header boundaries, and the IPv4 and TCP header
updates overwrite the outer Ethernet and IPv4 headers. When the bytes
read as fragment offset are not zero, the packet is returned
unsegmented instead.

Return -ENOTSUP for such packets, as documented for protocols that
can not be segmented.

Fixes: 119583797b6a ("gso: support TCP/IPv4 GSO")
Fixes: b166d4f30b66 ("gso: support UDP/IPv4 fragmentation")
Cc: stable@dpdk.org

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
 lib/gso/gso_common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/gso/gso_common.h b/lib/gso/gso_common.h
index d1c1b73..cbc6b1b 100644
--- a/lib/gso/gso_common.h
+++ b/lib/gso/gso_common.h
@@ -17,7 +17,8 @@
 #define TCP_HDR_PSH_MASK ((uint8_t)0x08)
 #define TCP_HDR_FIN_MASK ((uint8_t)0x01)
 
-#define IS_IPV4_TCP(flag) (((flag) & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_IPV4)) == \
+#define IS_IPV4_TCP(flag) (((flag) & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_IPV4 | \
+				RTE_MBUF_F_TX_TUNNEL_MASK)) == \
 		(RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_IPV4))
 
 #define IS_IPV4_VXLAN_TCP4(flag) (((flag) & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_IPV4 | \
@@ -35,7 +36,8 @@
 		(RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_IPV4 | RTE_MBUF_F_TX_OUTER_IPV4 | \
 		 RTE_MBUF_F_TX_TUNNEL_GRE))
 
-#define IS_IPV4_UDP(flag) (((flag) & (RTE_MBUF_F_TX_UDP_SEG | RTE_MBUF_F_TX_IPV4)) == \
+#define IS_IPV4_UDP(flag) (((flag) & (RTE_MBUF_F_TX_UDP_SEG | RTE_MBUF_F_TX_IPV4 | \
+				RTE_MBUF_F_TX_TUNNEL_MASK)) == \
 		(RTE_MBUF_F_TX_UDP_SEG | RTE_MBUF_F_TX_IPV4))
 
 /**
-- 
2.56.0


