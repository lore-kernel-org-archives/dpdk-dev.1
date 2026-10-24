Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680AC606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 10:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8F4A402B0;
	Sat, 24 Oct 2026 12:10:18 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 350E54021F;
 Sat, 24 Oct 2026 12:10:17 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F0C2320B93;
 Sat, 24 Oct 2026 12:10:16 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 24 Oct 2026 12:10:16 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH v2] examples/l3fwd: fix RFC 1812 checks
Date: Sat, 24 Oct 2026 10:10:14 +0000
Message-ID: <20261024101014.3232120-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915105822.988106-1-mb@smartsharesystems.com>
References: <20260915105822.988106-1-mb@smartsharesystems.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Oct 2026 10:10:16.0371 (UTC)
 FILETIME=[DDD5D030:01DD639F]
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Four bug fixes and an enhancement.

1.
If the PMD didn't check the IP header checksum, the
offload value is RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN,
not RTE_MBUF_F_RX_IP_CKSUM_NONE.
CKSUM_NONE means that the packet integrity is good, but the checksum
field has not been set.
CKSUM_UNKNOWN means that the checksum has not been investigated.
(BTW, no PMD currently sets RTE_MBUF_F_RX_IP_CKSUM_NONE, so this part
of the check was effectively dead code.)

Fixed this by processing all four RTE_MBUF_F_RX_IP_CKSUM enum values.
All four values may not actually occur in this application,
but it serves an educational purpose.

2.
When checking the checksum, the checksum field in the packet was zeroed
for calculating the checksum.
If the checksum was correct, the zero value remained in the packet.

Fixed this by restoring the actual value in the packet after checking.

3.
When checking the Link Layer length of an IP packet, the length did
not omit the length of the preceding Layer 2 headers.

Fixed this by subtracting the Ethernet header length when calling the
IPv4 validation function.

4.
In the 5th bullet check,
"5. The IP total length field must be large enough to hold the IP
datagram header, whose length is specified in the IP header length
field."
the comparison did not use the IP header length field, but the size
of the IP header structure, which did not account for IP header
options.

Fixed this by using the IP header length field instead of the
size of the structure.

5.
Added the additional check recommended in RFC 1812 section 5.2.2,
verifying that the packet length reported by the Link Layer is at least
as large as the IP total length recorded in the packet's IP header.

Fixes: 4b01cabfb09b ("examples/l3fwd: add option to relax Rx offload")
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Rebased.
* Improved (1): Process all four checksum offload enum values, not just
  CKSUM_UNKNOWN instead of CKSUM_NONE.
* Added (2): Restore checksum field value in packet after checking.
* Added (3): Subtract Layer 2 header length when passing Link Layer
  length.
* Added (4): Fix IP header Total Length vs. IP Header Length check.
* Added (5): Link Layer length vs. IP header Total Length check.
* Added the Fixes tag going back to the first public release.
---
 examples/l3fwd/l3fwd.h     | 26 +++++++++++++++++++++++---
 examples/l3fwd/l3fwd_em.h  |  3 ++-
 examples/l3fwd/l3fwd_lpm.h |  3 ++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..3bcc7da87a 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -170,14 +170,26 @@ is_valid_ipv4_pkt(struct rte_ipv4_hdr *pkt, uint32_t link_len, uint64_t ol_flags
 		return -1;
 
 	/* 2. The IP checksum must be correct. */
-	/* if this is not checked in H/W, check it. */
-	if ((ol_flags & RTE_MBUF_F_RX_IP_CKSUM_MASK) == RTE_MBUF_F_RX_IP_CKSUM_NONE) {
+	switch (ol_flags & RTE_MBUF_F_RX_IP_CKSUM_MASK) {
+	case RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN:
+		/* Not checked by H/W; check it. */
 		uint16_t actual_cksum, expected_cksum;
 		actual_cksum = pkt->hdr_checksum;
 		pkt->hdr_checksum = 0;
 		expected_cksum = rte_ipv4_cksum(pkt);
+		pkt->hdr_checksum = actual_cksum;
 		if (actual_cksum != expected_cksum)
 			return -2;
+		break;
+	case RTE_MBUF_F_RX_IP_CKSUM_GOOD:
+		break;
+	case RTE_MBUF_F_RX_IP_CKSUM_BAD:
+		return -2;
+	case RTE_MBUF_F_RX_IP_CKSUM_NONE:
+		/* Packet integrity known good, header field unset; set it. */
+		pkt->hdr_checksum = 0;
+		pkt->hdr_checksum = rte_ipv4_cksum(pkt);
+		break;
 	}
 
 	/*
@@ -199,9 +211,17 @@ is_valid_ipv4_pkt(struct rte_ipv4_hdr *pkt, uint32_t link_len, uint64_t ol_flags
 	 * datagram header, whose length is specified in the IP header length
 	 * field.
 	 */
-	if (rte_cpu_to_be_16(pkt->total_length) < sizeof(struct rte_ipv4_hdr))
+	if (rte_cpu_to_be_16(pkt->total_length) < rte_ipv4_hdr_len(pkt))
 		return -5;
 
+	/*
+	 * Additionally, the router SHOULD verify that the packet length
+	 * reported by the Link Layer is at least as large as the IP total
+	 * length recorded in the packet's IP header.
+	 */
+	if (link_len < rte_cpu_to_be_16(pkt->total_length))
+		return -6;
+
 	return 0;
 }
 #endif /* DO_RFC_1812_CHECKS */
diff --git a/examples/l3fwd/l3fwd_em.h b/examples/l3fwd/l3fwd_em.h
index 1fee2e2e6c..34801fba2b 100644
--- a/examples/l3fwd/l3fwd_em.h
+++ b/examples/l3fwd/l3fwd_em.h
@@ -20,7 +20,8 @@ l3fwd_em_handle_ipv4(struct rte_mbuf *m, uint16_t portid,
 
 #ifdef DO_RFC_1812_CHECKS
 	/* Check to make sure the packet is valid (RFC1812) */
-	if (is_valid_ipv4_pkt(ipv4_hdr, m->pkt_len, m->ol_flags) < 0) {
+	if (is_valid_ipv4_pkt(ipv4_hdr, m->pkt_len - sizeof(struct rte_ether_hdr),
+			m->ol_flags) < 0) {
 		rte_pktmbuf_free(m);
 		return BAD_PORT;
 	}
diff --git a/examples/l3fwd/l3fwd_lpm.h b/examples/l3fwd/l3fwd_lpm.h
index 4ee61e8d88..1731ebb2a8 100644
--- a/examples/l3fwd/l3fwd_lpm.h
+++ b/examples/l3fwd/l3fwd_lpm.h
@@ -22,7 +22,8 @@ l3fwd_lpm_simple_forward(struct rte_mbuf *m, uint16_t portid,
 
 #ifdef DO_RFC_1812_CHECKS
 		/* Check to make sure the packet is valid (RFC1812) */
-		if (is_valid_ipv4_pkt(ipv4_hdr, m->pkt_len, m->ol_flags) < 0) {
+		if (is_valid_ipv4_pkt(ipv4_hdr, m->pkt_len - sizeof(struct rte_ether_hdr),
+				m->ol_flags) < 0) {
 			rte_pktmbuf_free(m);
 			return;
 		}
-- 
2.43.0

