Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35831606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bsSYZPUN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD0C54029D;
	Wed, 18 Nov 2026 16:13:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id AF79540298;
 Wed, 18 Nov 2026 16:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795014802; x=1826550802;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6UqopCMwl5DUBrnbCnlfR42FLPntd/1bBb6X5EFVcno=;
 b=bsSYZPUNENo0NUVtWhIYnDdU3L+cV/e3I6JTJSlKQtwzIbNm/ZkQ1E7n
 foZja2/tSTRAT1dn9QWmDahxc09x2k9nLyXMb6lbX3YQwdi8Z24epE2Va
 TC6cwcG4DVKuj7eNocz/27Ksg+PzkLmk1VQg2Pz+5n3mNr4aNULZlMAQ7
 Ge7VshkrrjqpJa4OzgJOh7r0stlW29Hw4wPReOhVRSIUIit5F8csANLRC
 S4K5BrWo3qsymu+DDSeAMp3XirpTo2Rlfszjco2uHV/Vcxlz427u5YKpA
 90Ly8gxlqAxpBlRbydRhCiArcP/Z10Mhx/DrW61BVlnl/XmJqdv8aNpBC g==;
X-CSE-ConnectionGUID: kIgT53gmRmSZlGSxWr08iA==
X-CSE-MsgGUID: 3msTTKXFSouyHS4izdPNtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3687959"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3687959"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 07:12:04 -0800
X-CSE-ConnectionGUID: fZ4cc15EQ42kaEeQnX/Tow==
X-CSE-MsgGUID: Db77lHPSSheObPdc2qdA4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10186175"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa002.jf.intel.com with ESMTP; 18 Nov 2026 07:12:03 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH] app/test-pmd: use burst IO for IEEE1588 forwarding
Date: Wed, 18 Nov 2026 15:11:55 +0000
Message-ID: <20261118151155.2740034-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
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
 app/test-pmd/ieee1588fwd.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/app/test-pmd/ieee1588fwd.c b/app/test-pmd/ieee1588fwd.c
index afea7735c7..5b97ddc41b 100644
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
@@ -90,21 +90,14 @@ port_ieee1588_tx_timestamp_check(portid_t pi)
 }
 
 static bool
-ieee1588_packet_fwd(struct fwd_stream *fs)
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
@@ -194,6 +187,20 @@ ieee1588_packet_fwd(struct fwd_stream *fs)
 	return true;
 }
 
+static bool
+ieee1588_packet_fwd(struct fwd_stream *fs)
+{
+	struct rte_mbuf *pkts_burst[MAX_PKT_BURST];
+	bool fwd = false;
+
+	const uint16_t nb_rx = common_fwd_stream_receive(fs, pkts_burst, nb_pkt_per_burst);
+	for (uint16_t i = 0; i < nb_rx; i++)
+		if (ieee1588_process_packet(fs, pkts_burst[i]))
+			fwd = true;
+
+	return fwd;
+}
+
 static int
 port_ieee1588_fwd_begin(portid_t pi)
 {
-- 
2.55.0

