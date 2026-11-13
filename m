Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0429606A32D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 20:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C0D8402A4;
	Fri, 13 Nov 2026 21:32:39 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTPS id 5525D4028E;
 Fri, 13 Nov 2026 21:32:38 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C6E4B20972;
 Fri, 13 Nov 2026 21:32:37 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 13 Nov 2026 21:32:37 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH v7] examples/l3fwd: fix RFC 1812 checks
Date: Fri, 13 Nov 2026 20:32:36 +0000
Message-ID: <20261113203236.597141-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915105822.988106-1-mb@smartsharesystems.com>
References: <20260915105822.988106-1-mb@smartsharesystems.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Nov 2026 20:32:37.0364 (UTC)
 FILETIME=[1F102B40:01DD73AE]
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

Five bug fixes and two enhancements.

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

Fixed this by simply calculating the checksum of the packet without
modifying the checksum field.
If the calculated checksum is zero, the checksum is correct.

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
Calculating the checksum in the 2nd bullet check uses rte_ipv4_cksum(),
which gets its length from the IP header length field.
If the IP header length exceeded the Link Layer length, it would read
out of bounds.

Fixed this by moving the 2nd bullet check down after the length checks,
and adding a comment describing the reason for its position.

6.
Added the additional check recommended in RFC 1812 section 5.2.2,
verifying that the packet length reported by the Link Layer is at least
as large as the IP total length recorded in the packet's IP header.

7.
Different negative values are returned on failure, but they are not used
by any callers of this function.
This is unnecessary, and may be confusing.
Changed all negative return values to -1.

Fixes: 4b01cabfb09b ("examples/l3fwd: add option to relax Rx offload")
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v7:
* Fixed rebase error. (Thomas)
* Fixed spelling in patch description. (CI)
v6:
* Rebased.
* Moved checksum check down, to prevent potential out-of-bounds read in
  rte_ipv4_cksum(). (Thomas' AI)
* Tx offload is not configured to update the checksum, so for CKSUM_NONE,
  set it instead of forwarding the unset value. (Thomas' AI)
* Changed all negative return values to -1.
v5:
* Use rte_be_to_cpu_16(), not rte_cpu_to_be_16(), for reading
  IP header total_length field. (AI)
v4:
* When CKSUM_NONE, don't update checksum field. (AI)
v3:
* Simplified the checksum check. No need to modify the packet for
  checking the checksum.
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
 examples/l3fwd/l3fwd.h     | 50 ++++++++++++++++++++++++++------------
 examples/l3fwd/l3fwd_em.h  |  3 ++-
 examples/l3fwd/l3fwd_lpm.h |  3 ++-
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 20c457ee7f..300b400a72 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -169,38 +169,58 @@ is_valid_ipv4_pkt(struct rte_ipv4_hdr *pkt, uint32_t link_len, uint64_t ol_flags
 	if (link_len < sizeof(struct rte_ipv4_hdr))
 		return -1;
 
-	/* 2. The IP checksum must be correct. */
-	/* if this is not checked in H/W, check it. */
-	if ((ol_flags & RTE_MBUF_F_RX_IP_CKSUM_MASK) == RTE_MBUF_F_RX_IP_CKSUM_NONE) {
-		uint16_t actual_cksum, expected_cksum;
-		actual_cksum = pkt->hdr_checksum;
-		pkt->hdr_checksum = 0;
-		expected_cksum = rte_ipv4_cksum(pkt);
-		if (actual_cksum != expected_cksum)
-			return -2;
-	}
-
 	/*
 	 * 3. The IP version number must be 4. If the version number is not 4
 	 * then the packet may be another version of IP, such as IPng or
 	 * ST-II.
 	 */
 	if (((pkt->version_ihl) >> 4) != 4)
-		return -3;
+		return -1;
 	/*
 	 * 4. The IP header length field must be large enough to hold the
 	 * minimum length legal IP datagram (20 bytes = 5 words).
 	 */
 	if ((pkt->version_ihl & 0xf) < 5)
-		return -4;
+		return -1;
 
 	/*
 	 * 5. The IP total length field must be large enough to hold the IP
 	 * datagram header, whose length is specified in the IP header length
 	 * field.
 	 */
-	if (rte_cpu_to_be_16(pkt->total_length) < sizeof(struct rte_ipv4_hdr))
-		return -5;
+	if (rte_be_to_cpu_16(pkt->total_length) < rte_ipv4_hdr_len(pkt))
+		return -1;
+
+	/*
+	 * Additionally, the router SHOULD verify that the packet length
+	 * reported by the Link Layer is at least as large as the IP total
+	 * length recorded in the packet's IP header.
+	 */
+	if (link_len < rte_be_to_cpu_16(pkt->total_length))
+		return -1;
+
+	/*
+	 * 2. The IP checksum must be correct.
+	 * Note: This check is performed after the length checks,
+	 * to prevent rte_ipv4_cksum() from reading out of bounds
+	 * if the IP header length exceeds the packet length.
+	 */
+	switch (ol_flags & RTE_MBUF_F_RX_IP_CKSUM_MASK) {
+	case RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN:
+		/* Not checked in H/W; check it. */
+		if (rte_ipv4_cksum(pkt) != 0)
+			return -1;
+		break;
+	case RTE_MBUF_F_RX_IP_CKSUM_GOOD:
+		break;
+	case RTE_MBUF_F_RX_IP_CKSUM_BAD:
+		return -1;
+	case RTE_MBUF_F_RX_IP_CKSUM_NONE:
+		/* Packet integrity known good, checksum field unset; set it. */
+		pkt->hdr_checksum = 0;
+		pkt->hdr_checksum = rte_ipv4_cksum(pkt);
+		break;
+	}
 
 	return 0;
 }
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

