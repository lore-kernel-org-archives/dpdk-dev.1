Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4BC88E64
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Sep 2026 23:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 866494026E;
	Mon, 14 Sep 2026 01:37:01 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1DCF44013F;
 Mon, 14 Sep 2026 01:36:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.67.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 91E1FE053E;
 Mon, 14 Sep 2026 03:36:57 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 91E1FE053E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1789342617;
 bh=+hR8vWXuPYnMDVD1EcKJARPv+SneGpOBpFbs18kp77k=;
 h=From:To:Cc:Subject:Date:From;
 b=AZJIRn5xv9Sw0SQw19otTZFo7W3va1N07RFNjoWIa0C8O9WolZaYYy1d45cMaIDBU
 2xd/pbJXq+Npomt0sOD5MOgQ9KonGuGR7mugWyczMqs9NaEJGfb/jJtJPM/ak7MmiO
 cVMJECDKR7hA/9i5HjiCu6o5okEXAlYXKaiLXY21KV8yVeBJPYaBRg9AK3PS2fvA6r
 QWjDKzQj+rom0YGs/ZCm+yzfoootXAfqAGOjeLvVeB5QY8TIY9FYRH+ww9bRjpxIXD
 H085qgJrKTX59pYCU20NHSAIMa+mh2aojzlDt7i7UHa/5SLyr3ioWR4ZOJMNCNS68J
 bLqcdpKb9K1nQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH 1/1] net: fix L2 ptype for VLAN-tagged packets
Date: Mon, 14 Sep 2026 03:36:55 +0400
Message-ID: <20260913233655.21866-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
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

When a tag is discovered, the code does not remove 'RTE_PTYPE_L2_ETHER'
set on function entry. For single-tagged packets, 'RTE_PTYPE_L2_ETHER'
and 'RTE_PTYPE_L2_ETHER_VLAN' give 'RTE_PTYPE_L2_ETHER_QINQ' when
OR-ed together. Clear previously set L2 type when handling VLANs.

Also, since 'RTE_PTYPE_L2_ETHER_VLAN' requires that the EtherType field
in the Ethernet header be set to 0x8100 and 'RTE_PTYPE_L2_ETHER_QINQ'
requires that it be set to 0x88a8, it is the outermost (first) tag
that determines what the software L2 ptype should be. Clarify that.

Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 lib/net/rte_net.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 0a91e92ba0..826d9f58b9 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -365,10 +365,18 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 
 		if (++vlan_depth > RTE_NET_VLAN_MAX_DEPTH)
 			return 0;
-		pkt_type |=
-			proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
-				 RTE_PTYPE_L2_ETHER_VLAN :
-				 RTE_PTYPE_L2_ETHER_QINQ;
+
+		/*
+		 * It is the outermost tag that determines whether
+		 * the packet will be classified as VLAN or QinQ.
+		 */
+		if (vlan_depth == 1) {
+			/* Override previously set 'RTE_PTYPE_L2_ETHER'. */
+			pkt_type = (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
+					RTE_PTYPE_L2_ETHER_VLAN :
+					RTE_PTYPE_L2_ETHER_QINQ);
+		}
+
 		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
 		if (unlikely(vh == NULL))
 			return pkt_type;
-- 
2.47.3

