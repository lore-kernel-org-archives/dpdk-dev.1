Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A884606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BABEEJTa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA2D740431;
	Thu, 26 Nov 2026 14:51:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 294DF402BD;
 Thu, 26 Nov 2026 14:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795701083; x=1827237083;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pWwp26IkWX2+nQ3BN4AyAXdf++mLPecfZvQ5MVGdQqU=;
 b=BABEEJTaAC56kFg7QWJ+htlph9/fZoSYMnxbtzEtmWxunAByla/VzJuL
 R5OY1GET7bAVY2XOYV/0Td04yhheP1dyoyn2nBXubj5Ki5mQbem9SiMPF
 RpiTR+3lnPX2iAoDBQdCw5NM8nfG5EoDYbrtBk1KJMX4NQkQslSSoiH5q
 E6moXX/BfxaxtUiETgLcGCUtlqkZIGmP+IYA1MY98nnLWGge0tIrArE6g
 jB80T8ODll7RUJVrAMjJMmjBJVDRPd0bGSWgnZfoSgBuIm9qjpwdETtLX
 6GYwm+Oo4+aWJLyYlJSj03v1Db60+tlZvIH3BxJe6mrihc+9xUTtAYo9o A==;
X-CSE-ConnectionGUID: ncPSoZTWQEStE+gkHaAiZg==
X-CSE-MsgGUID: 616D2rD5SrCKp2QIS36WUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4522830"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4522830"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:51:21 -0800
X-CSE-ConnectionGUID: 1KPv/XqKSCi5DpveMco/gw==
X-CSE-MsgGUID: GVXFsNHJSda9CofI82qKCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="11957489"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 26 Nov 2026 05:51:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v3] app/testpmd: use burst IO for IEEE1588 forwarding
Date: Thu, 26 Nov 2026 13:51:09 +0000
Message-ID: <20261126135109.3493777-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118151155.2740034-1-bruce.richardson@intel.com>
References: <20261118151155.2740034-1-bruce.richardson@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IEEE1588 forwarder in test-pmd read a single packet at a time rather
than using the burst size configuration parameter. This meant that it
cannot be used with vector driver paths which require a minimum burst
size for calling the Rx function.

Make the forwarding function respect the configured burst size and only
process packets one at a time, not Rx them one-at-a-time.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V3: make per-packet forwarding function void rather than ignoring return
    value
V2: align return value from ieee_packet_fwd() with other fwd fns.
---
 app/test-pmd/ieee1588fwd.c | 44 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/app/test-pmd/ieee1588fwd.c b/app/test-pmd/ieee1588fwd.c
index afea7735c7..8c6a60aff1 100644
--- a/app/test-pmd/ieee1588fwd.c
+++ b/app/test-pmd/ieee1588fwd.c
@@ -34,10 +34,10 @@ struct ptpv2_msg {
 /*
  * Forwarding of IEEE1588 Precise Time Protocol (PTP) packets.
  *
- * In this mode, packets are received one by one and are expected to be
- * PTP V2 L2 Ethernet frames (with the specific Ethernet type "0x88F7")
- * containing PTP "sync" messages (version 2 at offset 1, and message ID
- * 0 at offset 0).
+ * In this mode, packets are received in bursts and processed one by one.
+ * They are expected to be PTP V2 L2 Ethernet frames (with the specific
+ * Ethernet type "0x88F7") containing PTP "sync" messages (version 2 at
+ * offset 1, and message ID 0 at offset 0).
  *
  * Check that each received packet is a IEEE1588 PTP V2 packet of type
  * PTP_SYNC_MESSAGE, and that it has been identified and timestamped
@@ -89,22 +89,15 @@ port_ieee1588_tx_timestamp_check(portid_t pi)
 	       (wait_us == 1) ? "" : "s");
 }
 
-static bool
-ieee1588_packet_fwd(struct fwd_stream *fs)
+static void
+ieee1588_process_packet(struct fwd_stream *fs, struct rte_mbuf *mb)
 {
-	struct rte_mbuf  *mb;
 	struct rte_ether_hdr *eth_hdr;
 	struct rte_ether_addr addr;
 	struct ptpv2_msg *ptp_hdr;
 	uint16_t eth_type;
 	uint32_t timesync_index;
 
-	/*
-	 * Receive 1 packet at a time.
-	 */
-	if (common_fwd_stream_receive(fs, &mb, 1) == 0)
-		return false;
-
 	/*
 	 * Check that the received packet is a PTP packet that was detected
 	 * by the hardware.
@@ -124,14 +117,14 @@ ieee1588_packet_fwd(struct fwd_stream *fs)
 			       (unsigned) mb->pkt_len);
 		}
 		rte_pktmbuf_free(mb);
-		return false;
+		return;
 	}
 	if (eth_type != RTE_ETHER_TYPE_1588) {
 		printf("Port %u Received NON PTP packet incorrectly"
 		       " detected by hardware\n",
 		       fs->rx_port);
 		rte_pktmbuf_free(mb);
-		return false;
+		return;
 	}
 
 	/*
@@ -145,14 +138,14 @@ ieee1588_packet_fwd(struct fwd_stream *fs)
 		       " protocol version 0x%x (should be 0x02)\n",
 		       fs->rx_port, ptp_hdr->version);
 		rte_pktmbuf_free(mb);
-		return false;
+		return;
 	}
 	if (ptp_hdr->msg_id != PTP_SYNC_MESSAGE) {
 		printf("Port %u Received PTP V2 Ethernet frame with unexpected"
 		       " message ID 0x%x (expected 0x0 - PTP_SYNC_MESSAGE)\n",
 		       fs->rx_port, ptp_hdr->msg_id);
 		rte_pktmbuf_free(mb);
-		return false;
+		return;
 	}
 	printf("Port %u IEEE1588 PTP V2 SYNC Message filtered by hardware\n",
 	       fs->rx_port);
@@ -166,7 +159,7 @@ ieee1588_packet_fwd(struct fwd_stream *fs)
 		       " by hardware\n",
 		       fs->rx_port);
 		rte_pktmbuf_free(mb);
-		return false;
+		return;
 	}
 
 	/* For i40e we need the timesync register index. It is ignored for the
@@ -184,14 +177,25 @@ ieee1588_packet_fwd(struct fwd_stream *fs)
 	mb->ol_flags |= RTE_MBUF_F_TX_IEEE1588_TMST;
 	if (common_fwd_stream_transmit(fs, &mb, 1) == 0) {
 		printf("Port %u sent PTP packet dropped\n", fs->tx_port);
-		return false;
+		return;
 	}
 
 	/*
 	 * Check the TX timestamp.
 	 */
 	port_ieee1588_tx_timestamp_check(fs->tx_port);
-	return true;
+}
+
+static bool
+ieee1588_packet_fwd(struct fwd_stream *fs)
+{
+	struct rte_mbuf *pkts_burst[MAX_PKT_BURST];
+
+	const uint16_t nb_rx = common_fwd_stream_receive(fs, pkts_burst, nb_pkt_per_burst);
+	for (uint16_t i = 0; i < nb_rx; i++)
+		ieee1588_process_packet(fs, pkts_burst[i]);
+
+	return nb_rx > 0;
 }
 
 static int
-- 
2.55.0

