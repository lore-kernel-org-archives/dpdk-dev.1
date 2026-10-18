Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B511CCA490
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28791402EE;
	Sun, 18 Oct 2026 11:20:44 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B3BF240276;
 Sun, 18 Oct 2026 11:20:42 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8D214207E8;
 Sun, 18 Oct 2026 11:20:42 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sun, 18 Oct 2026 11:20:39 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH v3] net/vhost: fix SW checksum when zero
Date: Sun, 18 Oct 2026 09:20:37 +0000
Message-ID: <20261018092037.3143058-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017165952.3139535-1-mb@smartsharesystems.com>
References: <20261017165952.3139535-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Oct 2026 09:20:39.0516 (UTC)
 FILETIME=[F10349C0:01DD5EE1]
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

There is a special rule for UDP, where a checksum of zero is as 0xffff
instead of zero.

Identifying packet types requires masking with the mask, not the value,
before comparing to the value.
Identifying by masking with the L4 UDP packet type value (0x00000200)
instead of the L4 packet type mask caused other L4 packet types to match;
specifically IP fragments, IGMP packets, and certain non-fragments.
This meant that some non-UDP packets followed the special UDP checksum
rule, which they should not.

Updated to mask the packet type with the L4 packet type mask and then
compare to the L4 UDP packet type value, so only UDP packets follow the
special UDP checksum rule.

Furthermore, according to the mbuf documentation, Tx checksum offload
requires that "ol_flags" is set, and only mentions "packet_type" for Rx,
so use "ol_flags" instead of "packet_type" for checking the packet type
at Tx.

Furthermore, writing the checksum needs room for 2 bytes, not 1 byte.

Note:
Using "if (unlikely(cksum == 0) && PTYPE_MATCH)" to advise the optimizer
about the need to evaluate PTYPE_MATCH being unlikely.
The probability of cksum being zero is only 1/65536, so it's better to
branch early.

Fixes: 8ba1723783b2 ("net/vhost: perform SW checksum in Tx path")
Fixes: 8f1750f42e2d ("net/vhost: perform SW checksum in Rx path")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v3:
* Writing the checksum needs room for 2 bytes, not 1 byte.
v2:
* Use ol_flags instead of packet_type for Tx.
* Added note about the use of unlikely().
---
 drivers/net/vhost/rte_eth_vhost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index f6ef997455..9ffc844356 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -346,10 +346,11 @@ vhost_dev_tx_sw_csum(struct rte_mbuf *mbuf)
 
 	csum = ~csum;
 	/* See RFC768 */
-	if (unlikely((mbuf->packet_type & RTE_PTYPE_L4_UDP) && csum == 0))
+	if (unlikely(csum == 0) &&
+			(mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_UDP_CKSUM)
 		csum = 0xffff;
 
-	if (rte_pktmbuf_data_len(mbuf) >= csum_offset + 1)
+	if (rte_pktmbuf_data_len(mbuf) >= csum_offset + sizeof(uint16_t))
 		*rte_pktmbuf_mtod_offset(mbuf, uint16_t *, csum_offset) = csum;
 
 	mbuf->ol_flags &= ~RTE_MBUF_F_TX_L4_MASK;
@@ -389,10 +390,10 @@ vhost_dev_rx_sw_csum(struct rte_mbuf *mbuf)
 
 	csum = ~csum;
 	/* See RFC768 */
-	if (unlikely((ptype & RTE_PTYPE_L4_UDP) && csum == 0))
+	if (unlikely(csum == 0) && (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP)
 		csum = 0xffff;
 
-	if (rte_pktmbuf_data_len(mbuf) >= csum_offset + 1)
+	if (rte_pktmbuf_data_len(mbuf) >= csum_offset + sizeof(uint16_t))
 		*rte_pktmbuf_mtod_offset(mbuf, uint16_t *, csum_offset) = csum;
 
 	mbuf->ol_flags &= ~RTE_MBUF_F_RX_L4_CKSUM_MASK;
-- 
2.43.0

