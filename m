Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C87CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 17:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A80EA40291;
	Sat, 17 Oct 2026 19:00:04 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8E44D40276;
 Sat, 17 Oct 2026 19:00:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7EE862080A;
 Sat, 17 Oct 2026 19:00:01 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 17 Oct 2026 19:00:00 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH] net/vhost: fix SW checksum when zero
Date: Sat, 17 Oct 2026 16:59:52 +0000
Message-ID: <20261017165952.3139535-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Oct 2026 17:00:00.0211 (UTC)
 FILETIME=[F20DDA30:01DD5E58]
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

Identifying UDP packets by masking the packet type with the L4 UDP packet
type value (0x00000200) also matched other L4 packet types with that bit
set; specifically IP fragments, IGMP packets, and certain non-fragments.
This meant that non-UDP packets followed the special UDP rule about
transmitting a checksum of zero as 0xffff instead.

Updated to mask the packet type with the L4 packet type mask and then
compare to the L4 UDP packet type, so only UDP packets follow the special
UDP checksum rule.

Fixes: 8ba1723783b2 ("net/vhost: perform SW checksum in Tx path")
Fixes: 8f1750f42e2d ("net/vhost: perform SW checksum in Rx path")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 drivers/net/vhost/rte_eth_vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index f6ef997455..1f55ee9670 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -346,7 +346,7 @@ vhost_dev_tx_sw_csum(struct rte_mbuf *mbuf)
 
 	csum = ~csum;
 	/* See RFC768 */
-	if (unlikely((mbuf->packet_type & RTE_PTYPE_L4_UDP) && csum == 0))
+	if (unlikely(csum == 0) && (mbuf->packet_type & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP)
 		csum = 0xffff;
 
 	if (rte_pktmbuf_data_len(mbuf) >= csum_offset + 1)
@@ -389,7 +389,7 @@ vhost_dev_rx_sw_csum(struct rte_mbuf *mbuf)
 
 	csum = ~csum;
 	/* See RFC768 */
-	if (unlikely((ptype & RTE_PTYPE_L4_UDP) && csum == 0))
+	if (unlikely(csum == 0) && (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP)
 		csum = 0xffff;
 
 	if (rte_pktmbuf_data_len(mbuf) >= csum_offset + 1)
-- 
2.43.0

