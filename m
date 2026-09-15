Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64164C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B2D340A7A;
	Tue, 15 Sep 2026 12:58:33 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 68CA64067C;
 Tue, 15 Sep 2026 12:58:32 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1C763206CA;
 Tue, 15 Sep 2026 12:58:32 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 15 Sep 2026 12:58:29 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH] examples/l3fwd: fix check of unchecked IP checksum
Date: Tue, 15 Sep 2026 10:58:21 +0000
Message-ID: <20260915105822.988106-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Sep 2026 10:58:29.0621 (UTC)
 FILETIME=[243C7A50:01DD4501]
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

If the PMD didn't check the IP header checksum, the
offload value is RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN,
not RTE_MBUF_F_RX_IP_CKSUM_NONE.

Fixes: 4b01cabfb09b ("examples/l3fwd: add option to relax Rx offload")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 examples/l3fwd/l3fwd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..331d17602d 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -171,7 +171,7 @@ is_valid_ipv4_pkt(struct rte_ipv4_hdr *pkt, uint32_t link_len, uint64_t ol_flags
 
 	/* 2. The IP checksum must be correct. */
 	/* if this is not checked in H/W, check it. */
-	if ((ol_flags & RTE_MBUF_F_RX_IP_CKSUM_MASK) == RTE_MBUF_F_RX_IP_CKSUM_NONE) {
+	if ((ol_flags & RTE_MBUF_F_RX_IP_CKSUM_MASK) == RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN) {
 		uint16_t actual_cksum, expected_cksum;
 		actual_cksum = pkt->hdr_checksum;
 		pkt->hdr_checksum = 0;
-- 
2.43.0

